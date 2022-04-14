#include "pretty-printer.h"
#include <string.h>
#include <ctype.h>

#define TEST_OP(s, o) if(o == op) {return s;}

static inline char *type_to_string(uint16_t op)
{
  TEST_OP( "int",    BRILINT);
  TEST_OP( "bool",   BRILBOOL);
  TEST_OP( "float",  BRILFLOAT);
  TEST_OP( "ptr<>",  BRILPTR);
  return "";
}

static inline char *base_type_to_string(char tp)
{
  switch (tp)
    {
    case 'i': return "int";
    case 'f': return "float";
    case 'b': return "bool";
    }
  return "";
}


static inline char *opcode_to_string(uint16_t op)
{
  /* printf("op: %s\n", str); */
  TEST_OP( "nop",    NOP);
  TEST_OP( "const",  CONST);
  TEST_OP( "add",    ADD);
  TEST_OP( "mul",    MUL);
  TEST_OP( "mul",    MUL);
  TEST_OP( "sub",    SUB);
  TEST_OP( "div",    DIV);
  TEST_OP( "eq",     EQ);
  TEST_OP( "lt",     LT);
  TEST_OP( "gt",     GT);
  TEST_OP( "le",     LE);
  TEST_OP( "ge",     GE);
  TEST_OP( "not",    NOT);
  TEST_OP( "and",    AND);
  TEST_OP( "or",     OR);
  TEST_OP( "jmp",    JMP);
  TEST_OP( "br",     BR);
  TEST_OP( "call",   CALL);
  TEST_OP( "ret",    RET);
  TEST_OP( "print",  PRINT);
  TEST_OP( "phi",    PHI);
  TEST_OP( "alloc",  ALLOC);
  TEST_OP( "free",   FREE);
  TEST_OP( "store",  STORE);
  TEST_OP( "load",   LOAD);
  TEST_OP( "ptradd", PTRADD);
  TEST_OP( "fadd",   FADD);
  TEST_OP( "fmul",   FMUL);
  TEST_OP( "fsub",   FSUB);
  TEST_OP( "fdiv",   FDIV);
  TEST_OP( "feq",    FEQ);
  TEST_OP( "flt",    FLT);
  TEST_OP( "fle",    FLE);
  TEST_OP( "fgt",    FGT);
  TEST_OP( "fge",    FGE);
  TEST_OP( "id",     ID);
  return "";
}


void format_fun_name(FILE *stream, const char *fun_name)
{
  putc('@', stream);
  char *num = strrchr(fun_name, '_');
  if(num)
    {
      for(const char *c = fun_name; c != num; ++c)
	putc(*c, stream);
    }
  else
    fprintf(stream, "%s", fun_name);
}



size_t format_insn(FILE *stream, program_t *prog, instruction_t *insns, size_t idx)
{
  if(is_labelled(insns[idx]))
    fprintf(stream, ".L%ld:\n", idx);
  switch(get_opcode(insns[idx]))
    {
    case CONST:
      fprintf(stream, "    t%d = const %d;\n", insns[idx].const_insn.dest,
	      insns[idx].const_insn.value);
      break;
    case ADD:
    case MUL:
    case SUB:
    case DIV:
    case EQ:
    case LT:
    case GT:
    case LE:
    case GE:
    case AND:
    case OR:
    case PTRADD:
    case FADD:
    case FMUL:
    case FSUB:
    case FDIV:
    case FEQ:
    case FLT:
    case FLE:
    case FGT:
    case FGE:
      fprintf(stream, "    t%d = %s t%d t%d;\n", insns[idx].norm_insn.dest,
	      opcode_to_string(get_opcode(insns[idx])),
	      insns[idx].norm_insn.arg1, insns[idx].norm_insn.arg2);
      break;
    case NOT:
    case ID:
    case ALLOC:
    case LOAD:
      fprintf(stream, "    t%d = %s t%d;\n", insns[idx].norm_insn.dest,
	      opcode_to_string(get_opcode(insns[idx])),
	      insns[idx].norm_insn.arg1);
      break;
    case JMP:
      fprintf(stream, "    jmp .L%d;\n", insns[idx].norm_insn.dest);
      break;
    case BR:
      fprintf(stream, "    br t%d .L%d .L%d;\n", insns[idx].br_inst.test,
	      insns[idx].br_inst.ltrue, insns[idx].br_inst.lfalse);
      break;
    case CALL:
      {
	char *target = prog->funcs[insns[idx].call_inst.target].name;
	if(insns[idx].call_inst.dest != 0xffff)
	  {
	    fprintf(stream, "    t%d = call ", insns[idx].call_inst.dest);
	    format_fun_name(stream, target);
	  }
	else
	  {
	    fprintf(stream, "    call ");
	    format_fun_name(stream, target);
	  }
	uint16_t *args = (uint16_t*) (insns + idx + 1);
	for(size_t i = 0; i < insns[idx].call_inst.num_args; ++i)
	  fprintf(stream, " t%d", args[i]);
	fprintf(stream, ";\n");
	return idx + 1 + (insns[idx].call_inst.num_args + 3) / 4;
    }
    case RET:
      if(insns[idx].norm_insn.arg1 == 0xffff)
	fprintf(stream, "    ret;\n");
      else
	fprintf(stream, "    ret t%d;\n", insns[idx].norm_insn.arg1);
      break;
    case PRINT:
      fprintf(stream, "    print");
      uint16_t *args = (uint16_t*) &insns[idx].print_insn.arg1;
      for(size_t i = 0; i < insns[idx].print_insn.num_prints; ++i)
	fprintf(stream, " t%d", args[2 * i]);
      fprintf(stream, ";\n");
      return idx + 1 + insns[idx].print_insn.num_prints / 2;
    case LCONST:
      fprintf(stream, "    t%d = const ", insns[idx].long_const_insn.dest);
      switch(insns[idx].long_const_insn.type)
	{
	case BRILINT:
	  fprintf(stream, "%ld;\n", insns[idx + 1].const_ext.int_val);
	  break;
	case BRILFLOAT:
	  fprintf(stream, "%f;\n", insns[idx + 1].const_ext.float_val);
	  break;
	case BRILBOOL:
	  fprintf(stream, "%s;\n",
		  insns[idx + 1].const_ext.int_val ? "true" : "false");
	}
      return idx + 2;
    case PHI:
      fprintf(stream, "    t%d = phi", insns[idx].phi_inst.dest);
      uint16_t *phi_ext = (uint16_t*) (insns + idx + 1);
      for(size_t i = 0; i < insns[idx].phi_inst.num_choices; ++i)
	fprintf(stream, " t%d .L%d", phi_ext[2 * i + 1], phi_ext[2 * i]);
      fprintf(stream, ";\n");
      return idx + 1 + (insns[idx].phi_inst.num_choices + 1) / 2;
    case STORE:
      fprintf(stream, "    store t%d t%d;\n", insns[idx].norm_insn.arg1,
	      insns[idx].norm_insn.arg2);
      break;
    case FREE:
      fprintf(stream, "    free t%d;\n", insns[idx].norm_insn.arg1);
      break;
    }
  return idx + 1;
}

size_t get_num_args(const char *fun_name)
{
  char *num = strrchr(fun_name, '_');
  return num == 0 ? 0 : strlen(num + 1);
}

const char *next_tp(const char *prev_tp)
{
  if(isdigit(*prev_tp))
    {
      char *end;
      strtol(prev_tp, &end, 10);
      return *(end + 1) == '\0' ? 0 : end + 1;
    } else return *(prev_tp + 1) == '\0' ? 0 : prev_tp + 1;
}


void format_type(FILE *stream, const char *type)
{
  if(isdigit(*type))
    {
      char *end;
      size_t depth = strtol(type, &end, 10);
      for(size_t i = 0; i < depth; ++i)
	fprintf(stream, "ptr<");
      fprintf(stream, "%s", base_type_to_string(*end));
      for(size_t i = 0; i < depth; ++i)
	putc('>', stream);
    } else
    {
      fprintf(stream, "%s", base_type_to_string(*type));
    }
}

void format_fun_header(FILE *stream, const char *fun_name)
{
  putc('@', stream);
  char *num = strrchr(fun_name, '_');
  if(num)
    {
      const char *ret_tp = num + 1;
      for(const char *c = fun_name; c != num; ++c)
	putc(*c, stream);
      putc('(', stream);
      size_t a = 0;
      for(const char *arg_tp = next_tp(ret_tp); arg_tp; arg_tp = next_tp(arg_tp))
	{
	  if(a != 0)
	    fprintf(stream, ", ");
	  fprintf(stream, "t%ld :", a);
	  format_type(stream, arg_tp);
	  ++a;
	}
      putc(')', stream);
      if(*ret_tp != 'v')
	{
	  fprintf(stream, " :");
	  format_type(stream, ret_tp);
	}
    }
  else
    fprintf(stream, "%s", fun_name);
  putc('\n', stream);
}


void format_program(FILE *stream, program_t *prog)
{
  for(size_t f = 0; f < prog->num_funcs; ++f)
    {
      //fprintf(stream, "@%s(", prog->funcs[f].name);
      format_fun_header(stream, prog->funcs[f].name);
      /* for(size_t a = 0; a < get_num_args(prog->funcs[f].name); ++a) */
      /* 	{ */
      /* 	  if(a != 0) */
      /* 	    fprintf(stream, ", "); */
      /* 	  fprintf(stream, "t%ld", a); */
      /* 	} */
      fprintf(stream, "  {\n");
      size_t idx = 0;
      while(idx < prog->funcs[f].num_insns)
	idx = format_insn(stream, prog, prog->funcs[f].insns, idx);
      fprintf(stream, "  }\n\n");
    }
}
