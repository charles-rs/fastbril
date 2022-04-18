#ifndef EMISSION_H
#define EMISSION_H
#include "instrs.h"
#include <stdio.h>

void emit_program(FILE *stream, const char *src_file, program_t *prog);

#endif
