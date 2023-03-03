#inc_asm "lib/stdio.asm"

int SIZE = 100;

int current[100] = {
                    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
                    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
                    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
                    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
                    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
                    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
                    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
                    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
                    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
                    0, 0, 0, 0, 0, 0, 0, 0, 0, 0 
                    };
int next[100] = {
                    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
                    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
                    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
                    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
                    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
                    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
                    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
                    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
                    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
                    0, 0, 0, 0, 0, 0, 0, 0, 0, 0 
    };


void print(char *s){
    asm{
        mov a, @s
        mov d, a
        call puts
    }
    return;
}
void main() {
    int i;

    while(1){
        initialize();

        for (i = 0; i < SIZE; i++) {
            compute_next();
            update_current();
            display();
        }
    }

    return;
}
// Initialize the automaton with a single active cell at the center
void initialize() {
    current[SIZE/2] = 1;
    return;
}

// Compute the next state of the automaton using Rule 90
void compute_next(void) {
    int left;
    int right;
    int i;

    for (i = 0; i < SIZE; i++) {
        left = (i == 0) ? current[SIZE - 1] : current[i - 1];
        right = (i == SIZE - 1) ? current[0] : current[i + 1];
        if(left == right) next[i] = 0;
        else next[i] = 1;
    }
    return;
}

// Update the current state of the automaton with the next state
void update_current() {
    int i;
    for (i = 0; i < SIZE; i++) {
        current[i] = next[i];
    }
    return;
}

// Display the current state of the automaton
void display() {
    char c;
    int i;
    for (i = 0; i < SIZE; i++) {
        if(current[i] != 0) print("*");
        else print(" ");
        
    }
    print("\n");
    return;
}


