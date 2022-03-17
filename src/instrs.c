#include "instrs.h"

inline uint16_t get_opcode(instruction_t i)
{
  return i.opcode_lbled & 0x7fff;
}
inline bool is_labelled(instruction_t i)
{
  return i.opcode_lbled & 0x8000;
}
