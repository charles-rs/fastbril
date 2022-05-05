#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

#include "json.h"
#include "instrs.h"
#include "parser.h"
#include "byte-io.h"
#include "interp.h"
#include "pretty-printer.h"
#include "emission.h"

/* Bit masks for cmd flags/modes */
#define OUTPUT_BYTECODE 0x0001
#define COUNT_INSNS     0x0002
#define NO_INTERPRET    0x0004
#define PRINT_OUT       0x0008
#define EMIT_ASM        0x0010

/**
 * read the contents of stdin and return a single heap allocated string.
 */
char* get_stdin()
{
  size_t buf_len = 128;
  char *buffer = malloc(buf_len);
  size_t i = 0;
  while(true)
    {
      if(i == buf_len - 1)
	{
	  buf_len *= 2;
	  buffer = realloc(buffer, buf_len);
	}
      int c = getchar();
      if(c == EOF)
	{
	  buffer[i] = 0x00;
	  break;
	}
      buffer[i] = c;
      ++i;
    }
  return buffer;
}

/**
 * turn a string into a value_t that can be used by the interpreter
 */
value_t parse_argument(const char *str)
{
  if(strcmp(str, "true") == 0)
    return (value_t) {.int_val = 1};
  else if(strcmp(str, "false") == 0)
    return (value_t) {.int_val = 1};
  else
    {
      char *end = 0;
      long tmp = strtol(str, &end, 0);
      if(*end == '\0')
	return (value_t) {.int_val = tmp};
      else
	{
	  double tmp = strtod(str, &end);
	  if(*end == '\0')
	    return (value_t) {.float_val = tmp};
	  else
	    {
	      fprintf(stderr, "unrecognized argument %s. exiting.\n", str);
	      exit(1);
	    }
	}
    }
}

int main(int argc, char **argv)
{
  long options = 0;
  char *out_file;
  value_t *args = malloc(sizeof(value_t) * argc);
  size_t argidx = 0;
  for(int i = 1; i < argc; ++i)
    {
      if(strcmp(argv[i], "-p") == 0)
	options |= COUNT_INSNS;
      else if(strcmp(argv[i], "-bo") == 0)
	{
	  options |= OUTPUT_BYTECODE;
	  out_file = argv[++i];
	}
      else if(strcmp(argv[i], "-pr") == 0)
	options |= PRINT_OUT;
      else if(strcmp(argv[i], "-ni") == 0)
	options |= NO_INTERPRET;
      else if(strcmp(argv[i], "-e") == 0)
	options |= EMIT_ASM;
      else
	{
	  args[argidx++] = parse_argument(argv[i]);
	}
    }
  char *string = get_stdin();
  struct json_value_s *root = json_parse(string, strlen(string));
  struct json_object_s *functions = root->payload;
  program_t *prog = parse_program(functions);
  if(options & OUTPUT_BYTECODE)
    {
      FILE *f = fopen("my-output", "w+");
      output_program(prog, f);
      fclose(f);
    }
  if(!(options & NO_INTERPRET))
    interp_main(prog, args, argidx, options & COUNT_INSNS);
  if(options & PRINT_OUT)
    format_program(stdout, prog);
  if(options & EMIT_ASM)
    {
      FILE *f = fopen("output.s", "w+");
      emit_program(f, "unknown.bril", prog);
      fclose(f);
    }
  free(string);
  free(root);
  free(args);
  free_program(prog);
  return 0;
}

