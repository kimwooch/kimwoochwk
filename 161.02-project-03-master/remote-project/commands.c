#include <stdio.h>
#include <MyroC.h>
#include <commands.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>
#include <unistd.h>

/* NOTE */

// For documentation on each command, refer to the commands.h header file
// or you can look at the printed portion of the help command below.

/* MARCH COMPONENTS */

// These components are for the march command

// Key Frequencies

#define Fn6 1397
#define En6 1319
#define Eb6 1245
#define Dn6 1175
#define Db6 1109
#define Cn6 1047
#define Bn5 987
#define Bb5 932
#define An5 880
#define Ab5 831
#define Gn5 784
#define Gb5 740
#define Fn5 698

// Note Durations

#define a2_NOTE 1.0
#define a4_NOTE 0.5
#define a8_NOTE 0.25
#define a16_NOTE 0.125
#define a8_TRP 0.083
#define a8_DOT 0.375

void intro_measure_partA(void)
{
  rBeep(a4_NOTE, An5);
  rBeep(a8_NOTE, An5);
  rBeep(a8_TRP, An5);
  rBeep(a8_TRP, An5);
  rBeep(a8_TRP, An5);
  rBeep(a8_NOTE, An5);
  rBeep(a8_TRP, An5);
  rBeep(a8_TRP, An5);
  rBeep(a8_TRP, An5);
}

void intro_measure_partB(void)
{
  rBeep(a8_TRP, Ab5);
  rBeep(a8_TRP, Ab5);
  rBeep(a8_TRP, Ab5);
  rBeep(a8_NOTE, Ab5);
}

void intro_measure_partC(void)
{
  rBeep(a8_TRP, Bn5);
  rBeep(a8_TRP, Bn5);
  rBeep(a8_TRP, Bn5);
  rBeep(a8_NOTE, Bn5);  
}

void intro_measure_partD(void)
{
  rBeep(a8_TRP, Cn6);
  rBeep(a8_TRP, Cn6);
  rBeep(a8_TRP, Cn6);
  rBeep(a8_NOTE, Cn6);
}

void intro(void)
{
  intro_measure_partA();
  intro_measure_partB();
  intro_measure_partA();
  intro_measure_partB();
  intro_measure_partA();
  intro_measure_partC();
  intro_measure_partA();
  intro_measure_partD();
}

void theme_partA(void)
{
  rBeep(a4_NOTE, An5);
  rBeep(a4_NOTE, An5);
  rBeep(a4_NOTE, An5);
  rBeep(a8_DOT, Fn5);
  rBeep(a16_NOTE, Cn6);

  rBeep(a4_NOTE, An5);
  rBeep(a8_DOT, Fn5);
  rBeep(a16_NOTE, Cn6);
  rBeep(a2_NOTE, An5);

  rBeep(a4_NOTE, En6);
  rBeep(a4_NOTE, En6);
  rBeep(a4_NOTE, En6);
  rBeep(a8_DOT, Fn6);
  rBeep(a16_NOTE, Cn6);

  rBeep(a4_NOTE, Ab5);
  rBeep(a8_DOT, Fn5);
  rBeep(a16_NOTE, Cn6);
  rBeep(a2_NOTE, An5);
}

/* NON-PARAMETERIZED COMMANDS */

void march(void)
{
  intro();
  theme_partA();
}

void left(void)
{
  rTurnLeft(1.0, 0.78);
}

void right(void)
{
  rTurnRight(1.0, 0.78);
}

void zigZag(void)
{
  for (int i = 1; i <= 5; i++)
  {
    rForward (1.0, 0.225);
    rTurnLeft (1.0, 0.78);
    rForward (1.0, 0.225);
    rTurnRight (1.0, 0.78);
  }
}

void light(void)
{
  printf("Current Light Level (lower values indicate more light): %d\n", rGetLightTxt("middle", 5));
}

/* PARAMETERIZED COMMANDS */

void beep(double time, int pitch)
{
  rBeep(time, pitch);
}

void forward(double time)
{
  rForward(1.0, time);
}

void backward(double time)
{
  rBackward(1.0, time);
}

void square(int size, char *turn)
{
  char aLeft[] = "left";
  char aRight[] = "right";
  
  for (int i = 0; i < 4; i++)
    {
      if (strcmp(turn, aLeft) == 0)
      {
	rForward(1.0, 0.75 * size);
	rTurnLeft(1.0, 0.78);
      }
      else if (strcmp(turn, aRight) == 0)
      {
	rForward(1.0, 0.75 * size);
	rTurnRight(1.0, 0.78);
      }
      else
      {
	printf("TURN PARAMETER INVALID - TRY AGAIN\n");
	return;
      }
    } 
}

void spiral(int size, char *turn)
{
  char aLeft[] = "left";
  char aRight[] = "right";

  if (strcmp(turn, aLeft) == 0)
  {
    rMotors(1.0, 0.4 * size);
    sleep(20 * size);
    rStop();
  }
  else if (strcmp(turn, aRight) == 0)
  {
    rMotors(0.4 * size, 1.0);
    sleep(20 * size);
    rStop();
  }
  else
  {
    printf("TURN PARAMETER INVALID - TRY AGAIN\n");
    return;
  }
}

//UTILITY COMMANDS

void quit(void)
{
  exit(1);
}

void help(void)
{
  printf("\nHelp Menu:\n");
  printf("-------------------------------------------------------------------------------------\n");
  printf("All available commands are listed below. Commands are listed surrounded by\n");
  printf("'apostrophes' and their parameters are listed after surrounded by (parens).\n\n");
  
  printf("For reference, here are two valid example command line entries:\n\n");
  
  printf("square 2 left\n\n");
  
  printf("beep 2.0 1000\n\n");
  
  printf("-------------------------------------------------------------------------------------\n");
  printf("UTILITY COMMANDS\n\n");
  
  printf("'help'   - shows you this list!\n\n");
  
  printf("'quit'   - exits the program.\n\n");
  
  printf("NON-PARAMETERIZED COMMANDS\n\n");
  
  printf("'march'  - makes the robot play John Williams' Imperial March\n\n");
  
  printf("'left'   - makes the robot turn 90 degrees to the left\n\n");
  
  printf("'right'  - makes the robot turn 90 degrees to the right\n\n");
  
  printf("'zigzag' - makes the robot move forward in a zig-zag pattern for ~10 seconds\n\n");
  
  printf("'light'  - makes the robot detect the current light level and then return an\n");
  printf("           integer value between 0 (bright) and 65535 (dark)\n\n");
  
  printf("PARAMETERIZED COMMANDS\n\n");
  
  printf("'beep' (time) (pitch)  - makes robot beep at (pitch) in Hz, a an int, for (time) in\n");
  printf("                         seconds, a double\n\n");
  
  printf("'forward' (time)       - makes robot move forward for (time) in seconds, a double\n\n");
  
  printf("'backward' (time)      - makes robot move backward for (time) in seconds, a double\n\n");

  printf("'square' (size) (turn) - makes the robot move in a square scaled by a factor of\n");
  printf("                         (size), a positive double, where 1 is the default size,\n");
  printf("                         taking only left or right turns as determined by (turn), a\n"); 
  printf("                         string\n\n");
  
  printf("'spiral' (size) (turn) - makes the robot move in a spiral scaled by a factor of\n");
  printf("                         (size), a positive double, where 1 is the default size,\n");
  printf("                         taking only left or right turns as determined by (turn), a\n");
  printf("                         string\n\n");
}
