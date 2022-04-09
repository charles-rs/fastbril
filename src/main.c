#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

#include "json.h"
#include "instrs.h"
#include "parser.h"
#include "byte-io.h"

char* get_stdin()
{
  size_t buf_len = 128;
  char *buffer = malloc(buf_len);
  size_t i = 0;
  while(true)
    {
      //      printf("%s", buffer);
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

int main(int argc, char **argv)
{
  char *string = get_stdin();
  struct json_value_s *root = json_parse(string, strlen(string));
  struct json_object_s *functions = root->payload;
  program_t *prog = parse_program(functions);
  FILE *f = fopen("my-output", "w+");
  output_program(prog, f);
  fclose(f);
  free(string);
  free(root);
  free_program(prog);
  printf("%ld\n", sizeof(instruction_t));
  return 0;
}

