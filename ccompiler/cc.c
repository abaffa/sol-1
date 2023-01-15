#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include "def.h"

int main(int argc, char *argv[]){
  if(argc > 1) load_program(argv[1]);  
  else{
    printf("usage: cc [filename]\n");
    return 0;
  }
 
  prog = pbuf; // resets pointer to the beginning of the program

  initial_setup();
  pre_scan();

  emit_libraries();
  emitln("\n.org PROC_TEXT_ORG");

  emitln("\n; -----begin text block-----");
  parse_functions();
  emitln("; -----end text block-----");
  
  emit_global_variables();

  emitln("\n.end");

  *asmp = '\0';

  generate_file("a.s"); // generate a.s assembly file

  return 0;
}

void generate_file(char *filename){
  FILE *fp;
  int i;
  
  if((fp = fopen(filename, "wb")) == NULL){
    exit(0);
  }
  
  fprintf(fp, "%s", ASM_output);

  fclose(fp);
}

void emit_libraries(void){
  emit("; -----begin include block-----");
  emitln(includes_list_ASM);
  emitln("; -----end include block-----");
}

void emit_global_variables(void){
  int i;
  char s_init[1024];

  emitln("\n; -----begin data block-----");
  for(i = 0; i < global_var_tos; i++){
    if(global_variables[i].data.ind_level > 0){
      switch(global_variables[i].data.type){
        case DT_CHAR:
          if(global_variables[i].as_string[0] != '\0'){ // if var was initialized, then instantiate its data in assembly data block
            emit(global_variables[i].var_name); // var name
            emit("_data");
            emit(": .db \"");
            emit(global_variables[i].as_string);
            emitln("\", 0");
            emit(global_variables[i].var_name); // var name
            emit(": .dw ");
            emit(global_variables[i].var_name); // var name
            emitln("_data");
          }
          else{
            emit(global_variables[i].var_name); // var name
            emitln(": .dw 0");
          }
          break;
        case DT_INT:
          emit(global_variables[i].var_name); // var name
          emit(": .dw ");
          sprintf(s_init, "%d", global_variables[i].data.value.p);
          emitln(s_init);
      }
    }
    else if(global_variables[i].data.type == DT_CHAR){
      emit(global_variables[i].var_name); // var name
      emit(": .db ");
      if(global_variables[i].data.value.c != 0) sprintf(s_init, "'%c'", global_variables[i].data.value.c);
      else sprintf(s_init, "%d", 0);
      emitln(s_init);
    }
    else if(global_variables[i].data.type == DT_INT){
      emit(global_variables[i].var_name); // var name
      emit(": .dw ");  
      sprintf(s_init, "%d", global_variables[i].data.value.shortint);
      emitln(s_init);
    }
  }
  emitln("; -----end data block-----");
}

void initial_setup(void){
  global_var_tos = 0;
  
  asmp = ASM_output;  // set ASM output pointer to the ASM array beginning
}

void emitln(char *p){
  while(*p){
    *asmp = *p;
    asmp++;
    p++;
  }
  *asmp++ = '\n';
}

void emit(char *p){
  while(*p){
    *asmp = *p;
    asmp++;
    p++;
  }
}

void load_program(char *filename){
  FILE *fp;
  int i;
  
  if((fp = fopen(filename, "rb")) == NULL){
    printf("program source file not found");
    exit(0);
  }
  
  prog = pbuf;
  i = 0;
  
  do{
    *prog = getc(fp);
    prog++;
    i++;
  } while(!feof(fp));
  
  fclose(fp);
  
  if(*(prog - 2) == 0x1A) *(prog - 2) = '\0';
  else *(prog - 1) = '\0';
}

void dbg(char *s){
  puts(s);
}

void parse_functions(void){
  register int i;

  for(i = 0; *function_table[i].func_name; i++){
    current_function_var_bp_offset = 0; // this is used to position local variables correctly relative to BP.
                      // whenever a new function is parsed, this is reset to 0.
                      // then inside the function it can increase according to how any local vars there are.
    current_func_id = i;
    prog = function_table[i].code_location;
    emit(function_table[i].func_name);
    emitln(":");
    emitln("  push bp");
    emitln("  mov bp, sp");
    parse_block(); // starts parsing the function block;
  }
}

void include_lib(char *lib_name){
  strcat(includes_list_ASM, "\n.include ");
  strcat(includes_list_ASM, lib_name); // concatenate library name into a small text session that
  // in the end we add this to the final ASM text  
}

void pre_scan(void){
  char *tp;
  
  do{
    tp = prog;
    get();
    if(tok_type == END) return;

    if(tok == DIRECTIVE){
      get();
      if(tok != INCLUDE) error(UNKNOWN_DIRECTIVE);
      get();
      if(tok_type != STRING_CONST) error(DIRECTIVE_SYNTAX);
      include_lib(token);
      continue;
    }
    
    if(tok == CONST) get();
    if(tok != VOID && tok != CHAR && tok != INT && tok != FLOAT && tok != DOUBLE) error(NOT_VAR_OR_FUNC_OUTSIDE);
    
    get();
    
    while(tok == STAR) get();
    if(tok_type != IDENTIFIER) error(IDENTIFIER_EXPECTED);

    get();
    if(tok == OPENING_PAREN){ //it must be a function declaration
      prog = tp;
      declare_func();
      find_end_of_BLOCK();
    }
    else { //it must be variable declarations
      prog = tp;
      declare_global();
    }
  } while(tok_type != END);
  
}

void declare_func(void){
  _USER_FUNC *func; // variable to hold a pointer to the user function top of stack
  _BASIC_DATA param_data_type; // function data type
  int bp_offset; // for each parameter, keep the running offset of that parameter.
  char *temp_prog;
  int total_parameter_bytes;

  if(function_table_tos == MAX_USER_FUNC - 1) error(EXCEEDED_FUNC_DECL_LIMIT);

  func = &function_table[function_table_tos];

  get();

  switch(tok){
    case VOID:
      func->return_type = DT_VOID;
      break;
    case CHAR:
      func->return_type = DT_CHAR;
      break;
    case INT:
      func->return_type = DT_INT;
      break;
    case FLOAT:
      func->return_type = DT_FLOAT;
      break;
    case DOUBLE:
      func->return_type = DT_DOUBLE;
  }

  get(); // gets the function name
  strcpy(func->func_name, token);
  get(); // gets past "("

  func->local_var_tos = 0;
  
  get();
  if(tok == CLOSING_PAREN || tok == VOID){
    if(tok == VOID) get();
  }
  else{
    putback();
    temp_prog = prog;
    total_parameter_bytes = find_total_parameter_bytes();
    bp_offset = total_parameter_bytes;
    prog = temp_prog;

    do{
      func->local_vars[func->local_var_tos].is_parameter = 1;

      get();
      if(tok == CONST){
        func->local_vars[func->local_var_tos].constant = 1;
        get();
      }
      if(tok != VOID && tok != CHAR && tok != INT && tok != FLOAT && tok != DOUBLE) error(VAR_TYPE_EXPECTED);
      
      // assign the bp offset of this parameter
      func->local_vars[func->local_var_tos].bp_offset = bp_offset;

      // gets the parameter type
      switch(tok){
        case CHAR:
          func->local_vars[func->local_var_tos].data.type = DT_CHAR;
          get();
          if(tok == STAR){
            while(tok == STAR){
              func->local_vars[func->local_var_tos].data.ind_level++;
              get();
            }
            bp_offset -= 2; 
          }
          else{
            putback();
            bp_offset -= 1; 
          }
          break;
        case INT:
          func->local_vars[func->local_var_tos].data.type = DT_INT;
          bp_offset -= 2; 
          break;
        case FLOAT:
          func->local_vars[func->local_var_tos].data.type = DT_FLOAT;
          bp_offset -= 2; 
          break;
        case DOUBLE:
          func->local_vars[func->local_var_tos].data.type = DT_DOUBLE;
          get();
          if(tok == STAR){
            while(tok == STAR){
              func->local_vars[func->local_var_tos].data.ind_level++;
              get();
            }
            bp_offset -= 2;
          }
          else{
            putback();
            bp_offset -= 4;
          }
      }

      get();
      if(tok_type != IDENTIFIER) error(IDENTIFIER_EXPECTED);
      strcpy(func->local_vars[func->local_var_tos].var_name, token);
        
      get();
      func->local_var_tos++;
    } while(tok == COMMA);
  }
    
  if(tok != CLOSING_PAREN) error(CLOSING_PAREN_EXPECTED);

  func->code_location = prog; // sets the function starting point to  just after the "(" token
  
  get(); // gets to the "{" token
  if(tok != OPENING_BRACE) error(OPENING_BRACE_EXPECTED);
  putback(); // puts the "{" back so that it can be found by find_end_of_BLOCK()

  //*func->local_vars[func->local_var_tos].var_name = '\0'; // marks the end of the variable list with a null character
  function_table_tos++;
}

int find_total_parameter_bytes(void){
  int total_bytes;

  total_bytes = 0;
  do{
    get();
    switch(tok){
      case CHAR:
        total_bytes += 1;
        break;
      case INT:
        total_bytes += 2;
        break;
      case FLOAT:
        total_bytes += 2;
        break;
      case DOUBLE:
        total_bytes += 4;
    }
    get(); // get past parameter name
    get(); // get possible comma
  } while(tok == COMMA);

  return total_bytes;
}

void parse_asm(void){
  get();
  if(tok == OPENING_BRACE){
    emit("; -----begin inline asm block-----\n");
    do{
      get_line();
      if(*string_constant != '}'){
        emit("  ");
        emitln(string_constant);
      }
    } while(*string_constant != '}');
    emitln("; -----end inline asm block-----");
  }
  else{
    emit("; -----inline asm block-----\n");
    putback();
    get_line();
    emit("  ");
    emitln(string_constant);
  }

}

void parse_break(void){
  char s_label[64];
  
  sprintf(s_label, "  jmp _while%d_exit", current_label_index_loop);
  emitln(s_label);
}

/* for(i=0; i< 10; i=i+1){} */
void parse_for(void){
  char s_label[64];
  char *update_loc;
  
  highest_label_index++;
  label_stack_loop[label_tos_loop] = current_label_index_loop;
  label_tos_loop++;
  current_label_index_loop = highest_label_index;

  sprintf(s_label, "_for%d_init:", current_label_index_loop);
  emitln(s_label);
  get();
  if(tok != OPENING_PAREN) error(OPENING_PAREN_EXPECTED);
  get();
  if(tok != SEMICOLON){
    putback();
    parse_expr();
  }
  if(tok != SEMICOLON) error(SEMICOLON_EXPECTED);

  sprintf(s_label, "_for%d_cond:", current_label_index_loop);
  emitln(s_label);
  
  // checks for an empty condition, which means always true
  get();
  if(tok != SEMICOLON){
    putback();
    parse_expr();
    if(tok != SEMICOLON) error(SEMICOLON_EXPECTED);
  }
  else{
    emitln("  mov b, 1"); // emit a TRUE condition
  }

  emitln("  mov a, b");
  emitln("  cmp a, 0");
  sprintf(s_label, "  je _for%d_exit", current_label_index_loop);
  emitln(s_label);
  sprintf(s_label, "_for%d_block:", current_label_index_loop);
  emitln(s_label);

  update_loc = prog; // holds the location of incrementation part

  // gets past the update expression
  int paren = 1;
  do{
    if(*prog == '(') paren++;
    else if(*prog == ')') paren--;
    prog++;
  } while(paren && *prog);
  if(!*prog) error(CLOSING_PAREN_EXPECTED);

  parse_block();
  
  sprintf(s_label, "_for%d_update:", current_label_index_loop);
  emitln(s_label);
  
  prog = update_loc;
  // checks for an empty update expression
  get();
  if(tok != CLOSING_PAREN){
    putback();
    parse_expr();
  }
    
  sprintf(s_label, "  jmp _for%d_cond", current_label_index_loop);
  emitln(s_label);

  find_end_of_block();

  sprintf(s_label, "_for%d_exit:", current_label_index_loop);
  emitln(s_label);

  label_tos_loop--;
  current_label_index_loop = label_stack_loop[label_tos_loop];
}

void parse_while(void){
  char s_label[64];

  highest_label_index++;
  label_stack_loop[label_tos_loop] = current_label_index_loop;
  label_tos_loop++;
  current_label_index_loop = highest_label_index;

  sprintf(s_label, "_while%d_cond:", current_label_index_loop);
  emitln(s_label);
  get();
  if(tok != OPENING_PAREN) error(OPENING_PAREN_EXPECTED);
  parse_expr(); // evaluate condition
  if(tok != CLOSING_PAREN) error(CLOSING_PAREN_EXPECTED);
  emitln("  mov a, b");
  emitln("  cmp a, 0");
  sprintf(s_label, "  je _while%d_exit", current_label_index_loop);
  emitln(s_label);
  sprintf(s_label, "_while%d_block:", current_label_index_loop);
  emitln(s_label);
  parse_block();  // parse while block
  sprintf(s_label, "  jmp _while%d_cond", current_label_index_loop);
  emitln(s_label);
  sprintf(s_label, "_while%d_exit:", current_label_index_loop);
  emitln(s_label);

  label_tos_loop--;
  current_label_index_loop = label_stack_loop[label_tos_loop];
}

void parse_if(void){
  char s_label[64];
  char *temp_p;

  highest_label_index++;
  label_stack_if[label_tos_if] = current_label_index_if;
  label_tos_if++;
  current_label_index_if = highest_label_index;

  sprintf(s_label, "_if%d_cond:", current_label_index_if);
  emitln(s_label);
  get();
  if(tok != OPENING_PAREN) error(OPENING_PAREN_EXPECTED);
  parse_expr(); // evaluate condition
  if(tok != CLOSING_PAREN) error(CLOSING_PAREN_EXPECTED);
  emitln("  cmp b, 0");
  
  temp_p = prog;
  find_end_of_block(); // skip main IF block in order to check for ELSE block.
  get();
  if(tok == ELSE){
    sprintf(s_label, "  je _if%d_else_block", current_label_index_if);
    emitln(s_label);
  }
  else{
    sprintf(s_label, "  je _if%d_exit", current_label_index_if);
    emitln(s_label);
  }

  prog = temp_p;
  sprintf(s_label, "_if%d_block:", current_label_index_if);
  emitln(s_label);
  parse_block();  // parse the positive condition block
  sprintf(s_label, "  jmp _if%d_exit", current_label_index_if);
  emitln(s_label);
  get(); // look for 'else'
  if(tok == ELSE){
    sprintf(s_label, "_if%d_else_block:", current_label_index_if);
    emitln(s_label);
    parse_block();  // parse the positive condition block
  }
  else{
    putback();
  }
  
  sprintf(s_label, "_if%d_exit:", current_label_index_if);
  emitln(s_label);

  label_tos_if--;
  current_label_index_if = label_stack_if[label_tos_if];
}

void parse_return(void){
  get();
  if(tok != SEMICOLON){
    putback();
    parse_expr();  // return value in register B
  }
  emitln("  leave");
  emitln("  ret");
}

void parse_block(void){
  int brace = 0;
  
  do{
    get();
    switch(tok){
      case INT:
      case CHAR:
      case FLOAT:
      case DOUBLE:
        putback();
        declare_local();
        break;
      case ASM:
        parse_asm();
        break;
      case IF:
        parse_if();
        break;
      case FOR:
        parse_for();
        break;
      case WHILE:
        parse_while();
        break;
      case BREAK:
        parse_break();
        break;
      case DO:
        break;
      case OPENING_BRACE:
        brace++;
        break;
      case CLOSING_BRACE:
        brace--;
        break;
      case SEMICOLON:
        break;
      case RETURN:
        parse_return();
        break;
      default:
        if(tok_type == END) error(CLOSING_BRACE_EXPECTED);
        putback();
        parse_expr();
        if(tok != SEMICOLON) error(SEMICOLON_EXPECTED);
    }    
  } while(brace); // exits when it finds the last closing brace
}

void find_end_of_block(void){
  int paren = 0;

  get();
  switch(tok){
    case ASM:
      find_end_of_block();
      break;
    case IF:
      // skips the conditional expression between parenthesis
      get();
      if(tok != OPENING_PAREN) error(OPENING_PAREN_EXPECTED);
      paren = 1; // found the first parenthesis
      do{
        if(*prog == '(') paren++;
        else if(*prog == ')') paren--;
        prog++;
      } while(paren && *prog);
      if(!*prog) error(CLOSING_PAREN_EXPECTED);

      find_end_of_block();
      get();
      if(tok == ELSE) find_end_of_block();
      else
        putback();
      break;
    case OPENING_BRACE: // if it's a block, then the block is skipped
      putback();
      find_end_of_BLOCK();
      break;
    case FOR:
      get();
      if(tok != OPENING_PAREN) error(OPENING_PAREN_EXPECTED);
      paren = 1;
      do{
        if(*prog == '(') paren++;
        else if(*prog == ')') paren--;
        prog++;
      } while(paren && *prog);
      if(!*prog) error(CLOSING_PAREN_EXPECTED);
      get();
      if(tok != SEMICOLON){
        putback();
        find_end_of_block();
      }
      break;
      
    default: // if it's not a keyword, then it must be an expression
      putback(); // puts the last token back, which might be a ";" token
      while(*prog++ != ';' && *prog);
      if(!*prog) error(SEMICOLON_EXPECTED);
  }
}

void find_end_of_BLOCK(void){
  int brace = 0;
  
  do{
    if(*prog == '{') brace++;
    else if(*prog == '}') brace--;
    prog++;
  } while(brace && *prog);

  if(brace && !*prog) error(CLOSING_BRACE_EXPECTED);
}

_BASIC_DATA get_var_type(char *var_name){
	register int i;

  for(i = 0; i < function_table[current_func_id].local_var_tos; i++)
    if(!strcmp(function_table[current_func_id].local_vars[i].var_name, var_name))
			return function_table[current_func_id].local_vars[i].data.type;

	for(i = 0; i < global_var_tos; i++)
		if(!strcmp(global_variables[i].var_name, var_name)) 
			return global_variables[i].data.type;

	error(UNDECLARED_VARIABLE);
}

void parse_expr(){
  parse_attrib();
}

void parse_attrib(){
  char var_name[ID_LEN];
  char temp[ID_LEN];
  char *temp_prog;
  int var_id;

  temp_prog = prog;

  get();
  if(tok_type == IDENTIFIER){
    strcpy(var_name, token);
    get();
    if(tok == ASSIGNMENT){
      //emitln("  mov a, 0");
      parse_attrib();
      if(local_var_exists(var_name) != -1){ // is a local variable
        var_id = local_var_exists(var_name);
        if(function_table[current_func_id].local_vars[var_id].data.ind_level > 0){ // is a pointer
          emitln("  mov a, b");
          emitln("  swp a"); // due to a stack silliness in the CPU where the LSB of a word is at the higher address, we need the swap here. 
                    // i need to fix the stack push/pop in the cpu so that low bytes are at lower addresses!
          emit("  mov [bp + ");
          if(function_table[current_func_id].local_vars[var_id].is_parameter)
            // add +4 below to account for BP and PC offsets which were pushed into the stack
            sprintf(temp, "%d", 4 + function_table[current_func_id].local_vars[var_id].bp_offset - 1);
          else
            sprintf(temp, "%d", -function_table[current_func_id].local_vars[var_id].bp_offset - 1);
          emit(temp);
          emitln("], a");
        }
        else if(function_table[current_func_id].local_vars[var_id].data.type == DT_CHAR){
          emitln("  mov al, bl");
          emit("  mov [bp + ");
          if(function_table[current_func_id].local_vars[var_id].is_parameter)
            // add +4 below to account for BP and PC offsets which were pushed into the stack
            sprintf(temp, "%d", 4 + function_table[current_func_id].local_vars[var_id].bp_offset);
          else
            sprintf(temp, "%d", -function_table[current_func_id].local_vars[var_id].bp_offset);
          emit(temp);
          emitln("], al");
        }
        else if(function_table[current_func_id].local_vars[var_id].data.type == DT_INT){
          emitln("  mov a, b");
          emitln("  swp a"); // due to a stack silliness in the CPU where the LSB of a word is at the higher address, we need the swap here. 
                    // i need to fix the stack push/pop in the cpu so that low bytes are at lower addresses!
          emit("  mov [bp + ");
          if(function_table[current_func_id].local_vars[var_id].is_parameter)
            // add +4 below to account for BP and PC offsets which were pushed into the stack
            sprintf(temp, "%d", 4 + function_table[current_func_id].local_vars[var_id].bp_offset - 1);
          else
            sprintf(temp, "%d", -function_table[current_func_id].local_vars[var_id].bp_offset - 1);
          emit(temp);
          emitln("], a");
        }
      }
      else if(global_var_exists(var_name) != -1){  // is a global variable
        var_id = global_var_exists(var_name);
        if(global_variables[var_id].data.ind_level > 0){ // is a pointer
          emit("  mov [");
          emit(global_variables[var_id].var_name);
          emitln("], b");
        }
        else if(global_variables[var_id].data.type == DT_CHAR){
            emit("  mov [");
            emit(global_variables[var_id].var_name);
            emitln("], bl");
        }
        else if(global_variables[var_id].data.type == DT_INT){
            emit("  mov [");
            emit(global_variables[var_id].var_name);
            emitln("], b");
        }
      }
      else error(UNDECLARED_VARIABLE);

      return;
    }
  }
	else if(tok == STAR){ // tests if this is a pointer assignment
		while(tok != SEMICOLON && tok_type != END){
			get();
      if(tok_type == IDENTIFIER) strcpy(var_name, token); // save var name
			if(tok == ASSIGNMENT){ // is an attribution statement
				prog = temp_prog; // goes back to the beginning of the expression
				get(); // gets past the first asterisk
				parse_atom();
				emitln("  mov d, b"); // pointer given in 'b', so mov 'b' into 'a'
				// after evaluating the address expression, the token will be a "="
				parse_attrib(); // evaluates the value to be attributed to the address, result in 'b'
        switch(get_var_type(var_name)){
          case DT_CHAR:
            emitln("  mov [d], bl");
            break;
          case DT_INT:
            emitln("  mov [d], b");
            break;
          default: error(INVALID_POINTER);
        }
				return;
			}
		}
	}
  
  prog = temp_prog;
  parse_logical();
}

void parse_logical(void){
  char temp_tok;

  parse_relational();
  while(tok == LOGICAL_AND || tok == LOGICAL_OR){
    temp_tok = tok;
    emitln("  push a");
    emitln("  mov a, b");
    parse_relational();
    emitln("  cmp b, 0");
    emitln("  push a");
    emitln("  lodflgs");
    emitln("  mov b, a");
    emitln("  pop a");
    emitln("  not bl");  
    emitln("  and bl, %00000001"); // isolate ZF only. 
    emitln("  mov bh, 0");
    emitln("  cmp a, 0");
    emitln("  lodflgs");
    emitln("  not al");  
    emitln("  and al, %00000001"); // isolate ZF only. 
    emitln("  mov ah, 0");
    if(temp_tok == LOGICAL_AND) emitln("  and a, b");
    else emitln("  or a, b");
    emitln("  mov b, a");
    emitln("  pop a");
  }
}

void parse_relational(void){
  char temp_tok;

/* x = y > 1 && z<4 && y == 2 */
  parse_terms();
  while(tok == EQUAL || tok == NOT_EQUAL || tok == LESS_THAN || tok == LESS_THAN_OR_EQUAL
    || tok == GREATER_THAN || tok == GREATER_THAN_OR_EQUAL){
    temp_tok = tok;
    emitln("  push a");
    emitln("  mov a, b");
    parse_terms();
    switch(temp_tok){
      case EQUAL:
        emitln("  cmp a, b");
        emitln("  lodflgs");
        emitln("  and al, %00000001"); // isolate ZF only. therefore if ZF==1 then A == B
        emitln("  mov ah, 0");
        break;
      case NOT_EQUAL:
        emitln("  cmp a, b");
        emitln("  lodflgs");
        emitln("  and al, %00000001"); // isolate ZF only.
        emitln("  xor al, %00000001"); // invert the condition
        emitln("  mov ah, 0");
        break;
      case LESS_THAN:
        emitln("  cmp a, b");
        emitln("  lodflgs");
        emitln("  and al, %00000010"); // isolate CF only. therefore if CF==1 then A < B
        emitln("  mov ah, 0");
        break;
      case LESS_THAN_OR_EQUAL:
        emitln("  cmp a, b");
        emitln("  lodflgs");
        emitln("  and al, %00000011"); // isolate both ZF and CF. therefore if CF==1 or ZF==1 then A <= B
        emitln("  mov ah, 0");
        break;
      case GREATER_THAN_OR_EQUAL:
        emitln("  cmp a, b");
        emitln("  lodflgs");
        emitln("  and al, %00000010"); 
        emitln("  xor al, %00000010"); 
        emitln("  mov ah, 0");
        break;
      case GREATER_THAN:
        emitln("  cmp a, b");
        emitln("  lodflgs");
        emitln("  and al, %00000011"); 
        emitln("  cmp al, 0");
        emitln("  lodflgs");
        emitln("  and al, %00000001"); 
        emitln("  mov ah, 0");
        break;
    }
    emitln("  mov b, a");
    emitln("  pop a");
  }
}

void parse_terms(void){
  char temp_tok;
  
  parse_factors();
  while(tok == PLUS || tok == MINUS){
    temp_tok = tok;
    emitln("  push a");
    emitln("  mov a, b");
    parse_factors();
    if(temp_tok == PLUS) emitln("  add a, b"); else emitln("  sub a, b");
    emitln("  mov b, a");
    emitln("  pop a");
  }
}

void parse_factors(void){
  char temp_tok;

  parse_atom();
  while(tok == STAR || tok == FSLASH || tok == MOD){
    temp_tok = tok;
    emitln("  push a");
    emitln("  mov a, b");
    parse_atom();
    if(temp_tok == STAR){
      emitln("  mul a, b");
    }
    else if(temp_tok == FSLASH){
      emitln("  div a, b");
      emitln("  mov g, a");
      emitln("  mov a, b");
      emitln("  mov b, g");
    }
    else if(temp_tok == MOD){
      emitln("  div a, b");
    }
    emitln("  pop a");
  }
}

void parse_atom(void){
  int var_id;
  int func_id;
  char temp_name[ID_LEN];
  char temp[64];

  get();

/*   a = *(p+1);
  a = *p;
 */
  if(tok == STAR){ // is a pointer operator
    parse_atom(); // parse expression after STAR, which could be inside parenthesis. result in B
    emitln("  mov d, b");// now we have the pointer value. we then get the data at the address.
    emitln("  mov b, [d]"); // data fetched as an int. need to improve this to allow any types later.
    putback();
  }
  else if(tok == AMPERSAND){
    get(); // get variable name
    if(tok_type != IDENTIFIER) error(IDENTIFIER_EXPECTED);
    if(local_var_exists(token) != -1){ // is a local variable
      var_id = local_var_exists(token);
      if(function_table[current_func_id].local_vars[var_id].is_parameter)
        // add +4 below to account for BP and PC offsets which were pushed into the stack
        sprintf(temp, "%d", 4 + function_table[current_func_id].local_vars[var_id].bp_offset);
      else
        sprintf(temp, "%d", -function_table[current_func_id].local_vars[var_id].bp_offset);
      emit("  mov b, ");
      emitln(temp);
    }
    else if(global_var_exists(token) != -1){  // is a global variable
      var_id = global_var_exists(token);
      emit("  mov b, ");
      emitln(global_variables[var_id].var_name);
    }
  }
  else if(tok_type == INTEGER_CONST){
    emit("  mov b, ");
    emitln(token);
  }
  else if(tok_type == CHAR_CONST){
    emit("  mov bl, ");
    emitln(token);
    //emitln("  mov bh, 0"); // not sure why i set bh to 0 here, but removing as doesnt seem to be needed
  }
  else if(tok == MINUS){
    parse_atom();
    emitln("  neg b");
    putback();
  }
  else if(tok == BITWISE_NOT){
    parse_atom();
    emitln("  not b");
    putback();
  }
  else if(tok == OPENING_PAREN){
    parse_expr();  // parses expression between parenthesis and result will be in B
    if(tok != CLOSING_PAREN) error(CLOSING_PAREN_EXPECTED);
  }
  else if(tok_type == IDENTIFIER){
    strcpy(temp_name, token);
    get();
    if(tok == OPENING_PAREN){ // function call      
      func_id = find_function(temp_name);
      if(func_id != -1){
        parse_function_arguments(func_id);
        emit("  call ");
        emitln(temp_name);
        if(tok != CLOSING_PAREN) error(CLOSING_PAREN_EXPECTED);
        // the function's return value is in register B

        // if the first local var is a parameter then the function has defined parameters
        if(function_table[func_id].local_vars[0].is_parameter){
          // clean stack of the arguments added to it
          int i, bp_offsetclean = 0;
          char bp_offset_string[10];
          for(i = 0; function_table[func_id].local_vars[i].is_parameter; i++){
            if(function_table[func_id].local_vars[i].data.ind_level > 0) bp_offsetclean += 2;
            else switch(function_table[func_id].local_vars[i].data.type){
              case DT_CHAR:
                bp_offsetclean += 1;
                break;
              case DT_INT:
                bp_offsetclean += 2;
                break;
            }
          }
          sprintf(bp_offset_string, "%i", bp_offsetclean);
          emit("  add sp, ");
          emitln(bp_offset_string);
        }
      }
      else error(UNDECLARED_FUNC);
    }
    else{
      if(local_var_exists(temp_name) != -1){ // is a local variable
        var_id = local_var_exists(temp_name);
        if(function_table[current_func_id].local_vars[var_id].data.ind_level > 0){ // is a pointer
          emit("  mov b, [bp + ");
          if(function_table[current_func_id].local_vars[var_id].is_parameter)
            // add +4 below to account for BP and PC offsets which were pushed into the stack
            sprintf(temp, "%d", 4 + function_table[current_func_id].local_vars[var_id].bp_offset - 1);
          else
            sprintf(temp, "%d", -function_table[current_func_id].local_vars[var_id].bp_offset - 1);
          emit(temp);
          emitln("]");
          emitln("  swp b"); // due to a stack silliness in the CPU where the LSB of a word is at the higher address, we need the swap here. 
                    // i need to fix the stack push/pop in the cpu so that low bytes are at lower addresses!
        }
        else if(function_table[current_func_id].local_vars[var_id].data.type == DT_CHAR){
          emit("  mov bl, [bp + ");
          if(function_table[current_func_id].local_vars[var_id].is_parameter)
            // add +4 below to account for BP and PC offsets which were pushed into the stack
            sprintf(temp, "%d", 4 + function_table[current_func_id].local_vars[var_id].bp_offset);
          else
            sprintf(temp, "%d", -function_table[current_func_id].local_vars[var_id].bp_offset);
          emit(temp);
          emitln("]");
        }
        else if(function_table[current_func_id].local_vars[var_id].data.type == DT_INT){
          emit("  mov b, [bp + ");
          if(function_table[current_func_id].local_vars[var_id].is_parameter)
            // add +4 below to account for BP and PC offsets which were pushed into the stack
            sprintf(temp, "%d", 4 + function_table[current_func_id].local_vars[var_id].bp_offset - 1);
          else
            sprintf(temp, "%d", -function_table[current_func_id].local_vars[var_id].bp_offset - 1);
          emit(temp);
          emitln("]");
          emitln("  swp b"); // due to a stack silliness in the CPU where the LSB of a word is at the higher address, we need the swap here. 
                    // i need to fix the stack push/pop in the cpu so that low bytes are at lower addresses!
        }
      }
      else if(global_var_exists(temp_name) != -1){  // is a global variable
        var_id = global_var_exists(temp_name);
        if(global_variables[var_id].data.ind_level > 0){ // is a pointer
          emit("  mov b, [");
          emit(global_variables[var_id].var_name);
          emitln("]");
        }
        else if(global_variables[var_id].data.type == DT_CHAR){
          emit("  mov bl, [");
          emit(global_variables[var_id].var_name);
          emitln("]");
        }
        else if(global_variables[var_id].data.type == DT_INT){
          emit("  mov b, [");
          emit(global_variables[var_id].var_name);
          emitln("]");
        }
      }
      else error(UNDECLARED_VARIABLE);
      putback();
    }
  }
  else
    error(INVALID_EXPRESSION);

  get(); // gets the next token (it must be a delimiter)
}

void parse_function_arguments(int func_id){
  _USER_FUNC *func; // variable to hold a pointer to the user function
  int param_index;

  func = &function_table[func_id];
  param_index = 0;

  get();
  if(tok == CLOSING_PAREN) return;

  putback();

  do{
    parse_expr();
    switch(func->local_vars[param_index].data.type){
      case DT_CHAR:
        emitln("  push bl");
        break;
      case DT_INT:
        emitln("  push b");
        break;
    }
    param_index++;
  } while(tok == COMMA);
  
}

int find_global_var(char *var_name){
  register int i;
  
  for(i = 0; (i < global_var_tos) && (*global_variables[i].var_name); i++)
    if(!strcmp(global_variables[i].var_name, var_name)) return i;
  
  return -1;
}

void putback(void){
  char *t = token;

  while(*t++) prog--;
}

void declare_global(void){
  _BASIC_DATA dt;
  int ind_level;
  char constant = 0;

  get(); // gets past the data type
  if(tok == CONST){
    constant = 1;
    get();
  }
  
  switch(tok){
    case VOID:
      dt = DT_VOID;
      break;
    case CHAR:
      dt = DT_CHAR;
      break;
    case INT:
      dt = DT_INT;
      break;
    case FLOAT:
      dt = DT_FLOAT;
      break;
    case DOUBLE:
      dt = DT_DOUBLE;
  }

  do{
    if(global_var_tos == MAX_GLOBAL_VARS) error(EXCEEDED_GLOBAL_VAR_LIMIT);

    global_variables[global_var_tos].constant = constant;

    // initializes the variable to 0
    global_variables[global_var_tos].data.value.c = 0;
    global_variables[global_var_tos].data.value.shortint = 0;
    global_variables[global_var_tos].data.value.f = 0.0;
    global_variables[global_var_tos].data.value.d = 0.0;
    global_variables[global_var_tos].data.value.p = 0;
    global_variables[global_var_tos].as_string[0] = '\0';
    
    get();
// **************** checks whether this is a pointer declaration *******************************
    ind_level = 0;
    while(tok == STAR){
      ind_level++;
      get();
    }
// *********************************************************************************************
    if(tok_type != IDENTIFIER) error(IDENTIFIER_EXPECTED);
    if(dt == DT_VOID && ind_level == 0) error(INVALID_TYPE_IN_VARIABLE);

    // checks if there is another global variable with the same name
    if(find_global_var(token) != -1) error(DUPLICATE_GLOBAL_VARIABLE);
    
    global_variables[global_var_tos].data.type = dt;
    global_variables[global_var_tos].data.ind_level = ind_level;
    strcpy(global_variables[global_var_tos].var_name, token);

    get();
    // checks for variable initialization
    if(tok == ASSIGNMENT){
      switch(dt){
        case DT_VOID:
          get();
          global_variables[global_var_tos].data.value.p = atoi(token);
          break;
        case DT_CHAR:
          if(ind_level > 0){ // if is a string
            get();
            if(tok_type != STRING_CONST) error(STRING_CONSTANT_EXPECTED);
            strcpy(global_variables[global_var_tos].as_string, string_constant);
          }
          else{
            get();
            global_variables[global_var_tos].data.value.c = string_constant[0];
          }
          break;
        case DT_INT:
          get();
          if(ind_level > 0) global_variables[global_var_tos].data.value.p = atoi(token);
          else global_variables[global_var_tos].data.value.shortint = atoi(token);
          break;
        case DT_FLOAT:
          break;
        case DT_DOUBLE:
          break;
      }
      get();
    }
    global_var_tos++;  
  } while(tok == COMMA);

  if(tok != SEMICOLON) error(SEMICOLON_EXPECTED);
}

int find_function(char *func_name){
  register int i;
  
  for(i = 0; *function_table[i].func_name; i++)
    if(!strcmp(function_table[i].func_name, func_name))
      return i;
  
  return -1;
}

int global_var_exists(char *var_name){
  register int i;

  for(i = 0; i < global_var_tos; i++)
    if(!strcmp(global_variables[i].var_name, var_name)) return i;
  
  return -1;
}

int local_var_exists(char *var_name){
  register int i;

  //check local variables whose function id is the id of current function being parsed
  for(i = 0; i < function_table[current_func_id].local_var_tos; i++)
    if(!strcmp(function_table[current_func_id].local_vars[i].var_name, var_name)) return i;
  
  return -1;
}

void declare_local(void){                        
  _BASIC_DATA dt;
  _LOCAL_VAR new_var;
  char ind_level;
  char constant = 0;
  
  get(); // gets past the data type

  if(tok == CONST){
    constant = 1;
    get();
  }
  
  switch(tok){
    case VOID:
      dt = DT_VOID;
      break;
    case CHAR:
      dt = DT_CHAR;
      break;
    case INT:
      dt = DT_INT;
      break;
    case FLOAT:
      dt = DT_FLOAT;
      break;
    case DOUBLE:
      dt = DT_DOUBLE;
  }

  do{
    if(function_table[current_func_id].local_var_tos == MAX_LOCAL_VARS) error(LOCAL_VAR_LIMIT_REACHED);
    
    new_var.function_id = current_func_id; // set variable owner function

    // this is used to position local variables correctly relative to BP.
    // whenever a new function is parsed, this is reset to 0.
    // then inside the function it can increase according to how any local vars there are.
    new_var.bp_offset = current_function_var_bp_offset;
    new_var.is_parameter = 0;
    new_var.constant = constant;

    // initializes the variable to 0
    new_var.data.value.c = 0;
    new_var.data.value.shortint = 0;
    new_var.data.value.f = 0.0;
    new_var.data.value.d = 0.0;
    new_var.data.value.p = 0;

    // gets the variable name
    get();
// **************** checks whether this is a pointer declaration *******************************
    ind_level = 0;
    while(tok == STAR){
      ind_level++;
      get();
    }    
// *********************************************************************************************
    if(ind_level > 0){
      current_function_var_bp_offset += 2;
    }
    else switch(dt){
      case DT_CHAR:
        current_function_var_bp_offset += 1;
        break;
      case DT_INT:
        current_function_var_bp_offset += 2;
        break;
      default: 
        current_function_var_bp_offset += 2;
    }
    if(tok_type != IDENTIFIER) error(IDENTIFIER_EXPECTED);

    if(local_var_exists(token) != -1) error(DUPLICATE_LOCAL_VARIABLE);

    new_var.data.type = dt;
    new_var.data.ind_level = ind_level;
    strcpy(new_var.var_name, token);
    get();

    if(tok == ASSIGNMENT){
      get();
    // emit ASM for variables
      switch(new_var.data.type){
        case DT_CHAR:
          emit("  push byte ");
          emitln(token);
          break;
        case DT_INT:
          emit("  push word ");
          emitln(token);
          break;
      }
      get();
    }
    else{
      switch(new_var.data.type){
        case DT_CHAR:
          emitln("  push byte 0"); // replace with sub sp, 1
          break;
        case DT_INT:
          emitln("  push word 0"); // replace with sub sp, 2
          break;
      }
    }

    // the indirection level needs to be reset now, because if it not, its value might be changed to the expression ind_level    
    new_var.data.ind_level = ind_level;
    // assigns the new variable to the local stack
    function_table[current_func_id].local_vars[function_table[current_func_id].local_var_tos] = new_var;    
    function_table[current_func_id].local_var_tos++;
  } while(tok == COMMA);

  if(tok != SEMICOLON) error(SEMICOLON_EXPECTED);
}

_LOCAL_VAR *get_local_var(char *var_name){
  register int i;

  //check local variables whose function id is the id of current function being parsed
  for(i = 0; i < function_table[current_func_id].local_var_tos; i++)
    if(!strcmp(function_table[current_func_id].local_vars[i].var_name, var_name))
      return &function_table[current_func_id].local_vars[i];
  
  return NULL;
}

_GLOBAL_VAR *get_global_var(char *var_name){
  register int i;

  for(i = 0; (i < global_var_tos) && (*global_variables[i].var_name); i++)
    if(!strcmp(global_variables[i].var_name, var_name)) return &global_variables[i];
  
  return NULL;
}

void error(_ERROR e){
  int line = 1;
  char *t = pbuf;

  puts(error_table[e]);
  
  while(t < prog){
    t++;
    if(*t == '\n') line++;
  }
  
  printf("line number: %d\n", line);
  printf("near: %s", token);

  exit(0);
}


// converts a literal string or char constant into constants with true escape sequences
void convert_constant(){
  char *s = string_constant;
  char *t = token;
  
  if(tok_type == CHAR_CONST){
    t++;
    if(*t == '\\'){
      t++;
      switch(*t){
        case '0':
          *s++ = '\0';
          break;
        case 'a':
          *s++ = '\a';
          break;
        case 'b':
          *s++ = '\b';
          break;  
        case 'f':
          *s++ = '\f';
          break;
        case 'n':
          *s++ = '\n';
          break;
        case 'r':
          *s++ = '\r';
          break;
        case 't':
          *s++ = '\t';
          break;
        case 'v':
          *s++ = '\v';
          break;
        case '\\':
          *s++ = '\\';
          break;
        case '\'':
          *s++ = '\'';
          break;
        case '\"':
          *s++ = '\"';
      }
    }
    else{
      *s++ = *t;
    }
  }
  else if(tok_type == STRING_CONST){
    t++;
    while(*t != '\"' && *t){
      *s++ = *t++;
    }
  }
  
  *s = '\0';
}

void get(void){
  char *t;
  // skip blank spaces

  *token = '\0';
  tok = 0;
  t = token;
  
/* Skip comments and whitespaces */
  do{
    while(isspace(*prog)) prog++;
    if(*prog == '/' && *(prog+1) == '*'){
      prog = prog + 2;
      while(!(*prog == '*' && *(prog+1) == '/')) prog++;
      prog = prog + 2;
    }
    else if(*prog == '/' && *(prog+1) == '/'){
      while(*prog != '\n') prog++;
      prog++;
    }
  } while(isspace(*prog) || (*prog == '/' && *(prog+1) == '/'));

  if(*prog == '\0'){
    tok_type = END;
    return;
  }
  
  if(*prog == '\''){
    *t++ = '\'';
    prog++;
    if(*prog == '\\'){
      *t++ = '\\';
      prog++;
      *t++ = *prog++;
    }
    else *t++ = *prog++;
    
    if(*prog != '\'') error(SINGLE_QUOTE_EXPECTED);
    
    *t++ = '\'';
    prog++;
    tok_type = CHAR_CONST;
    *t = '\0';
    convert_constant(); // converts this string token with quotation marks to a non quotation marks string, and also converts escape sequences to their real bytes
  }
  else if(*prog == '\"'){
    *t++ = '\"';
    prog++;
    while(*prog != '\"' && *prog) *t++ = *prog++;
    if(*prog != '\"') error(DOUBLE_QUOTE_EXPECTED);
    *t++ = '\"';
    prog++;
    tok_type = STRING_CONST;
    *t = '\0';
    convert_constant(); // converts this string token qith quotation marks to a non quotation marks string, and also converts escape sequences to their real bytes
  }
  else if(isdigit(*prog)){
    while(isdigit(*prog)) *t++ = *prog++;
    tok_type = INTEGER_CONST;
  }
  else if(is_idchar(*prog)){
    while(is_idchar(*prog) || isdigit(*prog))
      *t++ = *prog++;
    *t = '\0';

    if((tok = find_keyword(token)) != -1) tok_type = RESERVED;
    else tok_type = IDENTIFIER;
  }
  else if(isdelim(*prog)){
    tok_type = DELIMITER;  
    
    if(*prog == '#'){
      *t++ = *prog++;
      tok = DIRECTIVE;
    }
    else if(*prog == '{'){
      *t++ = *prog++;
      tok = OPENING_BRACE;
    }
    else if(*prog == '}'){
      *t++ = *prog++;
      tok = CLOSING_BRACE;
    }
    else if(*prog == '='){
      *t++ = *prog++;
      if (*prog == '='){
        *t++ = *prog++;
        tok = EQUAL;
      }
      else tok = ASSIGNMENT;
    }
    else if(*prog == '&'){
      *t++ = *prog++;
      if(*prog == '&'){
        *t++ = *prog++;
        tok = LOGICAL_AND;
      }
      else tok = AMPERSAND;
    }
    else if(*prog == '|'){
      *t++ = *prog++;
      if (*prog == '|'){
        *t++ = *prog++;
        tok = LOGICAL_OR;
      }
      else tok = BITWISE_OR;
    }
    else if(*prog == '~'){
      *t++ = *prog++;
      tok = BITWISE_NOT;
    }
    else if(*prog == '<'){
      *t++ = *prog++;
      if (*prog == '='){
        *t++ = *prog++;
        tok = LESS_THAN_OR_EQUAL;
      }
      else tok = LESS_THAN;
    }
    else if(*prog == '>'){
      *t++ = *prog++;
      if (*prog == '='){
        *t++ = *prog++;
        tok = GREATER_THAN_OR_EQUAL;
      }
      else tok = GREATER_THAN;
    }
    else if(*prog == '!'){
      *t++ = *prog++;
      if(*prog == '='){
        *t++ = *prog++;
        tok = NOT_EQUAL;
      }
      else tok = LOGICAL_NOT;
    }
    else if(*prog == '+'){
      *t++ = *prog++;
      if(*prog == '+'){
        *t++ = *prog++;
        tok = INCREMENT;
      }
      else tok = PLUS;
    }
    else if(*prog == '-'){
      *t++ = *prog++;
      if(*prog == '-'){
        *t++ = *prog++;
        tok = DECREMENT;
      }
      else tok = MINUS;
    }
    else if(*prog == '*'){
      *t++ = *prog++;
      tok = STAR;
    }
    else if(*prog == '/'){
      *t++ = *prog++;
      tok = FSLASH;
    }
    else if(*prog == '%'){
      *t++ = *prog++;
      tok = MOD;
    }
    else if(*prog == '('){
      *t++ = *prog++;
      tok = OPENING_PAREN;
    }
    else if(*prog == ')'){
      *t++ = *prog++;
      tok = CLOSING_PAREN;
    }
    else if(*prog == ';'){
      *t++ = *prog++;
      tok = SEMICOLON;
    }
    else if(*prog == ','){
      *t++ = *prog++;
      tok = COMMA;
    }
    else if(*prog == '.'){
      *t++ = *prog++;
      tok = STRUCT_DOT;
    }
  }

  *t = '\0';
}
/*
asm{
  line1
  line2
}
*/
void get_line(void){
  char *t;

  t = string_constant;
  
  do{
    while(isspace(*prog)) prog++;
    if(*prog == '/' && *(prog+1) == '*'){
      prog = prog + 2;
      while(!(*prog == '*' && *(prog+1) == '/')) prog++;
      prog = prog + 2;
    }
  } while(isspace(*prog));

  if(*prog == '\0'){
    error(UNEXPECTED_EOF);
  }

  while(*prog != '\n'){
    *t = *prog;
    t++;
    prog++;
  }

  *t = '\0';
}

int find_keyword(char *keyword){
  register int i;
  
  for(i = 0; keyword_table[i].key; i++)
    if (!strcmp(keyword_table[i].keyword, keyword)) return keyword_table[i].key;
  
  return -1;
}

char isdelim(char c){
  if(strchr("#+-*/%[](){};,<>=!&|~.", c)) return 1;
  else return 0;
}

char is_idchar(char c){
  return(isalpha(c) || c == '_');
}

