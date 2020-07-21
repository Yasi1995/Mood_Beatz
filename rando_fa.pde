import processing.sound.*;
import controlP5.*;
PulseSensorAmpd_Processing_Visualizer PulseSensorAmpd_Processing_Visualizer;

//PImage img;
//SoundFile file; 
//ControlP5 cp5;

//public void settings() {
 //size(1920,1080);
//}

class rando_fa extends PApplet {
  rando_fa(){
    super();
    PApplet.runSketch(new String[] {this.getClass().getSimpleName()},this);
  }
  
  public void settings(){
    size(1920,1080);
  }
  

void setup() {
  //size(200, 200);
  
  
  
  
  
   cp5 = new ControlP5(this);
  
 cp5.addButton("Go ")
               .setPosition(1450,850)
               .setSize(450,150)
               .setFont(createFont("arial",100))
               .setColorBackground(color(3, 117, 13));
 smooth();
 //loading background image 
 img = loadImage( "emo.jpg" );

   //putting the sound file
   for(int i =0; i<5;i++){
  file = new SoundFile(this, "hb.mp3");
  file.play();
  file.play();
}
}
//public void settings() {
 // size(1920,1080);
//}
void draw() {
   image( img, 0, 0, width, height );
 // background(0);


  

drawFace();

}

void drawFace() {
  //place face in middle of window
  float faceX = width/2;
  float faceY = height/2;

  //smallest face is quarter the window, biggest face is half of the window
  float faceWidth = random(width/4, width/2);
  float faceHeight = random(height/4, height/2);

  //random face color
  fill(random(255), random(255), random(255));

  //draw the head
  ellipse(faceX, faceY, faceWidth, faceHeight);

  //random eye size
  float eyeWidth = random(faceWidth*.1, faceWidth*.25);
  float eyeHeight = random(faceHeight*.1, faceHeight*.25);

  //random eye position
  float spaceBetweenEyes = random(eyeWidth, eyeWidth*2);
  float leftEyeX = faceX - spaceBetweenEyes/2;
  float rightEyeX = faceX + spaceBetweenEyes/2;
  float eyeY = faceY - random(faceHeight*.1, faceHeight*.25);

  //white
  fill(255);

  //draw the eyes
  ellipse(leftEyeX, eyeY, eyeWidth, eyeHeight);
  ellipse(rightEyeX, eyeY, eyeWidth, eyeHeight);

  //random pupil size
  float pupilWidth = random(eyeWidth*.1, eyeWidth*.9);
  float pupilHeight = random(eyeHeight*.1, eyeHeight*.9);

  //black
  fill(0);

  //draw the pupils
  ellipse(leftEyeX, eyeY, pupilWidth, pupilHeight);
  ellipse(rightEyeX, eyeY, pupilWidth, pupilHeight);

  //random mouth size and Y
  float mouthWidth = random(faceWidth*.2, faceWidth*.8);
  float mouthHeight = random(faceHeight*.1, faceHeight*.3);
  float mouthY = faceY + random(faceHeight*.1, faceHeight*.25);

  //random mouth color
  fill(random(255), random(255), random(255));

  //draw the mouth
  arc(faceX, mouthY, mouthWidth, mouthHeight, 0, 3.14);
  line(faceX - mouthWidth/2, mouthY, faceX + mouthWidth/2, mouthY);
  
  textSize(50);
text("Keep your finger to the heartbeat sensor to detect your current mood", 950, 100); 
textAlign(CENTER);

  //textSize(80);
//text("Go Forward", 1650, 950); 
//textAlign(CENTER);
}
  
  
}
void mouseClicked(){
  if((mouseX> 1450    && mouseX<850 ) && (mouseY>  1900  && mouseY< 1000)){
    if(PulseSensorAmpd_Processing_Visualizer == null) PulseSensorAmpd_Processing_Visualizer = new PulseSensorAmpd_Processing_Visualizer();
  }
}
