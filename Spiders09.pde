import processing.video.*;
Capture cam;
//PGraphics pg;  //PG is the graphics buffer for over the video
int numOfSpiders = int(random(10, 25));
PImage Spider;
String Score = "Score ";
String Win = "WIN!!!!";
int yourscore;
//float rot = 0;
Spider[] ourSpiders = new Spider[numOfSpiders];   //make a new array named Spiders
//************* Do I need a boolean array to display these guys?  Or does it need to output into a new array every time I delete one?
float scrollY;
boolean mouseDown;
float spiderXspeed;
float spiderYspeed;
Animation explosion1;

void setup() {

  String[] cameras = Capture.list();

  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } 
  else {
    // println("Available cameras:");
    println("CAMERA IS GO");
    //   for (int i = 0; i < cameras.length; i++) {
    //println(cameras[i]);
    // }

    // The camera can be initialized directly using an 
    // element from the array returned by list():
    cam = new Capture(this, cameras[0]);
    cam.start();
  }  
  size(640, 360);  
  imageMode(CENTER);
  Spider = loadImage("Spider.png");
  imageMode(CENTER);
  scrollY = 40;
  mouseDown = false;
  spiderXspeed = spiderXspeed+1;
  spiderYspeed = spiderYspeed+2;
  //frameRate(24);
  explosion1 = new Animation("Explosion_", 14);
  yourscore = 0;

  for (int i=0; i < numOfSpiders; i++) {  //this for loop initiates places for spiders to be drawn at every place in the array
    ourSpiders[i] = new Spider(random(0, width-20), random(0, height-20), spiderXspeed, spiderYspeed);
  }
}

void draw() {
  // background(255);  //commenting out leaves streaks, if no video

  if (cam.available() == true) {
    cam.read();
  }
  image(cam, 0, 0);
  // The following does the same, and is faster when just drawing the image
  // without any additional resizing, transformations, or tint.
  //set(0, 0, cam);

  for (int i=0; i < numOfSpiders; i++) {  //this for-loop actually draws the spiders
    ourSpiders[i].fly();
    //only display a spider if it hasn't been killed.
    // Maybe what I need is a boolean array of true and false for each spider on the list??
    if (ourSpiders[i].isVisible) {
      ourSpiders[i].display();
      //yourscore++;
      println("Your score = " + yourscore);
    }
  }
  fill(200);   //fill for the score box
  rect(4, 25, 133, 30, 7);  //box behind the score
  textSize(24);
  fill(15);
  if (yourscore < numOfSpiders) {
    text(Score + yourscore, 15, 50);
  } 
  else {
    text(Win, 15, 50);
  }
}

class Spider { 
  float xpos;
  float ypos;
  float xspeed;
  float yspeed;
  boolean isVisible;

  Spider(float tempXpos, float tempYpos, float tempXspeed, float tempYspeed) { 
    xpos = tempXpos;
    ypos = tempYpos;
    xspeed = tempXspeed;
    yspeed = tempYspeed;
    isVisible = true;
  }

  void display() {
    //if the mouse is within 30 pixels of the spider, kill it
    if (mouseX >= xpos-5 && mouseY >= ypos-5 &&
      mouseX <= xpos+5 && mouseY >= ypos+5 ) {
      explosion1.display(xpos, ypos);
      this.isVisible = false;
      yourscore++;
      //println("You killed a spider");
    } 
    else {
      this.isVisible = true;
      //println("You win!");
    }
    if (this.isVisible)
      image(Spider, xpos, ypos);
  }

  void fly() {
    xpos = xpos + xspeed;
    ypos = ypos + yspeed;
    /// Perhaps here is where the stage constraints can be set??
    if ((xpos > width) || (xpos < 0)) {
      // If the object reaches either edge, multiply speed by -1 to turn it around.
      xspeed = xspeed * -1;
    }
    if ((ypos > height) || (ypos < 0)) {
      // If the object reaches either edge, multiply speed by -1 to turn it around.
      yspeed = yspeed * -1;
    }
  }
}


//
//void mouseDragged () {
//  mouseDown = true;
//  //println ("MouseDown!!!");
//}
//
//void mouseReleased () {
//  mouseDown = false;
//}
//
//void mouseClicked () {
//
//}

