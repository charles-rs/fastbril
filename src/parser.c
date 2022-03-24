#include "parser.h"
#include "hashmap.h"
#include <stdio.h>

#define TEST_OP(s, ret) if(strcmp(s, str) == 0) { return (ret);}

uint16_t opcode_of_string(const char *str)
{
  printf("op: %s\n", str);
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
  return 0xffff;
}

uint16_t type_of_string(const char *str)
{
  TEST_OP( "int",    BRILINT);
  TEST_OP( "bool",   BRILBOOL);
  TEST_OP( "float",  BRILFLOAT);
  if(strncmp(str, "ptr<", 4) == 0)
    return BRILPTR;
  return 0xffff;
}

typedef struct string_uint16
{
  const char *str;
  uint16_t num;
} hashdat;

uint64_t hashfun(const void *item, uint64_t seed0, uint64_t seed1) {
    const struct string_uint16 *val = item;
    return hashmap_sip(val->str, strlen(val->str), seed0, seed1);
}

int hash_compare(const void *a, const void *b, void *udata) {
    const struct string_uint16 *ua = a;
    const struct string_uint16 *ub = b;
    return strcmp(ua->str, ub->str);
}

uint16_t parse_temp(struct json_value_s *tmp,
		    struct hashmap *tmp_map,
		    uint16_t *num_tmps)
{
  const char *nm = json_value_as_string(tmp)->string;
  hashdat *precomped = hashmap_get(tmp_map, &(hashdat){.str = nm});
  if (precomped)
    {
      //printf("found %s -> %d\n", nm, precomped->num);
      return precomped->num;
    } else
    {
      uint16_t tmp  = *num_tmps;
      *num_tmps = *num_tmps + 1;
      hashmap_set(tmp_map, &(hashdat){.str = nm, .num = tmp});
      // printf("computed %s -> %d\n", nm, tmp);
      return tmp;
    }
}

uint16_t parse_lbls(struct json_value_s *lbl,
		    struct hashmap *prt_lbl_map,
		    const char **idx_to_lbl,
		    uint16_t *num_lbls)
{
  const char *nm = json_value_as_string(lbl)->string;
  hashdat *precomped = hashmap_get(prt_lbl_map, &(hashdat){.str = nm});
  if (precomped)
    {
      printf("LBL: found %s -> %d\n", nm, precomped->num);
      return precomped->num;
    } else
    {
      uint16_t new_lbl = (*num_lbls)++;
      hashmap_set(prt_lbl_map, &(hashdat){.str = nm, .num = new_lbl});
      idx_to_lbl[new_lbl] = nm;
      printf("LBL: computed %s -> %d\n", nm, new_lbl);
      return new_lbl;
    }
}

/* returns new pointer to where to insert instructions */
size_t parse_instruction(struct json_object_s *json,
			 instruction_t **insns,
			 size_t dest,
			 size_t *insn_length,
			 uint16_t *next_labelled,
			 struct hashmap *lbl_map,
			 struct hashmap *tmp_map,
			 struct hashmap *prt_lbl_map,
			 const char **idx_to_lbl,
			 uint16_t *num_lbls,
			 uint16_t *num_tmps,
			 uint16_t *tmp_types
			 )
// when see label: string -> instruction index
// when see jmp lbl: prt_lbl_map[lbl] || {prt_lbl_map[lbl] = *num_lbls;
///                                       idx_to_lbl[*num_lbls] = lbl;
//                                        ++*num_lbls;}
// when see jmp:   (string, ordered index)
{

  struct json_object_element_s *field = json->start;
  int16_t tagged_opcode = -1;
  uint16_t opcode;
  uint16_t insn_dest = 0xffff;
  bool is_label = false;
  uint16_t *args = 0;

  size_t numargs = 0;
  size_t num_cur_lbls = 0;
  uint16_t *lbls = 0;
  uint16_t type = 0xffff;
  uint64_t value = -1;
  
  while(field)
    {
      if(strcmp(field->name->string, "op") == 0)
	{
	  tagged_opcode = opcode_of_string(json_value_as_string(field->value)->string)
	    * (*next_labelled ? -1 : 1);
	  opcode = abs(tagged_opcode);
	} else if (strcmp(field->name->string, "label") == 0)
	{
	  is_label = true;
	  const char *nm = json_value_as_string(field->value)->string;
	  printf("label: %s\n", nm);
	  hashmap_set(lbl_map, &(hashdat){.str = nm, .num = dest});
	} else if (strcmp(field->name->string, "dest") == 0)
	{
	  insn_dest = parse_temp(field->value, tmp_map, num_tmps);
	} else if (strcmp(field->name->string, "args") == 0)
	{
	  struct json_array_s *arr = field->value->payload;
	  numargs = arr->length;
	  args = malloc(sizeof(uint16_t) * numargs);
	  struct json_array_element_s *elem = arr->start;
	  for(int i = 0; i < numargs; ++i)
	    {
	      args[i] = parse_temp(elem->value, tmp_map, num_tmps);
	      elem = elem->next;
	    }
	} else if (strcmp(field->name->string, "labels") == 0)
	{
	  struct json_array_s *arr = field->value->payload;
	  num_cur_lbls = arr->length;
	  lbls = malloc(sizeof(uint16_t) * num_cur_lbls);
	  struct json_array_element_s *elem = arr->start;
	  for(int i = 0; i < num_cur_lbls; ++i)
	    {
	      lbls[i] = parse_lbls(elem->value, prt_lbl_map, idx_to_lbl, num_lbls);
	      elem = elem->next;
	    }
	} else if (strcmp(field->name->string, "type") == 0)
	{
	  const char *nm = json_value_as_string(field->value)->string;
	  type = type_of_string(nm);
	} else if (strcmp(field->name->string, "value") == 0)
	{
	  value = strtoll(json_value_as_number(field->value)->number, 0, 0);
	}
      field = field->next;
    }
  /* add this variable to the type map (maybe) */
  if(type != 0xffff)
    {
      tmp_types[insn_dest] = type;
    }
  size_t extra_words_needed = 0;
  if(opcode == PHI)
    {
      extra_words_needed = (numargs << 1);
    } else if (opcode == PRINT)
    {
      extra_words_needed = ((numargs - 1) << 1);
    } else if (opcode == CONST)
    {
      if ((int64_t) ((int16_t) value) != value)
	{
	  opcode = LCONST;
	  tagged_opcode = (tagged_opcode < 0 ? -opcode : opcode);
	  extra_words_needed = 1;
	}
    }
  /* realloc when we run out of space */
  if(dest + extra_words_needed >= *insn_length)
    {
      printf("reallocing...\n");
      (*insn_length) *= 2;
      *insns = realloc(*insns, *insn_length);
    }
  if(opcode == PHI)
    {
      (*insns)[dest].phi_inst = ((phi_inst_t) {
	.opcode_lbled = tagged_opcode,
	.dest = insn_dest,
	.num_choices = numargs
	});
      for(size_t phi_ext_idx = 0; phi_ext_idx < numargs; phi_ext_idx += 2)
	{
	  phi_extension_t ext;
	  ext.lbl1 = lbls[phi_ext_idx * 2];
	  ext.val1 = args[phi_ext_idx * 2];
	  if(phi_ext_idx * 2 + 1 < numargs)
	    {
	      ext.lbl2 = lbls[phi_ext_idx * 2 + 1];
	      ext.val2 = args[phi_ext_idx * 2 + 1];
	    }
	  (*insns)[dest + phi_ext_idx + 1].phi_ext = ext;
	}
    }
  
  *next_labelled = is_label ? 1 : 0;
  printf("args: ");
  for(int i = 0; i < numargs; ++i)
    {
      printf("%d, ", args[i]);
    }
  printf("\n");
  if(args)
    free(args);
  if(lbls)
    free(lbls);
  if(is_label)
    return dest;
  return dest + 1 + extra_words_needed;
}


instruction_t *parse_instructions(struct json_array_s* json)
{
  size_t insn_len = 32;
  instruction_t *insns = malloc(sizeof(instruction_t) * insn_len);
  struct hashmap *lbl_map = hashmap_new(sizeof(struct string_uint16), 0, 0, 0,
					hashfun, hash_compare, NULL, NULL);
  struct hashmap *tmp_map = hashmap_new(sizeof(struct string_uint16), 0, 0, 0,
					hashfun, hash_compare, NULL, NULL);
  struct hashmap *prt_lbl_map = hashmap_new(sizeof(struct string_uint16), 0, 0, 0,
					    hashfun, hash_compare, NULL, NULL);
  struct json_array_element_s *tmp = json->start;
  size_t dest = 0;
  uint16_t next_labelled = 0;
  uint16_t num_temps = 0;
  uint16_t num_lbls = 0;
  const char **idx_to_lbl = malloc(sizeof(char*) * json->length);
  uint16_t *tmp_types = malloc(sizeof(uint16_t) * json->length);
  for(int i = 0; i < json->length; ++i)
    {
      dest = parse_instruction(json_value_as_object(tmp->value), &insns,
			       dest, &insn_len, &next_labelled,
			       lbl_map, tmp_map, prt_lbl_map, idx_to_lbl,
			       &num_lbls, &num_temps, tmp_types);
      tmp = tmp->next;
    }
  hashmap_free(lbl_map);
  hashmap_free(tmp_map);
  hashmap_free(prt_lbl_map);
  free(idx_to_lbl);
  free(tmp_types);
  return insns;
}

