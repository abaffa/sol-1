#define STRING_TABLE_SIZE      250
#define MAX_USER_FUNC          50
#define MAX_GLOBAL_VARS        100
#define MAX_LOCAL_VARS         100
#define ID_LEN                 50
#define CONST_LEN              500
#define PROG_SIZE              99999
#define MAX_MATRIX_DIMS           10

#define TRUE      1
#define FALSE     0

typedef enum {
  DIRECTIVE = 1, INCLUDE,
  
  VOID, CHAR, INT, FLOAT, DOUBLE,
  SHORT, LONG, SIGNED, UNSIGNED,
  
  STRUCT, STRUCT_DOT, STRUCT_ARROW,
  ENUM,
  
  IF, ELSE, FOR, DO, WHILE, BREAK, CONTINUE, SWITCH, CASE, DEFAULT, RETURN, CONST,
  SIZEOF,
  
  PLUS, MINUS, STAR, FSLASH, INCREMENT, DECREMENT, MOD,
  
  EQUAL, NOT_EQUAL, LESS_THAN, LESS_THAN_OR_EQUAL, GREATER_THAN, GREATER_THAN_OR_EQUAL,
  LOGICAL_AND, LOGICAL_OR, LOGICAL_NOT,
  ASSIGNMENT, DOLLAR,
  
  BITWISE_AND, AMPERSAND = BITWISE_AND, BITWISE_OR, BITWISE_NOT, BITWISE_SL, BITWISE_SR,
  
  OPENING_PAREN, CLOSING_PAREN,
  OPENING_BRACE, CLOSING_BRACE,
  OPENING_BRACKET, CLOSING_BRACKET,
  
  SEMICOLON, COMMA,

  ASM
} _TOKEN; // internal token representation
_TOKEN tok;

typedef enum {
  DELIMITER = 1,
  CHAR_CONST, STRING_CONST, INTEGER_CONST, FLOAT_CONST, DOUBLE_CONST,
  IDENTIFIER, RESERVED, END
} _TOKEN_TYPE;
_TOKEN_TYPE tok_type;

typedef enum {
  JF_NULL, 
  JF_BREAK, 
  JF_CONTINUE, 
  JF_RETURN
} _JUMP_FLAG;

typedef union {
  char c;
  short int shortint;
  short int p; // pointer value. 2 bytes since Sol-1 integers/pointers are 2 bytes long
  //int i;
  long int longint;
  long long int longlongint;
  float f;
  double d;
  long double longdouble;
} _VALUE;

// basic data types
typedef enum {
  DT_VOID = 1, DT_CHAR, DT_INT, DT_FLOAT, DT_DOUBLE, DT_STRUCT
} _BASIC_DATA;

typedef enum {
  mSIGNED = 1, mUNSIGNED, mSHORT, mLONG
} _MODIFIER;

typedef struct {
  _BASIC_DATA type;
  _MODIFIER smodf, lmodf, modf3;
  _VALUE value;
  int ind_level; // holds the pointer indirection level
} _DATA;

typedef struct {
  char *str;
  _DATA data;
} _CONST;

typedef struct {
  char var_name[ID_LEN];
  _DATA data; // holds the type of data and the value itself
  int dims[MAX_MATRIX_DIMS + 1];
  char constant;
  char is_parameter; // is this a parameter variable or a normal local variable?
  int bp_offset; // if var is local, this holds the offset of the var from BP.
  int function_id; // the function does this local var belong to
} _LOCAL_VAR;

typedef struct {
  char var_name[ID_LEN];
  _DATA data; // holds the type of data and the value itself
  int dims[MAX_MATRIX_DIMS + 1];
  char constant;
  char as_string[1024]; // this just saves the initialization string in case the var is a string. it makes it easier for the compiler
  // but is a poor solution that needs fixing later
} _GLOBAL_VAR;
_GLOBAL_VAR global_variables[MAX_GLOBAL_VARS];

typedef struct {
  char func_name[ID_LEN];
  _BASIC_DATA return_type;
  char *code_location;
  _LOCAL_VAR local_vars[MAX_LOCAL_VARS + 1];
  int local_var_tos;
} _USER_FUNC;
_USER_FUNC function_table[MAX_USER_FUNC];

struct _keyword_table{
  char *keyword;
  _TOKEN key;
} keyword_table[] = {
  "void", VOID,
  "char", CHAR,
  "int", INT,
  "float", FLOAT,
  "double", DOUBLE,
  "const", CONST,
  "enum", ENUM,
  "struct", STRUCT,
  "sizeof", SIZEOF,
  "return", RETURN,
  "if", IF,
  "else", ELSE,
  "for", FOR,
  "do", DO,
  "break", BREAK,
  "continue", CONTINUE,
  "while", WHILE,
  "switch", SWITCH,
  "case", CASE,
  "default", DEFAULT,
  "include", INCLUDE,
  "asm", ASM,
  "", 0
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
  DUPLICATE_GLOBAL_VARIABLE,
  DUPLICATE_LOCAL_VARIABLE,
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
  INVALID_TYPE_IN_VARIABLE
} _ERROR;

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
  "duplicate global variable declared",
  "duplicate local variable declared",
  "string constant expected",
  "pointer expected",
  "invalid pointer type",
  "insufficient function arguments",
  "pointer syntax error",
  "declared matrix exceeds the maximum number of dimensions (max = 10)",
  "invalid matrix dimension",
  "memory allocation failure",
  "matrix index outside bounds",
  "invalid matrix attribution",
  "matrix expected",
  "unkown library",
  "unknown directive",
  "directive syntax error",
  "incompatible function argument",
  "constant variable assignment",
  "invalid binary operands",
  "unexpected end of file",
  "incompatible argument type in function",
  "invalid type: void types need to be pointers"
};

int current_function_var_bp_offset;  // this is used to position local variables correctly relative to BP.
int current_func_id;
int function_table_tos;
int global_var_tos;

char token[CONST_LEN + 2];            // string token representation
char string_constant[CONST_LEN + 2];  // holds string and char constants without quotes and with escape sequences converted into the correct bytes
char *prog;                           // pointer to the current program position
char pbuf[PROG_SIZE];                 // pointer to the beginning of the source code
char ASM_output[64*1024];             // ASM output 
char *asmp;
char includes_list_ASM[1024];         // keeps a list of all included files
int highest_label_index = 0;          // this keeps the next value of the label index for use in new labels.
                                      //label values are never repeating. always increasing.
int current_label_index_if = 0;       // index of current 'if' label. starts at 0
int current_label_index_switch = 0;   // index of current 'switch' label. starts at 0
int current_label_index_loop = 0;     // index of current 'while' label. starts at 0
int label_stack_loop[64];             // for nested loop labels 
int label_stack_if[64];               // for nested if labels 
int label_stack_switch[64];           // for nested switch labels 
int label_tos_loop = 0;               // label stack pointer
int label_tos_if = 0;                 // label stack pointer
int label_tos_switch = 0;             // label stack pointer

// functions
char isdelim(char c);
char is_idchar(char c);
int find_keyword(char *keyword);
int local_var_exists(char *var_name);
int global_var_exists(char *var_name);
_LOCAL_VAR *get_local_var(char *var_name);
_GLOBAL_VAR *get_global_var(char *var_name);
int find_function(char *func_name);
void load_program(char *filename);

void initial_setup(void);
void pre_scan(void);

void get_line(void);
void get(void);
void error(_ERROR e);
void declare_func(void);
void declare_global(void);
void declare_local(void);
void putback(void);
void emit(char *p);
void emitln(char *p);
void emit_var(char *var_name);
void find_end_of_BLOCK(void);
void find_end_of_block(void);

void parse_expr();
void parse_attrib();
void parse_logical();
void parse_relational(void);
void parse_terms();
void parse_factors();
void parse_atom();
void parse_return(void);

void parse_block(void);
void parse_functions(void);
void parse_main(void);

void convert_data(_DATA *data_to_convert, _BASIC_DATA into_type);

_BASIC_DATA get_var_type(char *var_name);

void parse_directive(void);
void emit_global_variables(void);
void emit_libraries(void);


void generate_file(char *filename);

void parse_for(void);
void parse_if(void);
void parse_switch(void);
void parse_while(void);
void parse_break(void);
void parse_asm(void);


void parse_function_arguments(int func_index);
void call_func(int func_index);


int find_total_parameter_bytes(void);
