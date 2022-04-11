#ifndef PRETTY_PRINTER_H
#define PRETTY_PRINTER_H
#include "instrs.h"
#include <stdio.h>

size_t format_insn(FILE *stream, program_t *prog, instruction_t *insns, size_t idx);

void format_program(FILE *stream, program_t *prog);

#endif
