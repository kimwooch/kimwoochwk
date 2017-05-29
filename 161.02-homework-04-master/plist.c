#include <stdio.h>
#include <stdlib.h>
#include "plist.h"
#include <stdbool.h>
#include <string.h>

pnode_t* make_node(char *name, pnode_t *next){
  pnode_t *ret = (pnode_t *) malloc(sizeof(pnode_t));
  ret->name = name;
  ret->next = next;
  return ret;
}

plist_t* make_list(void){
  plist_t *lst = (plist_t*) malloc(sizeof(plist_t));
  lst->first = NULL;
  return lst;
}

void free_node(pnode_t *node){
  free(node->name);
    free(node);
}

void free_list (plist_t *list){
  free_node(list->first);
  free(list);
}

void list_insert(plist_t *list, char *name){
  pnode_t *n = make_node(name, NULL);
  if(list->first == NULL){
    list->first = n;
  }else {
    pnode_t *cur = list->first;
    while(cur->next != NULL){
      cur = cur->next;
    }
    cur->next = n;
  }
}

bool list_remove(plist_t *list, char *name)
{
  pnode_t * temp;
  pnode_t * cur = list->first;
  //if two strings are the same, then remove the first element.
 if (strcmp(cur->name, name) == 0)
  {
      temp = cur;
      list->first = cur->next;
      free(temp);
      return true;
  }
  else
  {
    //if the list is not empty and two strings are the same then remove the elements that are in the middle.
     if (cur != NULL)
     {
      while (strcmp(cur->name, name) != 0)
      {
        if (cur->next == NULL)
        {
          return false;
        }
        temp = cur;
        cur = cur->next;
      }
      temp->next = temp->next->next;
      free_node(cur);
      return true;
    }
    return false;
    }
}

int list_size(plist_t *list){
  int sz = 0;
  pnode_t *n = list->first;
  while(n != NULL){
    sz++;
    n = n->next;
  }
  return sz;
}

void printAsTargetRing(plist_t *list){
  if(list->first == NULL){
    printf("There are no targets left!\n");
  }else if (list->first->next == NULL){
    printf("%s is the final person remaining!\n", list->first->name);
  }else{
    printf("Target Ring:\n");
    pnode_t *cur = list->first;
    while(cur->next!=NULL){
      printf("\t%s is stalking %s\n", cur->name, cur->next->name);
      cur= cur->next;
    }
    printf("\t%s is stalking %s\n",cur->name, cur->name);
  }
}

void printAsTaggedList(plist_t *list){
  if(list->first != NULL){
    printf("Tagged List: \n");
    pnode_t *tl = list->first;
    while(tl!= NULL){
      printf("\t%s\n", tl->name);
      tl = tl->next;
    }
  }else{
    printf("No people have been tagged yet!\n");
  }
}

char* stralloc(char *str){
  int sz = 0;
  while(str[sz]!= '\0'){
    sz++;
  }
  char* cpy = (char*)malloc(sz*sizeof(char));
  for(int i = 0; i < sz; i ++){
    cpy[i] = str[i];
  }
  return cpy;
}

void readline(char *buf, int k){
  int count = 0;
  char input = getchar();
  while (count<k && input!= '\n'){
      buf[count] = input;
      input= getchar();
      count++;
    }
    buf[count] = '\0';
    while(input != '\n'){
    input = getchar();
  }
}

