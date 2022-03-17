#ifndef INSTRS_H
#define INSTRS_H
#include <stdint.h>
#include <stdbool.h>

#define NOP    0
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

typedef struct instruction
{
  uint16_t opcode_lbled;
  uint16_t dest;
  uint16_t arg1;
  uint16_t arg2;
} instruction_t;

typedef struct br_inst
{
  uint16_t opcode_lbled;
  uint16_t test;
  uint16_t ltrue;
  uint16_t lfalse;
} br_inst_t;

typedef struct phi_inst
{
  uint16_t opcode_lbled;
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
  uint16_t opcode_lbled;
  uint16_t dest;
  int32_t value;
} const_instr_t;

typedef int64_t const_extn_t;

typedef struct print_instr
{
  uint16_t opcode_lbled;
  uint16_t num_prints;
  uint16_t type1;
  uint16_t arg1;
} print_intrs_t;

typedef struct print_args
{
  uint16_t type1;
  uint16_t arg1;
  uint16_t type2;
  uint16_t arg2;
} print_args_t;

uint16_t get_opcode(instruction_t);
bool is_labelled(instruction_t i);

#endif
