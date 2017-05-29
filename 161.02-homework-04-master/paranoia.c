#include <stdio.h>
#include <stdlib.h>
#include "plist.h"
#include <stdbool.h>
#include <string.h>

int main(){
  //make a list for targetPlayers and taggedPlayers
  plist_t *targetPlayers = make_list();
  plist_t *taggedPlayers = make_list();
  char nameString[21];
  
  printf("Enter a player's name (press enter to begin game) :");
  readline(nameString, 20);
  //repeatedly prompt the user for names and stops prompting when the user enters in a blank line.
  while(nameString[0]!='\0'){
    list_insert(targetPlayers, stralloc(nameString));
    printf("Enter another player's name :");
    readline(nameString, 20);
  }
  //updates target ring and tagged list
  printAsTargetRing(targetPlayers);
  printAsTaggedList(taggedPlayers);

  while(list_size(targetPlayers)>1){
    char targetName[21];
    printf("\nThere are %d people left!\n", list_size(targetPlayers));
    printf("Enter a target: ");
    readline(targetName, 20);
    //if the user input is not in target list then make the user enter a different input.
    if(!list_remove(targetPlayers, stralloc(targetName))){
      printf("%s is not a target!\n", stralloc(targetName));
    }else{
      //insert the tagged name into a tagged list and remove the name from the target list
      printf("%s was tagged!\n", stralloc(targetName));
      list_insert(taggedPlayers, stralloc(targetName));
      list_remove(targetPlayers, stralloc(targetName));
    }
    //updates target ring and tagged list  
    printAsTargetRing(targetPlayers);
    printAsTaggedList(taggedPlayers);
  }
  //frees both target and tagged list.
  free_list(targetPlayers);
  free_list(taggedPlayers);

  return 0;
}
