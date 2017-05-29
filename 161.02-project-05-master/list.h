#ifndef _LINKED_LIST_H_
#define _LINKED_LIST_H_

/**
 * file: linkedlist.h
 *
 * authors:
 *   - Titus Klinge
 *   - Peter-Michael Osera
 *   - CSC 161.02 Spring 2017 class
 */

#include <stdbool.h>


// +------------+---------------------------------------------------
// | Structures |
// +------------+

/*
 * Structure for each of the nodes in the list
 */
typedef struct node
{
    int value;
    struct node *next;
} node_t;

/*
 * Structure for the list
 */

typedef struct list
{
node_t *first;
}list_t;

// +--------------+---------------------------------------------------
// | Constructors |
// +--------------+

/**
 * Constructs an empty list on the heap and returns a pointer to it.
 */
list_t *make_list(void);

// +-------------+----------------------------------------------------
// | Destructors |
// +-------------+

/*
 * Frees all the meory of the list including all the nodes.
 */
void free_list(list_t *lst);


// +------------+-----------------------------------------------------
// | Operations |
// +------------+

/**
 * Inserts a new value at the beginning of the list.
 */
void insert_front(list_t *lst, int value);

/**
 * Returns the number of elements stored in the list.
 */
int size(list_t *lst);

/**
 * Deletes the element in lst at the index. For example, if
 * lst = [4,5,7] and index = 1, then the result is the list [4,7].
 *
 * Returns whether the deletion was successful.
 *
 * pre: 0 <= index < size(lst)
 */
bool delete_at(list_t *lst, int index);

/**
 * Deletes the first element in lst. For example, if
 * lst = [4,5,7], then the result is the list [5,7].
 *
 * Returns whether the deletion was successful.
 */
bool delete_front(list_t *lst);

/**
 * Deletes the last element in lst. For example, if
 * lst = [4,5,7], then the result is the list [4,5].
 *
 * Returns whether the deletion was successful.
 */
bool delete_last(list_t* lst);

/**
 * Gets the element in lst at the index. For example, if
 * lst = [17,9,4] and index = 2, then the result is 4.
 *
 * Returns 0 if the index is out of bounds.
 *
 * pre: 0 <= index < size(lst)
 */
int get_element_at(list_t *lst, int index);

/*
 * Prints the contents of lst to stdout. The format
 * of the list is [4,5,7]. The empty list is [].
 */
void print_list(list_t *lst);

#endif
