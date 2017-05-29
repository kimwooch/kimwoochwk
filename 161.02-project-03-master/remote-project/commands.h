#pragma once

//NON-PARAMETERIZED COMMANDS

void march(void); //makes the robot play John Williams' Imperial March

void left(void); //makes the robot turn 90 degrees to the left

void right(void); //makes the robot turn 90 degrees to the right

void zigZag(void); //makes the robot move forward in a zigzag for 10 seconds

void light(void); //makes the robot detect the current light level and then return an
                  //integer value between 0 (bright) and 65535 (dark)\n\n");

//PARAMETERIZED COMMANDS

void beep(double time, int pitch); //makes robot beep at (pitch) in Hz, a an int, for (time) in
                                   //seconds, a double

void forward(double time); //makes robot move forward for (time) in seconds, a double

void backward(double time); //makes robot move backward for (time) in seconds, a double

void square(int size, char *turn); //makes the robot move in a square scaled by a factor of
                                   //(size), a positive double, where 1 is the default size,
                                   //taking only left or right turns as determined by (turn), a
                                   //string

void spiral(int size, char *turn); //makes the robot move in a spiral scaled by a factor of
                                   //(size), a positive double, where 1 is the default size,
                                   //taking only left or right turns as determined by (turn), a
                                   //string

//UTILITY COMMANDS

void quit(void); //exits the program

void help(void); //shows you a complete list of commands with their usage and parameters
