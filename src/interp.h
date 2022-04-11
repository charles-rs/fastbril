#ifndef INTERP_H
#define INTERP_H
#include "stdint.h"
#include "instrs.h"

typedef union value
{
  int64_t int_val;
  double float_val;
  union value* ptr_val;
} value_t;


value_t interp_fun(program_t *prog, size_t *dyn_insns,
		   size_t which_fun, value_t *args, size_t num_args);

void interp_main(program_t *prog, value_t *args, size_t num_args, bool count_insns);

#endif
