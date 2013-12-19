import processing.video.*;
import ddf.minim.*;

Minim minim;
AudioSample music;
AudioSample splatter;
AudioSample bugs;

Capture cam;
//PGraphics pg;  //PG is the graphics buffer for over the video
int numOfSpiders = int(random(20, 30));  //******************* Set the Number of Spiders (try 50 for Hard!!)*********
//int numOfSpiders = 5;
PImage Spider;
PImage StartScreen;
String Score = "Score ";
String Win = "WIN!!!!";
String WannaPlay = "Hey you! Want to play a Backscratcher Game?";
String Step1 = "Step 1:  Click to draw where the player's back is.";
String Step2 = "Step 2: Hold still while I click Your Weapon to START";
//String Step3 = "Step 3:  CLICK TO START!!";
String Reset = "You Won!!!  Game Over";
String Reset2 = "Any key to restart";
int yourscore;
//float rot = 0;
Spider[] ourSpiders = new Spider[numOfSpiders];   //make a new array named Spiders
boolean mouseDown;
float spiderXspeed;
float spiderYspeed;
Animation explosion1;
Animation spidersprite;
int mouseCounter;
float corner1x, corner1y, corner2x, corner2y;
float rectwidth, rectheight;
int camnumber = -1;


float idealRed; 
float idealGreen; 
float idealBlue;
float threshold = 50;
float ScratcherX = 0;
float ScratcherY = 0;
PFont font;


void setup() {
  //size(640, 360);   //******************STAGE SIZE to MAX Camera Size*********************
  //size(1280, 720);   //My built in cam is this   
  //size(800, 600);
  size(1600, 1200);  //Logitech at school
  frameRate(28);
  font = loadFont("Impact-48.vlw");


  mouseCounter = 0;
  println("mouseCounter = " + mouseCounter);
  String[] cameras = Capture.list();


  if (cameras.length == 0) {
    //println("There are no cameras available for capture.");
    exit();
  } 
  else {
    // println("Available cameras:");
    //println("CAMERA IS GO");
    for (int i = 0; i < cameras.length; i++) {
      //loop through the available cameras and list their numbers!!!
      camnumber++;
      //println(camnumber + " " + cameras[i]);
    }

    // The camera can be initialized directly using an 
    // element from the array returned by list():
    //*****************CHANGE THE CAMERA NUMBER HERE ************************************************//
    cam = new Capture(this, cameras[15]);  //camera 15 was the logitec at home/school
    cam.start();
  }  //end of camera loop

  imageMode(CENTER);
  Spider = loadImage("Spider.png");
  StartScreen = loadImage("BackScratcherImage.png");
  imageMode(CENTER);
  rectwidth = 0;
  rectheight = 0;
  mouseDown = false;
  spiderXspeed = 1;
  spiderYspeed = 1;
  //  spiderXspeed = spiderXspeed+1;
  //  spiderYspeed = spiderYspeed+2;
  //frameRate(24);
  explosion1 = new Animation("Explosion_", 14);
  spidersprite =  new Animation("SpiderSprite0_", 16);
  yourscore = 0;

  ///////////// MINIM CRAP
  minim = new Minim(this);

  // load BD.wav from the data folder
  music = minim.loadSample( "music.wav", // filename
  512      // buffer size
  );
  splatter = minim.loadSample( "splatter.wav", // filename
  512      // buffer size
  );
  bugs = minim.loadSample( "bugs.wav", // filename
  512      // buffer size
  );

  for (int i=0; i < numOfSpiders; i++) {  //this for loop initiates places for spiders to be drawn at every place in the array
    ourSpiders[i] = new Spider(random((width*0.25), (width*0.75)), random((height*0.25), (height*0.75)), spiderXspeed, spiderYspeed); //all spiders start from the center
    // Spider(float tempXpos, float tempYpos, float tempXspeed, float tempYspeed)
  }
}

void draw() {
  textFont(font);
  // music.trigger();
  // background(255);  //commenting out leaves streaks, if no video
  stroke(255);
  ellipse(mouseX, mouseY, 10, 10); //draw an ellipse at the mouse position
  if (cam.available() == true) {
    imageMode(CENTER);
    cam.read();
  }
  imageMode(CENTER);
  //image(cam, 0, 0, 1280, 720);
  // The following does the same, and is faster when just drawing the image
  // without any additional resizing, transformations, or tint.
  set(0, 0, cam);

  if (mouseCounter == 0) {
    fill(0);
    textAlign(CENTER, CENTER);
    image(StartScreen, width/2, height/3 + 150);
    //textSize(24);
    text(Step1, (width/2 + 3), (height/2 + 200));
    text(WannaPlay, (width/2 - 3), height/3 - 100);
    text(WannaPlay, (width/2 + 3), height/3 - 100);
    //textSize(24);
    fill(200);
    text(Step1, width/2, (height/2 + 200));
    fill(200);
    text(WannaPlay, (width/2 + 3), height/3 - 100);
  }
  if (mouseCounter == 1) {
    textSize(36);
    textAlign(CENTER, CENTER);
    fill(0);
    text(Step2, (width/2+2), (height/2+2));
    fill(200);
    text(Step2, width/2, height/2);
  }


  if (mouseCounter >= 2) {
    bugs.trigger();
    for (int i=0; i < numOfSpiders; i++) {  //this for-loop actually draws the spiders
      ourSpiders[i].fly();
      //only display a spider if it hasn't been killed.
      // Maybe what I need is a boolean array of true and false for each spider on the list??
      if (ourSpiders[i].isVisible) {
        ourSpiders[i].display();
        //yourscore++;
        //println("Your score = " + yourscore);
      }
    }
  }  //end of the Spider-making loop
  if (keyPressed) {
    println("Key pressed!!!");
  }

  fill(200);   //fill for the score box
  rect(4, 25, 133, 30, 7);  //box behind the score
  textSize(24);
  textAlign(LEFT);
  fill(15);
  if (yourscore < numOfSpiders) {
    text(Score + yourscore, 15, 50);
  }
  if (corner1x == 0 && mouseCounter == 1) {
    stroke(255);  //stage line
    noFill();
    rect(corner1x, corner1y, rectwidth, rectheight);  // draw the stage, drawwww it
  } 
  if (yourscore >= numOfSpiders) {
    //music.stop();
    splatter.stop();
    bugs.stop();
    textSize(48);
    text(Win, 15, 50);
    textAlign(CENTER, CENTER);
    fill(0);
    text(Reset2, (width/2 + 2), (height/2+22));  //Reset commands!!!
    text(Reset, (width/2 + 2), (height/3+22));
    fill(200);
    text(Reset2, width/2, (height/2+20)); 
    text(Reset, width/2, (height/3+20)); 
    //mouseCounter = 0;
    corner1x = 0;
    noFill();
  }

  //  fill(200);   //fill for the mouse counter box
  //  rect(1200, 680, 133, 30, 7);  //box behind the mouse counter
  //  textSize(24);
  //  textAlign(CENTER);
  //  fill(15);
  //  text(mouseCounter, 1210, 700);

  detectAcolor();
}   //end of the draw loop

class Spider { 
  float xpos;
  float ypos;
  float spiderXspeed;
  float spiderYspeed;
  boolean isVisible;

  Spider(float tempXpos, float tempYpos, float tempXspeed, float tempYspeed) { 
    xpos = tempXpos;
    ypos = tempYpos;
    spiderXspeed = tempXspeed;
    spiderYspeed = tempYspeed;
    isVisible = true;
  }

  void display() {
    //if the mouse is within 30 pixels of the spider, kill it
    if ((ScratcherX >= xpos-15 && ScratcherY >= ypos-15 &&
      ScratcherX <= xpos+15 && ScratcherY >= ypos+15) || (mouseX >= xpos-15 && mouseY >= ypos-15 &&
      mouseX <= xpos+15 && mouseY >= ypos+15)  ) {
      stroke(0);
      noFill();
      ellipse(ScratcherX, ScratcherY, 30, 30);
      explosion1.display(xpos, ypos); 
      this.isVisible = false;
      splatter.trigger();
      yourscore++;
      //println("visible F" + mouseCounter);
    } 
    else {
      this.isVisible = true;
      //println("You win!");
      //println("visible true" + mouseCounter);
    }

    if (this.isVisible == true) {      
      imageMode(CENTER);
      //image(Spider, xpos, ypos); //code for displaying Spider.png
      spidersprite.display(xpos, ypos);
    }
  }

  void fly() {
    xpos = xpos + spiderXspeed;   // they fly up if subtracting, down if adding
    ypos = ypos + spiderYspeed;  
    if (xpos > (corner1x + rectwidth) || xpos > width) {  //if the spider's currect position is outside of rect, fly towards the rect
      spiderXspeed = spiderXspeed - 1;
    }
    if (xpos < corner1x) {  //if the spider's currect position is outside of rect, fly towards the rect
      spiderXspeed = spiderXspeed + 1;
    }
    if (xpos < 0) {
      xpos = 2;
    }
    if (ypos > rectheight) {  //if the spider's currect position is outside of rect, fly towards the rect
      spiderYspeed = spiderYspeed - 1;
    }
    if (ypos < (rectheight - corner1y)) {  //if the spider's currect position is outside of rect, fly towards the rect
      spiderYspeed = spiderYspeed + 1;
    }
    if (ypos < 0) {  //if ypose is less than zero come back!!
      ypos = 2;
    }
    if (ypos < 100) {  //if ypose is less than zero come back!!
      ypos = 200;
    }
    //    if (spiderXspeed == 0 || spiderYspeed == 0) {
    //      spiderXspeed = spiderXspeed + 1;
    //      spiderYspeed = spiderYspeed + 1;
    //    }
    //println("rectwidth = " + rectwidth + " xpos = " + xpos);
    // println("rectheight = " + rectheight + " ypos = " + ypos);
    println("xspeed = " + spiderXspeed + ", spiderYspeed = " + spiderYspeed);
  }
}



void mouseReleased () {
  mouseCounter++;
  println("mouseCounter = " + mouseCounter);
}

void mouseClicked () {
  if (mouseCounter >= 2) {  //only pick up the color if the first two steps are complete
    //click to pick a color to chase
    int thisPixel = (mouseX + mouseY*cam.width);
    color fromCam = cam.pixels[thisPixel];
    idealRed = red(fromCam);
    idealGreen = green(fromCam);
    idealBlue =  blue(fromCam);
    //println("ideal" + idealRed+ " " + idealGreen + " " + idealBlue);
    textSize(24);
    fill(200);
    textAlign(CENTER, CENTER);
    //text(Step2, width/2, height/2);
  }
}

void mousePressed() {
  if (corner1x == 0) {
    corner1x = mouseX;
    corner1y = mouseY;
  }
}

void mouseDragged() {
  if (corner1x != 0) {
    rectwidth = mouseX-corner1x;
    rectheight = mouseY-corner1y;
  }
  stroke(255);
  rect(corner1x, corner1y, rectwidth, rectheight);
}

void keyPressed() {
  mouseCounter = 0;
  yourscore = 0;
  bugs.trigger();
  for (int i=0; i < numOfSpiders; i++) {  //this for loop initiates places for spiders to be drawn at every place in the array
    ourSpiders[i] = new Spider(random((width*0.25), (width*0.75)), random((height*0.25), (height*0.75)), spiderXspeed, spiderYspeed);
  }
  for (int i=0; i < numOfSpiders; i++) {  //this for-loop to redraw the spiders after a reset
    ourSpiders[i].fly();
    if (ourSpiders[i].isVisible) {
      ourSpiders[i].display();
      //yourscore++;
      //println("Your score = " + yourscore);
    }
  }
}
