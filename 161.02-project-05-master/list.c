/**
 * file: linkedlist.c
 *
 * authors:
 *   - Titus Klinge
 *   - Peter-Michael Osera
 *   - CSC 161.02 Spring 2017 class
 */

#include "list.h"
#include <stdio.h>
#include <stdlib.h>


// +--------------+---------------------------------------------------
// | Constructors |
// +--------------+

node_t *make_node(int value, node_t *next)
{
    node_t *ret = (node_t *) malloc(sizeof(node_t));

    ret->value = value;
    ret->next = next;

    return ret;
}

list_t *make_list(void)
{
    list_t *lst = (list_t*) malloc(sizeof(list_t));
    lst->first = NULL;
    return lst;
}

// +-------------+----------------------------------------------------
// | Destructors |
// +-------------+

void free_node(node_t *n)
{
    free(n);
}

void free_list(list_t *lst)
{
    node_t *temp = lst->first;
    while (temp != NULL)
    {
        node_t *next = temp->next;
        free_node(temp);
        temp = next;
    }
    free(lst);
}


// +------------+-----------------------------------------------------
// | Operations |
// +------------+

void insert_front(list_t *lst, int value)
{
    node_t *new_node = make_node(value, lst->first);
    lst->first = new_node;
}

int size(list_t *lst)
{
    int sz = 0;
    node_t *n = lst->first;
    while (n != NULL)
    {
        sz++;
        n = n->next;
    }
    return sz;
}

bool delete_at(list_t *lst, int index)
{
    // Check preconditions
    if (size(lst) <= index || index < 0)
    {
        return false;
    }

    // Special case of removing the first element
    if (index == 0)
    {
        node_t *temp = lst->first;
        lst->first = lst->first->next;
        free(temp);
    }
    else // removing an element in the middle
    {
        // Find the node right before the one
        // we want to remove
        node_t *cur = lst->first;
        for (int i = 0; i < index - 1; i++)
        {
            cur = cur->next;
        }

        node_t *temp = cur->next;
        cur->next = cur->next->next;
        free(temp);
    }

    return true;
}

bool delete_front(list_t *lst)
{
    return delete_at(lst, 0);
}

bool delete_last(list_t* lst)
{
    return delete_at(lst, size(lst)-1);
}

int get_element_at(list_t *lst, int index)
{
    // Check preconditions
    if (index < 0 || index >= size(lst))
    {
        return 0;
    }

    node_t* cur = lst->first;
    for (int i = 0; i < index; i++)
    {
        cur = cur->next;
    }

    return cur->value;
}

void print_list(list_t *lst)
{
    printf("[");

    node_t *cur = lst->first;

    // print first element
    if (cur != NULL)
    {
        printf("%d", cur->value);
        cur = cur->next;
    }

    // print the rest of the elements
    while (cur != NULL)
    {
        printf(",%d", cur->value);
        cur = cur->next;
    }

    printf("]\n");
}

