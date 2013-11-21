int numOfSpiders = int(random(10, 25));
PImage StarGazer;
PImage Spider;
String Score = "Score ";
String Win = "WIN!!!!";
int yourscore;
//float rot = 0;
Spider[] ourSpiders = new Spider[numOfSpiders];   //make a new array named Spiders
//float rotation;
//float Rcolor;
//float Gcolor;
//float Bcolor;
float scrollY;
boolean mouseDown;
float spiderXspeed;
float spiderYspeed;
float NearTheMouseX;
float NearTheMouseY;
Animation explosion1;

void setup() {
  size(800, 800);  
  imageMode(CENTER);
  StarGazer = loadImage("StarGazer.png");
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
  NearTheMouseX = constrain(20, mouseX-10, mouseX+10);
  NearTheMouseY = constrain(20, mouseY-10, mouseY+10);
  background(255);  //commenting out leaves streaks
  pushMatrix();

  popMatrix();
  for (int i=0; i < numOfSpiders; i++) {  //this for-loop actually draws the spiders
    ourSpiders[i].fly();
    ourSpiders[i].display();
  }
  fill(200);
  rect(4, 25, 133, 30, 7);  //box behind the score
  textSize(24);
  fill(15);
  if (yourscore < numOfSpiders) {
    text(Score + yourscore, 15, 50);
  } else {
    text(Win, 15, 50);
  }
  //imageMode(CORNER);
  image(StarGazer, 720, 680);
  //println(" mouseX = " + mouseX + " mouseY = " + mouseY );
}


class Spider { 
  float xpos;
  float ypos;
  float xspeed;
  float yspeed;

  Spider(float tempXpos, float tempYpos, float tempXspeed, float tempYspeed) { 
    xpos = tempXpos;
    ypos = tempYpos;
    xspeed = tempXspeed;
    yspeed = tempYspeed;
  }

  void display() {
    //if the mouse isn't within 30 pixels of the spider, kill it
    if (mouseX >= xpos-5 && mouseY >= ypos-5 &&
      mouseX <= xpos+5 && mouseY >= ypos+5 ) {
      explosion1.display(xpos, ypos);
      //println("You killed a spider");
      if (yourscore < numOfSpiders) {
        yourscore = yourscore + 1;
        
       // Here, I'd like to shorten the array of spiders... 
      //... or better yet, delete the spider I just moused over. 
      //When using an array of objects, the data returned from the function must be cast to the object array's data type. 
      //For example: SomeClass[] items = (SomeClass[]) shorten(originalArray)
       // ourSpiders[i].display();
       //Spider[i] = (Spider[]) shorten(ourSpiders);
       //"The type of expression must be an array type but it resolved to a PImage"
      } 
      else {
        println("You win!");
      }
    } 
    else {
      image(Spider, xpos, ypos);
    }
    //    println("xpos = " + xpos + " ypos = " + ypos);
    // println("NearTheMouseX = " + NearTheMouseX + " NearTheMouseY + " + NearTheMouseY);
  }

  void fly() {
    xpos = xpos + xspeed;
    ypos = ypos + yspeed;

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



void mouseDragged () {
  mouseDown = true;
  //println ("MouseDown!!!");
}

void mouseReleased () {
  mouseDown = false;
}

void mouseClicked () {
  if (mouseY >= 30 && mouseY <= 710) {  //&& mouseX >= 15 && mouseX <= 40
    scrollY=mouseY;
  }
}

