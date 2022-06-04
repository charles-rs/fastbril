#ifndef ASM_UTIL_H
#define ASM_UTIL_H

#include "asm.h"
#include <stdio.h>

void write_insn(asm_insn_t insn, FILE *insn_stream);

#ifdef __ARM_ARCH

arm_arg_tagged_t from_tmp(uint16_t tmp);

arm_arg_tagged_t from_reg(arm_reg_t r);

arm_arg_tagged_t from_const(int16_t num);

arm_arg_tagged_t from_uconst(uint16_t num);

tagged_arm_insn_t mov(arm_reg_t dest, arm_arg_tagged_t src);

arm_arg_tagged_t float_arg_reg(int n);

arm_arg_tagged_t norm_arg_reg(int n);

tagged_arm_insn_t movd(arm_arg_tagged_t dest, arm_reg_t src);

#endif


#endif
