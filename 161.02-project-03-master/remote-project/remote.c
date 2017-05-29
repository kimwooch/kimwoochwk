#include <stdio.h>
#include <commands.h>
#include <string.h>
#include <stdlib.h>
#include <assert.h>
#include <MyroC.h>
#include <unistd.h>

//-------------------------------------------------------------------------------------------------

/* FOR DEBUGGING & UNDERSTANDING HOW IT WORKS */

//enabling below option allows for printf-based program progress tracking. Cool right?

#define SHOW_HIDDEN_TEXT 0 //0 = disabled, 1 = enabled

//-------------------------------------------------------------------------------------------------

//cuts user input into tokens by looking for space characters
void makeTokens(char *buffer, char token[3][10])
{
  //pointer to processed tokens
  char *ptoken;

  //string containing delimiter character
  char d[2] = " "; 

  if (SHOW_HIDDEN_TEXT == 1)
  {
    printf("Splitting string \"%s\" into tokens:\n", buffer);
  }
  
  ptoken = strtok (buffer, d);

  if (SHOW_HIDDEN_TEXT == 1)
  {
    printf("ptoken = %s\n", ptoken);
  }
  
  //token counter
  int i = 0;

  //copies tokens until pd is set to null by strtok
  while (ptoken != NULL)
  {
    strcpy(token[i], ptoken);
    
    if (SHOW_HIDDEN_TEXT == 1)
    {
      printf("Token[%d] = %s\n", i, token[i]);
    }
    
    ptoken = strtok (NULL, d);

    if (SHOW_HIDDEN_TEXT == 1)
    {
      printf("ptoken = %s\n", ptoken);
    }
    
    i++;
  }
}

//gets user input
void getBuffer(char *buffer)
{
  fgets(buffer, 20, stdin);

  //remove '\' and 'n' end characters
  buffer[strcspn(buffer, "\n")] = 0;

  if (SHOW_HIDDEN_TEXT == 1)
  {
    printf("String Entered: \"%s\"\n", buffer);
  }
}

void commandSelector(char *token0, char *token1, char *token2)
{
  //list of commands accepted for reference by strcmp

  //UTILITY
  char aQuit[] = "quit";
  char aHelp[] = "help";

  //NON-PARAMETERIZED
  char aMarch[] = "march";
  char aLeft[] = "left";
  char aRight[] = "right";
  char aZigZag[] = "zigzag";
  char aLight[] = "light";

  //PARAMETERIZED
  char aBeep[] = "beep";
  char aForward[] = "forward";
  char aBackward[] = "backward";
  char aSquare[] = "square";
  char aSpiral[] = "spiral";

  //store token[1] and token[2] values once converted to int or double
  int paramInt = 0;
  double paramDoub = 0;
  
  //compares token[0] to possible command strings and if match is found, executes a command.
  //If no valid command/parameter found, it throws an error.
  if (strcmp(token0, aQuit) == 0)
  {
    quit();
  }
  else if (strcmp(token0, aHelp) == 0)
  {
    help();
  }
  else if (strcmp(token0, aMarch) == 0)
  {
    march();
  }
  else if(strcmp(token0, aLeft) == 0)
  {
    left();
  }
  else if(strcmp(token0, aRight) == 0)
  {
    right();
  }
  else if(strcmp(token0, aZigZag) == 0)
  {
    zigZag();
  }
  else if(strcmp(token0, aLight) == 0)
  {
    light();
  }
  else if (strcmp(token0, aBeep) == 0)
  {
    if (sscanf(token1, "%lf", &paramDoub) != 1)
    {
      printf("TIME PARAMETER INVALID - TRY AGAIN\n");
    }
    else if (sscanf(token2, "%d", &paramInt) != 1)
    {
      printf("PITCH PARAMETER INVALID - TRY AGAIN\n");
    }
    else
    {
      beep(paramDoub, paramInt);
    }
  }
  else if (strcmp(token0, aForward) == 0)
  {
    if (sscanf(token1, "%lf", &paramDoub) != 1)
    {
      printf("TIME PARAMETER INVALID - TRY AGAIN\n");
    }
    else
    {
      forward(paramDoub);
    }
  }
  else if (strcmp(token0, aBackward) == 0)
  {
    if (sscanf(token1, "%lf", &paramDoub) != 1)
    {
      printf("TIME PARAMETER INVALID - TRY AGAIN\n");
    }
    else
    {
      backward(paramDoub);
    }
  }
  else if (strcmp(token0, aSquare) == 0)
  {
    if (sscanf(token1, "%lf", &paramDoub) != 1)
    {
      printf("SIZE PARAMETER INVALID - TRY AGAIN\n");
    }
    else
    {
      square(paramDoub, token2);
    }
  }
  else if (strcmp(token0, aSpiral) == 0)
  {
    if (sscanf(token1, "%lf", &paramDoub) != 1)
    {
      printf("SIZE PARAMETER INVALID - TRY AGAIN\n");
    }
    else
    {
      spiral(paramDoub, token2);
    }
  }
  else
  {
    printf("ERROR: UNKNOWN COMMAND - TRY AGAIN\n");
  }
}

void commandPrompt(void)
{
  printf("\nPlease ensure Sribbler is ON and batteries are CHARGED\n\n");
  
  printf("-------------------------------------------------------------------------------------\n\n");

  printf("Here's some fun info on your robot:\n\n");

  printf("(it might take a few seconds to display)\n\n");

  //connect to scribbler robot
  rConnect("/dev/rfcomm0");
  
  printf("\n-------------------------------------------------------------------------------------\n\n");
  
  printf("\nWelcome to...\n\n");


  printf("   _____              _  __     __     __  \n");         
  printf("  / ___/ _____ _____ (_)/ /_   / /_   / /___   _____\n");
  printf("  \\__ \\ / ___// ___// // __ \\ / __ \\ / // _ \\ / ___/\n");
  printf(" ___/ // /__ / /   / // /_/ // /_/ // //  __// /    \n"); 
  printf("/____/ \\___//_/   /_//_.___//_.___//_/ \\___//_/     \n");
  printf("    ____                           __               \n");
  printf("   / __ \\ ___   ____ ___   ____   / /_ ___\n");         
  printf("  / /_/ // _ \\ / __ `__ \\ / __ \\ / __// _ \\\n");        
  printf(" / _, _//  __// / / / / // /_/ // /_ /  __/    \n");     
  printf("/_/ |_| \\___//_/ /_/ /_/ \\____/ \\__/ \\___/  \n\n\n");        
                                                   

  printf("By: Alec Monovich [monovich] & Kevin Kim [kimwooch]\n\n");
  
  printf("Instructions:\n");
  printf("-------------------------------------------------------------------------------------\n");
  printf("1. Type a command string (with optional parameters seperated by spaces).\n");
  printf("2. Press enter.\n\n");
  printf("For a full list of commands and parameters, use the 'help' command.\n\n");

  char buffer[20];
  char token[3][10];

  //infinite loop
  int i = 0;
  while (i == 0)
  {
    printf("Please enter a valid command string: ");

    //gets user input
    getBuffer(buffer);
    
    //splits user input into tokens
    makeTokens(buffer, token);

    //converts user input into executed command
    commandSelector(token[0], token[1], token[2]);

    //flushes previous user input (if any)
    fflush(stdin);
  }

  printf("If you see this, something is wrong...\n");
  
  return;
}

int main(void)
{
  //starts remote command prompt
  commandPrompt();

  //cleans up robot and closes bluetooth connection
  rDisconnect();
  
  return 0;
}
