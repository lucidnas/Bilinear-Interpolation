/**
Program: Bilinear Image Interpolation
Author: Abdulnasir Mohammed
Class: Computer Graphics
Date: 04/8/15
Credits: http://tech-algorithm.com/articles/bilinear-image-scaling/
**/

PImage original;// original image to be interpolated
PImage scaled;// new image variable that stores the interpolated image
float ratioX;// ratio of the scaled image to the original image on the width
float ratioY;// ratio of the scaled image to the original image on the height


//Usual setup of processing programs. Here the size of the program
//is set to 500 x 500 but it could be anything.
//original image is then loaded and displayed in our program.
void setup()
{
  size(500,480);
  original = loadImage("squirrel.jpg");
  image(original, 0,0);
}

//The control section of our program. 
void draw()
{

//Here the original image is stored into
//the image variable "scaled" and the variable "scaled" is then stored back into 
//the original image to dereference the original image from "squirrel.jpg"
  scaled = original;
  original = scaled;
  
  //This allows the program to scale the image up by a ratio of 0.9. I couldnt find 
  // another way to scale it up by exactly 1.1. It then interpolates it accordingly.
  if (mousePressed & (mouseButton == LEFT))
  {
      ratioX = 0.9;
      ratioY = 0.9;
      original = interpolate(scaled);
  }
  
  //This however, scales the image down by 1.1 ratio
  if (mousePressed & (mouseButton == RIGHT))
  {
      ratioX = 1.1;
      ratioY = 1.1;
      original = interpolate(scaled);
  }
}


//This function is the heart of our program.
//It takes in an image as a parameter and returns an interpolated version of the image.
//It also displays the scaled version onto the screen.
PImage interpolate(PImage img)
{
  int x, y;
  int scaledX = 1200;
  int scaledY = 1200;
  color A,B,C,D, rgb;
  float w, h ;
  PImage scale = createImage(scaledX, scaledY, RGB);

//These for loops go through all pixels based on the size of the scaled version of our image
  for (int i = 0; i < scaledY; i++)
  {
    for (int j = 0; j < scaledX; j++)
    {
      //this determines the new position of all pixels based on the ratio of 
      //of the scaled image to the original image.
      x = (int)(ratioX * j);
      y = (int)(ratioY * i);
      w = (ratioX * j) - x;
      h = (ratioY * i) - y;

    //This picks 4 pixels next to each other from the original image 
    //that will be interpolated and mapped to the scaled image
    //for example if pixel A = (1,1)in the original image, 
    //then pixel A = (0.9 * 1, 0.9 * 1) in the scaled image
      A = img.get(x, y);
      B = img.get(x + 1, y);
      C = img.get(x, y + 1);
      D = img.get(x + 1, y + 1);

    //This Uses the bilinear interpolation formula to get
    //the red, blue and green shading of the pixels A, B, C and D
    //that will then be mapped to the scaled image
      int r = (int)(red(A) * (1 - w) * (1 - h) + red(B) * (w) * (1 - h) + red(C) * (h) * (1 - w) + red(D) * (w * h));
      int g = (int)(green(A) * (1 - w) * (1 - h) + green(B) * (w) * (1 - h) + green(C) * (h) * (1 - w) + green(D) * (w * h));
      int b = (int)(blue(A)* (1 - w) * (1 - h) + blue(B) * (w) * (1 - h) + blue(C) * (h) * (1 - w) + blue(D) * (w * h));
    
    //rgb stores the color of each pixel that has been interpolated 
    //and then sets it to the mapped pixels of the scaled image 
      rgb = color(r, g, b);
      scale.set(j, i, rgb);
    }
  }
  //scaled image is drawn to the screen and returned as a variable anywhere its called
    image(scale,0, 0);
    return scale;
}

