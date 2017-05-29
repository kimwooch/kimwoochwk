# CSC 161.02 Project 03: Scribbler Remote

This is the repository for the fourth project of the spring 2017 semester of CSC 161 section 02. You can find the specifics of the project on the [course website](http://www.cs.grinnell.edu/~klingeti/courses/s2017/csc161/homeworks/05-scribbler-remote.html).

## Project Information
- Alec Monovich [monovich@grinnell.edu]
- Kevin Kim [kimwooch@grinnell.edu]

## Project Overview
In this project, we created a program to act as a remote control for the scribbler robot, featuring an easy to use UI and command
prompt. We have included 10 commands (5 with parameters), as well as two utility commands.

### List of Commands
UTILITY COMMANDS

'help'   - shows you this list!

'quit'   - exits the program.

NON-PARAMETERIZED COMMANDS

'march'  - makes the robot play John Williams' Imperial March

'left'   - makes the robot turn 90 degrees to the left

'right'  - makes the robot turn 90 degrees to the right

'zigzag' - makes the robot move forward in a zig-zag pattern for ~10 seconds

'light'  - makes the robot detect the current light level and then return an
           integer value between 0 (bright) and 65535 (dark)

PARAMETERIZED COMMANDS

'beep' (time) (pitch)  - makes robot beep at (pitch) in Hz, a an int, for (time) in
                         seconds, a double

'forward' (time)       - makes robot move forward for (time) in seconds, a double

'backward' (time)      - makes robot move backward for (time) in seconds, a double

'square' (size) (turn) - makes the robot move in a square scaled by a factor of
                         (size), a positive double, where 1 is the default size,
                         taking only left or right turns as determined by (turn), a
                         string

'spiral' (size) (turn) - makes the robot move in a spiral scaled by a factor of
                         (size), a positive double, where 1 is the default size,
                         taking only left or right turns as determined by (turn), a
                         string

## Citations
- Titus Klinge: http://www.cs.grinnell.edu/~klingeti/courses/s2017/csc161/homeworks/05-scribbler-remote.html = example implementations used to design our Makefile
- Alec Monovich: https://github.com/alexandercmonovich/161.02-project-01 = code for scribbler to trace a zig zag, used here for the 'zigzag' command
- Alec Monovich: https://github.com/alexandercmonovich/161.02-project-00 = code for scribbler to play Imperial march, used here for the 'march' command
- Patrick Gillespie: http://patorjk.com = for the very cool SCRIBBLER REMOTE ASCII title text
- cplusplus.com: http://www.cplusplus.com/reference/cstring/strtok/ = used their example implementation of strtok to design the method for creating our tokens
