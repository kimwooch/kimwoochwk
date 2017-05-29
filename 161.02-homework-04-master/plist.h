#ifndef plist_h
#define plist_h
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

//a node
typedef struct node{
  char *name;
  struct node *next;
} pnode_t;

//a list of nodes
typedef struct {
  pnode_t *first;
} plist_t;

// make_node: allocate space for a node on the heap and return its pointer
pnode_t* make_node(char *name, pnode_t *next);

// make_list: allocate space for a list on the heap and return its pointer
plist_t* make_list();

// free_node: frees the indicated node
void free_node(pnode_t *node);

// free_list: frees the indicated list
void free_list(plist_t *list);

// list_insert: append the given name to the end of the given list
void list_insert(plist_t *list, char *name);

// list_remove: finds and removes the given value from the list
bool list_remove(plist_t *list, char *name);

// list_size: returns the number of elements in the list
int list_size(plist_t *list);

// printAsTargetRing: prints the given list, interpreted as a paranoia target ring
void printAsTargetRing(plist_t *list);

// printAsTaggedList: prints the given list, interpreted as a paranoia tagged list
void printAsTaggedList(plist_t *list);

//reads a line of input from the user, storing the first k characters of the input into a char array assumed to be of size k+1. The function also stores a \0 into the index after the end of the stored characters. Finally, the function also flushes the buffer of remaining characters if the user enters in more than k characters
void readline(char *buf, int k);

//given a string, allocates a copy of the string on the heap and returns a pointer to it
char* stralloc(char *str);


#endif /* plist_h */
