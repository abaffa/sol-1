#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include "def.h"

int main(int argc, char *argv[]){
  char header[256];

  if(argc > 1) load_program(argv[1]);  
  else{
    printf("Usage: cc [filename]\n");
    return 0;
  }

  asm_p = asm_out;  // set ASM outback pointer to the ASM array beginning
  data_block_p = data_block_ASM; // data block pointer

  pre_processor();
  pre_scan();
  sprintf(header, "; --- FILENAME: %s", argv[1]);
  emitln(header);
  emitln(".include \"lib/kernel.exp\"");

  emitln(".org PROC_TEXT_ORG");

  emitln("\n; --- BEGIN TEXT BLOCK");
  parse_functions();
  emitln("; --- END TEXT BLOCK");
  
  emitln("\n; --- BEGIN DATA BLOCK");
  emit(data_block_ASM);
  emitln("; --- END DATA BLOCK");
  emit("\n; --- BEGIN INCLUDE BLOCK");
  emitln(includes_list_ASM);
  emitln("; --- END INCLUDE BLOCK\n");

  emitln("\n.end");

  *asm_p = '\0';
  generate_file("a.s"); // generate a.s assembly file

  return 0;
}

void emit_data(char *data){
  char *p = data;

  while(*p){
    *data_block_p++ = *p++;
  }
}

// ################################################################################################
// ################################################################################################
// ################################################################################################

void generate_file(char *filename){
  FILE *fp;
  int i;
  
  if((fp = fopen(filename, "wb")) == NULL){
    exit(0);
  }
  
  fprintf(fp, "%s", asm_out);

  fclose(fp);
}

// ################################################################################################
// ################################################################################################
// ################################################################################################

void emitln(char *p){
  while(*p) *asm_p++ = *p++;
  *asm_p++ = '\n';
}

void emit(char *p){
  while(*p) *asm_p++ = *p++;
}

// ################################################################################################
// ################################################################################################
// ################################################################################################

void load_program(char *filename){
  FILE *fp;
  int i;
  
  if((fp = fopen(filename, "rb")) == NULL){
    printf("program source file not found");
    exit(0);
  }
  
  prog = c_in;
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

// ################################################################################################
// ################################################################################################
// ################################################################################################

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

// ################################################################################################
// ################################################################################################
// ################################################################################################

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
      emit(function_table[i].func_name);
      emitln(":");
      emitln("  push bp");
      emitln("  mov bp, sp");
      parse_block(); // starts parsing the function block;
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
      emit(function_table[i].func_name);
      emitln(":");
      emitln("  push bp");
      emitln("  mov bp, sp");
      parse_block(); // starts parsing the function block;
    }
}

// ################################################################################################
// ################################################################################################
// ################################################################################################

void include_lib(char *lib_name){
  strcat(includes_list_ASM, "\n.include ");
  strcat(includes_list_ASM, lib_name); // concatenate library name into a small text session that
  // in the end we add this to the final ASM text  
}

// ################################################################################################
// ################################################################################################
// ################################################################################################

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
      if(tok == DEFINE){
        declare_define();
        continue;
      }
      else{
        prog = tp;
      }
    }

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
  
  prog = c_preproc_out;
  do{
    tp = prog;
    get();
    if(tok_type == END) return;

    if(tok == DIRECTIVE){
      get();
      if(tok == INCLUDE){
        get();
        if(tok_type != STRING_CONST) error(DIRECTIVE_SYNTAX);
        include_lib(token);
        continue;
      }
      else if(tok == DEFINE){
        get();
        get();
        continue;
      }
      else error(UNKNOWN_DIRECTIVE);
    }
    else if(tok == ENUM){
      declare_enum();
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
      skip_block();
    }
    else { //it must be variable declarations
      prog = tp;
      declare_global();
    }
  } while(tok_type != END);
  
}

// ################################################################################################
// ################################################################################################
// ################################################################################################

void declare_func(void){
  t_user_func *func; // variable to hold a pointer to the user function top of stack
  t_basic_data param_data_type; // function data type
  int bp_offset; // for each parameter, keep the running offset of that parameter.
  char *temp_prog, *temp_prog2;
  int total_parameter_bytes;
  char param_name[ID_LEN];

  if(function_table_tos == MAX_USER_FUNC - 1) error(EXCEEDED_FUNC_DECL_LIMIT);

  func = &function_table[function_table_tos];

  get();
  func->return_type = get_data_type_from_tok(tok);
  get(); // gets the function name
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
      if(tok == STAR){
        while(tok == STAR){
          func->local_vars[func->local_var_tos].data.ind_level++;
          get();
        }
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

// ################################################################################################
// ################################################################################################
// ################################################################################################

int find_parameter_size(void){
  int total_bytes;
  int data_size;

  total_bytes = 0;
  get();
  switch(tok){
    case CHAR:
      data_size += 1;
      break;
    case INT:
      data_size += 2;
      break;
    case FLOAT:
      data_size += 2;
      break;
    case DOUBLE:
      data_size += 4;
  }
  get(); // get past parameter name
  get();
  while(tok == OPENING_BRACKET){
    get();
    total_bytes += data_size * atoi(token);
    get(); // ']'
    get();
  }

  return total_bytes;
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

// ################################################################################################
// ################################################################################################

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

// ################################################################################################
// ################################################################################################

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
    emit("[");
    emit(var_name);
    emit("]");
  }
  else error(UNDECLARED_VARIABLE);
}

// ################################################################################################
// ################################################################################################
// ################################################################################################

void parse_break(void){
  if(current_break_type == FOR_BREAK) parse_for_break();
  else if(current_break_type == WHILE_BREAK) parse_while_break();
  else if(current_break_type == DO_BREAK) parse_do_break();
  else if(current_break_type == SWITCH_BREAK) parse_switch_break();
  get();
}

void parse_switch_break(void){
  char s_label[64];
  
  sprintf(s_label, "  jmp _switch%d_exit", current_label_index);
  emitln(s_label);
}

void parse_while_break(void){
  char s_label[64];
  
  sprintf(s_label, "  jmp _while%d_exit", current_label_index);
  emitln(s_label);
}

void parse_do_break(void){
  char s_label[64];
  
  sprintf(s_label, "  jmp _do%d_exit", current_label_index);
  emitln(s_label);
}

void parse_for_break(void){
  char s_label[64];
  
  sprintf(s_label, "  jmp _for%d_exit", current_label_index);
  emitln(s_label);
}

// ################################################################################################
// ################################################################################################
// ################################################################################################

void parse_for(void){
  char s_label[64];
  char *update_loc;
  
  current_break_type = FOR_BREAK;
  highest_label_index++;
  label_stack[label_tos] = current_label_index;
  label_tos++;
  current_label_index = highest_label_index;

  sprintf(s_label, "_for%d_init:", current_label_index);
  emitln(s_label);
  get();
  if(tok != OPENING_PAREN) error(OPENING_PAREN_EXPECTED);
  get();
  if(tok != SEMICOLON){
    back();
    parse_expr();
  }
  if(tok != SEMICOLON) error(SEMICOLON_EXPECTED);

  sprintf(s_label, "_for%d_cond:", current_label_index);
  emitln(s_label);
  
  // checks for an empty condition, which means always true
  get();
  if(tok != SEMICOLON){
    back();
    parse_expr();
    if(tok != SEMICOLON) error(SEMICOLON_EXPECTED);
  }
  else{
    emitln("  mov b, 1"); // emit a TRUE condition
  }

  emitln("  cmp b, 0");
  sprintf(s_label, "  je _for%d_exit", current_label_index);
  emitln(s_label);
  sprintf(s_label, "_for%d_block:", current_label_index);
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
  
  sprintf(s_label, "_for%d_update:", current_label_index);
  emitln(s_label);
  
  prog = update_loc;
  // checks for an empty update expression
  get();
  if(tok != CLOSING_PAREN){
    back();
    parse_expr();
  }
    
  sprintf(s_label, "  jmp _for%d_cond", current_label_index);
  emitln(s_label);

  skip_statements();

  sprintf(s_label, "_for%d_exit:", current_label_index);
  emitln(s_label);

  label_tos--;
  current_label_index = label_stack[label_tos];
}

// ################################################################################################
// ################################################################################################
// ################################################################################################

void parse_while(void){
  char s_label[64];

  current_break_type = WHILE_BREAK;
  highest_label_index++;
  label_stack[label_tos] = current_label_index;
  label_tos++;
  current_label_index = highest_label_index;

  sprintf(s_label, "_while%d_cond:", current_label_index);
  emitln(s_label);
  get();
  if(tok != OPENING_PAREN) error(OPENING_PAREN_EXPECTED);
  parse_expr(); // evaluate condition
  if(tok != CLOSING_PAREN) error(CLOSING_PAREN_EXPECTED);
  emitln("  cmp b, 0");
  sprintf(s_label, "  je _while%d_exit", current_label_index);
  emitln(s_label);
  sprintf(s_label, "_while%d_block:", current_label_index);
  emitln(s_label);
  parse_block();  // parse while block
  sprintf(s_label, "  jmp _while%d_cond", current_label_index);
  emitln(s_label);
  sprintf(s_label, "_while%d_exit:", current_label_index);
  emitln(s_label);

  label_tos--;
  current_label_index = label_stack[label_tos];
}

// ################################################################################################
// ################################################################################################
// ################################################################################################

void parse_do(void){
  char s_label[64];

  current_break_type = DO_BREAK;
  highest_label_index++;
  label_stack[label_tos] = current_label_index;
  label_tos++;
  current_label_index = highest_label_index;

  sprintf(s_label, "_do%d_block:", current_label_index);
  emitln(s_label);
  parse_block();  // parse block

  sprintf(s_label, "_do%d_cond:", current_label_index);
  emitln(s_label);
  get(); // get 'while'
  get();
  if(tok != OPENING_PAREN) error(OPENING_PAREN_EXPECTED);
  parse_expr(); // evaluate condition
  if(tok != CLOSING_PAREN) error(CLOSING_PAREN_EXPECTED);
  emitln("  cmp b, 1");
  sprintf(s_label, "  je _do%d_block", current_label_index);
  emitln(s_label);

  sprintf(s_label, "_do%d_exit:", current_label_index);
  emitln(s_label);

  label_tos--;
  current_label_index = label_stack[label_tos];
  get();
  if(tok != SEMICOLON) error(SEMICOLON_EXPECTED);
}

// ################################################################################################
// ################################################################################################
// ################################################################################################

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

// ################################################################################################
// ################################################################################################
// ################################################################################################

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

// ################################################################################################
// ################################################################################################
// ################################################################################################

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

// ################################################################################################
// ################################################################################################
// ################################################################################################

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

// ################################################################################################
// ################################################################################################
// ################################################################################################

void parse_switch(void){
  char s_label[64];
  char s_nextcase[64];
  char *temp_p;
  int nbr_cases;
  int current_case_nbr;
  int has_default;

  current_break_type = SWITCH_BREAK;
  highest_label_index++;
  label_stack[label_tos] = current_label_index;
  label_tos++;
  current_label_index = highest_label_index;

  sprintf(s_label, "_switch%d_expr:", current_label_index);
  emitln(s_label);
  get();
  if(tok != OPENING_PAREN) error(OPENING_PAREN_EXPECTED);
  parse_expr(); // evaluate condition
  if(tok != CLOSING_PAREN) error(CLOSING_PAREN_EXPECTED);
  sprintf(s_label, "_switch%d_comparisons:", current_label_index);
  emitln(s_label);

  get();
  if(tok != OPENING_BRACE) error(OPENING_BRACE_EXPECTED);

  temp_p = prog;
  nbr_cases = count_cases();
  prog = temp_p;
  has_default = switch_has_default();
  prog = temp_p;
  current_case_nbr = 0;

  // emit compares and jumps
  do{
    get();
    if(tok != CASE) error(CASE_EXPECTED);
    get();
    if(tok_type == INTEGER_CONST){
      emit("  cmp b, ");
      emitln(token);
      sprintf(s_label, "_switch%d_case%d", current_label_index, current_case_nbr);
      strcpy(asm_line, "  je ");
      strcat(asm_line, s_label);
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
      sprintf(s_label, "_switch%d_case%d", current_label_index, current_case_nbr);
      strcpy(asm_line, "  je ");
      strcat(asm_line, s_label);
      emitln(asm_line);
      get();
      if(tok != COLON) error(COLON_EXPECTED);
      skip_case();
      back();
    }
    else error(CONSTANT_EXPECTED);
    current_case_nbr++;
  } while(tok == CASE);

  // generate default if it exists
  if(tok == DEFAULT){
    get(); // get default
    get(); // get ':'
    sprintf(s_label, "_switch%d_default:", current_label_index);
    emitln(s_label);
    parse_case();
  }

  sprintf(s_label, "  jmp _switch%d_exit", current_label_index);
  emitln(s_label);

  // emit code for each case block
  prog = temp_p;
  current_case_nbr = 0;
  do{
    get(); // get 'case'
    get(); // get constant
    get(); // get ':'

    sprintf(s_label, "_switch%d_case%d:", current_label_index, current_case_nbr);
    emitln(s_label);
    parse_case();
    current_case_nbr++;
  } while(tok == CASE);

  sprintf(s_label, "_switch%d_exit:", current_label_index);
  emitln(s_label);

  label_tos--;
  current_label_index = label_stack[label_tos];
  get();
  if(tok == DEFAULT){
    get(); // get ':'
    skip_case();
  }
  if(tok != CLOSING_BRACE) error(CLOSING_BRACE_EXPECTED);
}

// ################################################################################################
// ################################################################################################
// ################################################################################################

void parse_if(void){
  char s_label[64];
  char *temp_p;

  highest_label_index++;
  label_stack[label_tos] = current_label_index;
  label_tos++;
  current_label_index = highest_label_index;

  sprintf(s_label, "_if%d_cond:", current_label_index);
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
    sprintf(s_label, "  je _if%d_else", current_label_index);
    emitln(s_label);
  }
  else{
    sprintf(s_label, "  je _if%d_exit", current_label_index);
    emitln(s_label);
  }

  prog = temp_p;
  sprintf(s_label, "_if%d_true:", current_label_index);
  emitln(s_label);
  parse_block();  // parse the positive condition block
  sprintf(s_label, "  jmp _if%d_exit", current_label_index);
  emitln(s_label);
  get(); // look for 'else'
  if(tok == ELSE){
    sprintf(s_label, "_if%d_else:", current_label_index);
    emitln(s_label);
    parse_block();  // parse the positive condition block
  }
  else{
    back();
  }
  
  sprintf(s_label, "_if%d_exit:", current_label_index);
  emitln(s_label);

  label_tos--;
  current_label_index = label_stack[label_tos];
}

// ################################################################################################
// ################################################################################################
// ################################################################################################

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

// ################################################################################################
// ################################################################################################
// ################################################################################################

void parse_case(void){
  do{
    get();
    switch(tok){
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
      case CASE:
      case DEFAULT:
      case CLOSING_BRACE:
        back();
        return;
      case RETURN:
        parse_return();
        break;
      default:
        back();
        parse_expr();
        if(tok != SEMICOLON) error(SEMICOLON_EXPECTED);
    }    
  } while(1); 
}

// ################################################################################################
// ################################################################################################
// ################################################################################################

void parse_block(void){
  int braces = 0;
  
  do{
    get();
    switch(tok){
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
      case OPENING_BRACE:
        braces++;
        break;
      case CLOSING_BRACE:
        braces--;
        break;
      case RETURN:
        parse_return();
        break;
      default:
        if(tok_type == END) error(CLOSING_BRACE_EXPECTED);
        back();
        parse_expr();
        if(tok != SEMICOLON) error(SEMICOLON_EXPECTED);
    }    
  } while(braces); // exits when it finds the last closing brace
}

// ################################################################################################
// ################################################################################################
// ################################################################################################

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

// ################################################################################################
// ################################################################################################
// ################################################################################################

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
// ################################################################################################
// ################################################################################################
// ################################################################################################

t_basic_data get_var_type(char *var_name){
  register int i;

  for(i = 0; i < function_table[current_func_id].local_var_tos; i++)
    if(!strcmp(function_table[current_func_id].local_vars[i].var_name, var_name))
      return function_table[current_func_id].local_vars[i].data.type;

  for(i = 0; i < global_var_tos; i++)
    if(!strcmp(global_variables[i].var_name, var_name)) 
      return global_variables[i].data.type;

  error(UNDECLARED_VARIABLE);
}

// ################################################################################################
// ################################################################################################
// ################################################################################################

void parse_expr(){
  parse_assignment();
}

// A = cond1 ? true_val : false_val;
void parse_ternary_op(void){
  char s_label[64];
  char *temp_prog;
  char *temp_asm_p;

  temp_prog = prog;
  temp_asm_p = asm_p; // save current assembly output pointer
  sprintf(s_label, "_ternary%d_cond:", highest_label_index + 1); // +1 because we are emitting the label ahead
  emitln(s_label);
  parse_logical(); // evaluate condition
  if(tok != TERNARY_OP){
    prog = temp_prog;
    asm_p = temp_asm_p; // recover asm output pointer
    parse_logical();
    return;
  }

  // '?' was found
  highest_label_index++;
  label_stack[label_tos] = current_label_index;
  label_tos++;
  current_label_index = highest_label_index;
  emitln("  cmp b, 0");
  
  sprintf(s_label, "  je _ternary%d_false", current_label_index);
  emitln(s_label);

  sprintf(s_label, "_ternary%d_true:", current_label_index);
  emitln(s_label);
  parse_ternary_op(); // result in 'b'
  if(tok != COLON) error(COLON_EXPECTED);
  sprintf(s_label, "  jmp _ternary%d_exit", current_label_index);
  emitln(s_label);
  sprintf(s_label, "_ternary%d_false:", current_label_index);
  emitln(s_label);

  parse_ternary_op(); // result in 'b'
  sprintf(s_label, "_ternary%d_exit:", current_label_index);
  emitln(s_label);

  label_tos--;
  current_label_index = label_stack[label_tos];
}

// ################################################################################################
// ################################################################################################
// ################################################################################################

void assign_var(char *var_name){
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
}

void parse_assignment(){
  char var_name[ID_LEN];
  char temp[ID_LEN];
  char *temp_prog;
  int var_id;
  char s_label[64];
  char *temp_asm_p;

  temp_prog = prog;
  temp_asm_p = asm_p; // save current assembly output pointer
  parse_ternary_op(); // evaluate condition
  if(tok != ASSIGNMENT){
    prog = temp_prog;
    asm_p = temp_asm_p; // recover asm output pointer
    parse_ternary_op();
    return;
  }

  // is assignment
  prog = temp_prog;
  asm_p = temp_asm_p; // recover asm output pointer
  get();
  if(tok_type == IDENTIFIER){
    strcpy(var_name, token);
    get();
    if(tok == OPENING_BRACKET){ // matrix operations
			t_var *matrix; // pointer to the matrix variable
			int i;
      int data_size; // matrix data size
			int dims;
			matrix = get_var_pointer(var_name); // gets a pointer to the variable holding the matrix address
			data_size = get_data_size(&matrix->data);
			dims = matrix_dim_count(matrix); // gets the number of dimensions for this matrix
      try_emitting_var(var_name); // emit the base address of the matrix or pointer
      emitln("  mov d, b");
			for(i = 0; i < dims; i++){
        parse_ternary_op(); // result in 'b'
				if(tok != CLOSING_BRACKET) error(CLOSING_BRACKET_EXPECTED);
				// if not evaluating the final dimension, it keeps returning pointers to the current position within the matrix
				if(i < dims - 1){
          sprintf(asm_line, "  mov a, %d", get_matrix_offset(i, matrix) * data_size);
          emitln(asm_line);
          emitln("  mul a, b");
          emitln("  add d, b");
        }
        // if it has reached the last dimension, it gets the final value at that address, which is one of the basic data types
        else if(i == dims - 1){
          // need to do this to get the correct data size in the last index
          // not ideal, but ok for now
          sprintf(asm_line, "  mov a, %d", data_size);
          emitln(asm_line);
          emitln("  mul a, b");           
          emitln("  add d, b");
          // here we have the final address of the referenced matrix item.
          // the code is similar to the matrix handling code in parse_atom,
          // except that the corresponding section which would be hereis deleted
          // since we only need the address and not the value at this matrix position.
			  }
				get();
				if(tok != OPENING_BRACKET) break;
			}
      // we are past the '=' sign here
      emitln("  push d"); // save 'd' in the stack (which contains the variable address), since the RHS expression could use 'd'
      parse_ternary_op(); // evaluate expression, result in 'b'
      emitln("  pop d"); // now retrieve the destination address so we can write to it
      if(matrix->data.ind_level > 0 || matrix->data.type == DT_INT){
        emitln("  mov a, b");
        emitln("  mov [d], a");
      }
      else if(matrix->data.type == DT_CHAR){
        emitln("  mov al, bl");
        emitln("  mov [d], al");
      }
      return;
		}
    else if(tok == ASSIGNMENT){
      parse_ternary_op(); // evaluate expression, result in 'b'
      assign_var(var_name);
      return;
    }
  }
  else if(tok == STAR){ // tests if this is a pointer assignment
    while(tok != SEMICOLON && tok_type != END){
      get();
      if(tok_type == IDENTIFIER) strcpy(var_name, token); // save var name
      if(tok == ASSIGNMENT){ // is an assignemnt
        prog = temp_prog; // goes back to the beginning of the expression
        get(); // gets past the first asterisk
        parse_atom();
        emitln("  mov d, b"); // pointer given in 'b', so mov 'b' into 'a'
        // after evaluating the address expression, the token will be a "="
        parse_ternary_op(); // evaluates the value to be assigned to the address, result in 'b'
        switch(get_var_type(var_name)){
          case DT_CHAR:
            emitln("  mov al, bl");
            emitln("  mov [d], al");
            break;
          case DT_INT:
            emitln("  mov a, b");
            emitln("  mov [d], a");
            break;
          default: error(INVALID_POINTER);
        }
        return;
      }
    }
  }
}

// ################################################################################################
// ################################################################################################
// ################################################################################################

void parse_logical(void){
  parse_logical_or();
}

void parse_logical_or(void){
  char temp_tok;

  parse_logical_and();
  while(tok == LOGICAL_OR){
    temp_tok = tok;
    emitln("  push a");
    emitln("  mov a, b");
    parse_logical_and();
    emitln("  or a, b");
    emitln("  mov b, a");
    emitln("  pop a");
  }
}

void parse_logical_and(void){
  char temp_tok;

  parse_bitwise_or();
  while(tok == LOGICAL_AND){
    temp_tok = tok;
    emitln("  push a");
    emitln("  mov a, b");
    parse_bitwise_or();
    emitln("  or a, b");
    emitln("  mov b, a");
    emitln("  pop a");

/*
    emitln("  push a");
    emitln("  mov a, b");
    parse_bitwise_or();
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
    emitln("  or a, b");
    emitln("  mov b, a");
    emitln("  pop a");*/
  }
}

void parse_bitwise_or(void){
  char temp_tok;

  parse_bitwise_xor();
  while(tok == BITWISE_OR){
    temp_tok = tok;
    emitln("  push a");
    emitln("  mov a, b");
    parse_bitwise_xor();
    emitln("  or b, a");
    emitln("  pop a");
  }
}

void parse_bitwise_xor(void){
  char temp_tok;

  parse_bitwise_and();
  while(tok == BITWISE_XOR){
    temp_tok = tok;
    emitln("  push a");
    emitln("  mov a, b");
    parse_bitwise_and();
    emitln("  xor b, a");
    emitln("  pop a");
  }
}

void parse_bitwise_and(void){
  char temp_tok;

  parse_relational();
  while(tok == BITWISE_AND){
    temp_tok = tok;
    emitln("  push a");
    emitln("  mov a, b");
    parse_relational();
    emitln("  and b, a");
    emitln("  pop a");
  }
}

// ################################################################################################
// ################################################################################################
// ################################################################################################

void parse_relational(void){
  char temp_tok;

/* x = y > 1 && z<4 && y == 2 */
  parse_bitwise_shift();
  while(tok == EQUAL || tok == NOT_EQUAL || tok == LESS_THAN || tok == LESS_THAN_OR_EQUAL
    || tok == GREATER_THAN || tok == GREATER_THAN_OR_EQUAL){
    temp_tok = tok;
    emitln("  push a");
    emitln("  mov a, b");
    parse_bitwise_shift();
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
        emitln("  and al, %00000011"); 
        emitln("  xor al, %00000010"); 
        emitln("  mov ah, 0");
        break;
      case GREATER_THAN:
        emitln("  cmp a, b");
        emitln("  lodflgs");
        emitln("  and al, %00000011"); 
        emitln("  cmp al, %00000000"); 
        emitln("  lodflgs");
        emitln("  and al, %00000001"); 
        emitln("  mov ah, 0");
        break;
    }
    emitln("  mov b, a");
    emitln("  pop a");
  }
}

void parse_bitwise_shift(void){
  char temp_tok;

  parse_terms();
  while(tok == BITWISE_SHL || tok == BITWISE_SHR){
    temp_tok = tok;
    emitln("  push a");
    emitln("  mov a, b");
    parse_terms();
    emitln("  mov c, b");
    emitln("  mov b, a");
    if(temp_tok == BITWISE_SHL) emitln("  shl b, cl");
    else if(temp_tok == BITWISE_SHR) emitln("  shr b, cl");
    emitln("  pop a");
  }
}

// ################################################################################################
// ################################################################################################
// ################################################################################################

void parse_terms(void){
  char temp_tok;
  
  parse_factors();
  while(tok == PLUS || tok == MINUS){
    temp_tok = tok;
    emitln("  push a");
    emitln("  mov a, b");
    parse_factors();
    if(temp_tok == PLUS) emitln("  add a, b");
    else if(temp_tok == MINUS) emitln("  sub a, b");
    emitln("  mov b, a");
    emitln("  pop a");
  }
}

// ################################################################################################
// ################################################################################################
// ################################################################################################

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

// ################################################################################################
// ################################################################################################
// ################################################################################################

unsigned int add_string(char *str){
  int i;
  char temp[256];

  for(i = 0; i < STRING_TABLE_SIZE; i++){
    if(!string_table[i][0]){
      strcpy(string_table[i], str);
      // emit the declaration of this string, into the data block
      sprintf(temp, "_string_%d", i);
      emit_data(temp);
      emit_data(": .db \"");
      emit_data(str);
      emit_data("\", 0\n");
      return i;
    }
  }

  error(MAX_STRINGS);
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

void parse_atom(void){
  int var_id;
  int func_id;
  int string_id;
  char temp_name[ID_LEN];
  char temp[1024];
  char var_address_str[32];
  char enum_value_str[32];
 
  get();
  if(tok_type == STRING_CONST){
    string_id = find_string(string_const);
    if(string_id == -1) string_id = add_string(string_const);
    // now emit the reference to this string into the ASM
    sprintf(temp, "_string_%d", string_id);
    emit("  mov b, ");
    emitln(temp);
  }
  else if(tok == SIZEOF){
    get();
    expect(OPENING_PAREN, OPENING_PAREN_EXPECTED);
    get();
    switch(tok){
      case CHAR:
        emitln("  mov b, 1");
        break;
      case INT:
        emitln("  mov b, 2");
        break;
    }
    get();
    expect(CLOSING_PAREN, CLOSING_PAREN_EXPECTED);
  }
  else if(tok == STAR){ // is a pointer operator
    parse_atom(); // parse expression after STAR, which could be inside parenthesis. result in B
    emitln("  mov d, b");// now we have the pointer value. we then get the data at the address.
    emitln("  mov b, [d]"); // data fetched as an int. need to improve this to allow any types later.
    //need to PARSE VARIABLE HERE TO SEE IF IS LOCAL OR GLOBAL SO THAT WE CAN SWP OR NOT
    back();
  }
  else if(tok == AMPERSAND){
    get(); // get variable name
    if(tok_type != IDENTIFIER) error(IDENTIFIER_EXPECTED);
    if(local_var_exists(token) != -1){ // is a local variable
      var_id = local_var_exists(token);
      get_var_base_addr(temp, token);
      emit("  lea d, [");
      emit(temp);
      emitln("]");
      emitln("  mov b, d");
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
    back();
  }
  else if(tok == BITWISE_NOT){
    parse_atom();
    emitln("  not b");
    back();
  }
  else if(tok == LOGICAL_NOT){
    parse_atom();
    emitln("  not b"); // TODO: this is probably wrong
    back();
  }
  else if(tok == OPENING_PAREN){
    parse_expr();  // parses expression between parenthesis and result will be in B
    if(tok != CLOSING_PAREN) error(CLOSING_PAREN_EXPECTED);
  }
  else if(tok_type == IDENTIFIER){
    strcpy(temp_name, token);
    get();
    if(tok == INCREMENT){ 
      try_emitting_var(temp_name); // into 'b'
      emitln("  inc b");
      assign_var(temp_name);
    }    
    else if(tok == DECREMENT){ 
      try_emitting_var(temp_name); // into 'b'
      emitln("  dec b");
      assign_var(temp_name);
    }    
    else if(tok == OPENING_PAREN){ // function call      
      func_id = find_function(temp_name);
      if(func_id != -1){
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
			t_var *matrix; // pointer to the matrix variable
			int i, dims, data_size; // matrix data size
			matrix = get_var_pointer(temp_name); // gets a pointer to the variable holding the matrix address
			data_size = get_data_size(&matrix->data);
			dims = matrix_dim_count(matrix); // gets the number of dimensions for this matrix
      try_emitting_var(temp_name); // emit the base address of the matrix or pointer into 'b'
      emitln("  mov d, b");
			for(i = 0; i < dims; i++){
        parse_expr(); // result in 'b'
				if(tok != CLOSING_BRACKET) error(CLOSING_BRACKET_EXPECTED);
				// if not evaluating the final dimension, it keeps returning pointers to the current position within the matrix
				if(i < dims - 1){
          sprintf(asm_line, "  mov a, %d", get_matrix_offset(i, matrix) * data_size);
          emitln(asm_line);
          emitln("  mul a, b");
          emitln("  add d, b");
        }
        // if it has reached the last dimension, it gets the final value at that address, which is one of the basic data types
        else if(i == dims - 1){
          sprintf(asm_line, "  mov a, %d", data_size);
          emitln(asm_line);
          emitln("  mul a, b");           
          emitln("  add d, b");
          if(matrix->data.ind_level > 0 || matrix->data.type == DT_INT){
            emitln("  mov b, [d]");
          }
          else if(matrix->data.type == DT_CHAR){
            emitln("  mov bl, [d]");
          }
			  }
				get();
				if(tok != OPENING_BRACKET){
          back();
          break;
        }
			}
		}
    else if(enum_element_exists(temp_name) != -1){
      back();
      sprintf(asm_line, "  mov b, %d; %s", get_enum_val(temp_name), temp_name);
      emit(asm_line);
    }
    else{
      back();
      try_emitting_var(temp_name);
    }
  }
  else error(INVALID_EXPRESSION);

  get(); // gets the next token (it must be a delimiter)
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

void try_emitting_var(char *var_name){
  int var_id;
  char temp[64];

  if(local_var_exists(var_name) != -1){ // is a local variable
    var_id = local_var_exists(var_name);
    // both matrix and parameter means this is a parameter local variable to a function
    // that is really a pointer variable and not really a matrix.
    if(is_matrix(&function_table[current_func_id].local_vars[var_id])
    && function_table[current_func_id].local_vars[var_id].is_parameter){
      emit("  lea d, [");
      get_var_base_addr(temp, var_name);
      emit(temp);
      emit("]");
      emit(" ; ");
      emitln(var_name);
      emitln("  mov b, [d]");
    }
    else if(is_matrix(&function_table[current_func_id].local_vars[var_id])){
      emit("  lea d, [");
      get_var_base_addr(temp, var_name);
      emit(temp);
      emit("]");
      emit(" ; ");
      emit(var_name);
      emitln("_data");
      emitln("  mov b, d");
    }
    else if(function_table[current_func_id].local_vars[var_id].data.ind_level > 0){
      emit("  lea d, [");
      get_var_base_addr(temp, var_name);
      emit(temp);
      emit("]");
      emit(" ; ");
      emitln(var_name);
      emitln("  mov b, [d]");
    }
    else if(function_table[current_func_id].local_vars[var_id].data.type == DT_INT){
      emit("  mov b, [");
      get_var_base_addr(temp, var_name);
      emit(temp);
      emit("]");
      emit(" ; ");
      emitln(var_name);
    }
    else if(function_table[current_func_id].local_vars[var_id].data.type == DT_CHAR){
      emit("  mov bl, [");
      get_var_base_addr(temp, var_name);
      emit(temp);
      emit("]");
      emit(" ; ");
      emitln(var_name);
    }
  }
  else if(global_var_exists(var_name) != -1){  // is a global variable
    var_id = global_var_exists(var_name);
    if(global_variables[var_id].data.ind_level > 0
    || is_matrix(&global_variables[var_id])){
      emit("  mov b, [");
      emit(global_variables[var_id].var_name);
      emitln("]");
    }
    else if(global_variables[var_id].data.type == DT_INT){
      emit("  mov b, [");
      emit(global_variables[var_id].var_name);
      emitln("]");
    }
    else if(global_variables[var_id].data.type == DT_CHAR){
      emit("  mov bl, [");
      emit(global_variables[var_id].var_name);
      emitln("]");
    }
  }
  else error(UNDECLARED_IDENTIFIER);
}

// ################################################################################################
// ################################################################################################
// ################################################################################################

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
	
	for(i = dim + 1; i < matrix_dim_count(matrix); i++)
		offset = offset * matrix -> dims[i];
	
	return offset;
}

int get_total_var_size(t_var *var){
	int i;
	int size = 1;

  // if it is a matrix, return its number of dimensions
	for(i = 0; i < matrix_dim_count(var); i++)
		size = size * var->dims[i];
	
  // if it is not a mtrix, it will return 1 * the data size
	return size * get_data_size(&var->data);
}

int is_matrix(t_var *var){
  if(var->dims[0]) return 1;
  else return 0;

/*
	register int i;

  //check local variables whose function id is the id of current function being parsed
  for(i = 0; i < function_table[current_func_id].local_var_tos; i++)
    if(!strcmp(function_table[current_func_id].local_vars[i].var_name, var_name))
      if(function_table[current_func_id].local_vars[i].dims[0] > 0) return 1;
      else return -1;

	for(i = 0; i < global_var_tos; i++)
		if(!strcmp(global_variables[i].var_name, var_name)) 
			if(global_variables[i].dims[0] > 0) return 1;
      else return -1;

	error(UNDECLARED_VARIABLE);
*/
}

// ################################################################################################
// ################################################################################################
// ################################################################################################

int matrix_dim_count(t_var *var){
	int i;
	
	for(i = 0; var->dims[i]; i++);
	
	return i;
}

int get_data_size(t_data *data){
	if(data -> ind_level > 0) return 2;
	else
		switch(data -> type){
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

// #########################V#######################################################################
// ################################################################################################
// ################################################################################################

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

// ################################################################################################
// ################################################################################################
// ################################################################################################

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

// ################################################################################################
// ################################################################################################
// ################################################################################################

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

// ################################################################################################
// ################################################################################################
// ################################################################################################

void declare_global(void){
  t_basic_data dt;
  int ind_level;
  char constant = 0;
  char temp[512];

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
    // ind_level == 1 && dt_char
    // var is a matrix (dims > 0)
    // checks for variable initialization
    if(tok == ASSIGNMENT){
      int j;
      if(is_matrix(&global_variables[global_var_tos])){
        get();
        expect(OPENING_BRACE, OPENING_BRACE_EXPECTED);
        sprintf(temp, "%s_data: ", global_variables[global_var_tos].var_name);
        emit_data(temp);
        emit_data_dbdw(ind_level, dim, dt);
        j = 0;
        do{
          get();
          switch(dt){
            case DT_VOID:
              sprintf(temp, "%u, ", atoi(token));
              emit_data(temp);
              break;
            case DT_CHAR:
              if(ind_level > 0){ // if is a pointer
                sprintf(temp, "%u, ", atoi(token));
                emit_data(temp);
              }
              else{
                if(tok_type == CHAR_CONST){
                  sprintf(temp, "'%c', ", string_const[0]);
                  emit_data(temp);
                }
                else if(tok_type == INTEGER_CONST){
                  sprintf(temp, "%u, ", (char)atoi(token));
                  emit_data(temp);
                }
              }
              break;
            case DT_INT:
              if(ind_level > 0){
                sprintf(temp, "%u, ", atoi(token));
                emit_data(temp);
              }
              else{
                sprintf(temp, "%u, ", atoi(token));
                emit_data(temp);
              }
              break;
          }
          j++;
          get();
        } while(tok == COMMA);
        // fill in the remaining unitialized array values with 0's 
        sprintf(temp, "\n.fill %u, 0\n", get_total_var_size(&global_variables[global_var_tos]) - j * get_data_size(&global_variables[global_var_tos].data));
        emit_data(temp);
        sprintf(temp, "%s: .dw %s_data\n", global_variables[global_var_tos].var_name, global_variables[global_var_tos].var_name);
        emit_data(temp);
        global_variables[global_var_tos].nbr_initial_values = j;
        expect(CLOSING_BRACE, CLOSING_BRACE_EXPECTED);
      }
      else{
        get();
        switch(dt){
          case DT_VOID:
            sprintf(temp, "%s: ", global_variables[global_var_tos].var_name);
            emit_data(temp);
            emit_data_dbdw(ind_level, dim, dt);
            sprintf(temp, "%u, ", atoi(token));
            emit_data(temp);
            break;
          case DT_CHAR:
            if(ind_level > 0){ // if is a string
              if(tok_type != STRING_CONST) error(STRING_CONSTANT_EXPECTED);
              sprintf(temp, "%s_data: ", global_variables[global_var_tos].var_name);
              emit_data(temp);
              emit_data_dbdw(ind_level, dim, dt);
              sprintf(temp, "%s, 0\n", token);
              emit_data(temp);
              sprintf(temp, "%s: .dw %s_data\n", global_variables[global_var_tos].var_name, global_variables[global_var_tos].var_name);
              emit_data(temp);
            }
            else{
              sprintf(temp, "%s: ", global_variables[global_var_tos].var_name);
              emit_data(temp);
              emit_data_dbdw(ind_level, dim, dt);
              if(tok_type == CHAR_CONST){
                sprintf(temp, "'%c'\n", string_const[0]);
                emit_data(temp);
              }
              else if(tok_type == INTEGER_CONST){
                sprintf(temp, "%u\n", (char)atoi(token));
                emit_data(temp);
              }
            }
            break;
          case DT_INT:
            sprintf(temp, "%s: ", global_variables[global_var_tos].var_name);
            emit_data(temp);
            emit_data_dbdw(ind_level, dim, dt);
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
        sprintf(temp, "%s_data: .fill %u, 0\n", global_variables[global_var_tos].var_name, get_total_var_size(&global_variables[global_var_tos]));
        emit_data(temp);
        sprintf(temp, "%s: .dw %s_data\n", global_variables[global_var_tos].var_name, global_variables[global_var_tos].var_name);
        emit_data(temp);
      }
      else{
        sprintf(temp, "%s: .fill %u, 0\n", global_variables[global_var_tos].var_name, get_total_var_size(&global_variables[global_var_tos]));
        emit_data(temp);
      }
    }
    global_var_tos++;  
  } while(tok == COMMA);

  if(tok != SEMICOLON) error(SEMICOLON_EXPECTED);
}

void emit_data_dbdw(int ind_level, int dims, t_basic_data dt){
  if(ind_level > 0 && dt == DT_CHAR && dims == 0
    || ind_level == 0 && dt == DT_CHAR && dims == 0){ 
    emit_data(".db ");
  }
  else{
    emit_data(".dw ");
  }
}

// ################################################################################################
// ################################################################################################
// ################################################################################################

int find_function(char *func_name){
  register int i;
  
  for(i = 0; *function_table[i].func_name; i++)
    if(!strcmp(function_table[i].func_name, func_name))
      return i;
  
  return -1;
}

// ################################################################################################
// ################################################################################################
// ################################################################################################

int global_var_exists(char *var_name){
  register int i;

  for(i = 0; i < global_var_tos; i++)
    if(!strcmp(global_variables[i].var_name, var_name)) return i;
  
  return -1;
}

// ################################################################################################
// ################################################################################################
// ################################################################################################

int local_var_exists(char *var_name){
  register int i;

  //check local variables whose function id is the id of current function being parsed
  for(i = 0; i < function_table[current_func_id].local_var_tos; i++)
    if(!strcmp(function_table[current_func_id].local_vars[i].var_name, var_name)) return i;
  
  return -1;
}

// ################################################################################################
// ################################################################################################
// ################################################################################################

t_basic_data get_data_type_from_tok(t_token t){
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
  t_basic_data dt;
  t_var new_var;
  char *temp_prog;
  
  temp_prog = prog;
  get(); // gets past the data type
  if(tok == CONST){
    new_var.constant = 1;
    get();
  }
  else new_var.constant = 0;
  dt = get_data_type_from_tok(tok);
  do{
    if(function_table[current_func_id].local_var_tos == MAX_LOCAL_VARS) error(LOCAL_VAR_LIMIT_REACHED);
    new_var.is_parameter = 0;
    new_var.function_id = current_func_id; // set variable owner function
    new_var.data.type = dt;
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
      error(LOCAL_ASSIGNMENT);
    }
    else{
      /*
      int ii;
      for(ii=0;ii<get_total_var_size(&new_var);ii++){
          emitln("  push byte 'A'");
      }*/
      sprintf(asm_line, "  sub sp, %d ; %s", get_total_var_size(&new_var), new_var.var_name);
      emitln(asm_line);
    }
    // assigns the new variable to the local stack
    function_table[current_func_id].local_vars[function_table[current_func_id].local_var_tos] = new_var;    
    function_table[current_func_id].local_var_tos++;
  } while(tok == COMMA);

  if(tok != SEMICOLON) error(SEMICOLON_EXPECTED);
} // declare_local

// ################################################################################################
// ################################################################################################
// ################################################################################################

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

// ################################################################################################
// ################################################################################################
// ################################################################################################

void expect(t_token _tok, t_errorCode errorCode){
  if(tok != _tok) error(errorCode);
}

void error(t_errorCode e){
  int line = 1;
  char *t = c_preproc_out;

  printf("\nERROR: %s\n", error_table[e]);
  
  while(t < prog){
    t++;
    if(*t == '\n') line++;
  }
  
  printf("LINE NUMBER: %d\n", line);
  printf("NEAR: %s\n\n", token);

  exit(0);
}


// ################################################################################################
// ################################################################################################
// ################################################################################################

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

// ################################################################################################
// ################################################################################################
// ################################################################################################

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
  else if(is_id_char(*prog)){
    while(is_id_char(*prog) || isdigit(*prog))
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
      tok = CARET;
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

// ################################################################################################
// ################################################################################################
// ################################################################################################

/*
asm{
  line1
  line2
}
*/
void get_line(void){
  char *t;

  t = string_const;
  
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

// ################################################################################################
// ################################################################################################
// ################################################################################################

int find_keyword(char *keyword){
  register int i;
  
  for(i = 0; keyword_table[i].key; i++)
    if (!strcmp(keyword_table[i].keyword, keyword)) return keyword_table[i].key;
  
  return -1;
}

// ################################################################################################
// ################################################################################################
// ################################################################################################

char is_delimiter(char c){
  if(strchr("?@$#+-*/%[](){}:;,<>=!&|~.", c)) return 1;
  else return 0;
}

char is_id_char(char c){
  return(isalpha(c) || c == '_');
}

