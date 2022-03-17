#ifndef PARSER_H
#define PARSER_H

#include "json.h"
#include "instrs.h"


instruction_t *parse_instructions(struct json_array_s*);
#endif
