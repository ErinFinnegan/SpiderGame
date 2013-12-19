//DanOs?  Code from https://github.com/ITPNYU/Comperas/blob/master/BestColorPixelChasing/BestColorPixelChasing.pde

void detectAcolor() {

  float closestSoFar = 65000; //start out very far away
  int winnerX = 0;
  int winnerY = 0;
  float closeness = 0;
  for (int row = 0; row < cam.height; row++) {
    for (int col = 0; col < cam.width; col++) {
      int offset = row*cam.width + col;
      int thisPixel = cam.pixels[offset];
      //color comes out as one big number, have to tease out component colors
      float currentR = red(thisPixel);
      float currentG = green(thisPixel);
      float currentB = blue(thisPixel);
      //find the distance in color space between the current pixel and ideal
      closeness = dist(currentR, currentG, currentB, idealRed, idealGreen, idealBlue);
      //check to see if this beats the world record for best match so far
      if (closeness < closestSoFar && closeness < threshold) {
        closestSoFar = closeness;
        winnerX = col;
        winnerY = row;
         //update the world record to this match
      }
    }
  }
  //  image(cam, 0, 0);  //probably not needed?
  noFill();
  ellipse(winnerX, winnerY, 30, 30);
  ScratcherX = winnerX;
  ScratcherY = winnerY;
  //println(closeness); //draw a circle over the winner
}
