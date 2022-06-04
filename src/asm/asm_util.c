#include "asm_util.h"
#include <stdlib.h>


void write_insn(asm_insn_t insn, FILE *insn_stream)
{
  fwrite(&insn, INSN_SIZE, 1, insn_stream);
}

#ifdef __ARM_ARCH

arm_arg_tagged_t from_tmp(uint16_t tmp)
{
  return (arm_arg_tagged_t) {.type = TMP, .value = (arm_arg_t) {.tmp = tmp}};
}


arm_arg_tagged_t from_reg(arm_reg_t r)
{
  return (arm_arg_tagged_t) {.type = REG, .value = (arm_arg_t) {.reg = r}};
}

arm_arg_tagged_t from_const(int16_t num)
{
  return (arm_arg_tagged_t) {.type = CNST, .value = (arm_arg_t) {.cnst = num}};
}

arm_arg_tagged_t from_uconst(uint16_t num)
{
  return (arm_arg_tagged_t) {.type = CNST, .value = (arm_arg_t) {.cnst = num}};
}

tagged_arm_insn_t mov(arm_reg_t dest, arm_arg_tagged_t src)
{
  switch(src.type)
    {
    case REG:
      return (tagged_arm_insn_t)
	{.type = AMOV, .value = (arm_insn_t)
	 {.mov = (mov_arm_insn_t)
	  {.dest = from_reg(dest), .src = src}}};
    case CNST:
      return (tagged_arm_insn_t)
	{.type = AMOV, .value = (arm_insn_t)
	 {.mov = (mov_arm_insn_t)
	  {.dest = from_reg(dest), .src = src}}};
    case TMP:
      return (tagged_arm_insn_t)
	{.type = ALDR, .value = (arm_insn_t)
	 {.ldr = (ldr_arm_insn_t)
	  {.dest = from_reg(dest),
	   .address = from_reg(SP),
	   .offset = 16 + src.value.tmp * 8}}};
    }
}

arm_arg_tagged_t float_arg_reg(int n)
{
  switch (n)
    {
    case 0: return from_reg(D0);
    case 1: return from_reg(D1);
    case 2: return from_reg(D2);
    case 3: return from_reg(D3);
    case 4: return from_reg(D4);
    case 5: return from_reg(D5);
    case 6: return from_reg(D6);
    case 7: return from_reg(D7);
    }
  fprintf(stderr, "invalid float arg %d\n", n);
  exit(1);
}


arm_arg_tagged_t norm_arg_reg(int n)
{
  switch (n)
    {
    case 0: return from_reg(X0);
    case 1: return from_reg(X1);
    case 2: return from_reg(X2);
    case 3: return from_reg(X3);
    case 4: return from_reg(X4);
    case 5: return from_reg(X5);
    case 6: return from_reg(X6);
    case 7: return from_reg(X7);
    }
  fprintf(stderr, "invalid regular arg %d\n", n);
  exit(1);
}

tagged_arm_insn_t movd(arm_arg_tagged_t dest, arm_reg_t src)
{
  switch(dest.type)
    {
    case REG:
      return (tagged_arm_insn_t)
	{.type = AMOV, .value = (arm_insn_t)
	 {.mov = (mov_arm_insn_t)
	  {.dest = dest, .src = from_reg(src)}}};
    case TMP:
      return (tagged_arm_insn_t)
	{.type = ASTR, .value = (arm_insn_t)
	 {.str = (str_arm_insn_t)
	  {.value = from_reg(src),
	   .address = from_reg(SP),
	   .offset = 16 + dest.value.tmp * 8}}};
    default:
      fprintf(stderr, "cannot move into a constant\n");
      exit(1);
    }
}

#endif
