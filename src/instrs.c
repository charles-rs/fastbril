#include "instrs.h"

inline uint16_t get_opcode(instruction_t i)
{
  return abs(i.norm_insn.opcode_lbled);
}
inline bool is_labelled(instruction_t i)
{
  return i.norm_insn.opcode_lbled < 0;
}


void free_program(program_t *prog)
{
  for(size_t i = 0; i < prog->num_funcs; ++i)
    {
      free(prog->funcs[i].name);
      free(prog->funcs[i].insns);
    }
  free(prog);
}
