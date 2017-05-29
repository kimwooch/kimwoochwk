#include <stdbool.h>
#include <stdlib.h>
#include "list.h"
#include "stack.h"


// +--------------+---------------------------------------------------
// | Constructors |
// +--------------+

/**
 * Constructs an empty stack on the heap and returns a pointer to it.
 */
stack_t *make_stack(void)
{
    stack_t *s = (stack_t*) malloc(sizeof(stack_t));
    s->list = make_list();
	return s;
}

// +-------------+----------------------------------------------------
// | Destructors |
// +-------------+

/*
 * Frees all the meory of the stack
 */
void free_stack(stack_t *s)
{
    free_list(s->list);
    free(s);
}



// +------------+-----------------------------------------------------
// | Operations |
// +------------+

/**
 * Pushes a new value to the top of the stack
 */
void push(stack_t *s, int value)
{
    insert_front(s->list, value);
}

/**
 * Returns the number of elements stored in the stack.
 */
int size_stack(stack_t *s)
{
    return size(s->list);
}

/**
 * Pops off the top element of the stack.
 * 
 * Returns whether the pop was successful.
 */
bool pop(stack_t *s)
{
    return delete_at(s->list, 0);
}

/**
 * Peeks at the element at the top of the stack. The stack
 * is not changed by this call.
 */
int peek_stack(stack_t *s)
{
    // return s->list->first->value;
    return get_element_at(s->list, 0);
}

/*
 * Prints the contents of s to stdout. The format
 * of the stack is [4,5,7] where 4 is the top of
 * the stack.
 */
void print_stack(stack_t *s)
{
    print_list(s->list);
}

