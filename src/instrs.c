#include "instrs.h"

inline uint16_t get_opcode(const instruction_t i)
{
  return i.norm_insn.opcode_lbled & 0x7fff;
}
inline bool is_labelled(const instruction_t i)
{
  return i.norm_insn.opcode_lbled & 0x8000;
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



char type_to_char[5] = {'i', 'b', 'f', 'p', 'v'};

