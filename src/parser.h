#ifndef PARSER_H
#define PARSER_H

#include "json.h"
#include "instrs.h"

/**
 * parses a program...
 */
program_t *parse_program(struct json_object_s *json);
#endif
