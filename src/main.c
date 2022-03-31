#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

#include "json.h"
#include "instrs.h"
#include "parser.h"

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
  /* struct json_array_s *function_arr = functions->start->value->payload; */
  /* struct json_object_s *funcarr[function_arr->length]; */
  /* struct json_array_element_s *tmp = function_arr->start; */
  /* for(int i = 0; i < function_arr->length; ++i) */
  /*   { */
  /*     funcarr[i] = tmp->value->payload; */
  /*     tmp = tmp->next; */
  /*   } */
  /* for(int i = 0; i < function_arr->length; ++i) */
  /*   { */
  /*     struct json_object_element_s *field = funcarr[i]->start; */
  /*     while(field) */
  /* 	{ */
  /* 	  if(strcmp(field->name->string, "name") == 0) */
  /* 	    { */
  /* 	      printf("%s\n", json_value_as_string(field->value)->string); */
  /* 	    } else if(strcmp(field->name->string, "instrs") == 0) */
  /* 	    { */
  /* 	      struct json_array_s *instrs_json = json_value_as_array(field->value); */
  /* 	      parse_instructions(instrs_json); */
  /* 	    } */
  /* 	  field = field->next; */
  /* 	} */
  /*   } */
  program_t *prog = parse_program(functions);
  free(string);
  free(root);
  free_program(prog);
  printf("%ld\n", sizeof(instruction_t));
  return 0;
}

