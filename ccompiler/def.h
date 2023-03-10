#define STRING_TABLE_SIZE      512
#define STRING_CONST_SIZE      512
#define MAX_USER_FUNC          512
#define MAX_GLOBAL_VARS        512
#define MAX_LOCAL_VARS         512
#define ID_LEN                 128
#define CONST_LEN              128
#define PROG_SIZE              1024 * 64
#define MAX_MATRIX_DIMS        10
#define MAX_ENUM_ELEMENTS      128
#define MAX_ENUM_DECLARATIONS  128
#define MAX_DEFINES            128

typedef enum {
  DIRECTIVE = 1, INCLUDE, INC_ASM, DEFINE,
  
  VOID, CHAR, INT, FLOAT, DOUBLE,
  SHORT, LONG, SIGNED, UNSIGNED,
  
  STRUCT, STRUCT_DOT, STRUCT_ARROW,
  ENUM,
  
  IF, ELSE, FOR, DO, WHILE, BREAK, CONTINUE, SWITCH, CASE, DEFAULT, RETURN, CONST,
  SIZEOF,
  
  PLUS, MINUS, STAR, FSLASH, INCREMENT, DECREMENT, MOD,
  
  EQUAL, NOT_EQUAL, LESS_THAN, LESS_THAN_OR_EQUAL, GREATER_THAN, GREATER_THAN_OR_EQUAL,
  LOGICAL_AND, LOGICAL_OR, LOGICAL_NOT,
  ASSIGNMENT, DOLLAR, CARET, AT, TERNARY_OP,
  
  BITWISE_AND, AMPERSAND = BITWISE_AND, BITWISE_XOR, BITWISE_OR, BITWISE_NOT, BITWISE_SHL, BITWISE_SHR,
  
  OPENING_PAREN, CLOSING_PAREN,
  OPENING_BRACE, CLOSING_BRACE,
  OPENING_BRACKET, CLOSING_BRACKET,
  
  COLON, SEMICOLON, COMMA,

  ASM
} t_token; // internal token representation
t_token tok;

typedef enum{
  LOCAL = 0, GLOBAL
} t_var_scope;

typedef enum{
  FOR_BREAK, WHILE_BREAK, DO_BREAK, SWITCH_BREAK
} t_break_type;

typedef enum {
  DELIMITER = 1,
  CHAR_CONST, STRING_CONST, INTEGER_CONST, FLOAT_CONST, DOUBLE_CONST,
  IDENTIFIER, RESERVED, END
} t_token_type;
t_token_type tok_type;

typedef union {
  char c;
  int i;
  short int p; // pointer value. 2 bytes since Sol-1 integers/pointers are 2 bytes long
  long int li;
  float f;
  double d;
} t_value;

typedef struct{
  char name[ID_LEN]; // enum name
  struct{
    char element_name[ID_LEN];
    int value;
  } elements[MAX_ENUM_ELEMENTS];
} t_enum;
t_enum enum_table[MAX_ENUM_DECLARATIONS];

// basic data types
typedef enum {
  DT_VOID = 1, DT_CHAR, DT_INT, DT_FLOAT, DT_DOUBLE, DT_STRUCT
} t_data_type;

typedef enum {
  MOD_UNSIGNED, MOD_SIGNED, MOD_LONG
} t_modifier;

typedef struct {
  t_data_type type;
  t_modifier smod, lmod;
  t_value value;
  int ind_level; // holds the pointer indirection level
} t_data;

typedef struct {
  char var_name[ID_LEN];
  t_data data; // holds the type of data and the value itself
  char is_parameter;
  int dims[MAX_MATRIX_DIMS + 1];
  char constant; // is it a constant?
  int bp_offset; // if var is local, this holds the offset of the var from BP.
  int function_id; // the function does var belong to? (if it is a local var)
} t_var;
t_var global_variables[MAX_GLOBAL_VARS];

struct{
  char name[ID_LEN];
  char content[256];
} defines_table[MAX_DEFINES];

typedef struct {
  char func_name[ID_LEN];
  t_data return_type;
  char *code_location;
  t_var local_vars[MAX_LOCAL_VARS + 1];
  int local_var_tos;
  int total_parameter_size;
} t_user_func;
t_user_func function_table[MAX_USER_FUNC];

struct _keyword_table{
  char *keyword;
  t_token key;
} keyword_table[] = {
  "include",  INCLUDE,
  "inc_asm",  INC_ASM,
  "define",   DEFINE,
  "asm",      ASM,

  "void",     VOID,
  "char",     CHAR,
  "int",      INT,
  "float",    FLOAT,
  "double",   DOUBLE,

  "const",    CONST,
  "signed",   SIGNED,
  "unsigned", UNSIGNED,
  "long",     LONG,

  "enum",     ENUM,
  "struct",   STRUCT,
  "sizeof",   SIZEOF,

  "if",       IF,
  "else",     ELSE,
  "for",      FOR,
  "do",       DO,
  "break",    BREAK,
  "continue", CONTINUE,
  "while",    WHILE,
  "switch",   SWITCH,
  "case",     CASE,
  "default",  DEFAULT,
  "return",   RETURN,
  "",         0
};

typedef enum {
  SYNTAX,
  OPENING_PAREN_EXPECTED, 
  CLOSING_PAREN_EXPECTED,
  OPENING_BRACE_EXPECTED,
  CLOSING_BRACE_EXPECTED,
  OPENING_BRACKET_EXPECTED,
  CLOSING_BRACKET_EXPECTED,
  COMMA_EXPECTED,
  SEMICOLON_EXPECTED,
  VAR_TYPE_EXPECTED,
  IDENTIFIER_EXPECTED,
  EXCEEDED_GLOBAL_VAR_LIMIT,
  EXCEEDED_FUNC_DECL_LIMIT,
  NOT_VAR_OR_FUNC_OUTSIDE,
  NO_MAIN_FOUND,
  UNDECLARED_FUNC,
  SINGLE_QUOTE_EXPECTED,
  DOUBLE_QUOTE_EXPECTED,
  UNDECLARED_VARIABLE,
  MAX_PARAMS_LIMIT_REACHED,
  USER_FUNC_CALLS_LIMIT_REACHED,
  LOCAL_VAR_LIMIT_REACHED,
  RETURNING_VALUE_FROM_VOID_FUNCTION,
  INVALID_EXPRESSION,
  INVALID_ARGUMENT_FOR_BITWISE_NOT,
  WHILE_KEYWORD_EXPECTED,
  DUPLICATE_LOCAL_VARIABLE,
  DUPLICATE_GLOBAL_VARIABLE,
  STRING_CONSTANT_EXPECTED,
  POINTER_EXPECTED,
  INVALID_POINTER,
  INSUFFICIENT_ARGUMENTS,
  POINTER_SYNTAX,
  TOO_MANY_MATRIX_DIMENSIONS,
  INVALID_MATRIX_DIMENSION,
  MEMORY_ALLOCATION_FAILURE,
  MATRIX_INDEX_OUTSIDE_BOUNDS,
  INVALID_MATRIX_ASSIGNMENT,
  MATRIX_EXPECTED,
  UNKOWN_LIBRARY,
  UNKNOWN_DIRECTIVE,
  DIRECTIVE_SYNTAX,
  INCOMPATIBLE_FUNCTION_ARGUMENT,
  CONSTANT_VARIABLE_ASSIGNMENT,
  INVALID_BINARY_OPERANDS,
  UNEXPECTED_EOF,
  INCOMPATIBLE_ARGUMENT_TYPE,
  INVALID_TYPE_IN_VARIABLE,
  CASE_EXPECTED,
  CONSTANT_EXPECTED,
  COLON_EXPECTED,
  EXCEEDED_MAX_ENUM_DECL,
  UNDECLARED_ENUM_ELEMENT,
  UNDECLARED_IDENTIFIER,
  MAX_STRINGS,
  LOCAL_ASSIGNMENT,
  UNKNOWN_DATA_TYPE
} t_errorCode;

// variable declaration
char *error_table[] = {
  "syntax error",
  "syntax error: opening parenthesis expected",
  "syntax error: closing parenthesis expected",
  "syntax error: opening brace expected",
  "syntax error: closing brace expected",
  "syntax error: opening bracket expected",
  "syntax error: closing bracket expected",
  "syntax error: comma expected",
  "syntax error: semicolon expected",
  "syntax error: variable type expected in the declaration",
  "syntax error: identifier expected",
  "global variable limit reached (max = 100)",
  "function declaration limit reached (max = 100)",
  "syntax error: only variable and function declarations are allowed outside of functions",
  "main funtion not found",
  "undeclared function",
  "syntax error: single quote expected",
  "syntax error: double quotes expected",
  "undeclared variable or constant",
  "maximum number of function paramters reached (max = 10)",
  "maximum number of program-defined function calls reached (max = 100)",
  "local variables limit reached (max = 200)",
  "returning value from void function",
  "invalid expression",
  "invalid argument for the bitwise not operation",
  "while part of do-while loop expected",
  "duplicate local variable declared",
  "duplicate global variable declared",
  "string constant expected",
  "pointer expected",
  "invalid pointer type",
  "insufficient function arguments",
  "pointer syntax error",
  "declared matrix exceeds the maximum number of dimensions (max = 10)",
  "invalid matrix dimension",
  "memory allocation failure",
  "matrix index outside bounds",
  "invalid matrix assignution",
  "matrix expected",
  "unkown library",
  "unknown directive",
  "directive syntax error",
  "incompatible function argument",
  "constant variable assignment",
  "invalid binary operands",
  "unexpected end of file",
  "incompatible argument type in function",
  "invalid type: void types need to be pointers",
  "case keyword expected",
  "constant expected",
  "colon expected",
  "maximum enum declaration limit reached",
  "undeclared enum element",
  "undeclared identifier",
  "maximum number of strings reached",
  "Assignment of local variables is not possible yet",
  "Unknown data type in array initialization"
};

char string_table[STRING_TABLE_SIZE][STRING_CONST_SIZE];

int current_function_var_bp_offset;  // this is used to position local variables correctly relative to BP.
int current_func_id;
int function_table_tos;
int global_var_tos;
int enum_table_tos;
int defines_tos;

char token[CONST_LEN + 2];            // string token representation
char string_const[STRING_CONST_SIZE];  // holds string and char constants without quotes and with escape sequences converted into the correct bytes
char *prog;                           // pointer to the current program position
char c_in[PROG_SIZE];               // C program-in buffer
char c_preproc_out[PROG_SIZE];     // pre-processor out buffer
char asm_out[64*1024];             // ASM output
char asm_optimized[64*1024];             // ASM output optimized
char *asm_p;
char *data_p;
char asm_line[256];
char includes_list_asm[1024];         // keeps a list of all included files
char data_block_asm[1024*32];
char *data_block_p;

t_break_type current_break_type;      // is it a for, while, or switch?
t_break_type break_type_stack[64];
int break_type_tos;

int highest_label_index; // keeps the highest label index and always increases
int current_label_index_if; 
int current_label_index_ter; 
int current_label_index_for; 
int current_label_index_do; 
int current_label_index_while; 
int current_label_index_switch; 
int label_stack_if[64];
int label_stack_ter[64];
int label_stack_for[64];
int label_stack_do[64];
int label_stack_while[64];
int label_stack_switch[64];
int label_tos_if = 0;
int label_tos_ter = 0;
int label_tos_for = 0;
int label_tos_do = 0;
int label_tos_while = 0;
int label_tos_switch = 0;


// functions
char is_delimiter(char c);
char is_identifier_char(char c);
int find_keyword(char *keyword);
int local_var_exists(char *var_name);
int global_var_exists(char *var_name);
t_var *get_var(char *var_name);
int find_function(char *func_name);
void load_program(char *filename);

void pre_scan(void);

void get_line(void);
void get(void);
void error(t_errorCode e);
void declare_enum(void);
void declare_func(void);
void declare_global(void);
void declare_local(void);
void back(void);
void emit(char *p);
void emitln(char *p);
void emit_c_var(char *var_name);
void emit_data(char *data);
void emit_data_block();
void emit_data_dbdw(int ind_level, int dims, t_data_type dt);
void emit_string_table_data(void);

void skip_statements(void);
void skip_block(void);
void skip_case(void);

t_data parse_expr();
t_data parse_assignment();
t_data parse_ternary_op(void);
t_data parse_logical(void);
t_data parse_logical_and(void);
t_data parse_logical_or(void);
t_data parse_bitwise_and(void);
t_data parse_bitwise_or(void);
t_data parse_bitwise_xor(void);
t_data parse_relational(void);
t_data parse_bitwise_shift(void);
t_data parse_terms();
t_data parse_factors();
t_data parse_atom();

int count_cases(void);
void parse_case(void);
void parse_block(void);
void parse_functions(void);
void parse_main(void);
void parse_return(void);

void convert_data(t_data *data_to_convert, t_data_type into_type);

t_data_type get_var_type(char *var_name);

void parse_directive(void);

void generate_file(char *filename);

void parse_for(void);
void parse_if(void);
void parse_switch(void);
void parse_while(void);
void parse_do(void);
void parse_break(void);
void parse_case_break(void);
void parse_while_break(void);
void parse_do_break(void);
void parse_for_break(void);
void parse_asm(void);
int switch_has_default(void);


void parse_function_arguments(int func_index);
void call_func(int func_index);


int get_total_func_param_size(void);

int get_enum_val(char *element_name);
int enum_element_exists(char *element_name);


int is_matrix(t_var *var);
int get_data_size(t_data *data);
int matrix_dim_count(t_var *var);
int get_matrix_offset(char dim, t_var *matrix);
t_var *get_var_pointer(char *var_name);
int get_total_var_size(t_var *var);

void get_var_base_addr(char *dest, char *var_name);
t_data emit_var_into_b(char *var_name);
t_var_scope get_var_scope(char *var_name);
t_var *get_var_by_name(char *var_name);
int get_param_size(void);
t_data_type get_data_type_from_tok(t_token t);
void emit_var_assignment(char *var_name);
void skip_matrix_bracket(void);


void expect(t_token _tok, t_errorCode errorCode);


unsigned int add_string_data(char *str);
void declare_define();
void pre_processor(void);
int find_define(char *name);
void include_asm_lib(char *lib_name);

void optimize(void);
int find_string(char *str);
t_data cast(t_data t1, t_data t2);