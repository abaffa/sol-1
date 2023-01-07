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
  emitln(".include \"lib/kernel.exp\"");
  emitln(".org PROC_TEXT_ORG");
  emitln("\n; -----begin text block-----");
  pre_scan();

  parse_main();
  parse_functions();

  emitln("\n; -----end text block-----\n");
  
  emit_global_variables();

  emit_libraries();

  emitln("\n.end");

  *asmp = '\0';
  //puts(ASM);

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
  emitln("\n; -----begin include block-----\n");
  emitln(includes_list_ASM);
  emitln("\n; -----end include block-----\n");
}

void emit_global_variables(void){
  int i;
  char s_init[64];

  emitln("\n; -----begin data block-----\n");
  for(i = 0; i < global_var_tos; i++){
    if(global_variables[i].data.type == DT_CHAR && global_variables[i].data.ind_level > 0){
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
    else if(global_variables[i].data.type == DT_CHAR){
      emit(global_variables[i].var_name); // var name
      emit(": .db ");  
      sprintf(s_init, "$%x", global_variables[i].data.value.c);
      emitln(s_init);
    }
    else{
      emit(global_variables[i].var_name); // var name
      emit(": .dw ");  
      sprintf(s_init, "%d", global_variables[i].data.value.i);
      emitln(s_init);
    }
  }
  emitln("\n; -----end data block-----\n");
}

void initial_setup(void){
  global_var_tos = 0;
  local_var_tos = 0;
  
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
  system("pause");
}

void parse_main(void){
  register int i;

  emitln("main:");
  for(i = 0; *function_table[i].func_name; i++)
    if(!strcmp(function_table[i].func_name, "main")){
      current_func_id = i;
      prog = function_table[i].code_location;
      parse_block(); // starts interpreting the main function block;
      return;
    }
  
  trigger_err(NO_MAIN_FOUND);
}

void parse_functions(void){
  register int i;

  for(i = 0; *function_table[i].func_name; i++)
    if(strcmp(function_table[i].func_name, "main") != 0){ // skip 'main'
      current_function_var_bp_offset = 0; // this is used to position local variables correctly relative to BP.
                        // whenever a new function is parsed, this is reset to 0.
                        // then inside the function it can increase according to how any local vars there are.
      current_func_id = i;
      prog = function_table[i].code_location;
      emit(function_table[i].func_name);
      emitln(":");
      emitln("\tpush bp");
      emitln("\tmov bp, sp");
      parse_block(); // starts parsing the function block;
    }
}

void include_lib(char *lib_name){
  strcat(includes_list_ASM, ".include ");
  strcat(includes_list_ASM, lib_name); // concatenate library name into a small text session that
  strcat(includes_list_ASM, "\n");
  // in the end we add this to the final ASM text  
}

void pre_scan(void){
  char *tp;
  
  do{
    tp = prog;
    get_token();
    if(token_type == END) return;

    if(tok == DIRECTIVE){
      get_token();
      if(tok != INCLUDE) trigger_err(UNKNOWN_DIRECTIVE);
      get_token();
      if(token_type != STRING_CONST) trigger_err(DIRECTIVE_SYNTAX);
      include_lib(token);
      continue;
    }
    
    if(tok == CONST) get_token();
    if(tok != VOID && tok != CHAR && tok != INT && tok != FLOAT && tok != DOUBLE) trigger_err(NOT_VAR_OR_FUNC_OUTSIDE);
    
    get_token();
    
    while(tok == STAR) get_token();
    if(token_type != IDENTIFIER) trigger_err(IDENTIFIER_EXPECTED);

    get_token();
    if(tok == OPENING_PAREN){ //it must be a function declaration
      prog = tp;
      declare_func();
      find_end_of_BLOCK();
    }
    else { //it must be variable declarations
      prog = tp;
      declare_global();
    }
  } while(token_type != END);
  
}

void declare_func(void){
  _USER_FUNC *func; // variable to hold a pointer to the user function top of stack
  _BASIC_DATA param_data_type; // function data type
  char param_count; // number of parameters found in the declaration
  int bp_offset = 0; // for each parameter, keep the running offset of that parameter.

  if(function_table_tos == MAX_USER_FUNC - 1) trigger_err(EXCEEDED_FUNC_DECL_LIMIT);

  func = &function_table[function_table_tos];

  get_token();

  switch(tok){
    case VOID:
      func -> return_type = DT_VOID;
      break;
    case CHAR:
      func -> return_type = DT_CHAR;
      break;
    case INT:
      func -> return_type = DT_INT;
      break;
    case FLOAT:
      func -> return_type = DT_FLOAT;
      break;
    case DOUBLE:
      func -> return_type = DT_DOUBLE;
    
  }

  get_token(); // gets the function name
  strcpy(func -> func_name, token);
  get_token(); // gets past "("

  param_count = 0;
  
  get_token();
  if(tok == CLOSING_PAREN || tok == VOID){
    func -> parameters[0].param_name[0] = '\0'; // assigns a null character to the name of the first parameter entry
    if(tok == VOID) get_token();
  }
  else{
    putback();
    do{
      if(param_count == MAX_USER_FUNC_PARAMS) trigger_err(MAX_PARAMS_LIMIT_REACHED);
      get_token();
      if(tok == CONST){
        func -> parameters[param_count].constant = 1;
        get_token();
      }
      if(tok != VOID && tok != CHAR && tok != INT && tok != FLOAT && tok != DOUBLE) trigger_err(VAR_TYPE_EXPECTED);
      
      // assign the bp offset of this parameter
      func -> parameters[param_count].bp_offset = bp_offset;

      // gets the parameter type
      switch(tok){
        case CHAR:
          func -> parameters[param_count].type = DT_CHAR;
          get_token();
          if(tok == STAR){
            while(tok == STAR){
              func -> parameters[param_count].ind_level++;
              get_token();
            }
            bp_offset += 2; // is a pointer, so offset is +2
          }
          else{
            putback();
            bp_offset += 1; // not a pointer
          }
          break;
        case INT:
          func -> parameters[param_count].type = DT_INT;
          bp_offset += 2; // offset is +2 whether it is a pointer or not
          break;
        case FLOAT:
          func -> parameters[param_count].type = DT_FLOAT;
          bp_offset += 2; // offset is +2 whether it is a pointer or not
          break;
        case DOUBLE:
          func -> parameters[param_count].type = DT_DOUBLE;
          get_token();
          if(tok == STAR){
            while(tok == STAR){
              func -> parameters[param_count].ind_level++;
              get_token();
            }
            bp_offset += 2; // is a pointer, so offset is +2
          }
          else{
            putback();
            bp_offset += 4; // not a pointer
          }
      }
      
      if(token_type != IDENTIFIER) trigger_err(IDENTIFIER_EXPECTED);
      strcpy(func -> parameters[param_count].param_name, token);
        
      get_token();
      param_count++;
    } while(tok == COMMA);
  }
    
  if(tok != CLOSING_PAREN) trigger_err(CLOSING_PAREN_EXPECTED);

  func -> code_location = prog; // sets the function starting point to  just after the "(" token
  
  get_token(); // gets to the "{" token
  if(tok != OPENING_BRACE) trigger_err(OPENING_BRACE_EXPECTED);
  putback(); // puts the "{" back so that it can be found by find_end_of_BLOCK()

  *func -> parameters[param_count].param_name = '\0'; // marks the end of the parameter list with a null character
  function_table_tos++;
}

/*
asm{
  line1
  line2
}
*/
void parse_asm(void){
  get_token();
  if(tok == OPENING_BRACE){
    emit("; -----begin inline asm block-----\n");
    do{
      get_line();
      if(*string_constant != '}'){
        emit("\t");
        emitln(string_constant);
      }
    } while(*string_constant != '}');
    emitln("; -----end inline asm block-----");
  }
  else{
    emit("; -----inline asm block-----\n");
    putback();
    get_line();
    emit("\t");
    emitln(string_constant);
  }

}

void parse_break(void){
  char s_label[64];
  
  sprintf(s_label, "\tjmp _while%d_exit", current_label_index_loop);
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
  get_token();
  if(tok != OPENING_PAREN) trigger_err(OPENING_PAREN_EXPECTED);
  get_token();
  if(tok != SEMICOLON){
    putback();
    parse_expr();
  }
  if(tok != SEMICOLON) trigger_err(SEMICOLON_EXPECTED);

  sprintf(s_label, "_for%d_cond:", current_label_index_loop);
  emitln(s_label);
  
  // checks for an empty condition, which means always true
  get_token();
  if(tok != SEMICOLON){
    putback();
    parse_expr();
    if(tok != SEMICOLON) trigger_err(SEMICOLON_EXPECTED);
  }
  else{
    emitln("\tmov b, 1"); // emit a TRUE condition
  }

  emitln("\tmov a, b");
  emitln("\tcmp a, 0");
  sprintf(s_label, "\tje _for%d_exit", current_label_index_loop);
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
  if(!*prog) trigger_err(CLOSING_PAREN_EXPECTED);

  parse_block();
  
  sprintf(s_label, "_for%d_update:", current_label_index_loop);
  emitln(s_label);
  
  prog = update_loc;
  // checks for an empty update expression
  get_token();
  if(tok != CLOSING_PAREN){
    putback();
    parse_expr();
  }
    
  sprintf(s_label, "\tjmp _for%d_cond", current_label_index_loop);
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
  get_token();
  if(tok != OPENING_PAREN) trigger_err(OPENING_PAREN_EXPECTED);
  parse_expr(); // evaluate condition
  if(tok != CLOSING_PAREN) trigger_err(CLOSING_PAREN_EXPECTED);
  emitln("\tmov a, b");
  emitln("\tcmp a, 0");
  sprintf(s_label, "\tje _while%d_exit", current_label_index_loop);
  emitln(s_label);
  sprintf(s_label, "_while%d_block:", current_label_index_loop);
  emitln(s_label);
  parse_block();  // parse while block
  sprintf(s_label, "\tjmp _while%d_cond", current_label_index_loop);
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
  get_token();
  if(tok != OPENING_PAREN) trigger_err(OPENING_PAREN_EXPECTED);
  parse_expr(); // evaluate condition
  if(tok != CLOSING_PAREN) trigger_err(CLOSING_PAREN_EXPECTED);
  emitln("\tcmp b, 0");
  
  temp_p = prog;
  find_end_of_block(); // skip main IF block in order to check for ELSE block.
  get_token();
  if(tok == ELSE){
    sprintf(s_label, "\tje _if%d_else_block", current_label_index_if);
    emitln(s_label);
  }
  else{
    sprintf(s_label, "\tje _if%d_exit", current_label_index_if);
    emitln(s_label);
  }

  prog = temp_p;
  sprintf(s_label, "_if%d_block:", current_label_index_if);
  emitln(s_label);
  parse_block();  // parse the positive condition block
  sprintf(s_label, "\tjmp _if%d_exit", current_label_index_if);
  emitln(s_label);
  get_token(); // look for 'else'
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
  get_token();
  if(tok != SEMICOLON){
    putback();
    parse_expr();  // return value in register B
  }
  emitln("\tleave");
  emitln("\tret");
}

void parse_block(void){
  int brace = 0;
  
  do{
    get_token();
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
        if(token_type == END) trigger_err(CLOSING_BRACE_EXPECTED);
        putback();
        parse_expr();
        if(tok != SEMICOLON) trigger_err(SEMICOLON_EXPECTED);
    }    
  } while(brace); // exits when it finds the last closing brace
}

void find_end_of_block(void){
  int paren = 0;

  get_token();
  switch(tok){
    case ASM:
      find_end_of_block();
      break;
    case IF:
      // skips the conditional expression between parenthesis
      get_token();
      if(tok != OPENING_PAREN) trigger_err(OPENING_PAREN_EXPECTED);
      paren = 1; // found the first parenthesis
      do{
        if(*prog == '(') paren++;
        else if(*prog == ')') paren--;
        prog++;
      } while(paren && *prog);
      if(!*prog) trigger_err(CLOSING_PAREN_EXPECTED);

      find_end_of_block();
      get_token();
      if(tok == ELSE) find_end_of_block();
      else
        putback();
      break;
    case OPENING_BRACE: // if it's a block, then the block is skipped
      putback();
      find_end_of_BLOCK();
      break;
    case FOR:
      get_token();
      if(tok != OPENING_PAREN) trigger_err(OPENING_PAREN_EXPECTED);
      paren = 1;
      do{
        if(*prog == '(') paren++;
        else if(*prog == ')') paren--;
        prog++;
      } while(paren && *prog);
      if(!*prog) trigger_err(CLOSING_PAREN_EXPECTED);
      get_token();
      if(tok != SEMICOLON){
        putback();
        find_end_of_block();
      }
      break;
      
    default: // if it's not a keyword, then it must be an expression
      putback(); // puts the last token back, which might be a ";" token
      while(*prog++ != ';' && *prog);
      if(!*prog) trigger_err(SEMICOLON_EXPECTED);
  }
}

void find_end_of_BLOCK(void){
  int brace = 0;
  
  do{
    if(*prog == '{') brace++;
    else if(*prog == '}') brace--;
    prog++;
  } while(brace && *prog);

  if(brace && !*prog) trigger_err(CLOSING_BRACE_EXPECTED);
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

  get_token();
  if(token_type == IDENTIFIER){
    strcpy(var_name, token);
    get_token();
    if(tok == ASSIGNMENT){
      emitln("\tmov a, 0");
      parse_attrib();

      if(local_var_exists(var_name) != -1){ // is a local variable
        var_id = local_var_exists(var_name);
        if(local_variables[var_id].data.type == DT_CHAR){
          emitln("\tmov al, bl");
          emit("\tmov [bp+");
          sprintf(temp, "%d", local_variables[var_id].bp_offset);
          emit(temp);
          emitln("], al");
        }
        else if(local_variables[var_id].data.type == DT_INT){
          emitln("\tmov a, b");
          emitln("\tswp a"); // due to a stack silliness in the CPU where the LSB of a word is at the higher address, we need the swap here. 
                    // i need to fix the stack push/pop in the cpu so that low bytes are at lower addresses!
          emit("\tmov [bp+");
          sprintf(temp, "%d", local_variables[var_id].bp_offset - 1);
          emit(temp);
          emitln("], a");
        }
      }
      else if(global_var_exists(var_name) != -1){  // is a global variable
        var_id = global_var_exists(var_name);
        if(global_variables[var_id].data.type == DT_CHAR){
          emit("\tmov [");
          emit(global_variables[var_id].var_name);
          emitln("], bl");
        }
        else if(global_variables[var_id].data.type == DT_INT){
          emit("\tmov [");
          emit(global_variables[var_id].var_name);
          emitln("], b");
        }
      }
      else trigger_err(UNDECLARED_VARIABLE);

      return;
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
    emitln("\tpush a");
    emitln("\tmov a, b");
    parse_relational();
    emitln("\tcmp b, 0");
    emitln("\tpush a");
    emitln("\tlodflgs");
    emitln("\tmov b, a");
    emitln("\tpop a");
    emitln("\tnot bl");  
    emitln("\tand bl, %00000001"); // isolate ZF only. 
    emitln("\tmov bh, 0");
    emitln("\tcmp a, 0");
    emitln("\tlodflgs");
    emitln("\tnot al");  
    emitln("\tand al, %00000001"); // isolate ZF only. 
    emitln("\tmov ah, 0");
    if(temp_tok == LOGICAL_AND) emitln("\tand a, b");
    else emitln("\tor a, b");
    emitln("\tmov b, a");
    emitln("\tpop a");
  }
}

void parse_relational(void){
  char temp_tok;

/* x = y > 1 && z<4 && y == 2 */
  parse_terms();
  while(tok == EQUAL || tok == NOT_EQUAL || tok == LESS_THAN || tok == LESS_THAN_OR_EQUAL
    || tok == GREATER_THAN || tok == GREATER_THAN_OR_EQUAL){
    temp_tok = tok;
    emitln("\tpush a");
    emitln("\tmov a, b");
    parse_terms();
    switch(temp_tok){
      case EQUAL:
        emitln("\tcmp a, b");
        emitln("\tlodflgs");
        emitln("\tand al, %00000001"); // isolate ZF only. therefore if ZF==1 then A == B
        emitln("\tmov ah, 0");
        break;
      case NOT_EQUAL:
        emitln("\tcmp a, b");
        emitln("\tlodflgs");
        emitln("\tand al, %00000001"); // isolate ZF only.
        emitln("\txor al, %00000001"); // invert the condition
        emitln("\tmov ah, 0");
        break;
      case LESS_THAN:
        emitln("\tcmp a, b");
        emitln("\tlodflgs");
        emitln("\tand al, %00000010"); // isolate CF only. therefore if CF==1 then A < B
        emitln("\tmov ah, 0");
        break;
      case LESS_THAN_OR_EQUAL:
        emitln("\tcmp a, b");
        emitln("\tlodflgs");
        emitln("\tand al, %00000011"); // isolate both ZF and CF. therefore if CF==1 or ZF==1 then A <= B
        emitln("\tmov ah, 0");
        break;
      case GREATER_THAN_OR_EQUAL:
        emitln("\tcmp a, b");
        emitln("\tlodflgs");
        emitln("\tand al, %00000010"); 
        emitln("\txor al, %00000010"); 
        emitln("\tmov ah, 0");
        break;
      case GREATER_THAN:
        emitln("\tcmp a, b");
        emitln("\tlodflgs");
        emitln("\tand al, %00000011"); 
        emitln("\tcmp al, 0");
        emitln("\tlodflgs");
        emitln("\tand al, %00000001"); 
        emitln("\tmov ah, 0");
        break;
    }
    emitln("\tmov b, a");
    emitln("\tpop a");
  }
}

void parse_terms(void){
  char temp_tok;
  
  parse_factors();
  while(tok == PLUS || tok == MINUS){
    temp_tok = tok;
    emitln("\tpush a");
    emitln("\tmov a, b");
    parse_factors();
    if(temp_tok == PLUS) emitln("\tadd a, b"); else emitln("\tsub a, b");
    emitln("\tmov b, a");
    emitln("\tpop a");
  }
}

void parse_factors(void){
  char temp_tok;

  parse_atom();
  while(tok == STAR || tok == FSLASH || tok == MOD){
    temp_tok = tok;
    emitln("\tpush a");
    emitln("\tmov a, b");
    parse_atom();
    if(temp_tok == STAR){
      emitln("\tmul a, b");
    }
    else if(temp_tok == FSLASH){
      emitln("\tdiv a, b");
      emitln("\tmov g, a");
      emitln("\tmov a, b");
      emitln("\tmov b, g");
    }
    else if(temp_tok == MOD){
      emitln("\tdiv a, b");
    }
    emitln("\tpop a");
  }
}

void parse_atom(void){
  int var_id;
  int func_id;
  char temp_name[ID_LEN];
  char temp[64];

  get_token();

/*   a = *(p+1);
  a = *p;
 */
  if(tok == STAR){ // is a pointer operator
    parse_expr(); // parse expression after STAR, which could be inside parenthesis. result in B
    emitln("\tmov d, b");// now we have the pointer value. we then get the data at the address.
    emitln("\tmov bl, [d]"); // data fetched as a char! need to improve this to allow any types later.
    emitln("\tmov bh, 0");
    putback();
  }
  else if(token_type == INTEGER_CONST){
    emit("\tmov b, ");
    emitln(token);
  }
  else if(token_type == CHAR_CONST){
    emit("\tmov bl, "); emitln(token);
    emitln("\tmov bh, 0");
  }
  else if(tok == MINUS){
    parse_atom();
    emitln("\tneg b");
    putback();
  }
  else if(tok == BITWISE_NOT){
    parse_atom();
    emitln("\tnot b");
    putback();
  }
  else if(tok == OPENING_PAREN){
    parse_expr();  // parses expression between parenthesis and result will be in B
    if(tok != CLOSING_PAREN) trigger_err(CLOSING_PAREN_EXPECTED);
  }
  else if(token_type == IDENTIFIER){
    strcpy(temp_name, token);
    get_token();
    if(tok == OPENING_PAREN){ // function call      
      func_id = find_function(temp_name);
      if(func_id != -1){
        parse_function_arguments(func_id);
        emit("\tcall ");
        emitln(temp_name);
        if(tok != CLOSING_PAREN) trigger_err(CLOSING_PAREN_EXPECTED);
        // the function's return value is in register B

        // clean stack of the arguments added to it
        int i, bp_offsetclean = 0;
        char bp_offset_string[10];
        for(i = 0; *function_table[func_id].parameters[i].param_name; i++){
          if(function_table[func_id].parameters[i].ind_level > 0) bp_offsetclean += 2;
          else switch(function_table[func_id].parameters[i].type){
            case DT_CHAR:
              bp_offsetclean += 1;
              break;
            case DT_INT:
              bp_offsetclean += 2;
              break;
          }
        }
        sprintf(bp_offset_string, "%i", bp_offsetclean);
        emit("\tadd sp, ");
        emitln(bp_offset_string);
      }
      else trigger_err(UNDECLARED_FUNC);
      
    }
    else{
      if(local_var_exists(temp_name) != -1){ // is a local variable
        var_id = local_var_exists(temp_name);
        if(local_variables[var_id].data.type == DT_CHAR){
          emit("\tmov bl, [bp+");
          sprintf(temp, "%d", local_variables[var_id].bp_offset);
          emit(temp);
          emitln("]");
        }
        else if(local_variables[var_id].data.type == DT_INT){
          emit("\tmov b, [bp+");
          sprintf(temp, "%d", local_variables[var_id].bp_offset - 1);
          emit(temp);
          emitln("]");
          emitln("\tswp b"); // due to a stack silliness in the CPU where the LSB of a word is at the higher address, we need the swap here. 
                    // i need to fix the stack push/pop in the cpu so that low bytes are at lower addresses!
        }
      }
      else if(global_var_exists(temp_name) != -1){  // is a global variable
        var_id = global_var_exists(temp_name);
        if(global_variables[var_id].data.type == DT_CHAR){
          emit("\tmov bl, [");
          emit(global_variables[var_id].var_name);
          emitln("]");
        }
        else if(global_variables[var_id].data.type == DT_INT){
          emit("\tmov b, [");
          emit(global_variables[var_id].var_name);
          emitln("]");
        }
      }
      else trigger_err(UNDECLARED_VARIABLE);
      putback();
    }
  }
  else
    trigger_err(INVALID_EXPRESSION);

  get_token(); // gets the next token (it must be a delimiter)
}

void parse_function_arguments(int func_id){
  _USER_FUNC *func; // variable to hold a pointer to the user function
  int param_index;

  func = &function_table[func_id];
  param_index = 0;

  get_token();
  if(tok == CLOSING_PAREN){
    putback();
    return;
  }

  putback();

  do{
    get_token();
    switch(func -> parameters[param_index].type){
      case DT_CHAR:
        if(token_type != CHAR_CONST) trigger_err(INCOMPATIBLE_ARGUMENT_TYPE);
        else{
          parse_expr();
          emitln("\tpush bl");
        }
        break;
      case DT_INT:
        if(token_type != INTEGER_CONST) trigger_err(INCOMPATIBLE_ARGUMENT_TYPE);
        else{
          parse_expr();
          emitln("\tpush b");
        }
        break;
    }
    param_index++;
  } while(tok == COMMA);
  
}

void call_func(int func_id){
  char *t;
  int temp_local_tos;
  
  if(user_func_call_index == MAX_USER_FUNC_CALLS) trigger_err(USER_FUNC_CALLS_LIMIT_REACHED);

  current_func_id = func_id;

  temp_local_tos = local_var_tos;
  parse_function_arguments(func_id); // pushes the parameter variables into the local variables stack

  if(tok != CLOSING_PAREN) trigger_err(CLOSING_PAREN_EXPECTED);
  
  local_var_tos_history[user_func_call_index] = temp_local_tos;
  user_func_call_index++;

// saves the current program address
  t = prog;
  prog = function_table[func_id].code_location; // sets the program pointer to the beginning of the function code, just before the "{" token

// recovers the previous program address
  prog = t;
  
//recovers the previous local variable top of stack
  user_func_call_index--;
  local_var_tos = local_var_tos_history[user_func_call_index];

}

int find_global_var(char *var_name){
  register int i;
  char internal_name[ID_LEN] = "_var_";
  
  strcat(internal_name, var_name);
  for(i = 0; (i < global_var_tos) && (*global_variables[i].var_name); i++)
    if(!strcmp(global_variables[i].var_name, internal_name)) return i;
  
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

  get_token(); // gets past the data type
  if(tok == CONST){
    constant = 1;
    get_token();
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
    if(global_var_tos == MAX_GLOBAL_VARS) trigger_err(EXCEEDED_GLOBAL_VAR_LIMIT);

    global_variables[global_var_tos].constant = constant;

    // initializes the variable to 0
    global_variables[global_var_tos].data.value.c = 0;
    global_variables[global_var_tos].data.value.i = 0;
    global_variables[global_var_tos].data.value.f = 0.0;
    global_variables[global_var_tos].data.value.d = 0.0;
    global_variables[global_var_tos].data.value.p = NULL;
    
    get_token();
// **************** checks whether this is a pointer declaration *******************************
    ind_level = 0;
    while(tok == STAR){
      ind_level++;
      get_token();
    }
// *********************************************************************************************
    if(token_type != IDENTIFIER) trigger_err(IDENTIFIER_EXPECTED);
    
    // checks if there is another global variable with the same name
    if(find_global_var(token) != -1) trigger_err(DUPLICATE_GLOBAL_VARIABLE);
    
    global_variables[global_var_tos].data.type = dt;
    global_variables[global_var_tos].data.ind_level = ind_level;
    
    strcpy(global_variables[global_var_tos].var_name, "_var_");
    strcat(global_variables[global_var_tos].var_name, token);
    get_token();

    // checks for variable initialization
    if(tok == ASSIGNMENT){
      switch(dt){
        case DT_VOID:
          break;
        case DT_CHAR:
          if(ind_level > 0){ // if is a string
            get_token();
            if(token_type != STRING_CONST) trigger_err(STRING_CONSTANT_EXPECTED);
            strcpy(global_variables[global_var_tos].as_string, string_constant);
          }
          else{
            get_token();
            global_variables[global_var_tos].data.value.c = string_constant[0];
          }
          break;
        case DT_INT:
          get_token();
          global_variables[global_var_tos].data.value.i = atoi(token);
          break;
        case DT_FLOAT:
          break;
        case DT_DOUBLE:
          break;
      }
      get_token();
      //eval(&global_variables[global_var_tos].data);
      // after the value has been assigned, the data could be of any type, hence it needs to be converted into the correct type for this variable
      //convert_data(&global_variables[global_var_tos].data, dt);
    }
// the indirection level needs to be reset now, because if it is not its value might be changed to the attribution expression ind_level
    global_variables[global_var_tos].data.ind_level = ind_level;
    global_var_tos++;  
  } while(tok == COMMA);

  if(tok != SEMICOLON) trigger_err(SEMICOLON_EXPECTED);
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
  char internal_name[ID_LEN] = "_var_";

  strcat(internal_name, var_name);
  for(i = 0; i < global_var_tos; i++)
    if(!strcmp(global_variables[i].var_name, internal_name)) return i;
  
  return -1;
}

int local_var_exists(char *var_name){
  register int i;
  char internal_name[ID_LEN] = "_var_";

  strcat(internal_name, var_name);
  //check local variables whose function id is the id of current function being parsed
  for(i = 0; i < local_var_tos; i++)
    if(local_variables[i].function_id == current_func_id)
      if(!strcmp(local_variables[i].var_name, internal_name)) return i;
  
  return -1;
}

void declare_local(void){                        
  _BASIC_DATA dt;
  _LOCAL_VAR new_var;
  char ind_level;
  char constant = 0;
  
  get_token(); // gets past the data type

  if(tok == CONST){
    constant = TRUE;
    get_token();
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
    if(local_var_tos == MAX_LOCAL_VARS) trigger_err(LOCAL_VAR_LIMIT_REACHED);
    
    new_var.function_id = current_func_id; // set variable owner function

    // this is used to position local variables correctly relative to BP.
    // whenever a new function is parsed, this is reset to 0.
    // then inside the function it can increase according to how any local vars there are.
    new_var.bp_offset = current_function_var_bp_offset;
    switch(dt){
      case DT_CHAR:
        current_function_var_bp_offset -= 1;
        break;
      case DT_INT:
        current_function_var_bp_offset -= 2;
        break;
    }

    new_var.constant = constant;

    // initializes the variable to 0
    new_var.data.value.c = 0;
    new_var.data.value.i = 0;
    new_var.data.value.f = 0.0;
    new_var.data.value.d = 0.0;
    new_var.data.value.p = NULL;

    // gets the variable name
    get_token();
// **************** checks whether this is a pointer declaration *******************************
    ind_level = 0;
    while(tok == STAR){
      ind_level++;
      get_token();
    }    
// *********************************************************************************************
    if(token_type != IDENTIFIER) trigger_err(IDENTIFIER_EXPECTED);

    if(local_var_exists(token) != -1) trigger_err(DUPLICATE_LOCAL_VARIABLE);

    new_var.data.type = dt;
    new_var.data.ind_level = ind_level;
    strcpy(new_var.var_name, "_var_");
    strcat(new_var.var_name, token);
    get_token();

    if(tok == ASSIGNMENT){
      get_token();
    // emit ASM for variables
      switch(new_var.data.type){
        case DT_CHAR:
          emit("\tpush byte ");
          emitln(token);
          break;
        case DT_INT:
          emit("\tpush word ");
          emitln(token);
          break;
      }
      get_token();
    }
    else{
      switch(new_var.data.type){
        case DT_CHAR:
          emitln("\tpush byte 0");
          break;
        case DT_INT:
          emitln("\tpush word 0");
          break;
      }
    }


    // the indirection level needs to be reset now, because if it not, its value might be changed to the expression ind_level    
    new_var.data.ind_level = ind_level;
    // assigns the new variable to the local stack
    local_variables[local_var_tos] = new_var;    
    local_var_tos++;
  } while(tok == COMMA);

  if(tok != SEMICOLON) trigger_err(SEMICOLON_EXPECTED);
}

_LOCAL_VAR *get_local_var(char *var_name){
  register int i;

  //check local variables whose function id is the id of current function being parsed
  for(i = 0; i < local_var_tos; i++)
    if(local_variables[i].function_id == current_func_id)
      if(!strcmp(local_variables[i].var_name, var_name)) return &local_variables[i];
  
  return NULL;
}

_GLOBAL_VAR *get_global_var(char *var_name){
  register int i;

  for(i = 0; (i < global_var_tos) && (*global_variables[i].var_name); i++)
    if(!strcmp(global_variables[i].var_name, var_name)) return &global_variables[i];
  
  return NULL;
}

void local_push(_LOCAL_VAR *var){
  local_variables[local_var_tos] = *var;
  local_var_tos++;
}

void trigger_err(_ERROR e){
  int line = 1;
  char *t = pbuf;

  puts(error_table[e]);
  
  while(t < prog){
    t++;
    if(*t == '\n') line++;
  }
  
  printf("line number: %d\n", line);
  printf("near: %s", token);
  system("pause");

  exit(0);
}


// converts a literal string or char constant into constants with true escape sequences
void convert_constant(){
  char *s = string_constant;
  char *t = token;
  
  if(token_type == CHAR_CONST){
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
  else if(token_type == STRING_CONST){
    t++;
    while(*t != '\"' && *t){
      *s++ = *t++;
    }
  }
  
  *s = '\0';
}

void get_token(void){
  char *t;
  // skip blank spaces

  *token = '\0';
  tok = 0;
  t = token;
  
/* a comment */
  do{
    while(isspace(*prog)) prog++;
    if(*prog == '/' && *(prog+1) == '*'){
      prog = prog + 2;
      while(!(*prog == '*' && *(prog+1) == '/')) prog++;
      prog = prog + 2;
    }
  } while(isspace(*prog));

  if(*prog == '\0'){
    token_type = END;
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
    
    if(*prog != '\'') trigger_err(SINGLE_QUOTE_EXPECTED);
    
    *t++ = '\'';
    prog++;
    token_type = CHAR_CONST;
    *t = '\0';
    convert_constant(); // converts this string token with quotation marks to a non quotation marks string, and also converts escape sequences to their real bytes
  }
  else if(*prog == '\"'){
    *t++ = '\"';
    prog++;
    while(*prog != '\"' && *prog) *t++ = *prog++;
    if(*prog != '\"') trigger_err(DOUBLE_QUOTE_EXPECTED);
    *t++ = '\"';
    prog++;
    token_type = STRING_CONST;
    *t = '\0';
    convert_constant(); // converts this string token qith quotation marks to a non quotation marks string, and also converts escape sequences to their real bytes
  }
  else if(isdigit(*prog)){
    while(isdigit(*prog)) *t++ = *prog++;
    token_type = INTEGER_CONST;
  }
  else if(is_idchar(*prog)){
    while(is_idchar(*prog) || isdigit(*prog))
      *t++ = *prog++;
    *t = '\0';

    if((tok = find_keyword(token)) != -1) token_type = RESERVED;
    else token_type = IDENTIFIER;
  }
  else if(isdelim(*prog)){
    token_type = DELIMITER;  
    
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
      else tok = BITWISE_AND;
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
    trigger_err(UNEXPECTED_EOF);
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

