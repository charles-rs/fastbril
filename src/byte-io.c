#include "byte-io.h"



void output_function(function_t *func, FILE *dest)
{
  fprintf(dest, "%s\n", func->name);
  fwrite(&func->num_insns, sizeof(size_t), 1, dest);
  printf("there are %ld insns!\n", func->num_insns);
  fwrite(func->insns, sizeof(instruction_t), func->num_insns, dest);
}

void output_program(program_t *prog, FILE *dest)
{
  //printf("%ld\n", prog->num_funcs);
  fwrite(&prog->num_funcs, sizeof(size_t), 1, dest);
  for(size_t i = 0; i < prog->num_funcs; ++i)
    {
      output_function(&prog->funcs[i], dest);
    }
}

void read_function(function_t *dest, FILE *source)
{
  char *name = malloc(512); /* don't make function names longer than this lmao */
  fscanf(source, "%s\n", name);
  dest->name = name;
  fread(&dest->num_insns, sizeof(size_t), 1, source);
  instruction_t *insns = malloc(sizeof(instruction_t) * dest->num_insns);
  fread(insns, sizeof(instruction_t), dest->num_insns, source);
  dest->insns = insns;
}


program_t *read_program(FILE *source)
{
  size_t num_funcs;
  fread(&num_funcs, sizeof(size_t), 1, source);
  program_t *prog = malloc(sizeof(prog) + sizeof(function_t) * num_funcs);
  prog->num_funcs = num_funcs;
  for(size_t i = 0; i < num_funcs; ++i)
    read_function(prog->funcs + i, source);
  return prog;
}
