#include <stdlib.h>
#include <MyroC.h>
#include <math.h>

void circleSelect(Picture *pic, int radius, int x, int y){
  for(int i = y - radius; i < y + radius; i++){
    for(int j = x - radius; j < x + radius; j++){
      double circle  =  (j - x) * (j - x) +  (i - y) * (i - y);
      if(circle  < radius*radius){
         //Point is inside circle
         //calculates greyscale and stores as int value
         int greyscale = (pic->pix_array[i][j].R * 0.30 + pic->pix_array[i][j].G
                          * 0.59 + pic->pix_array[i][j].B * 0.11);
         //assigns greyscale value to the pixel.
         pic->pix_array[i][j].R = greyscale;
         pic->pix_array[i][j].G = greyscale;
         pic->pix_array[i][j].B = greyscale;
      }  
    }
  }
}

void tornEdges(Picture *pic){
  int greyscales[256];
  int count = 0;
  int median = 0;
  int imageSize = pic->width * pic->height;
  //sets every element of greyscales to 0
  for (int i = 0; i < 256; i++){
    greyscales[i] = 0;
  }
  //increments 1 in an array size of 256, according to the pixel's greyscale value
  for(int i = 0; i < pic->height; i++){
    for(int j = 0; j < pic->width; j++){
      int greys = (pic->pix_array[i][j].R * 0.30 + pic->pix_array[i][j].G * 0.59 + pic->pix_array[i][j].B * 0.11); 
      greyscales[greys] += 1; 
    }                 
  }
  //finds the median value of greyscale values of each pixels in an image
  while (count < imageSize/2){
    count += greyscales[median];
    median++;
  }
  //assigns 255 to each color components if grayscale value is less than median and 0 to each color components if greyscale value is greater than median.
  for(int i = 0; i < pic->height; i++){
    for(int j = 0; j < pic->width; j++){
      int tempGray = (pic->pix_array[i][j].R * 0.30 + pic->pix_array[i][j].G * 0.59 + pic->pix_array[i][j].B * 0.11); 
      if (tempGray >= median){
        Pixel black = {0,0,0};
        pic->pix_array[i][j] = black;
      }else{
        Pixel white = {255,255,255};
        pic->pix_array[i][j] = white;
      }
    }
  }
  
}

void split(Picture *pic){
  int height = pic->height;
  int width = pic->width;
  int newR = 0;
  int newG = 0;
  int newB = 0;
  for(int i = 0; i < height; i++){
    for(int j = 0; j < width; j++){
       if(i < (height/3)){
         //sets red component of the pixel as width value on the top third of the picture and -2 to the other components of pixel to make them darker
         newR =  j;
         newG =  pic->pix_array[i][j].G-2 ;
         newB =  pic->pix_array[i][j].B-2 ;
       }else if(i > (height/3) && i < (2*(height/3))){
         //sets green component of the pixel as width value on the second third of the picture and -2 to the other components of pixel to make them darker
         newR = pic->pix_array[i][j].R-2 ;
         newG = j ;
         newB = pic->pix_array[i][j].B-2 ;
       }else{
        //sets blue component of the pixel as width value on the last section of the picture and -2 to the other components of pixel to make them darker
        newR = pic->pix_array[i][j].R-2;
        newG = pic->pix_array[i][j].B-2;
        newB = j;  
       }
       //sets changed pixel value to the original pixel value
       Pixel newpixel = {newR, newG, newB};
       pic->pix_array[i][j] = newpixel;
     }
   }
 }

int main(){
  //connects the robot
  rConnect("/dev/rfcomm0");
  
  //takes a picture1 from MyroC robot
  Picture pic1 = rTakePicture();
  //displays a picture from MyroC robot 
  rDisplayPicture(&pic1, 5, "Picture 1");
  //turns each pixel within that circle to its corresponding grayscale value
  circleSelect(&pic1, 50, 100, 100);
  //displays the transformed picture from circleSelect
  rDisplayPicture(&pic1, 5, "Picture 2");

  //takes a picture3 from MyroC robot
  Picture pic3 = rTakePicture();
  //displays a picture from MyroC robot
  rDisplayPicture(&pic3, 5, "Picture 3");
  //applies a torn edges effect to the image.
  tornEdges(&pic3);
  //displays the transformed picture from tornEdges
  rDisplayPicture(&pic3, 5, "Picture 4");
  
  //takes a picture5 from MyroC robot 
  Picture pic5 = rTakePicture();
  //displays a picture from MyroC robot
  rDisplayPicture(&pic5, 5, "Picture 5");
  //applies a split effect to the image
  split(&pic5);
  //displays the transformed picture from split
  rDisplayPicture(&pic5, 5, "Picture 6");

  //disconnects the robot
  rDisconnect();
  return 0;
  
}
