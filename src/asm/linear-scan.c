#include "linear-scan.h"
#include "armv8.h"
#include "asm_util.h"

#include "../bril-insns/types.h"

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#ifdef __ARM_ARCH


typedef struct interval
{
  int start, end;
  arm_reg_t reg;
  uint16_t temp, stack_loc;
  bool is_reg, is_float;
} interval_t;

static inline void print_active(interval_t **active, size_t num_active)
{
  for(size_t i = 0; i < num_active; ++i)
    printf("t%d (%d, %d) ", active[i]->temp, active[i]->start, active[i]->end);
  putchar(10);
}

static inline bool is_preallocated(interval_t *i)
{
  return i->temp == 0xffff;
}


typedef struct temps_used
{
  int16_t num;
  int tmps[2];
} temps_used_t;

static inline int max(int a, int b)
{
  return a > b ? a : b;
}

static inline temps_used_t norm_temps_used(arm_arg_tagged_t a1, arm_arg_tagged_t a2)
{
  uint16_t num = (a1.type == TMP ? 1 : 0) +
    (a2.type == TMP ? 1 : 0);
  return (temps_used_t)
    {.num = num,
     .tmps[0] = num == 0 ? -1 : (num == 1 && a1.type != TMP ?
			    a2.value.tmp : a1.value.tmp),
     .tmps[1] = num < 2 ? -1 : a2.value.tmp};
}

static inline temps_used_t one_temps_used(arm_arg_tagged_t a)
{
  uint16_t num = a.type == TMP ? 1 : 0;
  return (temps_used_t)
    {.num = num,
     .tmps[0] = num == 0 ? -1 : a.value.tmp,
     .tmps[1] = -1};
}

temps_used_t get_temps_used(tagged_arm_insn_t insn)
{
  switch(insn.type)
    {
    case ANORM:
      return norm_temps_used(insn.value.norm.a1, insn.value.norm.a2);
    case ACMP:
      return norm_temps_used(insn.value.cmp.a1, insn.value.cmp.a2);
    case AMOV:
      return one_temps_used(insn.value.mov.src);
    case ACBZ:
      return one_temps_used(insn.value.cbz.cond);
    case ASTR:
      return norm_temps_used(insn.value.str.address, insn.value.str.value);
    case ALDR:
      return one_temps_used(insn.value.ldr.address);
    default:
      return (temps_used_t)
	{.num = 0,
	 .tmps[0] = -1,
	 .tmps[1] = -1};
    }
}

temps_used_t get_temps_defd(tagged_arm_insn_t insn)
{
  switch(insn.type)
    {
    case ANORM:
      return one_temps_used(insn.value.norm.dest);
    case ASET:
      return one_temps_used(insn.value.set.dest);
    case AMOV:
      return one_temps_used(insn.value.mov.dest);
    case AMOVC:
      return one_temps_used(insn.value.movc.dest);
    case ALDR:
      return one_temps_used(insn.value.ldr.dest);
    default:
      return (temps_used_t)
	{.num = 0,
	 .tmps[0] = -1,
	 .tmps[1] = -1};
    }
}

static int cmp_interval_start(const void *p1, const void *p2)
{
  return ((const interval_t *) p1)->start -
    ((const interval_t *) p2)->start;
}

static int cmp_interval_ptr_end(const void *p1, const void *p2)
{
  return (*(const interval_t **) p1)->end -
    (*(const interval_t **) p2)->end;
}

static int cmp_interval_tmp(const void *p1, const void *p2)
{
  return ((const interval_t *) p1)->temp -
    ((const interval_t *) p2)->temp;
}


void write_call_intervals(FILE *stream, asm_insn_t *insns, size_t i)
{
  uint16_t num_args = insns[i].value.abs_call.num_args;
  size_t float_args = 0, other_args = 0;
  bool should_write;
  for(size_t x = 0; x < num_args; x += 32)
    {
      for(size_t argi = 0; x * 32 + argi < num_args && argi < 32; ++argi)
	{
	  uint16_t tp = insns[i + 1 + x/32].value.abs_call_ext.typed_temps[argi] >> 16;
	  interval_t ival = (interval_t)
	    {.start = i,
	     .end = i + 1,
	     .temp = 0xffff,
	     .is_reg = true,
	    };
	  if(tp == BRILFLOAT)
	    {
	      ival.reg = D0 + float_args;
	      should_write = float_args++ < 8;
	    } else
	    {
	      ival.reg = X0 + other_args;
	      should_write = other_args++ < 8;
	    }
	  if(should_write)
	    {
	      fwrite(&ival, sizeof(interval_t), 1, stream);
	    }
	}
    }
}


void annotate_float_invervals(interval_t *intervals, asm_func_t f)
{
  for(size_t i = 0; i < f.num_insns; ++i)
    {
      switch(f.insns[i].type)
	{
	case ANORM:
	  switch(f.insns[i].value.norm.op)
	    {
	    case AFADD:
	    case AFMUL:
	    case AFSUB:
	    case AFDIV:
	      {
		temps_used_t tmps = get_temps_used(f.insns[i]);
		for(size_t j = 0; j < tmps.num; ++j)
		  intervals[tmps.tmps[j]].is_float = true;
		tmps = get_temps_defd(f.insns[i]);
		for(size_t j = 0; j < tmps.num; ++j)
		  intervals[tmps.tmps[j]].is_float = true;
	      }
	      break;
	    default: {}
	    }
	  break;
	case ACMP:
	  if(f.insns[i].value.cmp.is_float)
	    {
	      temps_used_t tmps = get_temps_used(f.insns[i]);
	      for(size_t j = 0; j < tmps.num; ++j)
		intervals[tmps.tmps[j]].is_float = true;
	    }
	  break;
	default: {}
	}
    }
}

interval_t *get_intervals(asm_func_t f, size_t *num_ivals)
{
  interval_t *intervals = malloc(sizeof(interval_t) * f.num_temps);
  char *call_intervals;
  size_t size_loc;
  FILE *call_interval_stream = open_memstream(&call_intervals, &size_loc);
  printf("%s:\n", f.name);
  for(uint16_t i = 0; i < f.num_temps; ++i)
    {
      intervals[i].temp = i;
      intervals[i].start = -1;
      intervals[i].end = -1;
      intervals[i].is_reg = false;
      intervals[i].is_float = false;
    }
  annotate_float_invervals(intervals, f);
  for(size_t i = 0; i < f.num_args; ++i)
    {
      intervals[i].start = 0;
    }
  for(int i = 0; i < f.num_insns; ++i)
    {
      if(f.insns[i].type == AABSCALL)
	{
	  write_call_intervals(call_interval_stream, f.insns, i);
	  if(f.insns[i].value.abs_call.dest != 0xffff)
	    if(intervals[f.insns[i].value.abs_call.dest].start == -1)
	      intervals[f.insns[i].value.abs_call.dest].start = i;
	  uint16_t num_args = f.insns[i].value.abs_call.num_args;
	  for(size_t x = 0; x < num_args; x += 32)
	      {
		for(size_t argi = 0; x * 32 + argi < num_args && argi < 32; ++argi)
		  {
		    intervals[f.insns[i + 1 + x/32].value
			      .abs_call_ext.typed_temps[argi] & 0xffff].end = max
		      (intervals[f.insns[i + 1 + x/32].value
				 .abs_call_ext.typed_temps[argi] & 0xffff].end, i);
		    if(intervals[f.insns[i + 1 + x/32].value
				 .abs_call_ext.typed_temps[argi] & 0xffff].start == -1)
		      intervals[f.insns[i + 1 + x/32].value
				.abs_call_ext.typed_temps[argi] & 0xffff].start = i;
		  }
		++i;
              }
	} else
	{
	  temps_used_t t = get_temps_used(f.insns[i]);
	  for(size_t j = 0; j < t.num; ++j)
	    {
	      intervals[t.tmps[j]].end = max(intervals[t.tmps[j]].end, i);
	      if(intervals[t.tmps[j]].start == -1)
		intervals[t.tmps[j]].start = i;
	    }
	  temps_used_t defd = get_temps_defd(f.insns[i]);
	  for(size_t j = 0; j < defd.num; ++j)
	    {
	      if(intervals[defd.tmps[j]].start == -1)
		intervals[defd.tmps[j]].start = i;
	    }
	}
    }
  fclose(call_interval_stream);
  *num_ivals = f.num_temps + size_loc / sizeof(interval_t);
  intervals = realloc(intervals, *num_ivals * sizeof(interval_t));
  memcpy(intervals + f.num_temps, call_intervals, size_loc);
  free(call_intervals);
  qsort(intervals, *num_ivals, sizeof(interval_t), cmp_interval_start);
  return intervals;
}


/**
 * any register in [0, top] is available for use
 */
typedef struct reg_pool
{
  int top;
  arm_reg_t regs[32];
} reg_pool_t;



bool is_float_reg(arm_reg_t r)
{
  switch (r)
    {
    case D0:
    case D1:
    case D2:
    case D3:
    case D4:
    case D5:
    case D6:
    case D7:
    case D8:
    case D9:
    case D10:
    case D11:
    case D12:
    case D13:
    case D14:
    case D15:
    case D16:
    case D17:
    case D18:
    case D19:
    case D20:
    case D21:
    case D22:
    case D23:
    case D24:
    case D25:
    case D26:
    case D27:
    case D28:
    case D29:
    case D30:
    case D31: return true;
    default: return false;
    }
}

static inline const char *reg_to_string(arm_reg_t reg)
{
  switch(reg)
    {
    case SP: return "sp"; case X0: return "x0"; case X1: return "x1";
    case X2: return "x2"; case X3: return "x3"; case X4: return "x4";
    case X5: return "x5"; case X6: return "x6"; case X7: return "x7";
    case X8: return "x8"; case X9: return "x9"; case X10: return "x10";
    case X11: return "x11"; case X12: return "x12"; case X13: return "x13";
    case X14: return "x14"; case X15: return "x14"; case X16: return "x16";
    case X17: return "x17"; case X18: return "x18"; case X19: return "x19";
    case X20: return "x20"; case X21: return "x21"; case X22: return "x22";
    case X23: return "x23"; case X24: return "x24"; case X25: return "x25";
    case X26: return "x26"; case X27: return "x27"; case X28: return "x28";
    case X29: return "x29"; case X30: return "x30"; case XZR: return "xzr";
    case D0: return "d0"; case D1: return "d1"; case D2: return "d2";
    case D3: return "d3"; case D4: return "d4"; case D5: return "d5";
    case D6: return "d6"; case D7: return "d7"; case D8: return "d8";
    case D9: return "d9"; case D10: return "d10"; case D11: return "d11";
    case D12: return "d12"; case D13: return "d13"; case D14: return "d14";
    case D15: return "d15"; case D16: return "d16"; case D17: return "d17";
    case D18: return "d18"; case D19: return "d19"; case D20: return "d20";
    case D21: return "d21"; case D22: return "d22"; case D23: return "d23";
    case D24: return "d24"; case D25: return "d25"; case D26: return "d26";
    case D27: return "d27"; case D28: return "d28"; case D29: return "d29";
    case D30: return "d30"; case D31: return "d31";
    }
}


static inline void print_regpool(reg_pool_t *pool)
{
  for(size_t i = 0; i < pool->top; ++i)
    {
      printf("%s ", reg_to_string(pool->regs[i]));
    }
  putchar(10);
}

static inline  void remove_from_pool(arm_reg_t r, reg_pool_t *pool)
{
  /* print_regpool(pool); */
  /* printf("removing %s\n", reg_to_string(r)); */
  for(size_t i = pool->top; i < pool->top; ++i)
    {
      if(pool->regs[i] == r)
	{
	  memmove(&(pool->regs[i]), &(pool->regs[i + 1]), (pool->top - (i + 1)) * sizeof(arm_reg_t));
	  --(pool->top);
	  print_regpool(pool);
	  return;
	}
    }
  /* print_regpool(pool); */
}



void expire_old_intervals(interval_t i, interval_t **active, size_t *num_active,
			  reg_pool_t *float_pool, reg_pool_t *int_pool)
{
  /* printf("float: "); */
  /* print_regpool(float_pool); */
  /* printf("gener: "); */
  /* print_regpool(int_pool); */
  /* print_active(active, *num_active); */
  /* printf("current start: %d\n", i.start); */
  qsort(active, *num_active, sizeof(interval_t*), cmp_interval_ptr_end);
  size_t active_shift = 0;
  for(size_t j = 0; j < *num_active; ++j)
    {
      if(active[j]->end >= i.start)
        break;
      active_shift = j + 1;
      if(is_float_reg(active[j]->reg))
	float_pool->regs[++(float_pool->top)] = active[j]->reg;
      else
	int_pool->regs[++(int_pool->top)] = active[j]->reg;
    }
  *num_active -= active_shift;
  memmove(active, active + active_shift, *num_active * sizeof(interval_t*));
  /* puts("after"); */
  /* print_active(active, *num_active); */
}

void spill_at_interval(interval_t *i, interval_t **active, size_t *num_active,
		       reg_pool_t *float_pool, reg_pool_t *int_pool, size_t *stack_locs)
{
  interval_t *spill = active[(*num_active - 1)];
  if(spill->end > i->end && spill->temp != 0xffff)
    {
      i->is_reg = true;
      i->reg = spill->reg;
      spill->stack_loc = (*stack_locs += 8);
      spill->is_reg = false;
      active[*num_active - 1] = i;
      qsort(active, *num_active, sizeof(interval_t), cmp_interval_ptr_end);
    } else
    {
      i->is_reg = false;
      i->stack_loc = (*stack_locs += 8);
    }
}

static inline size_t floats_active(reg_pool_t *pool) {return pool->top;}//{ return 30 - pool->top; }

static inline size_t ints_active(reg_pool_t *pool) {return pool->top;}//{return 29 - pool->top; }

interval_t *lin_allocate(asm_prog_t p, size_t which_fun, size_t *num_intervals,
			 size_t *stack_locs)
{
  interval_t *intervals = get_intervals(p.funcs[which_fun], num_intervals);
  interval_t **active = malloc(sizeof(interval_t*) * 128);
  reg_pool_t float_pool = (reg_pool_t)
    {.top = 29,
     .regs = {D31, D30, D29, D28, D27, D26, D25, D24, D23, D22, D21, D20, D19, D18,
       D17, D16, D15, D14, D13, D12, D11, D10, D9, D8, D7, D6, D5, D4, D3, D2,}};
  reg_pool_t int_pool = (reg_pool_t)
    {.top = 26,
     .regs = {X28, X27, X26, X25, X24, X23, X22, X21, X20, X19, X18,
       X17, X16, X15, X14, X13, X12, X11, X10, X9, X8, X7, X6, X5, X4, X3, X2,}};
  size_t num_active = 0;
  for(size_t i = 0; i < *num_intervals; ++i)
    {
       expire_old_intervals(intervals[i], active, &num_active, &float_pool, &int_pool);
      if(is_preallocated(intervals + i))
	{
	  if(is_float_reg(intervals[i].reg))
	    remove_from_pool(intervals[i].reg, &float_pool);
	  else
	    remove_from_pool(intervals[i].reg, &int_pool);
	} else
	{
	  if(intervals[i].is_float)
	    {
	      if(float_pool.top == -1)
		spill_at_interval(intervals + i, active, &num_active, &float_pool, &int_pool, stack_locs);
	      else
		{
		  intervals[i].reg = float_pool.regs[float_pool.top--];
		  intervals[i].is_reg = true;
		  /* printf("t%d -> %s\n", intervals[i].temp, reg_to_string(intervals[i].reg)); */
		  active[num_active++] = intervals + i;
		  qsort(active, num_active, sizeof(interval_t*), cmp_interval_ptr_end);
		}
	    } else
	    {
	      if(int_pool.top == -1)
		spill_at_interval(intervals + i, active, &num_active, &float_pool, &int_pool, stack_locs);
	      else
		{
		  intervals[i].reg = int_pool.regs[int_pool.top--];
		  intervals[i].is_reg = true;
		  /* printf("t%d -> %s\n", intervals[i].temp, reg_to_string(intervals[i].reg)); */
		  active[num_active++] = intervals + i;
		  /* print_active(active, num_active); */
		  qsort(active, num_active, sizeof(interval_t*), cmp_interval_ptr_end);
		}
	    }
	}
    }
  
  for(size_t i = 0; i < *num_intervals; ++i)
    {
      if(intervals[i].is_reg)
	printf("t%d : %s live from %d to %d\n", intervals[i].temp, reg_to_string(intervals[i].reg), intervals[i].start, intervals[i].end);
      else
	printf("t%d : stack %d live from %d to %d\n", intervals[i].temp, intervals[i].stack_loc, intervals[i].start, intervals[i].end);
      /* if(intervals[i].is_reg) */
      /* 	printf("reg: %s live from %d to %d\n", reg_to_string(intervals[i].reg), */
      /* 	       intervals[i].start, intervals[i].end); */
      /* else */
      /* 	printf("t%d: live from %d to %d\n", intervals[i].temp, intervals[i].start, intervals[i].end); */
    }
  free(active);
  return intervals;
}

static inline bool is_saved_reg(arm_reg_t reg)
{
  //TODO IMPLEMENT
  return true;
}

static arm_reg_t *get_saved_used(interval_t *intervals, size_t num_intervals,
				bool save_for_main, size_t *num_used)
{
  bool reg_map[128] = {0};
  if(save_for_main)
    reg_map[X19] = true;
  for(size_t i = 0; i < num_intervals; ++i)
    {
      if(intervals[i].is_reg && is_saved_reg(intervals[i].reg))
	reg_map[intervals[i].reg] = true;
    }
  for(size_t i = 0; i < 128; ++i)
    {
      if(reg_map[i])
	++(*num_used);
    }
  arm_reg_t *used = malloc(*num_used * sizeof(arm_reg_t));
  size_t j = 0;
  for(size_t i = 0; i < 128; ++i)
    {
      if(reg_map[i])
	used[j++] = i;
    }
  return used;
}


size_t linear_prologue(asm_func_t f, FILE *insn_stream, interval_t *intervals,
		       size_t num_intervals, size_t stack_locs)
{
  size_t stack_offset = 8 * stack_locs + 8;
  bool is_main = strcmp(f.name, "main") == 0;
  size_t num_saved_reg = 0;
  arm_reg_t *saved_used = get_saved_used(intervals, num_intervals, is_main &&
					 f.num_args != 0, &num_saved_reg);
  stack_offset -= num_saved_reg;
  if(stack_offset % 16 != 0)
    stack_offset += 8;
  if(stack_offset < 512)
    {
      tagged_arm_insn_t i = (tagged_arm_insn_t)
	{.type = AOTHER, .value = (arm_insn_t) {}};
      sprintf(i.value.other, "\tstp\tx29, x30, [sp, -%ld]!", stack_offset);
      write_insn(i, insn_stream);
    } else
    {
      write_insn((tagged_arm_insn_t)
		 {.type = ANORM, .value = (arm_insn_t)
		  {.norm = (norm_arm_insn_t)
		   {.op = ASUB, .dest = from_reg(SP),
		    .a1 = from_reg(SP), .a2 = from_const(stack_offset)}}},
		       insn_stream);
      tagged_arm_insn_t i = (tagged_arm_insn_t)
	{.type = AOTHER, .value = (arm_insn_t) {}};
      sprintf(i.value.other, "\tstp\tx29, x30, [sp, -%ld]!", stack_offset);
      write_insn(i, insn_stream);
    }
  write_insn(mov(X29, from_reg(SP)), insn_stream);
  //save the saved registers
  for(size_t i = 0; i < num_saved_reg; ++i)
    {
      write_insn((tagged_arm_insn_t)
		 {.type = ASTR, .value = (arm_insn_t)
		  {.str = (str_arm_insn_t)
		   {.value = from_reg(saved_used[i]),
		    .address = from_reg(SP),
		    .offset = stack_offset - 16 - (8 * i)}}}, insn_stream);
    }
  if(is_main && f.num_args != 0)
    {
      write_insn(mov(X19, from_reg(X1)), insn_stream);
      for(size_t i = 0; i < f.num_args; ++i)
	{
	  write_insn((tagged_arm_insn_t)
		     {.type = ALDR, .value = (arm_insn_t)
		      {.ldr = (ldr_arm_insn_t)
		       {.dest = from_reg(X0),
			.address = from_reg(X19),
			.offset = (i + 1) * 8}}}, insn_stream);
	  switch(f.arg_types[i])
	    {
	          case BRILINT:
	      write_insn((tagged_arm_insn_t)
			 {.type = ACALL, .value = (arm_insn_t)
			  {.call = (call_arm_insn_t)
			   {.name = "int_of_string"}}}, insn_stream);
	      write_insn((tagged_arm_insn_t)
			 {.type = ASTR, .value = (arm_insn_t)
			  {.str = (str_arm_insn_t)
			   {.value = from_reg(X0),
			    .address = from_reg(SP),
			    .offset = 16 + i * 8}}}, insn_stream);
	      break;
	    case BRILBOOL:
	      write_insn((tagged_arm_insn_t)
			 {.type = ACALL, .value = (arm_insn_t)
			  {.call = (call_arm_insn_t)
			   {.name = "bool_of_string"}}}, insn_stream);
	      write_insn((tagged_arm_insn_t)
			 {.type = ASTR, .value = (arm_insn_t)
			  {.str = (str_arm_insn_t)
			   {.value = from_reg(X0),
			    .address = from_reg(SP),
			    .offset = 16 + i * 8}}}, insn_stream);
	      break;
	    case BRILFLOAT:
	      write_insn((tagged_arm_insn_t)
			 {.type = ACALL, .value = (arm_insn_t)
			  {.call = (call_arm_insn_t)
			   {.name = "float_of_string"}}}, insn_stream);
	      write_insn((tagged_arm_insn_t)
			 {.type = ASTR, .value = (arm_insn_t)
			  {.str = (str_arm_insn_t)
			   {.value = from_reg(D0),
			    .address = from_reg(SP),
			    .offset = 16 + i * 8}}}, insn_stream);
	      break;
	    default:
	      fprintf(stderr, "main cannot have pointer arguments! Exiting.\n");
	      exit(1);
	    }
	}
    } else {
    size_t double_args = 0, other_args = 0, spilled_args = 0;
    
  }
}


asm_func_t lin_alloc(asm_prog_t p, size_t which_fun)
{
  size_t stack_locs = 0, num_intervals;
  interval_t *intervals = lin_allocate(p, which_fun, &num_intervals, &stack_locs);
  char *mem_stream;
  size_t size_loc;
  FILE *insn_stream = open_memstream(&mem_stream, &size_loc);
  asm_func_t f = p.funcs[which_fun];
  size_t stack_offset = linear_prologue(f, insn_stream, intervals,
					num_intervals, stack_locs);
}

asm_prog_t linear_scan(asm_prog_t p)
{
  asm_func_t *funs = malloc(sizeof(asm_func_t) * p.num_funcs);
  for(size_t i = 0; i < p.num_funcs; ++i)
    funs[i] = lin_alloc(p, i);
  return (asm_prog_t)
    {.funcs = funs,
     .num_funcs = p.num_funcs};
}

#else

asm_prog_t linear_scan(asm_prog_t p)
{
  fprintf(stderr, "arch not supported\n");
  exit(1);
}


#endif
