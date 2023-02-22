#include <stdio.h>

#define SIZE 50

int current[SIZE];
int next[SIZE];

// Initialize the automaton with a single active cell at the center
void initialize() {
    current[SIZE / 2] = 1;
}

// Compute the next state of the automaton using Rule 90
void compute_next() {
    int left, right;

    for (int i = 0; i < SIZE; i++) {
        left = (i == 0) ? current[SIZE - 1] : current[i - 1];
        right = (i == SIZE - 1) ? current[0] : current[i + 1];

        next[i] = !(left == right);
    }
}

// Update the current state of the automaton with the next state
void update_current() {
    for (int i = 0; i < SIZE; i++) {
        current[i] = next[i];
    }
}

// Display the current state of the automaton
void display() {
    for (int i = 0; i < SIZE; i++) {
        printf("%c ", current[i] ? '*' : ' ');
    }
    printf("\n");
}

int main() {
    initialize();

    for (int i = 0; i < 100; i++) {
        compute_next();
        update_current();
        display();
    }

    return 0;
}
