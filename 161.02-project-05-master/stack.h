#ifndef _STACK_H_
#define _STACK_H_

/**
 * file: stack.h
 *
 * authors:
 *   - Titus Klinge
 *   - Peter-Michael Osera
 *   - CSC 161.02 Spring 2017 class
 */

#include <stdbool.h>
#include "list.h"

typedef struct stack
{
  list_t* list;
}stack_t;

// +--------------+---------------------------------------------------
// | Constructors |
// +--------------+

/**
 * Constructs an empty stack on the heap and returns a pointer to it.
 */
stack_t *make_stack(void);

// +-------------+----------------------------------------------------
// | Destructors |
// +-------------+

/*
 * Frees all the meory of the stack
 */
void free_stack(stack_t *s);


// +------------+-----------------------------------------------------
// | Operations |
// +------------+

/**
 * Pushes a new value to the top of the stack
 */
void push(stack_t *s, int value);

/**
 * Returns the number of elements stored in the stack.
 */
int size_stack(stack_t *s);

/**
 * Pops off the top element of the stack.
 * 
 * Returns whether the pop was successful.
 */
bool pop(stack_t *s);

/**
 * Peeks at the element at the top of the stack. The stack
 * is not changed by this call.
 */
int peek_stack(stack_t *s);

/*
 * Prints the contents of s to stdout. The format
 * of the stack is [4,5,7] where 4 is the top of
 * the stack.
 */
void print_stack(stack_t *s);

#endif

