# CSC 161.02 Project 04: Image Suite

This is the repository for the fifth project of the spring 2017 semester of CSC 161 section 02. You can find the specifics of the project on the [course website](http://www.cs.grinnell.edu/~klingeti/courses/s2017/csc161/homeworks/05-image-suite.html).

## Project Information
[Woochul Kim] kimwooch@grinnell.edu
[Giani Chavez] chavezgi@grinnell.edu

## Project Overview

Our projects have three filters circleSelect, tornEdges, and split.
circleSelect changes each pixel within the circle given the origin and radius to its corresponding grayscale value.
tornEdges takes a pointer to a Picture and applies a torn edges effect which is turning the pixel color to white if the greyscale value of the pixel is less than its median grayscale value gathered from all the pixels in the picture and black if it is greater than or equal to it.
Our custom filter "split" seeks to split the image into 3 parts from top to bottom, separating the sections into thirds. Our intention was to create a display of changing values as they move from left to rigth and from top to bottom. So for example, for the top third of the image, the red component grows as you move through the pixels by the variable'j', where j is incremented by 1 as it moves through the loop, and the green and blue components get darker by decrementing the values by 2. Then it reaches the second third of the image and the blue component grows as the other two components are decremented by 2. Finally in the third image, the green component is incremented as well and the blue and red components are decremented. We set this up using a nested for-loop consisting of two loops. The outer loop was for the columns of and the inner loop accounts for the rows. We set up if statements that change the values of the RGB components differently  for the top, the middle and bottom of the image. Then we set the values of each RGB component to a pixel and save that new pixel back into the original image.





## Citations
https://en.wikipedia.org/wiki/Bucket_sort
http://www.cs.grinnell.edu/~klingeti/courses/s2017/csc161/labs/13-image-processing.html
http://www.cs.grinnell.edu/~klingeti/courses/s2017/csc161/homeworks/05-image-suite.html
