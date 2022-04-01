#ifndef BYTE_OUTPUT_H
#define BYTE_OUTPUT_H
#include "instrs.h"
#include <stdio.h>

void output_program(program_t *prog, FILE *dest);

program_t *read_program(FILE *source);

#endif
