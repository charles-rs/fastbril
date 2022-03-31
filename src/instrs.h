#ifndef INSTRS_H
#define INSTRS_H
#include <stdint.h>
#include <stdbool.h>
#include <stdlib.h>

/* opcodes */
#define CONST  1
#define ADD    2
#define MUL    3
#define SUB    4
#define DIV    5
#define EQ     6
#define LT     7
#define GT     8
#define LE     9
#define GE     10
#define NOT    11
#define AND    12
#define OR     13
#define JMP    14
#define BR     15
#define CALL   16
#define RET    17
#define PRINT  18
#define PHI    19
#define ALLOC  20
#define FREE   21
#define STORE  22
#define LOAD   23
#define PTRADD 24
#define FADD   25
#define FMUL   26
#define FSUB   27
#define FDIV   28
#define FEQ    29
#define FLT    30
#define FLE    31
#define FGT    32
#define FGE    33
#define LCONST 34
#define NOP    35
#define ID     36

/* BRIL types */
#define BRILINT   0
#define BRILBOOL  1
#define BRILFLOAT 2
#define BRILPTR   3

typedef struct norm_instruction
{
  int16_t opcode_lbled;
  uint16_t dest;
  uint16_t arg1;
  uint16_t arg2;
} norm_instruction_t;

typedef struct br_inst
{
  int16_t opcode_lbled;
  uint16_t test;
  uint16_t ltrue;
  uint16_t lfalse;
} br_inst_t;

typedef struct call_inst
{
  int16_t opcode_lbled;
  uint16_t dest;
  uint16_t num_args;
  uint16_t target;
} call_inst_t;

typedef struct call_args
{
  uint16_t arg1;
  uint16_t arg2;
  uint16_t arg3;
  uint16_t arg4;
} call_args_t;

typedef struct phi_inst
{
  int16_t opcode_lbled;
  uint16_t dest;
  uint16_t num_choices;
  uint16_t __unused;
} phi_inst_t;

typedef struct phi_extension
{
  uint16_t lbl1;
  uint16_t val1;
  uint16_t lbl2;
  uint16_t val2;
} phi_extension_t;

typedef struct const_instr
{
  int16_t opcode_lbled;
  uint16_t dest;
  int32_t value;
} const_instr_t;

typedef union const_extn
{
  int64_t int_val;
  double float_val;
} const_extn_t;

typedef struct print_instr
{
  int16_t opcode_lbled;
  uint16_t num_prints;
  uint16_t type1;
  uint16_t arg1;
} print_instr_t;

typedef struct print_args
{
  uint16_t type1;
  uint16_t arg1;
  uint16_t type2;
  uint16_t arg2;
} print_args_t;

typedef union instruction
{
  norm_instruction_t norm_insn;
  br_inst_t br_inst;
  phi_inst_t phi_inst;
  phi_extension_t phi_ext;
  const_instr_t const_insn;
  const_extn_t const_ext;
  print_instr_t print_insn;
  print_args_t print_args;
  call_inst_t call_inst;
  call_args_t call_args;
} instruction_t;


typedef struct function
{
  char *name;
  size_t num_insns;
  instruction_t *insns;
} function_t;


typedef struct program
{
  size_t num_funcs;
  function_t funcs[];
} program_t;

void free_program(program_t *prog);

uint16_t get_opcode(instruction_t);
bool is_labelled(instruction_t i);

#endif
