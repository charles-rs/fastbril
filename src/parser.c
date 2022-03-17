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
      printf("found %s -> %d\n", nm, precomped->num);
      return precomped->num;
    } else
    {
      uint16_t tmp  = *num_tmps;
      *num_tmps = *num_tmps + 1;
      hashmap_set(tmp_map, &(hashdat){.str = nm, .num = tmp});
      printf("computed %s -> %d\n", nm, tmp);
      return tmp;
    }
}

/* returns new pointer to where to insert instructions */
size_t parse_instruction(struct json_object_s *json,
			 instruction_t *insns,
			 size_t dest,
			 size_t *insn_length,
			 uint16_t *next_labelled,
			 struct hashmap *lbl_map,
			 struct hashmap *tmp_map,
			 uint16_t *num_tmps
			 )
{
  struct json_object_element_s *field = json->start;
  uint16_t opcode = 0xffff;
  uint16_t insn_dest;
  bool is_label = false;
  uint16_t *args;

  size_t numargs = 0;
  while(field)
    {
      if(strcmp(field->name->string, "op") == 0)
	{
	  opcode = opcode_of_string(json_value_as_string(field->value)->string)
	    | (*next_labelled << 15);
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
	}
      field = field->next;
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
  if(!is_label)
    return dest + 1;
  return dest;
}


instruction_t *parse_instructions(struct json_array_s* json)
{
  instruction_t *insns = malloc(sizeof(instruction_t) * 32);
  struct hashmap *lbl_map = hashmap_new(sizeof(struct string_uint16), 0, 0, 0,
					hashfun, hash_compare, NULL, NULL);
  struct hashmap *tmp_map = hashmap_new(sizeof(struct string_uint16), 0, 0, 0,
					hashfun, hash_compare, NULL, NULL);
  struct json_array_element_s *tmp = json->start;
  size_t dest = 0;
  uint16_t next_labelled = 0;
  uint16_t num_temps = 0;
  for(int i = 0; i < json->length; ++i)
    {
      dest = parse_instruction(json_value_as_object(tmp->value), insns,
			       dest, 0, &next_labelled,
			       lbl_map, tmp_map, &num_temps);
      tmp = tmp->next;
    }
  hashmap_free(lbl_map);
  hashmap_free(tmp_map);
  return insns;
}

