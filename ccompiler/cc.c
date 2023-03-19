#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include "def.h"

/* 
  DONE:
    * fix logical value comparisons: remove ah half
    * add data types to expressions as return values 
    * implement signed numbers. conditions such as i >= 0 
      when i decreases will always evaluate to true since after 0  we get 65535 which is > 0!
  
  TODO:
    * add automatic return to function ends when final } met
    * implement 'goto'

  COMMENTS:
    for char data types, we still put them in a 16bit register.
    if the data type is char, then we just make the high byte of the register = 0
    this makes it easier in places where matrices or pointers are used to dereference chars,
    specially when they are used in conditional expressions such as in while loops
*/

int main(int argc, char *argv[]){
  char header[256];

  if(argc > 1) load_program(argv[1]);  
  else{
    printf("Usage: cc [filename]\n");
    return 0;
  }

  asm_p = asm_out;  // set ASM outback pointer to the ASM array beginning
  data_block_p = data_block_asm; // data block pointer

  pre_processor();
  pre_scan();
  sprintf(header, "; --- FILENAME: %s", argv[1]);
  emitln(header);
  emitln(".include \"lib/kernel.exp\"");

  emitln(".org PROC_TEXT_ORG");

  emitln("\n; --- BEGIN TEXT BLOCK");
  parse_functions();
  emitln("; --- END TEXT BLOCK");

  emit_data_block();
  
  emit("\n; --- BEGIN INCLUDE BLOCK");
  emitln(includes_list_asm);
  emitln("; --- END INCLUDE BLOCK\n");

  emitln("\n.end");

  *asm_p = '\0';

//  optimize();
  generate_file("a.s"); // generate a.s assembly file

  return 0;
}

/*
void optimize(void){
  char s1[STRING_CONST_SIZE];
  prog = asm_out;

  do{
    get_line();
    if(!*string_const) break;
    strcpy(s1, string_const);
    if(!strcmp(s1, "  pop a\n")){
      get_line();
      if(!*string_const) break;
      if(!strcmp(string_const, "  push a\n")) continue;
    }
    else if(!strcmp(s1, "  pop b\n")){
      get_line();
      if(!*string_const) break;
      if(!strcmp(string_const, "  push b\n")) continue;
    }
    else if(!strcmp(s1, "  pop c\n")){
      get_line();
      if(!*string_const) break;
      if(!strcmp(string_const, "  push c\n")) continue;
    }
    else if(!strcmp(s1, "  pop d\n")){
      get_line();
      if(!*string_const) break;
      if(!strcmp(string_const, "  push d\n")) continue;
    }
    else if(!strcmp(s1, "  mov b, a\n")){
      get_line();
      if(!*string_const) break;
      if(!strcmp(string_const, "  mov a, b\n")){
        strcat(asm_optimized, s1);
        continue;
      }
    }
    else{
      strcat(asm_optimized, s1);
      continue;
    }

    strcat(asm_optimized, s1);
    strcat(asm_optimized, string_const);
  } while(string_const[0] != '\0');
}
*/

void emit_data_block(){
  emitln("\n; --- BEGIN DATA BLOCK");
  emit_string_table_data();
  emit(data_block_asm);
  emitln("; --- END DATA BLOCK");
}


void emit_data(char *data){
  char *p = data;

  while(*p){
    *data_block_p++ = *p++;
  }
}


void generate_file(char *filename){
  FILE *fp;
  int i;
  
  if((fp = fopen(filename, "wb")) == NULL){
    exit(0);
  }
  
  fprintf(fp, "%s", asm_out);

  fclose(fp);
}

void emitln(char *p){
  while(*p) *asm_p++ = *p++;
  *asm_p++ = '\n';
}


void emit(char *p){
  while(*p) *asm_p++ = *p++;
}


void load_program(char *filename){
  FILE *fp;
  int i;
  
  if((fp = fopen(filename, "rb")) == NULL){
    printf("%s: Source file not found.\n", filename);
    exit(0);
  }
  
  prog = c_in;
  i = 0;
  
  do{
    *prog = getc(fp);
    prog++;
    i++;
  } while(!feof(fp));
  
  *(prog - 1) = '\0'; // overwrite the EOF char with NULL

  fclose(fp);
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
  
  error(NO_MAIN_FOUND);
}


void parse_functions(void){
  register int i;

  for(i = 0; *function_table[i].func_name; i++)
    // parse main function first
    if(strcmp(function_table[i].func_name, "main") == 0){
      current_function_var_bp_offset = 0; // this is used to position local variables correctly relative to BP.
                        // whenever a new function is parsed, this is reset to 0.
                        // then inside the function it can increase according to how any local vars there are.
      current_func_id = i;
      prog = function_table[i].code_location;
      emitln("");
      emit(function_table[i].func_name);
      emitln(":");
      emitln("  push bp");
      emitln("  mov bp, sp");
      parse_block(); // starts parsing the function block;

      if(return_is_last_statement != RETURN){ // generate code for a 'return'
        emitln("  leave");
        emitln("  syscall sys_terminate_proc");
      }
      break;
    }

  for(i = 0; *function_table[i].func_name; i++)
    if(strcmp(function_table[i].func_name, "main") != 0)
    { // skip 'main'
      current_function_var_bp_offset = 0; // this is used to position local variables correctly relative to BP.
                        // whenever a new function is parsed, this is reset to 0.
                        // then inside the function it can increase according to how any local vars there are.
      current_func_id = i;
      prog = function_table[i].code_location;
      emitln("");
      emit(function_table[i].func_name);
      emitln(":");
      emitln("  push bp");
      emitln("  mov bp, sp");
      parse_block(); // starts parsing the function block;
      if(return_is_last_statement != RETURN){ // generate code for a 'return'
        emitln("  leave");
        emitln("  ret");
      }
    }
}


void include_asm_lib(char *lib_name){
  strcat(includes_list_asm, "\n.include ");
  strcat(includes_list_asm, lib_name); // concatenate library name into a small text session that
  // in the end we add this to the final ASM text  
}


void declare_define(){
  get(); // get define's name
  strcpy(defines_table[defines_tos].name, token);
  get(); // get definition
  strcpy(defines_table[defines_tos].content, token);
  defines_tos++;
}


void pre_processor(void){
  char *tp;
  char *c_preproc_p;
  int define_id;

  prog = c_in; 
  do{
    tp = prog;
    get();
    if(tok_type == END) return;

    if(tok == DIRECTIVE){
      get();
      if(tok == INC_ASM){
        get();
        if(tok_type != STRING_CONST) error(DIRECTIVE_SYNTAX);
        include_asm_lib(token);
        continue;
      }
      /*else if(tok == DEFINE){
        declare_define();
        continue;
      }
      else{
        prog = tp;
      }*/
    }
/*
    prog = tp;
    get();
    if(tok_type == IDENTIFIER){
      define_id = find_define(token);
      if(define_id != -1){
        strcat(c_preproc_out, defines_table[define_id].content);
      }
      else{
        strcat(c_preproc_out, token);
      }
    }
    else if(tok == ASM){
      strcat(c_preproc_out, "\nasm{");
      get(); // get '{'
      c_preproc_p = c_preproc_out;
      while(*c_preproc_p) c_preproc_p++; // go to end of buffer
      while(*prog != '}'){
        *c_preproc_p++ = *prog++;        
      }
      prog++; // skip '}'
      *c_preproc_p = '\0'; // end with NULL so that strcat can continue working
      strcat(c_preproc_out, "}\n");
    }
    else{
      strcat(c_preproc_out, token);
    }
    strcat(c_preproc_out, " ");
*/
  } while(tok_type != END);
}


int find_define(char *name){
  int i;
  for(i = 0; i < defines_tos; i++){
    if(!strcmp(defines_table[i].name, name)) return i;
  }
  return -1;
}


void pre_scan(void){
  char *tp;
  
  //prog = c_preproc_out;
  prog = c_in;
  do{
    tp = prog;
    get();
    if(tok_type == END) return;

    if(tok == DIRECTIVE){
      get();
      if(tok == INC_ASM){
        get();
        continue;
      }
      else if(tok == DEFINE){
        continue;
      }
    }
    else if(tok == ENUM){
      declare_enum();
      continue;
    }
    
    if(tok == CONST) get();
    if(tok == SIGNED || tok == UNSIGNED || tok == LONG) get();
    if(tok != VOID && tok != CHAR && tok != INT && tok != FLOAT && tok != DOUBLE) error(NOT_VAR_OR_FUNC_OUTSIDE);

    get();
    
    while(tok == STAR) get();
    if(tok_type != IDENTIFIER) error(IDENTIFIER_EXPECTED);

    get();
    if(tok == OPENING_PAREN){ //it must be a function declaration
      prog = tp;
      declare_func();
      skip_block();
    }
    else { //it must be variable declarations
      prog = tp;
      declare_global();
    }
  } while(tok_type != END);
  
}


void declare_func(void){
  t_user_func *func; // variable to hold a pointer to the user function top of stack
  t_data_type param_data_type; // function data type
  int bp_offset; // for each parameter, keep the running offset of that parameter.
  char *temp_prog, *temp_prog2;
  int total_parameter_bytes;
  char param_name[ID_LEN];

  if(function_table_tos == MAX_USER_FUNC - 1) error(EXCEEDED_FUNC_DECL_LIMIT);
  func = &function_table[function_table_tos];

  get();
  func->return_type.type = get_data_type_from_tok(tok);

  get();
  while(tok == STAR){
    func->return_type.ind_level++;
    get();
  }
  strcpy(func->func_name, token);
  get(); // gets past "("

  func->local_var_tos = 0;
  
  get();
  if(tok == CLOSING_PAREN || tok == VOID){
    if(tok == VOID) get();
  }
  else{
    back();
    temp_prog = prog;
    total_parameter_bytes = get_total_func_param_size();
    func->total_parameter_size = total_parameter_bytes;
    bp_offset = 4 + total_parameter_bytes; // +4 to account for pc and bp in the stack
    prog = temp_prog;

    do{
      // set as parameter so that we can tell that if a matrix is declared, the argument is also a pointer
      // even though it may not be declared with any '*' tokens;
      func->local_vars[func->local_var_tos].is_parameter = 1;
      temp_prog = prog;
      get();
      if(tok == CONST){
        func->local_vars[func->local_var_tos].constant = 1;
        get();
      }
      if(tok != VOID && tok != CHAR && tok != INT && tok != FLOAT && tok != DOUBLE) error(VAR_TYPE_EXPECTED);
      // gets the parameter type
      switch(tok){
        case CHAR:
          func->local_vars[func->local_var_tos].data.type = DT_CHAR;
          break;
        case INT:
          func->local_vars[func->local_var_tos].data.type = DT_INT;
          break;
        case FLOAT:
          func->local_vars[func->local_var_tos].data.type = DT_FLOAT;
          break;
        case DOUBLE:
          func->local_vars[func->local_var_tos].data.type = DT_DOUBLE;
          break;
      }
      get();
      while(tok == STAR){
        func->local_vars[func->local_var_tos].data.ind_level++;
        get();
      }
      if(tok_type != IDENTIFIER) error(IDENTIFIER_EXPECTED);
      strcpy(param_name, token); // copy parameter name
      // checks if this is a matrix declaration
      get();
      int i = 0;
      func->local_vars[func->local_var_tos].dims[0] = 0; // in case its not a matrix, this signals that fact
      if(tok == OPENING_BRACKET){
        while(tok == OPENING_BRACKET){
          get();
          func->local_vars[func->local_var_tos].dims[i] = atoi(token);
          get();
          if(tok != CLOSING_BRACKET) error(CLOSING_BRACKET_EXPECTED);
          get();
          i++;
        }
        func->local_vars[func->local_var_tos].dims[i] = 0; // sets the last variable dimention to 0, to mark the end of the list
      }
      prog = temp_prog;
      bp_offset -= get_param_size();
      // assign the bp offset of this parameter
      func->local_vars[func->local_var_tos].bp_offset = bp_offset + 1;

      strcpy(func->local_vars[func->local_var_tos].var_name, param_name);
      get();
      func->local_var_tos++;
    } while(tok == COMMA);
  }
    
  if(tok != CLOSING_PAREN) error(CLOSING_PAREN_EXPECTED);

  func->code_location = prog; // sets the function starting point to  just after the "(" token
  
  get(); // gets to the "{" token
  if(tok != OPENING_BRACE) error(OPENING_BRACE_EXPECTED);
  back(); // puts the "{" back so that it can be found by skip_block()

  //*func->local_vars[func->local_var_tos].var_name = '\0'; // marks the end of the variable list with a null character
  function_table_tos++;
}


int get_param_size(void){
  int data_size;

  get();
  switch(tok){
    case CHAR:
      data_size = 1;
      break;
    case INT:
      data_size = 2;
      break;
    case FLOAT:
      data_size = 2;
      break;
    case DOUBLE:
      data_size = 4;
  }

  get(); // check for '*'
  if(tok == STAR){
    data_size = 2;
    while(tok == STAR) get();
  }

  get(); // check for brackets
  if(tok == OPENING_BRACKET){
    data_size = 2; // parameter is a pointer if it is an array
    while(tok == OPENING_BRACKET){
      get();
      // line below commented out because parameter variables are passed as pointers instead
      //data_size *= atoi(token);
      get(); // ']'
      get();
    }
    back();
  }
  else back();
  
  return data_size;
}


int get_total_func_param_size(void){
  int total_bytes;
  int data_size;

  total_bytes = 0;
  do{
    total_bytes += get_param_size();
    get();
  } while(tok == COMMA);

  return total_bytes;
}


void parse_asm(void){
  char *temp_prog;

  get();
  if(tok != OPENING_BRACE) error(OPENING_BRACE_EXPECTED);
  emit("\n; --- BEGIN INLINE ASM BLOCK");
  while(1){
    while(*prog != 0x0A) prog++;
    *asm_p++ = *prog++; // copy 0x0A
    while(*prog == ' ' || *prog == '\t') prog++; // skip leading spaces
    temp_prog = prog;
    get();
    if(tok == CLOSING_BRACE) break;
    get();
    if(tok == COLON){ // is a label
      prog = temp_prog;
      while(*prog != ':') *asm_p++ = *prog++;
      *asm_p++ = ':';
      prog++;
    }
    else{
      prog = temp_prog;
      *asm_p++ = ' ';
      *asm_p++ = ' ';
      while(*prog != 0x0A){
        if(*prog == '@'){
          prog++;
          get();
          emit_c_var(token);
        }
        else *asm_p++ = *prog++;
      }
    }
  }
  emitln("; --- END INLINE ASM BLOCK\n");
}


void emit_c_var(char *var_name){
  int var_id;
  char temp[256];
  if(local_var_exists(var_name) != -1){ // is a local variable
    var_id = local_var_exists(var_name);
    if(function_table[current_func_id].local_vars[var_id].data.ind_level > 0){
      emit("[");
      get_var_base_addr(temp, var_name);
      emit(temp);
      emit("]");
    }
    else if(function_table[current_func_id].local_vars[var_id].data.type == DT_INT){
      emit("[");
      get_var_base_addr(temp, var_name);
      emit(temp);
      emit("]");
    }
    else if(function_table[current_func_id].local_vars[var_id].data.type == DT_CHAR){
      emit("[");
      get_var_base_addr(temp, var_name);
      emit(temp);
      emit("]");
    }
  }
  else if(global_var_exists(var_name) != -1){  // is a global variable
    emit("[__");
    emit(var_name);
    emit("]");
  }
  else error(UNDECLARED_VARIABLE);
}


void parse_break(void){
  char s_label[64];

  if(current_loop_type == FOR_LOOP){
    sprintf(s_label, "  jmp _for%d_exit ; for break", current_label_index_for);
    emitln(s_label);
  }
  else if(current_loop_type == WHILE_LOOP){
    sprintf(s_label, "  jmp _while%d_exit ; while break", current_label_index_while);
    emitln(s_label);
  }
  else if(current_loop_type == DO_LOOP){
    sprintf(s_label, "  jmp _do%d_exit ; do break", current_label_index_do);
    emitln(s_label);
  }
  else if(current_loop_type == SWITCH_CONSTRUCT){
    sprintf(s_label, "  jmp _switch%d_exit ; case break", current_label_index_switch);
    emitln(s_label);
  }
  get();
}


void parse_continue(void){
  char s_label[64];

  if(current_loop_type == FOR_LOOP){
    sprintf(s_label, "  jmp _for%d_update ; for continue", current_label_index_for);
    emitln(s_label);
  }
  else if(current_loop_type == WHILE_LOOP){
    sprintf(s_label, "  jmp _while%d_cond ; while continue", current_label_index_while);
    emitln(s_label);
  }
  else if(current_loop_type == DO_LOOP){
    sprintf(s_label, "  jmp _do%d_cond ; do continue", current_label_index_do);
    emitln(s_label);
  }
  get();
}


void parse_for(void){
  char s_label[64];
  char *update_loc;

  loop_type_stack[loop_type_tos] = current_loop_type;
  loop_type_tos++;
  current_loop_type = FOR_LOOP;
  highest_label_index++;
  label_stack_for[label_tos_for] = current_label_index_for;
  label_tos_for++;
  current_label_index_for = highest_label_index;

  sprintf(s_label, "_for%d_init:", current_label_index_for);
  emitln(s_label);
  get();
  if(tok != OPENING_PAREN) error(OPENING_PAREN_EXPECTED);
  get();
  if(tok != SEMICOLON){
    back();
    parse_expr();
  }
  if(tok != SEMICOLON) error(SEMICOLON_EXPECTED);

  sprintf(s_label, "_for%d_cond:", current_label_index_for);
  emitln(s_label);
  
  // checks for an empty condition, which means always true
  get();
  if(tok != SEMICOLON){
    back();
    parse_expr();
    if(tok != SEMICOLON) error(SEMICOLON_EXPECTED);
    emitln("  cmp b, 0");
    sprintf(s_label, "  je _for%d_exit", current_label_index_for);
    emitln(s_label);
  }

  sprintf(s_label, "_for%d_block:", current_label_index_for);
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
  
  sprintf(s_label, "_for%d_update:", current_label_index_for);
  emitln(s_label);
  
  prog = update_loc;
  // checks for an empty update expression
  get();
  if(tok != CLOSING_PAREN){
    back();
    parse_expr();
  }
    
  sprintf(s_label, "  jmp _for%d_cond", current_label_index_for);
  emitln(s_label);

  skip_statements();

  sprintf(s_label, "_for%d_exit:", current_label_index_for);
  emitln(s_label);

  label_tos_for--;
  current_label_index_for = label_stack_for[label_tos_for];
  loop_type_tos--;
  current_loop_type = loop_type_stack[loop_type_tos];
}


void parse_while(void){
  char s_label[64];

  loop_type_stack[loop_type_tos] = current_loop_type;
  loop_type_tos++;
  current_loop_type = WHILE_LOOP;
  highest_label_index++;
  label_stack_while[label_tos_while] = current_label_index_while;
  label_tos_while++;
  current_label_index_while = highest_label_index;

  sprintf(s_label, "_while%d_cond:", current_label_index_while);
  emitln(s_label);
  get();
  if(tok != OPENING_PAREN) error(OPENING_PAREN_EXPECTED);
  parse_expr(); // evaluate condition
  if(tok != CLOSING_PAREN) error(CLOSING_PAREN_EXPECTED);
  emitln("  cmp b, 0");
  sprintf(s_label, "  je _while%d_exit", current_label_index_while);
  emitln(s_label);
  sprintf(s_label, "_while%d_block:", current_label_index_while);
  emitln(s_label);
  parse_block();  // parse while block
  sprintf(s_label, "  jmp _while%d_cond", current_label_index_while);
  emitln(s_label);
  sprintf(s_label, "_while%d_exit:", current_label_index_while);
  emitln(s_label);

  label_tos_while--;
  current_label_index_while = label_stack_while[label_tos_while];
  loop_type_tos--;
  current_loop_type = loop_type_stack[loop_type_tos];
}


void parse_do(void){
  char s_label[64];

  loop_type_stack[loop_type_tos] = current_loop_type;
  loop_type_tos++;
  current_loop_type = DO_LOOP;
  highest_label_index++;
  label_stack_do[label_tos_do] = current_label_index_do;
  label_tos_do++;
  current_label_index_do = highest_label_index;

  sprintf(s_label, "_do%d_block:", current_label_index_do);
  emitln(s_label);
  parse_block();  // parse block

  sprintf(s_label, "_do%d_cond:", current_label_index_do);
  emitln(s_label);
  get(); // get 'while'
  get();
  if(tok != OPENING_PAREN) error(OPENING_PAREN_EXPECTED);
  parse_expr(); // evaluate condition
  if(tok != CLOSING_PAREN) error(CLOSING_PAREN_EXPECTED);
  emitln("  cmp b, 1");
  sprintf(s_label, "  je _do%d_block", current_label_index_do);
  emitln(s_label);

  sprintf(s_label, "_do%d_exit:", current_label_index_do);
  emitln(s_label);

  get();
  if(tok != SEMICOLON) error(SEMICOLON_EXPECTED);

  label_tos_do--;
  current_label_index_do = label_stack_do[label_tos_do];
  loop_type_tos--;
  current_loop_type = loop_type_stack[loop_type_tos];
}

/*
  switch(expr){
    case const1:

    case const2:

    default:
  }
  parse expr into b
  for each case, mov const into a
  cmp a, b
  if true, execute block
  else jmp to next block
  
*/
int count_cases(void){
  int nbr_cases = 0;

  do{
    get();
    if(tok == OPENING_BRACE){
      back();
      skip_block();
    }
    else if(tok == CASE) nbr_cases++;
    else if(tok == CLOSING_BRACE || tok == DEFAULT) return nbr_cases;
  } while(1);
}


void skip_case(void){
  do{
    get();
    if(tok == OPENING_BRACE){
      back();
      skip_block();
      get();
    }
  } while(tok != CASE && tok != DEFAULT && tok != CLOSING_BRACE);
}


void goto_next_case(void){
  int nbr_cases = 0;
  do{
    get();
    if(tok == OPENING_BRACE){
      back();
      skip_block();
    }
    else if(tok == CASE) nbr_cases++;
    else if(tok == CLOSING_BRACE || tok == DEFAULT) return;
  } while(1);
}


int switch_has_default(void){
  do{
    get();
    if(tok == OPENING_BRACE){
      back();
      skip_block();
    }
    else if(tok == DEFAULT) return 1;
    else if(tok == CLOSING_BRACE) return 0;
  } while(1);
}

void parse_switch(void){
  char s_label[64];
  char *temp_p;
  int current_case_nbr;

  loop_type_stack[loop_type_tos] = current_loop_type;
  loop_type_tos++;
  current_loop_type = SWITCH_CONSTRUCT;
  highest_label_index++;
  label_stack_switch[label_tos_switch] = current_label_index_switch;
  label_tos_switch++;
  current_label_index_switch = highest_label_index;

  sprintf(s_label, "_switch%d_expr:", current_label_index_switch);
  emitln(s_label);
  get();
  if(tok != OPENING_PAREN) error(OPENING_PAREN_EXPECTED);
  parse_expr(); // evaluate condition
  if(tok != CLOSING_PAREN) error(CLOSING_PAREN_EXPECTED);
  sprintf(s_label, "_switch%d_comparisons:", current_label_index_switch);
  emitln(s_label);

  get();
  if(tok != OPENING_BRACE) error(OPENING_BRACE_EXPECTED);

  temp_p = prog;
  current_case_nbr = 0;

  // emit compares and jumps
  do{
    get();
    if(tok != CASE) error(CASE_EXPECTED);
    get();
    if(tok_type == INTEGER_CONST){
      emit("  cmp b, ");
      emitln(token);
      sprintf(s_label, "  je _switch%d_case%d", current_label_index_switch, current_case_nbr);
      emitln(asm_line);
      get();
      if(tok != COLON) error(COLON_EXPECTED);
      skip_case();
      back();
    }
    else if(tok_type == CHAR_CONST){
      emit("  cmp bl, '");
      emit(string_const);
      emitln("'");
      sprintf(asm_line, "  je _switch%d_case%d", current_label_index_switch, current_case_nbr);
      emitln(asm_line);
      get();
      if(tok != COLON) error(COLON_EXPECTED);
      skip_case();
      back();
    }
    else if(tok_type == IDENTIFIER){
      if(enum_element_exists(token) != -1){
        sprintf(asm_line, "  cmp b, %d", get_enum_val(token));
        emitln(asm_line);
        sprintf(asm_line, "  je _switch%d_case%d", current_label_index_switch, current_case_nbr);
        emitln(asm_line);
        get();
        if(tok != COLON) error(COLON_EXPECTED);
        skip_case();
        back();
      }
    }
    else error(CONSTANT_EXPECTED);
    current_case_nbr++;
  } while(tok == CASE);

  // generate default jump if it exists
  if(tok == DEFAULT){
    sprintf(s_label, "  jmp _switch%d_default", current_label_index_switch);
    emitln(s_label);
    get(); // get default
    get(); // get ':'
    skip_case();
  }

  // emit code for each case block
  prog = temp_p;
  current_case_nbr = 0;
  do{
    get(); // get 'case'
    get(); // get constant
    get(); // get ':'

    sprintf(s_label, "_switch%d_case%d:", current_label_index_switch, current_case_nbr);
    emitln(s_label);
    parse_case();
    current_case_nbr++;
  } while(tok == CASE);

  get();
  if(tok == DEFAULT){
    get(); // get ':'
    sprintf(s_label, "_switch%d_default:", current_label_index_switch);
    emitln(s_label);
    parse_case();
  }
  else back();

  get(); // get the final '}'
  if(tok != CLOSING_BRACE) error(CLOSING_BRACE_EXPECTED);

  sprintf(s_label, "_switch%d_exit:", current_label_index_switch);
  emitln(s_label);
  

  label_tos_switch--;
  current_label_index_switch = label_stack_switch[label_tos_switch];
  loop_type_tos--;
  current_loop_type = loop_type_stack[loop_type_tos];
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
  skip_statements(); // skip main IF block in order to check for ELSE block.
  get();
  if(tok == ELSE){
    sprintf(s_label, "  je _if%d_else", current_label_index_if);
    emitln(s_label);
  }
  else{
    sprintf(s_label, "  je _if%d_exit", current_label_index_if);
    emitln(s_label);
  }

  prog = temp_p;
  sprintf(s_label, "_if%d_true:", current_label_index_if);
  emitln(s_label);
  parse_block();  // parse the positive condition block
  sprintf(s_label, "  jmp _if%d_exit", current_label_index_if);
  emitln(s_label);
  get(); // look for 'else'
  if(tok == ELSE){
    sprintf(s_label, "_if%d_else:", current_label_index_if);
    emitln(s_label);
    parse_block();  // parse the positive condition block
  }
  else{
    back();
  }
  
  sprintf(s_label, "_if%d_exit:", current_label_index_if);
  emitln(s_label);

  label_tos_if--;
  current_label_index_if = label_stack_if[label_tos_if];
}


void parse_return(void){
  get();
  if(tok != SEMICOLON){
    back();
    parse_expr();  // return value in register B
  }
  emitln("  leave");
  // check if this is "main"
  if(!strcmp(function_table[current_func_id].func_name, "main")){
    emitln("  syscall sys_terminate_proc");
  }
  else{
    emitln("  ret");
  }
}


void parse_case(void){
  do{
    get();
    switch(tok){
      case CASE:
      case DEFAULT:
      case CLOSING_BRACE:
        back();
        return;
      default:
        back();
    get();
        back();
        parse_block();
    }    
  } while(1); 
}


void parse_block(void){
  int braces = 0;
  
  do{
    get();
    if(tok != CLOSING_BRACE) return_is_last_statement = 0;
    switch(tok){
      case SIGNED:
      case UNSIGNED:
      case LONG:
      case INT:
      case CHAR:
      case FLOAT:
      case DOUBLE:
        back();
        declare_local();
        break;
      case ASM:
        parse_asm();
        break;
      case IF:
        parse_if();
        break;
      case SWITCH:
        parse_switch();
        break;
      case FOR:
        parse_for();
        break;
      case WHILE:
        parse_while();
        break;
      case DO:
        parse_do();
        break;
      case BREAK:
        parse_break();
        break;
      case CONTINUE:
        parse_continue();
        break;
      case OPENING_BRACE:
        braces++;
        break;
      case CLOSING_BRACE:
        braces--;
        break;
      case RETURN:
        parse_return();
        return_is_last_statement = RETURN;
        break;
      default:
        if(tok_type == END) error(CLOSING_BRACE_EXPECTED);
        back();
        parse_expr();
        if(tok != SEMICOLON) error(SEMICOLON_EXPECTED);
    }    
  } while(braces); // exits when it finds the last closing brace
}


void skip_statements(void){
  int paren = 0;

  get();
  switch(tok){
    case ASM:
      skip_statements();
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

      skip_statements();
      get();
      if(tok == ELSE) skip_statements();
      else
        back();
      break;
    case OPENING_BRACE: // if it's a block, then the block is skipped
      back();
      skip_block();
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
        back();
        skip_statements();
      }
      break;
      
    default: // if it's not a keyword, then it must be an expression
      back(); // puts the last token back, which might be a ";" token
      while(*prog++ != ';' && *prog);
      if(!*prog) error(SEMICOLON_EXPECTED);
  }
}


void skip_block(void){
  int braces = 0;
  
  do{
    get();
    if(tok == OPENING_BRACE) braces++;
    else if(tok == CLOSING_BRACE) braces--;
  } while(braces && tok_type != END);

  if(braces && tok_type == END) error(CLOSING_BRACE_EXPECTED);
}


void skip_matrix_bracket(void){
  int brackets = 0;
  
  do{
    get();
    if(tok == OPENING_BRACKET) brackets++;
    else if(tok == CLOSING_BRACKET) brackets--;
  } while(brackets && tok_type != END);

  if(brackets && tok_type == END) error(CLOSING_BRACKET_EXPECTED);
}


t_data_type get_var_type(char *var_name){
  register int i;

  for(i = 0; i < function_table[current_func_id].local_var_tos; i++)
    if(!strcmp(function_table[current_func_id].local_vars[i].var_name, var_name))
      return function_table[current_func_id].local_vars[i].data.type;

  for(i = 0; i < global_var_tos; i++)
    if(!strcmp(global_variables[i].var_name, var_name)) 
      return global_variables[i].data.type;

  error(UNDECLARED_VARIABLE);
}


void emit_var_assignment(char *var_name){
  int var_id;
  char temp[ID_LEN];

  if(local_var_exists(var_name) != -1){ // is a local variable
    var_id = local_var_exists(var_name);
    if(function_table[current_func_id].local_vars[var_id].data.ind_level > 0
    || function_table[current_func_id].local_vars[var_id].data.type == DT_INT){
      emitln("  push a");
      emitln("  mov a, b");
      emit("  mov [");
      get_var_base_addr(temp, var_name);
      emit(temp);
      emit("], a");
      emit(" ; ");
      emitln(var_name);
      emitln("  pop a");
    }
    else if(function_table[current_func_id].local_vars[var_id].data.type == DT_CHAR){
      emitln("  push al");
      emitln("  mov al, bl");
      emit("  mov [");
      get_var_base_addr(temp, var_name);
      emit(temp);
      emit("], al");
      emit(" ; ");
      emitln(var_name);
      emitln("  pop al");
    }
  }
  else if(global_var_exists(var_name) != -1){  // is a global variable
    var_id = global_var_exists(var_name);
    if(global_variables[var_id].data.ind_level > 0){ // is a pointer
      emit("  mov [__");
      emit(global_variables[var_id].var_name);
      emitln("], b");
    }
    else if(global_variables[var_id].data.type == DT_CHAR){
        emit("  mov [__");
        emit(global_variables[var_id].var_name);
        emitln("], bl");
    }
    else if(global_variables[var_id].data.type == DT_INT){
        emit("  mov [__");
        emit(global_variables[var_id].var_name);
        emitln("], b");
    }
  }
  else error(UNDECLARED_VARIABLE);
}


t_data parse_expr(){
  t_data data;

  data.ind_level = 0;
  data.type = DT_INT;
  get();
  if(tok == SEMICOLON) return data;
  else{
    back();
    return parse_assignment();
  }
}


t_data parse_assignment(){
  char var_name[ID_LEN];
  char temp[ID_LEN];
  char *temp_prog;
  int var_id;
  char s_label[64];
  char *temp_asm_p;
  t_data expr_in, expr_out;

  temp_prog = prog;
  temp_asm_p = asm_p; // save current assembly output pointer
  expr_in = parse_ternary_op(); // parse expression before assignment(if assignment exists)
  if(tok != ASSIGNMENT){
    expr_out = expr_in;
    return expr_out;
  }

  // is assignment
  prog = temp_prog;
  asm_p = temp_asm_p; // recover asm output pointer
  get();
  if(tok_type == IDENTIFIER){
    strcpy(var_name, token);
    get();
    if(tok == OPENING_BRACKET){ // matrix operations
      t_var *matrix;
      int last_dim, dims;
      matrix = get_var_pointer(var_name); // gets a pointer to the variable holding the matrix address
      expr_in = emit_matrix_arithmetic(matrix, &last_dim);
      expr_out = expr_in;
      dims = matrix_dim_count(matrix); // gets the number of dimensions for this matrix
      get(); // get the '=' sign
      emitln("  push d"); // save 'd'. this is the matrix base address. save because expr below could use 'd' and overwrite it
      parse_expr(); // evaluate expression, result in 'b'
      emitln("  pop d"); 
      if(last_dim == dims - 1){
        if(matrix->data.ind_level > 0 || matrix->data.type == DT_INT){
          emitln("  mov [d], b");
        }
        else if(matrix->data.type == DT_CHAR){
          emitln("  mov [d], bl");
        }
      }
      else error(INVALID_MATRIX_ASSIGNMENT);
      return expr_out;
    }
    else if(tok == ASSIGNMENT){
      expr_out = parse_expr(); // evaluate expression, result in 'b'
      emit_var_assignment(var_name);
      return expr_out;
    }
  }
  else if(tok == STAR){ // tests if this is a pointer assignment
    expr_in = parse_atom(); // parse what comes after '*' (considered a pointer)
    emitln("  push b"); // pointer given in 'b'. push 'd' into stack to save it. we will retrieve it below into 'd' for the assignment address
    //emitln("  mov d, b"); // pointer given in 'b', so mov 'b' into 'd'
    // after evaluating the address expression, the token will be a "="
    if(tok != ASSIGNMENT) error(SYNTAX);
    parse_expr(); // evaluates the value to be assigned to the address, result in 'b'
    emitln("  pop d"); // now pop 'b' from before into 'd' so that we can recover the address for the assignment
    switch(expr_in.type){
      case DT_CHAR:
        emitln("  push al"); // pushing a/al as this function cLL could have come after a 'mov a, b' in parse_terms etc
        emitln("  mov al, bl");
        emitln("  mov [d], al");
        emitln("  pop al");
        break;
      case DT_INT:
        emitln("  push a"); // pushing a/al as this function cLL could have come after a 'mov a, b' in parse_terms etc
        emitln("  mov a, b");
        emitln("  mov [d], a");
        emitln("  pop a");
        break;
      default: error(INVALID_POINTER);
    }
    expr_out = expr_in;
    expr_out.ind_level--;
    return expr_out;
  }
}


// A = cond1 ? true_val : false_val;
t_data parse_ternary_op(void){
  char s_label[64];
  char *temp_prog;
  char *temp_asm_p;
  t_data data1, data2, expr_out;

  temp_prog = prog;
  temp_asm_p = asm_p; // save current assembly output pointer
  sprintf(s_label, "_ternary%d_cond:", highest_label_index + 1); // +1 because we are emitting the label ahead
  emitln(s_label);
  parse_logical(); // evaluate condition
  if(tok != TERNARY_OP){
    prog = temp_prog;
    asm_p = temp_asm_p; // recover asm output pointer
    return parse_logical();
  }

  // '?' was found
  highest_label_index++;
  label_stack_ter[label_tos_ter] = current_label_index_ter;
  label_tos_ter++;
  current_label_index_ter = highest_label_index;
  emitln("  cmp b, 0");
  
  sprintf(s_label, "  je _ternary%d_false", current_label_index_ter);
  emitln(s_label);

  sprintf(s_label, "_ternary%d_true:", current_label_index_ter);
  emitln(s_label);
  data1 = parse_ternary_op(); // result in 'b'
  if(tok != COLON) error(COLON_EXPECTED);
  sprintf(s_label, "  jmp _ternary%d_exit", current_label_index_ter);
  emitln(s_label);
  sprintf(s_label, "_ternary%d_false:", current_label_index_ter);
  emitln(s_label);

  data2 = parse_ternary_op(); // result in 'b'
  sprintf(s_label, "_ternary%d_exit:", current_label_index_ter);
  emitln(s_label);

  label_tos_ter--;
  current_label_index_ter = label_stack_ter[label_tos_ter];

  expr_out = cast(data1, data2);
  return expr_out;
}


t_data parse_logical(void){
  return parse_logical_or();
}


t_data parse_logical_or(void){
  char temp_tok;
  t_data data1, data2, expr_out;

  data1 = parse_logical_and();
  if(tok == LOGICAL_OR){
    while(tok == LOGICAL_OR){
      temp_tok = tok;
      emitln("  push a");
      emitln("  mov a, b");
      data2 = parse_logical_and();
      emitln("  or a, b");
      emitln("  mov b, a");
      emitln("  pop a");
    }
    expr_out.ind_level = 0; // if is a logical operation then result is an integer with ind_level = 0
    expr_out.type = DT_INT;
  }
  else{
    expr_out.type = data1.type;
    expr_out.ind_level = data1.ind_level;
  }
  return expr_out;
}


t_data parse_logical_and(void){
  char temp_tok;
  t_data data1, data2, expr_out;

  data1 = parse_bitwise_or();
  if(tok == LOGICAL_AND){
    while(tok == LOGICAL_AND){
      temp_tok = tok;
      emitln("  push al");
      //emitln("  mov a, b");
      emitln("  cmp b, 0");
      emitln("  lodflgs ; transform condition into a single bit");
      //emitln("  xor al, %00000001"); 
      data2 = parse_bitwise_or();
      emitln("  push al");
      emitln("  cmp b, 0");
      emitln("  lodflgs");
      //emitln("  xor al, %00000001");

      emitln("  pop bl ; matches previous 'push al'"); // popping into bl rather than al so we don't need an extra 'mov bl, al'
      emitln("  or al, bl"); 
      emitln("  xor al, %00000001"); // instead of ~A & ~B, doing ~(A | B) to save one opcode
      emitln("  mov bl, al"); 
      emitln("  mov bh, 0");  // bh needs to be set to 0 since the logical result still needs to be 16bit 
                              //(an if/while/do/for condition always tests whether a whole 16bit number could be 0 or 1, since conditions can be 16bit numbers as well)
      emitln("  pop al");
    }
    expr_out.ind_level = 0; // if is a logical operation then result is an integer with ind_level = 0
    expr_out.type = DT_INT;
  }
  else{
    expr_out.type = data1.type;
    expr_out.ind_level = data1.ind_level;
  }
  return expr_out;
}


t_data parse_bitwise_or(void){
  char temp_tok;
  t_data data1, data2, expr_out;

  data1 = parse_bitwise_xor();
  data2.type = DT_CHAR;
  data2.ind_level = 0; // initialize so that cast works even if 'while' below does not trigger
  while(tok == BITWISE_OR){
    temp_tok = tok;
    emitln("  push a");
    emitln("  mov a, b");
    data2 = parse_bitwise_xor();
    emitln("  or a, b");
    emitln("  mov b, a");
    emitln("  pop a");
  }
  expr_out = cast(data1, data2);
  return expr_out;
}


t_data parse_bitwise_xor(void){
  char temp_tok;
  t_data data1, data2, expr_out;

  data1 = parse_bitwise_and();
  data2.type = DT_CHAR;
  data2.ind_level = 0; // initialize so that cast works even if 'while' below does not trigger
  while(tok == BITWISE_XOR){
    temp_tok = tok;
    emitln("  push a");
    emitln("  mov a, b");
    data2 = parse_bitwise_and();
    emitln("  xor a, b");
    emitln("  mov b, a");
    emitln("  pop a");
  }
  expr_out = cast(data1, data2);
  return expr_out;
}


t_data parse_bitwise_and(void){
  char temp_tok;
  t_data data1, data2, expr_out;

  data1 = parse_relational();
  data2.type = DT_CHAR;
  data2.ind_level = 0; // initialize so that cast works even if 'while' below does not trigger
  while(tok == BITWISE_AND){
    temp_tok = tok;
    emitln("  push a");
    emitln("  mov a, b");
    data2 = parse_relational();
    emitln("  and a, b");
    emitln("  mov b, a");
    emitln("  pop a");
  }
  expr_out = cast(data1, data2);
  return expr_out;
}


t_data parse_relational(void){
  char temp_tok;
  t_data data1, data2, expr_out;

/* x = y > 1 && z<4 && y == 2 */
  data1 = parse_bitwise_shift();
  if(tok == EQUAL || tok == NOT_EQUAL || tok == LESS_THAN
  || tok == LESS_THAN_OR_EQUAL || tok == GREATER_THAN || tok == GREATER_THAN_OR_EQUAL){
    while(tok == EQUAL || tok == NOT_EQUAL || tok == LESS_THAN
    || tok == LESS_THAN_OR_EQUAL || tok == GREATER_THAN || tok == GREATER_THAN_OR_EQUAL){
      temp_tok = tok;
      emitln("  push a");
      emitln("  mov a, b");
      data2 = parse_bitwise_shift();
      expr_out = cast(data1, data2); // convert to a common type
      switch(temp_tok){
        case EQUAL:
          emitln("  cmp a, b");
          emitln("  lodflgs");
          emitln("  and al, %00000001 ; =="); // isolate ZF only. therefore if ZF==1 then A == B
          break;
        case NOT_EQUAL:
          emitln("  cmp a, b");
          emitln("  lodflgs");
          emitln("  and al, %00000001"); // isolate ZF only.
          emitln("  xor al, %00000001 ; !="); // invert the condition
          break;
        case LESS_THAN:
          if(expr_out.ind_level > 0 || expr_out.signedness == SNESS_UNSIGNED){
            emitln("  cmp a, b");
            emitln("  lodflgs");
            emitln("  and al, %00000010 ; < (unsigned)"); // isolate CF only. therefore if CF==1 then A < B
            emitln("  shr al"); // move to 0th position
          }
          else{
            emitln("  cmp a, b");
            emitln("  lodflgs");
            emitln("  mov bl, al");
            emitln("  shr al, 3"); // move OF to bit0 position
            emitln("  shr bl, 2"); // move SF to bit0 position
            emitln("  and bl, %00000001"); // mask out OF
            emitln("  xor al, bl ; < (signed)"); // OF ^ SF (less than)
          }
          break;
        case LESS_THAN_OR_EQUAL:
          if(expr_out.ind_level > 0 || expr_out.signedness == SNESS_UNSIGNED){
            emitln("  cmp a, b");
            emitln("  lodflgs");
            emitln("  and al, %00000011 ; <= (unsigned)"); // isolate both ZF and CF. therefore if CF==1 or ZF==1 then A <= B
            emitln("  cmp al, 0");
            emitln("  lodflgs");
            emitln("  xor al, %00000001");
          }
          else{
            emitln("  cmp a, b");
            emitln("  lodflgs");
            emitln("  mov bl, al");
            emitln("  mov g, a"); // save flags temporarily
            emitln("  shr al, 3"); // move OF to bit0 position
            emitln("  shr bl, 2"); // move SF to bit0 position
            emitln("  and bl, %00000001"); // mask out OF
            emitln("  xor al, bl"); // OF ^ SF (less than)
            emitln("  mov b, g");
            emitln("  and bl, %00000001"); // isolate ZF
            emitln("  or al, bl ; <= (signed)"); // OR result with ZF
          }
          break;
        case GREATER_THAN_OR_EQUAL:
          if(expr_out.ind_level > 0 || expr_out.signedness == SNESS_UNSIGNED){
            emitln("  cmp a, b");
            emitln("  lodflgs");
            emitln("  and al, %00000011"); 
            emitln("  xor al, %00000010 ; >="); 
            emitln("  cmp al, 0");
            emitln("  lodflgs");
            emitln("  xor al, %00000001");
          }
          else{
            // same as LT, but invert at the end so that ~LT = GTE
            emitln("  cmp a, b");
            emitln("  lodflgs");
            emitln("  mov bl, al");
            emitln("  shr al, 3"); // move OF to bit0 position
            emitln("  shr bl, 2"); // move SF to bit0 position
            emitln("  and bl, %00000001"); // mask out OF
            emitln("  xor al, bl"); // OF ^ SF (less than)
            emitln("  xor al, %00000001 ; >= (signed)"); // invert, hence ~LT = GTE
          }
          break;
        case GREATER_THAN:
          if(expr_out.ind_level > 0 || expr_out.signedness == SNESS_UNSIGNED){
            emitln("  cmp a, b");
            emitln("  lodflgs");
            emitln("  and al, %00000011"); 
            emitln("  cmp al, 0"); 
            emitln("  lodflgs");
          }
          else{
            // same as LTE, but invert at the end so that ~LTE = GT
            emitln("  cmp a, b");
            emitln("  lodflgs");
            emitln("  mov bl, al");
            emitln("  mov g, a"); // save flags temporarily
            emitln("  shr al, 3"); // move OF to bit0 position
            emitln("  shr bl, 2"); // move SF to bit0 position
            emitln("  and bl, %00000001"); // mask out OF
            emitln("  xor al, bl"); // OF ^ SF (less than)
            emitln("  mov b, g");
            emitln("  and bl, %00000001"); // isolate ZF
            emitln("  or al, bl"); // OR result with ZF
            emitln("  xor al, %00000001 ; > (signed)"); // invert, hence ~LTE = GT
          }
          break;
      }
      emitln("  mov ah, 0");
      emitln("  mov b, a");
      emitln("  pop a");
    }
    expr_out.type = DT_INT;
    expr_out.ind_level = 0; // if is a relational operation then result is an integer with ind_level = 0
    expr_out.signedness = SNESS_UNSIGNED;
  }
  else{
    expr_out.type = data1.type;
    expr_out.ind_level = data1.ind_level;
  }
  return expr_out;
}

t_data parse_bitwise_shift(void){
  char temp_tok;
  t_data data1, data2, expr_out;

  data1 = parse_terms();
  data2.type = DT_CHAR;
  data2.ind_level = 0; // initialize so that cast works even if 'while' below does not trigger
  while(tok == BITWISE_SHL || tok == BITWISE_SHR){
    temp_tok = tok;
    emitln("  push a");
    emitln("  mov a, b");
    data2 = parse_terms();
    emitln("  push c"); // for safety. not sure if needed yet
    emitln("  mov c, b"); // using 16bit values even though only cl is needed, because 'mov cl, bl' is not implemented as an opcode
    emitln("  mov b, a");
    if(temp_tok == BITWISE_SHL){
      if(data1.signedness == SNESS_SIGNED) emitln("  shl b, cl"); // there is no ashl, since it is equal to shl
      else emitln("  shl b, cl");
    }
    else if(temp_tok == BITWISE_SHR){
      if(data1.signedness == SNESS_SIGNED) emitln("  ashr b, cl");
      else emitln("  shr b, cl");
    }
    emitln("  pop c");
    emitln("  pop a");
  }
  expr_out = cast(data1, data2);
  return expr_out;
}


t_data parse_terms(void){
  char temp_tok;
  t_data data1, data2, expr_out;
  
  data1 = parse_factors();
  data2.type = DT_CHAR;
  data2.ind_level = 0; // initialize so that cast works even if 'while' below does not trigger
  while(tok == PLUS || tok == MINUS){
    temp_tok = tok;
    emitln("  push a");
    emitln("  mov a, b");
    data2 = parse_factors();
    if(temp_tok == PLUS) emitln("  add b, a");
    else if(temp_tok == MINUS){
      emitln("  sub a, b");
      emitln("  mov b, a");
    }
    emitln("  pop a");
  }
  expr_out = cast(data1, data2);
  return expr_out;
}


t_data parse_factors(void){
  char temp_tok;
  t_data data1, data2, expr_out;

// if data1 is an INT and data2 is a char*, then the result should be a char* still
  data1 = parse_atom();
  data2.type = DT_CHAR;
  data2.ind_level = 0; // initialize so that cast works even if 'while' below does not trigger
  while(tok == STAR || tok == FSLASH || tok == MOD){
    temp_tok = tok;
    emitln("  push a");
    emitln("  mov a, b");
    data2 = parse_atom();
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
  expr_out = cast(data1, data2);
  return expr_out;
}


t_data parse_atom(void){
  int var_id, func_id, string_id;
  char temp_name[ID_LEN], temp[1024];
  char var_address_str[32], enum_value_str[32];
  t_data expr_in, expr_out;

  get();
  if(tok_type == STRING_CONST){
    string_id = find_string(string_const);
    if(string_id == -1) string_id = add_string_data(string_const);
    // now emit the reference to this string into the ASM
    sprintf(temp, "  mov b, __string_%d ; \"%s\"", string_id, string_const);
    emitln(temp);
    expr_out.type = DT_CHAR;
    expr_out.ind_level = 1;
    expr_out.signedness = SNESS_SIGNED;
  }
  else if(tok == SIZEOF){
    get();
    expect(OPENING_PAREN, OPENING_PAREN_EXPECTED);
    get();
    if(tok_type == IDENTIFIER){
      if(local_var_exists(token) != -1){ // is a local variable
        var_id = local_var_exists(token);
        sprintf(temp, "  mov b, %d", get_total_var_size(&function_table[current_func_id].local_vars[var_id]));
        emitln(temp);
      }
      else if(global_var_exists(token) != -1){  // is a global variable
        var_id = global_var_exists(token);
        sprintf(temp, "  mov b, %d", get_total_var_size(&global_variables[var_id]));
        emitln(temp);
      }
      else error(UNDECLARED_IDENTIFIER);
    }
    else{
      switch(tok){
        case CHAR:
          emitln("  mov b, 1");
          break;
        case INT:
          emitln("  mov b, 2");
          break;
      }
    }
    get();
    expr_out.type = DT_INT;
    expr_out.ind_level = 0;
    expr_out.signedness = SNESS_SIGNED;
    expect(CLOSING_PAREN, CLOSING_PAREN_EXPECTED);
  }
  else if(tok == STAR){ // is a pointer operator
    expr_in = parse_atom(); // parse expression after STAR, which could be inside parenthesis. result in B
    emitln("  mov d, b");// now we have the pointer value. we then get the data at the address.
    if(expr_in.ind_level == 0) error(POINTER_EXPECTED);
    if(expr_in.type == DT_INT || expr_in.ind_level > 1){
      emitln("  mov b, [d]"); 
    }
    else if(expr_in.type == DT_CHAR){
      emitln("  mov bl, [d]"); 
      emitln("  mov bh, 0");
    }
    back();
    expr_out.type = expr_in.type;
    expr_out.ind_level = expr_in.ind_level - 1;
    expr_out.signedness = expr_in.signedness;
  }
  else if(tok == AMPERSAND){ // TODO: gather expr type
    get(); // get variable name
    if(tok_type != IDENTIFIER) error(IDENTIFIER_EXPECTED);
    if(local_var_exists(token) != -1){ // is a local variable
      var_id = local_var_exists(token);
      get_var_base_addr(temp, token);
      emit("  lea d, [");
      emit(temp);
      emitln("]");
      emitln("  mov b, d");
      expr_out = function_table[current_func_id].local_vars[var_id].data;
      expr_out.ind_level++;
      }
    else if(global_var_exists(token) != -1){  // is a global variable
      var_id = global_var_exists(token);
      emit("  mov b, __");
      emit(global_variables[var_id].var_name);
      if(is_matrix(&global_variables[var_id])) emitln("_data");
      expr_out = global_variables[var_id].data;
      expr_out.ind_level++;
    }
    //printf("ind_level: %d, type: %d\n", expr_out.ind_level, expr_out.type);
  }
  else if(tok_type == INTEGER_CONST){
    int i;
    emit("  mov b, ");
    emitln(token);
    i = atoi(token);
    expr_out.type = DT_INT;
    expr_out.ind_level = 0;
    expr_out.signedness = i > 32767 || i < -32768 ? SNESS_UNSIGNED : SNESS_SIGNED;
  }
  else if(tok_type == CHAR_CONST){
    sprintf(temp, "  mov b, $%x", string_const[0]);
    emitln(temp);
    expr_out.type = DT_INT; // considering it an INT as an experiment for now
    expr_out.ind_level = 0;
    expr_out.signedness = SNESS_UNSIGNED;
  }
  // -127, -128, -255, -32768, -32767, -65535
  else if(tok == MINUS){
    expr_in = parse_atom(); // TODO: add error if type is pointer since cant neg a pointer
    if(expr_in.ind_level > 0 || expr_in.type == DT_INT) emitln("  neg b");
    else emitln("  neg b"); // treating as int as experiment
    back();
    expr_out.type = DT_INT; // convert to int
    expr_out.ind_level = 0;
    expr_out.signedness = expr_in.signedness;
  }
  else if(tok == BITWISE_NOT){
    expr_in = parse_atom(); // in 'b'
    if(expr_in.ind_level > 0 || expr_in.type == DT_INT) emitln("  not b");
    else emitln("  not b"); // treating as int as an experiment
    expr_out.type = DT_INT;
    expr_out.ind_level = 0;
    expr_out.signedness = expr_in.signedness;
    back();
  }
  else if(tok == LOGICAL_NOT){
    expr_in = parse_atom(); // in 'b'
    emitln("  push al");
    emitln("  cmp b, 0");
    emitln("  lodflgs");
    emitln("  and al, %00000001 ; transform logical not condition result into a single bit"); 
    emitln("  mov bl, al");
    emitln("  mov bh, 0");
    emitln("  pop al");
    back();
    expr_out.type = DT_INT;
    expr_out.ind_level = 0;
    expr_out.signedness = SNESS_UNSIGNED;
  }
  else if(tok == OPENING_PAREN){
    get();
    if(tok == INT){
      get();
      expect(CLOSING_PAREN, CLOSING_PAREN_EXPECTED);
      expr_in = parse_expr();
      expr_out = expr_in;
      //expr_out.
      back();
    }
    else if(tok == CHAR){
      get();
      expect(CLOSING_PAREN, CLOSING_PAREN_EXPECTED);
      expr_in = parse_expr();
      expr_out = expr_in;
      back();
    }
    else{
      back();
      expr_in = parse_expr();  // parses expression between parenthesis and result will be in B
      expr_out = expr_in;
      if(tok != CLOSING_PAREN) error(CLOSING_PAREN_EXPECTED);
    }
  }
  else if(tok == INCREMENT){  // pre increment. do increment first
    get();
    if(tok_type != IDENTIFIER) error(IDENTIFIER_EXPECTED);
    strcpy(temp_name, token);
    expr_in = emit_var_into_b(temp_name); // into 'b'
    if(expr_in.ind_level > 0 || expr_in.type == DT_INT) emitln("  inc b");
    else emitln("  inc b"); // treating as int as an experiment
    emit_var_assignment(temp_name);
    expr_out = expr_in;
  }    
  else if(tok == DECREMENT){ // pre decrement. do decrement first
    get();
    if(tok_type != IDENTIFIER) error(IDENTIFIER_EXPECTED);
    strcpy(temp_name, token);
    expr_in = emit_var_into_b(temp_name); // into 'b'
    if(expr_in.ind_level > 0 || expr_in.type == DT_INT) emitln("  dec b");
    else emitln("  dec b"); // treating as int as an experiment
    emit_var_assignment(temp_name);
    expr_out = expr_in;
  }    
  else if(tok_type == IDENTIFIER){
    strcpy(temp_name, token);
    get();
    if(tok == INCREMENT){  // post increment. get value first, then do assignment
      expr_in = emit_var_into_b(temp_name); // into 'b'
      emitln("  push a"); // save 'a' since functions such as parse_terms use 'a' and we can't overwrite it here.
      emitln("  mov a, b"); // TODO: inefficient, needs changing later. emit var directly into 'a' instead by adding regsel parameter to emitter function?
      if(expr_in.ind_level > 0 || expr_in.type == DT_INT) emitln("  inc b");
      else emitln("  inc b"); // treating as int as an experiment
      emit_var_assignment(temp_name);
      emitln("  mov b, a"); // TODO: inefficient, needs changing later. emit var directly into 'a' instead by adding regsel parameter to emitter function?
      emitln("  pop a");
      expr_out = expr_in;
    }    
    else if(tok == DECREMENT){ // post decrement. get value first, then do assignment
      expr_in = emit_var_into_b(temp_name); // into 'b'
      emitln("  push a"); // save 'a' since functions such as parse_terms use 'a' and we can't overwrite it here.
      emitln("  mov a, b"); // TODO: inefficient, needs changing later. emit var directly into 'a' instead by adding regsel parameter to emitter function?
      if(expr_in.ind_level > 0 || expr_in.type == DT_INT) emitln("  dec b");
      else emitln("  dec b"); // treating as int as an experiment
      emit_var_assignment(temp_name);
      emitln("  mov b, a"); // TODO: inefficient, needs changing later. emit var directly into 'a' instead by adding regsel parameter to emitter function?
      emitln("  pop a");
      expr_out = expr_in;
    }    
    else if(tok == OPENING_PAREN){ // function call      
      func_id = find_function(temp_name);
      if(func_id != -1){
        expr_out = function_table[func_id].return_type; // get function's return type
        parse_function_arguments(func_id);
        emit("  call ");
        emitln(temp_name);
        if(tok != CLOSING_PAREN) error(CLOSING_PAREN_EXPECTED);
        // the function's return value is in register B
        if(function_table[func_id].total_parameter_size > 0){
          // clean stack of the arguments added to it
          char bp_offset_string[10];
          sprintf(bp_offset_string, "%i", function_table[func_id].total_parameter_size);
          emit("  add sp, ");
          emitln(bp_offset_string);
        }
      }
      else error(UNDECLARED_FUNC);
    }
    else if(tok == OPENING_BRACKET){ // matrix operations
      t_var *var;
      int last_dim, dims;
      var = get_var_pointer(temp_name); // gets a pointer to the variable holding the matrix address
      if(is_matrix(var)){
        dims = matrix_dim_count(var); // gets the number of dimensions for this matrix
        expr_in = emit_matrix_arithmetic(var, &last_dim); // emit matrix final address in 'd'
        if(last_dim == dims - 1){
          if(var->data.ind_level > 0 || var->data.type == DT_INT){
            emitln("  mov b, [d]"); // last dimension, so return value
          }
          else if(var->data.type == DT_CHAR){
            emitln("  mov bl, [d]");
            emitln("  mov bh, 0"); // treating as an int as an experiment
          }
        }
        else emitln("  mov b, d");
        expr_out = expr_in;
      }
      // pointer indexing
      else if(var->data.ind_level > 0){
        emitln("  push a");
        expr_in = emit_var_into_b(temp_name); // pointer variable value into 'b'
        emitln("  mov d, b");
        emitln("  push d"); // save 'd' in case the expressions inside brackets use 'd' for addressing (likely)
        parse_atom(); // parse index expression, result in B
        emitln("  pop d");
        if(tok != CLOSING_BRACKET) error(CLOSING_BRACKET_EXPECTED);
        emitln("  mov a, b");
        sprintf(temp, "  mov b, %u", get_data_size(&var->data));
        emitln(temp);
        emitln("  mul a, b");
        emitln("  add d, b");
        if(var->data.type == DT_INT || var->data.ind_level > 1){
          emitln("  mov b, [d]"); 
        }
        else if(var->data.type == DT_CHAR){
          emitln("  mov bl, [d]"); 
          emitln("  mov bh, 0");
        }
        emitln("  pop a");
        expr_out.type = expr_in.type;
        expr_out.ind_level = expr_in.ind_level - 1; // indexing reduces ind_level by 1
        expr_out.signedness = expr_in.signedness;
      }
      else error(INVALID_INDEXING);
    }
    else if(enum_element_exists(temp_name) != -1){
      back();
      sprintf(asm_line, "  mov b, %d; %s", get_enum_val(temp_name), temp_name);
      emitln(asm_line);
      expr_out.type = DT_INT;
      expr_out.ind_level = 0;
      expr_out.signedness = SNESS_SIGNED; // TODO: check enums can always be signed...
    }
    else{
      back();
      expr_in = emit_var_into_b(temp_name);
      expr_out = expr_in;
    }
  }
  else error(INVALID_EXPRESSION);

  get(); // gets the next token (it must be a delimiter)

  return expr_out;
}

t_data emit_matrix_arithmetic(t_var *matrix, int *last_dim){
  t_data expr_out;

  int i, dims, data_size; // matrix data size

  data_size = get_data_size(&matrix->data);
  dims = matrix_dim_count(matrix); // gets the number of dimensions for this matrix
  expr_out = emit_var_into_b(matrix->var_name); // emit the base address of the matrix or pointer into 'b'
  emitln("  push a"); // needed because for loop below will modify 'a'. But 'a' is used by functions such as parse_terms, so keep previous results. so we cannot overwrite 'a' here.
  emitln("  mov d, b");
  for(i = 0; i < dims; i++){
    emitln("  push d"); // save 'd' in case the expressions inside brackets use 'd' for addressing (likely)
    parse_expr(); // result in 'b'
    emitln("  pop d");
    sprintf(asm_line, "  mov a, %d", get_matrix_offset(i, matrix));
    emitln(asm_line);
    emitln("  mul a, b");
    emitln("  add d, b");
    expr_out.ind_level--;
    get();
    if(tok != OPENING_BRACKET){
      back();
      break;
    }
  }
  emitln("  pop a");
  
  *last_dim = i; // return the last dimension index found

  return expr_out;
}
/*
+---------------+---------------+---------------+
| Operand 1     | Operand 2     | Result        |
+---------------+---------------+---------------+
| signed char   | signed char   | signed int    |
| signed char   | unsigned char | signed int    |
| signed char   | signed int    | signed int    |
| signed char   | unsigned int  | unsigned int  |
| unsigned char | signed char   | signed int    |
| unsigned char | unsigned char | unsigned int  |
| unsigned char | signed int    | signed int    |
| unsigned char | unsigned int  | unsigned int  |
| signed int    | signed char   | signed int    |
| signed int    | unsigned char | signed int    |
| signed int    | signed int    | signed int    |
| signed int    | unsigned int  | unsigned int  |
| unsigned int  | signed char   | unsigned int  |
| unsigned int  | unsigned char | unsigned int  |
| unsigned int  | signed int    | unsigned int  |
| unsigned int  | unsigned int  | unsigned int  |
+---------------+---------------+---------------+
*/
t_data cast(t_data t1, t_data t2){
  t_data data;

// TODO: check for matrix type
  switch(t1.type){
    case DT_CHAR:
      switch(t2.type){
        case DT_CHAR:
          if(t1.ind_level > 0){
            data.type = DT_CHAR;
            data.ind_level = t1.ind_level;
            data.signedness = t1.signedness;
          }
          else if(t2.ind_level > 0){
            data.type = DT_CHAR;
            data.ind_level = t2.ind_level;
            data.signedness = t2.signedness;
          }
          else{
            data.type = DT_INT;
            data.ind_level = 0;
            data.signedness = SNESS_SIGNED;
          }
          break;
        case DT_INT:
          if(t1.ind_level > 0){
            data.type = DT_CHAR;
            data.ind_level = t1.ind_level;
            data.signedness = t1.signedness;
          }
          else if(t2.ind_level > 0){
            data.type = DT_INT;
            data.ind_level = t2.ind_level;
            data.signedness = t2.signedness;
          }
          else{
            data.type = DT_INT;
            data.ind_level = 0;
            data.signedness = t2.signedness; // assign whatever the int's signedness is
          }
      }
      break;
    case DT_INT:
      switch(t2.type){
        case DT_CHAR:
          if(t1.ind_level > 0){
            data.type = DT_INT;
            data.ind_level = t1.ind_level;
            data.signedness = t1.signedness; // assign whatever the int's signednss is
          }
          else if(t2.ind_level > 0){
            data.type = DT_CHAR;
            data.ind_level = t2.ind_level;
            data.signedness = t2.signedness; // assign whatever the char* signedness is
          }
          else{
            data.type = DT_INT;
            data.ind_level = 0;
            data.signedness = t1.signedness; // assign whatever the int's signedness is
          }
          break;
        case DT_INT:
          if(t1.ind_level > 0){
            data.type = DT_INT;
            data.ind_level = t1.ind_level;
            data.signedness = t1.signedness;
          }
          else if(t2.ind_level > 0){
            data.type = DT_INT;
            data.ind_level = t2.ind_level;
            data.signedness = t2.signedness;
          }
          else{
            data.type = DT_INT;
            data.ind_level = 0;
            if(t1.signedness == SNESS_UNSIGNED || t2.signedness == SNESS_UNSIGNED)
              data.signedness = SNESS_UNSIGNED;
            else
              data.signedness = SNESS_SIGNED;
          }
      }
  }
  return data;
}


unsigned int add_string_data(char *str){
  int i;
  char temp[256];

  for(i = 0; i < STRING_TABLE_SIZE; i++){
    if(!string_table[i][0]){
      strcpy(string_table[i], str);
      return i;
    }
  }

  error(MAX_STRINGS);
}


void emit_string_table_data(void){
  int i;
  char temp[256];

  for(i = 0; string_table[i][0]; i++){
      // emit the declaration of this string, into the data block
      sprintf(temp, "__string_%d", i);
      emit_data(temp);
      emit_data(": .db \"");
      emit_data(string_table[i]);
      emit_data("\", 0\n");
    }
}


int find_string(char *str){
  int i;

  for(i = 0; i < STRING_TABLE_SIZE; i++){
    if(!strcmp(string_table[i], str)){
      return i;
    }
  }
  return -1;
}


t_var_scope get_var_scope(char *var_name){
  int var_id;

  if(local_var_exists(var_name) != -1){ // is a local variable
    return LOCAL;
  }
  else if(global_var_exists(var_name) != -1){  // is a global variable
    return GLOBAL;
  }

  return -1;
}


void get_var_base_addr(char *dest, char *var_name){
  int var_id;

  if(local_var_exists(var_name) != -1){ // is a local variable
    var_id = local_var_exists(var_name);
    if(function_table[current_func_id].local_vars[var_id].data.ind_level > 0
    || function_table[current_func_id].local_vars[var_id].data.type == DT_INT){
      sprintf(dest, "bp + %d", function_table[current_func_id].local_vars[var_id].bp_offset);
    }
    else if(function_table[current_func_id].local_vars[var_id].data.type == DT_CHAR){
      sprintf(dest, "bp + %d", function_table[current_func_id].local_vars[var_id].bp_offset);
    }
  }
  else if(global_var_exists(var_name) != -1){  // is a global variable
    strcpy(dest, var_name);
  }
  else error(UNDECLARED_IDENTIFIER);
}


t_var *get_var_by_name(char *var_name){
  int var_id;

  if(local_var_exists(var_name) != -1){ // is a local variable
    var_id = local_var_exists(var_name);
    return &function_table[current_func_id].local_vars[var_id];
  }
  else if(global_var_exists(var_name) != -1){  // is a global variable
    var_id = global_var_exists(var_name);
    return &global_variables[var_id];
  }
}


t_data emit_var_into_b(char *var_name){
  int var_id;
  char temp[64];
  t_data expr_out;

  if(local_var_exists(var_name) != -1){ // is a local variable
    var_id = local_var_exists(var_name);
    // both matrix and parameter means this is a parameter local variable to a function
    // that is really a pointer variable and not really a matrix.
    if(is_matrix(&function_table[current_func_id].local_vars[var_id])
    && function_table[current_func_id].local_vars[var_id].is_parameter){
      emit("  lea d, [");
      get_var_base_addr(temp, var_name);
      emit(temp);
      emit("] ; ");
      emitln(var_name);
      emitln("  mov b, [d]");
      expr_out.type = function_table[current_func_id].local_vars[var_id].data.type;
      expr_out.ind_level = function_table[current_func_id].local_vars[var_id].data.ind_level + 1; // +1 because a matrix reference is a pointer even though it can have ind_level = 0
      expr_out.signedness = function_table[current_func_id].local_vars[var_id].data.signedness; 
    }
    else if(is_matrix(&function_table[current_func_id].local_vars[var_id])){
      emit("  lea d, [");
      get_var_base_addr(temp, var_name);
      emit(temp);
      emit("] ; ");
      emit(var_name);
      emitln(" beginning on the stack");
      emitln("  mov b, d");
      expr_out.type = function_table[current_func_id].local_vars[var_id].data.type;
      expr_out.ind_level = function_table[current_func_id].local_vars[var_id].data.ind_level + 1; // +1 because a matrix reference is a pointer even though it can have ind_level = 0
      expr_out.signedness = function_table[current_func_id].local_vars[var_id].data.signedness; 
    }
    else if(function_table[current_func_id].local_vars[var_id].data.ind_level > 0){
      emit("  lea d, [");
      get_var_base_addr(temp, var_name);
      emit(temp);
      emit("] ; ");
      emitln(var_name);
      emitln("  mov b, [d]");
      expr_out.type = function_table[current_func_id].local_vars[var_id].data.type;
      expr_out.ind_level = function_table[current_func_id].local_vars[var_id].data.ind_level;
      expr_out.signedness = function_table[current_func_id].local_vars[var_id].data.signedness; 
    }
    else if(function_table[current_func_id].local_vars[var_id].data.type == DT_INT){
      emit("  mov b, [");
      get_var_base_addr(temp, var_name);
      emit(temp);
      emit("] ; ");
      emitln(var_name);
      expr_out.type = DT_INT;
      expr_out.ind_level = 0;
      expr_out.signedness = function_table[current_func_id].local_vars[var_id].data.signedness; 
    }
    else if(function_table[current_func_id].local_vars[var_id].data.type == DT_CHAR){
      emit("  mov bl, [");
      get_var_base_addr(temp, var_name);
      emit(temp);
      emit("] ; ");
      emitln(var_name);
      emitln("  mov bh, 0");
      expr_out.type = DT_CHAR;
      expr_out.ind_level = 0;
      expr_out.signedness = function_table[current_func_id].local_vars[var_id].data.signedness; 
    }
  }
  else if(global_var_exists(var_name) != -1){  // is a global variable
    var_id = global_var_exists(var_name);
    if(is_matrix(&global_variables[var_id])){
      emit("  mov b, [__");
      emit(global_variables[var_id].var_name);
      emit("] ; ");
      emitln(var_name);
      expr_out.type = global_variables[var_id].data.type;
      expr_out.ind_level = global_variables[var_id].data.ind_level + 1;
      expr_out.signedness = global_variables[var_id].data.signedness;
    }
    else if(global_variables[var_id].data.ind_level > 0){
      emit("  mov b, [__");
      emit(global_variables[var_id].var_name);
      emit("] ; ");
      emitln(var_name);
      expr_out.type = global_variables[var_id].data.type;
      expr_out.ind_level = global_variables[var_id].data.ind_level;
      expr_out.signedness = global_variables[var_id].data.signedness;
    }
    else if(global_variables[var_id].data.type == DT_INT){
      emit("  mov b, [__");
      emit(global_variables[var_id].var_name);
      emit("] ; ");
      emitln(var_name);
      expr_out.type = global_variables[var_id].data.type;
      expr_out.ind_level = global_variables[var_id].data.ind_level;
      expr_out.signedness = global_variables[var_id].data.signedness;
    }
    else if(global_variables[var_id].data.type == DT_CHAR){
      emit("  mov bl, [__");
      emit(global_variables[var_id].var_name);
      emit("] ; ");
      emitln(var_name);
      emitln("  mov bh, 0");
      expr_out.type = global_variables[var_id].data.type;
      expr_out.ind_level = global_variables[var_id].data.ind_level;
      expr_out.signedness = global_variables[var_id].data.signedness;
    }
  }
  else error(UNDECLARED_IDENTIFIER);

  return expr_out;
}


t_var *get_var_pointer(char *var_name){
  register int i;

  for(i = 0; i < function_table[current_func_id].local_var_tos; i++)
    if(!strcmp(function_table[current_func_id].local_vars[i].var_name, var_name))
      return &function_table[current_func_id].local_vars[i];

  for(i = 0; i < global_var_tos; i++)
    if(!strcmp(global_variables[i].var_name, var_name)) 
      return &global_variables[i];

  error(UNDECLARED_VARIABLE);
}


int get_matrix_offset(char dim, t_var *matrix){
  int i;
  int offset = 1;
  
  if(dim == matrix_dim_count(matrix) - 1) return get_data_size(&matrix->data);

  for(i = dim + 1; i < matrix_dim_count(matrix); i++)
    offset = offset * matrix -> dims[i];
  
  return offset * get_data_size(&matrix->data);
}


int get_total_var_size(t_var *var){
  int i;
  int size = 1;

  // if it is a matrix, return its number of dimensions * type size
  for(i = 0; i < matrix_dim_count(var); i++)
    size = size * var->dims[i];
  
  // if it is not a mtrix, it will return 1 * the data size
  return size * get_data_size(&var->data);
}


int is_matrix(t_var *var){
  if(var->dims[0]) return 1;
  else return 0;

}


int matrix_dim_count(t_var *var){
  int i;
  
  for(i = 0; var->dims[i]; i++);
  
  return i;
}


int get_data_size(t_data *data){
  if(data->ind_level > 0) return 2;
  else
    switch(data->type){
      case DT_CHAR:
        return 1;
      case DT_INT:
        return 2;
    }
}


void parse_function_arguments(int func_id){
  int param_index = 0;

  get();
  if(tok == CLOSING_PAREN) return;
  back();
  do{
    parse_expr();
    if(function_table[func_id].local_vars[param_index].data.ind_level > 0
    || is_matrix(&function_table[func_id].local_vars[param_index])){
      emitln("  swp b");
      emitln("  push b");
    }
    else
      switch(function_table[func_id].local_vars[param_index].data.type){
        case DT_CHAR:
          emitln("  push bl");
          break;
        case DT_INT:
          emitln("  swp b");
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


// enum my_enum {item1, item2, item3};
void declare_enum(void){
  int element_tos;
  int value;

  if(enum_table_tos == MAX_ENUM_DECLARATIONS) error(EXCEEDED_MAX_ENUM_DECL);

  get(); // get enum name
  strcpy(enum_table[enum_table_tos].name, token);
  get(); // '{'
  if(tok != OPENING_BRACE) error(OPENING_BRACE_EXPECTED);
  element_tos = 0;
  value = 0;

  do{
    get();
    if(tok_type != IDENTIFIER) error(IDENTIFIER_EXPECTED);
    strcpy(enum_table[enum_table_tos].elements[element_tos].element_name, token);
    enum_table[enum_table_tos].elements[element_tos].value = value;
    value++;
    element_tos++;  
    get();
  } while(tok == COMMA);
  
  enum_table_tos++;

  if(tok != CLOSING_BRACE) error(CLOSING_BRACE_EXPECTED);
  get();
  if(tok != SEMICOLON) error(SEMICOLON_EXPECTED);
}


int enum_element_exists(char *element_name){
  int i, j;
  
  for(i = 0; i < enum_table_tos; i++){
    for(j = 0; *enum_table[i].elements[j].element_name; j++){
      if(!strcmp(enum_table[i].elements[j].element_name, element_name))
        return 1;
    }
  }
  return -1;
}


int get_enum_val(char *element_name){
  int i, j;
  
  for(i = 0; i < enum_table_tos; i++){
    for(j = 0; *enum_table[i].elements[j].element_name; j++){
      if(!strcmp(enum_table[i].elements[j].element_name, element_name))
        return enum_table[i].elements[j].value;
    }
  }

  return -1;
}

void declare_global(void){
  t_data data;
  int ind_level;
  char constant = 0;
  char temp[512 + 8];

  get(); 
  if(tok == CONST){
    constant = 1;
    get();
  }

  data.signedness = SNESS_SIGNED; // set as signed by default
  while(tok == SIGNED || tok == UNSIGNED || tok == LONG){
    if(tok == SIGNED) data.signedness = SNESS_SIGNED;
    else if(tok == UNSIGNED) data.signedness = SNESS_UNSIGNED;
    else if(tok == LONG) data.longness = LNESS_LONG;
    get();
  }
  
  data.type = get_data_type_from_tok(tok);

  do{
    if(global_var_tos == MAX_GLOBAL_VARS) error(EXCEEDED_GLOBAL_VAR_LIMIT);

    global_variables[global_var_tos].constant = constant;
    
    get();
// **************** checks whether this is a pointer declaration *******************************
    ind_level = 0;
    while(tok == STAR){
      ind_level++;
      get();
    }
// *********************************************************************************************
    if(tok_type != IDENTIFIER) error(IDENTIFIER_EXPECTED);
    if(data.type == DT_VOID && ind_level == 0) error(INVALID_TYPE_IN_VARIABLE);

    // checks if there is another global variable with the same name
    if(find_global_var(token) != -1) error(DUPLICATE_GLOBAL_VARIABLE);
    
    global_variables[global_var_tos].data.type = data.type;
    global_variables[global_var_tos].data.ind_level = ind_level;
    strcpy(global_variables[global_var_tos].var_name, token);

    get();
    // checks if this is a matrix declaration
    int dim = 0;
    int expr;
    if(tok == OPENING_BRACKET){
      while(tok == OPENING_BRACKET){
        get();
        expr = atoi(token);
        get();
        if(tok != CLOSING_BRACKET) error(CLOSING_BRACKET_EXPECTED);
        global_variables[global_var_tos].dims[dim] = expr;
        get();
        dim++;
      }
      global_variables[global_var_tos].dims[dim] = 0; // sets the last variable dimention to 0, to mark the end of the list
    }

    // _data section for var is emmitted if:
    // ind_level == 1 && data.type_char
    // var is a matrix (dims > 0)
    // checks for variable initialization
    if(tok == ASSIGNMENT){
      int j;
      if(is_matrix(&global_variables[global_var_tos])){
        get();
        expect(OPENING_BRACE, OPENING_BRACE_EXPECTED);
        sprintf(temp, "__%s_data: \n", global_variables[global_var_tos].var_name);
        emit_data(temp);
        emit_data_dbdw(ind_level, dim, data.type);
        j = 0;
        do{
          get();
          if(tok_type == CHAR_CONST){
            sprintf(temp, "$%x,", string_const[0]);
            emit_data(temp);
          }
          else if(tok_type == INTEGER_CONST){
            sprintf(temp, "%u,", (char)atoi(token));
            emit_data(temp);
          }
          else if(tok_type == STRING_CONST){
            int string_id;
            string_id = add_string_data(string_const);
            sprintf(temp, "__string_%u, ", string_id);
            emit_data(temp);
          }
          else error(UNKNOWN_DATA_TYPE);
          j++;
          get();
          if(j % 30 == 0){ // split into multiple lines due to TASM limitation of how many items per .dw directive
            emit_data("\n");
            emit_data_dbdw(ind_level, dim, data.type);
          }
        } while(tok == COMMA);
        // fill in the remaining unitialized array values with 0's 
        sprintf(temp, "\n.fill %u, 0\n", get_total_var_size(&global_variables[global_var_tos]) - j * get_data_size(&global_variables[global_var_tos].data));
        emit_data(temp);
        sprintf(temp, "__%s: .dw __%s_data\n", global_variables[global_var_tos].var_name, global_variables[global_var_tos].var_name);
        emit_data(temp);
        expect(CLOSING_BRACE, CLOSING_BRACE_EXPECTED);
      }
      else{
        get();
        switch(data.type){
          case DT_VOID:
            sprintf(temp, "__%s: ", global_variables[global_var_tos].var_name);
            emit_data(temp);
            emit_data_dbdw(ind_level, dim, data.type);
            sprintf(temp, "%u, ", atoi(token));
            emit_data(temp);
            break;
          case DT_CHAR:
            if(ind_level > 0){ // if is a string
              if(tok_type != STRING_CONST) error(STRING_CONSTANT_EXPECTED);
              sprintf(temp, "__%s_data: ", global_variables[global_var_tos].var_name);
              emit_data(temp);
              emit_data_dbdw(ind_level, dim, data.type);
              sprintf(temp, "%s, 0\n", token); // TODO: do not require char pointer initialization to be a string only!
              emit_data(temp);
              sprintf(temp, "__%s: .dw __%s_data\n", global_variables[global_var_tos].var_name, global_variables[global_var_tos].var_name);
              emit_data(temp);
            }
            else{
              sprintf(temp, "__%s: ", global_variables[global_var_tos].var_name);
              emit_data(temp);
              emit_data_dbdw(ind_level, dim, data.type);
              if(tok_type == CHAR_CONST){
                sprintf(temp, "$%x\n", string_const[0]);
                emit_data(temp);
              }
              else if(tok_type == INTEGER_CONST){
                sprintf(temp, "%u\n", (char)atoi(token));
                emit_data(temp);
              }
            }
            break;
          case DT_INT:
            sprintf(temp, "__%s: ", global_variables[global_var_tos].var_name);
            emit_data(temp);
            emit_data_dbdw(ind_level, dim, data.type);
            if(ind_level > 0){
                sprintf(temp, "%u\n", atoi(token));
                emit_data(temp);
            }
            else{
              sprintf(temp, "%u\n", atoi(token));
              emit_data(temp);
            }
            break;
        }
      }
      get();
    }
    else{ // no assignment!
      if(dim > 0){
        sprintf(temp, "__%s_data: .fill %u, 0\n", global_variables[global_var_tos].var_name, get_total_var_size(&global_variables[global_var_tos]));
        emit_data(temp);
        sprintf(temp, "__%s: .dw __%s_data\n", global_variables[global_var_tos].var_name, global_variables[global_var_tos].var_name);
        emit_data(temp);
      }
      else{
        sprintf(temp, "__%s: .fill %u, 0\n", global_variables[global_var_tos].var_name, get_total_var_size(&global_variables[global_var_tos]));
        emit_data(temp);
      }
    }
    global_var_tos++;  
  } while(tok == COMMA);

  if(tok != SEMICOLON) error(SEMICOLON_EXPECTED);
}

void emit_data_dbdw(int ind_level, int dims, t_data_type dt){
  if(ind_level >  0 && dt == DT_CHAR && dims == 0
  || ind_level == 0 && dt == DT_CHAR){ 
    emit_data(".db ");
  }
  else{
    emit_data(".dw ");
  }
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


t_data_type get_data_type_from_tok(t_token t){
  switch(t){
    case VOID:
      return DT_VOID;
    case CHAR:
      return DT_CHAR;
    case INT:
      return DT_INT;
    case FLOAT:
      return DT_FLOAT;
    case DOUBLE:
      return DT_DOUBLE;
  }
}

void declare_local(void){                        
  t_var new_var;
  char *temp_prog;
  char temp[64];
  
  temp_prog = prog;
  get(); // gets past the data type
  if(tok == CONST){
    new_var.constant = 1;
    get();
  }
  else new_var.constant = 0;

  new_var.data.signedness = SNESS_SIGNED; // set as signed by default
  while(tok == SIGNED || tok == UNSIGNED || tok == LONG){
    if(tok == SIGNED) new_var.data.signedness = SNESS_SIGNED;
    else if(tok == UNSIGNED) new_var.data.signedness = SNESS_UNSIGNED;
    else if(tok == LONG) new_var.data.longness = LNESS_LONG;
    get();
  }
  new_var.data.type = get_data_type_from_tok(tok);
  do{
    if(function_table[current_func_id].local_var_tos == MAX_LOCAL_VARS) error(LOCAL_VAR_LIMIT_REACHED);
    new_var.is_parameter = 0;
    new_var.function_id = current_func_id; // set variable owner function
// **************** checks whether this is a pointer declaration *******************************
    new_var.data.ind_level = 0;
    get();
    while(tok == STAR){
      new_var.data.ind_level++;
      get();
    }    
// *********************************************************************************************
    if(tok_type != IDENTIFIER) error(IDENTIFIER_EXPECTED);
    if(local_var_exists(token) != -1) error(DUPLICATE_LOCAL_VARIABLE);
    strcpy(new_var.var_name, token);
    get();

    // checks if this is a matrix declaration
    int i = 0;
    new_var.dims[0] = 0; // in case its not a matrix, this signals that fact
    if(tok == OPENING_BRACKET){
      while(tok == OPENING_BRACKET){
        get();
        new_var.dims[i] = atoi(token);
        get();
        if(tok != CLOSING_BRACKET) error(CLOSING_BRACKET_EXPECTED);
        get();
        i++;
      }
      new_var.dims[i] = 0; // sets the last variable dimention to 0, to mark the end of the list
    }
    // this is used to position local variables correctly relative to BP.
    // whenever a new function is parsed, this is reset to 0.
    // then inside the function it can increase according to how many local vars there are.
    current_function_var_bp_offset -= get_total_var_size(&new_var);
    new_var.bp_offset = current_function_var_bp_offset + 1;

    if(tok == ASSIGNMENT){
      char isneg = 0;
      if(new_var.dims[0] > 0) error(LOCAL_MATRIX_ASSIGNMENT);
      get();
      if(tok == MINUS){
        isneg = 1;
        get();
      }
      // TODO: temporary solutuon due to error in push word, @ instruction
      if(tok_type != CHAR_CONST && tok_type != INTEGER_CONST) error(LOCALVAR_INITIALIZATION_TO_NONCONSTANT);
      if(new_var.data.type == DT_CHAR){
        if(tok_type == DT_CHAR)
          sprintf(temp, "  push byte $%x", string_const[0]);
        else
          sprintf(temp, "  push byte $%x", (unsigned char)(isneg ? -atoi(token) : atoi(token)));
        emitln(temp);
      }
      else if(new_var.data.type == DT_INT || new_var.data.ind_level > 0){
        if(tok_type == DT_CHAR){
          sprintf(temp, "  push byte $%x", string_const[0]);
          emitln(temp);
          emitln("  push byte 0");
        }
        else{
          sprintf(temp, "  push byte $%x", 0xFF & (isneg ? -atoi(token) : atoi(token)));
          emitln(temp);
          sprintf(temp, "  push byte $%x", (0xFF00 & (isneg ? -atoi(token) : atoi(token))) >> 8);
          emitln(temp);
        }
      }
      get(); // get ';'
    }
    else{
      sprintf(asm_line, "  sub sp, %d ; %s", get_total_var_size(&new_var), new_var.var_name);
      emitln(asm_line);
    }
    // assigns the new variable to the local stack
    function_table[current_func_id].local_vars[function_table[current_func_id].local_var_tos] = new_var;    
    function_table[current_func_id].local_var_tos++;
  } while(tok == COMMA);

  if(tok != SEMICOLON) error(SEMICOLON_EXPECTED);
} // declare_local


t_var *get_var(char *var_name){
  register int i;

  //check local variables whose function id is the id of current function being parsed
  for(i = 0; i < function_table[current_func_id].local_var_tos; i++)
    if(!strcmp(function_table[current_func_id].local_vars[i].var_name, var_name))
      return &function_table[current_func_id].local_vars[i];

  for(i = 0; (i < global_var_tos) && (*global_variables[i].var_name); i++)
    if(!strcmp(global_variables[i].var_name, var_name)) return &global_variables[i];
  
  return NULL;
}


void expect(t_token _tok, t_errorCode errorCode){
  if(tok != _tok) error(errorCode);
}


void error(t_errorCode e){
  int line = 1;
  char *t = c_in;

  printf("\nERROR: %s\n", error_table[e]);
  
  while(t < prog){
    t++;
    if(*t == '\n') line++;
  }
  
  printf("LINE NUMBER: %d\n", line);
  printf("NEAR: %s\n\n", token);

  exit(0);
}


// converts a literal string or char constant into constants with true escape sequences
void convert_constant(){
  char *s = string_const;
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
  tok_type = 0;
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
  else if(is_identifier_char(*prog)){
    while(is_identifier_char(*prog) || isdigit(*prog))
      *t++ = *prog++;
    *t = '\0';

    if((tok = find_keyword(token)) != -1) tok_type = RESERVED;
    else tok_type = IDENTIFIER;
  }
  else if(is_delimiter(*prog)){
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
    else if(*prog == '['){
      *t++ = *prog++;
      tok = OPENING_BRACKET;
    }
    else if(*prog == ']'){
      *t++ = *prog++;
      tok = CLOSING_BRACKET;
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
      else if (*prog == '<'){
        *t++ = *prog++;
        tok = BITWISE_SHL;
      }
      else tok = LESS_THAN;
    }
    else if(*prog == '>'){
      *t++ = *prog++;
      if (*prog == '='){
        *t++ = *prog++;
        tok = GREATER_THAN_OR_EQUAL;
      }
      else if (*prog == '>'){
        *t++ = *prog++;
        tok = BITWISE_SHR;
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
    else if(*prog == '?'){
      *t++ = *prog++;
      tok = TERNARY_OP;
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
    else if(*prog == '$'){
      *t++ = *prog++;
      tok = DOLLAR;
    }
    else if(*prog == '^'){
      *t++ = *prog++;
      tok = BITWISE_XOR;
    }
    else if(*prog == '@'){
      *t++ = *prog++;
      tok = AT;
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
    else if(*prog == ':'){
      *t++ = *prog++;
      tok = COLON;
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

void back(void){
  char *t = token;

  while(*t++) prog--;
}


void get_line(void){
  char *t;

  t = string_const;
  
  while(*prog != '\n' && *prog != '\0') *t++ = *prog++;
  *t++ = *prog++;
  *t = '\0';
}


int find_keyword(char *keyword){
  register int i;
  
  for(i = 0; keyword_table[i].key; i++)
    if (!strcmp(keyword_table[i].keyword, keyword)) return keyword_table[i].key;
  
  return -1;
}


char is_delimiter(char c){
  if(strchr("?@$#+-*/%[](){}:;,<>=!^&|~.", c)) return 1;
  else return 0;
}


char is_identifier_char(char c){
  return(isalpha(c) || c == '_');
}

