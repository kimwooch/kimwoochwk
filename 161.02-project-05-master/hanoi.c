#include <stdio.h>
#include <stdlib.h>
#include "stack.h"
#include "list.h"
#include <string.h>


// the structure of tower:

typedef struct tower
{
  stack_t* stack;
}tower_t;


// Construct a new tower on the heap:

tower_t *make_tower(void)
{
  tower_t *t = (tower_t*) malloc(sizeof(tower_t));
  t->stack = make_stack();
  return t;
}

// Frees the memory of a tower:

void free_tower(tower_t *t)
{
  free_stack(t->stack);
  free(t);
}

// structure for hanoi, which consists of three towers
// and the count of the move:

typedef struct hanoi{
  tower_t *one;
  tower_t *two;
  tower_t *three;
  int move;
}hanoi_t;

// Construct a new hanoi on the heap:

hanoi_t *make_hanoi(void)
{
  hanoi_t *h = (hanoi_t*) malloc(sizeof(hanoi_t));
  h->one = make_tower();
  h->two = make_tower();
  h->three = make_tower();
  
  // make the first tower a complete tower:
  for (int i = 5; i >= 1; i--){
    push(h->one->stack, i);
  }
  h->move = 0;
  return h;
}

// Frees the memory of a hanoi:

void free_hanoi(hanoi_t *h)
{
  free_tower(h->one);
  free_tower(h->two);
  free_tower(h->three);
  free(h);
}

// returns true if there is a valid move from the source
// tower to the destination tower according to the rules of
// the Tower of Hanoi:

bool has_valid_move(tower_t *src, tower_t *dest)
{
  if (size_stack(src->stack) == 0){
    return false;
  }else if(size_stack(dest->stack) == 0){
    return true;
  }else
    {
      int src_top = peek_stack(src->stack);
      int dest_top = peek_stack(dest->stack);
      if (src_top < dest_top){
        return true;
      }else{
        return false;
      }
    }
}

// move a disk from a source tower to the destination tower:

void move_disk(tower_t *src, tower_t *dest)
{
  if (has_valid_move(src, dest)){
    int element = peek_stack(src->stack);
    pop(src->stack);
    push(dest->stack, element);
  }
}

// determine whether the tower is complete:

bool is_complete_tower(tower_t *src)
{
  if (size_stack(src->stack) == 5){
    return true;
  }else{
    return false;
  }
}


// renders a disk to the console:

void print_disk(int disk)
{
  for (int i = 0; i < (5 - disk); i++)
    {
      printf(" ");
    }
  for (int i = 0; i < disk; i++){
    printf("-");
  }
  printf("|");
  for (int i = 0; i < disk; i++){
    printf("-");
  }
  printf("\n");
}

// renders the given tower to the console:

void print_tower(tower_t *tower, int id)
{
  printf("Tower %d:\n", id);
  int sz = size_stack(tower->stack);

  for (int i = 0; i < 5-sz; i++){
    print_disk(0);
  }

  for (int i = 0; i < sz; i++){
    print_disk(get_element_at(tower->stack->list, i));
  }
  printf("===========\n");
}

// renders the entire Towers of Hanoi game state to the console:

void print_hanoi(hanoi_t *game)
{
  printf("Move: %d:\n", game->move);
  print_tower(game->one, 0);
  print_tower(game->two, 1);
  print_tower(game->three, 2);
}


// main function:

int main(void)
{
  hanoi_t *h = make_hanoi();
 
  while(!(is_complete_tower(h->two)) && !(is_complete_tower(h->three))){
    print_hanoi(h);
    int src = 0;
    int des = 0;
    int ch;
    printf("Enter a source tower: ");
    scanf("%d", &src);
    while((ch=getchar())!='\n'&&ch!=EOF);
    printf("Enter a destination tower: ");
    scanf("%d", &des);
    while((ch=getchar())!='\n'&&ch!=EOF);
 
    if(!((src==0||src==1||src==2)&&(des==0||des==1||des==2))) // when the number given is out of range
      {
        printf("Please enter valid tower numbers!\n");
      }else if (src == des){  // when the source given is the same as the destination
      printf("Invalid move! Source and destination cannot be the same!");
    }else {
      tower_t* s;
      tower_t* d;

      // matches the user input with the towers in hanoi
      if (src == 0){
        s = h->one;
      }else if(src == 1){
        s = h->two;
      }else{
        s = h->three;
      }

      if (des == 0){
        d = h->one;
      }else if(des == 1){
        d = h->two;
      }else{
        d = h->three;
      }

      if (has_valid_move(s, d)){
        move_disk(s, d);
        h->move++;
        
      }else{ //when it is not a valid move
        printf("This is not a valid move!\n");
      }
    }
  }
 
  printf("You won in %d moves!\n", h->move);
  print_hanoi(h);

  free_hanoi(h);
  
  return 0;
}

