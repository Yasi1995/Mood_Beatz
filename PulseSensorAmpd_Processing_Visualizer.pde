/*
THIS PROGRAM WORKS WITH PulseSensorAmped_Arduino ARDUINO CODE
THE PULSE DATA WINDOW IS SCALEABLE WITH SCROLLBAR AT BOTTOM OF SCREEN
PRESS 'S' OR 's' KEY TO SAVE A PICTURE OF THE SCREEN IN SKETCH FOLDER (.jpg)
PRESS 'R' OR 'r' KEY TO RESET THE DATA TRACES
MADE BY JOEL MURPHY AUGUST, 2012
UPDATED BY JOEL MURPHY SUMMER 2016 WITH SERIAL PORT LOCATOR TOOL
UPDATED BY JOEL MURPHY WINTER 2017 WITH IMPROVED SERIAL PORT SELECTOR TOOL

THIS CODE PROVIDED AS IS, WITH NO CLAIMS OF FUNCTIONALITY OR EVEN IF IT WILL WORK
      WYSIWYG
*/

import processing.serial.*;  // serial library lets us talk to Arduino
import controlP5.*;
PFont font;
PFont portsFont;
Scrollbar scaleBar;
Textlabel lable;
ControlP5 cp5;

import processing.sound.*;
SoundFile file; 

PImage img;



PImage[] bub=new PImage[8];
PImage[] s=new PImage[8];
PImage[] c=new PImage[3];
PImage[] a=new PImage[8];


//intializing gif positions




Serial port;

int Sensor;      // HOLDS PULSE SENSOR DATA FROM ARDUINO
int IBI;         // HOLDS TIME BETWEN HEARTBEATS FROM ARDUINO
int BPM;         // HOLDS HEART RATE VALUE FROM ARDUINO
int[] RawY;      // HOLDS HEARTBEAT WAVEFORM DATA BEFORE SCALING
int[] ScaledY;   // USED TO POSITION SCALED HEARTBEAT WAVEFORM
int[] rate;      // USED TO POSITION BPM DATA WAVEFORM
float zoom;      // USED WHEN SCALING PULSE WAVEFORM TO PULSE WINDOW
float offset;    // USED WHEN SCALING PULSE WAVEFORM TO PULSE WINDOW
color eggshell = color(255, 253, 248);
int heart = 0;   // This variable times the heart image 'pulse' on screen
//  THESE VARIABLES DETERMINE THE SIZE OF THE DATA WINDOWS
int PulseWindowWidth = 490;
int PulseWindowHeight = 512;
int BPMWindowWidth = 180;
int BPMWindowHeight = 512;
boolean beat = false;    // set when a heart beat is detected, then cleared when the BPM graph is advanced

// SERIAL PORT STUFF TO HELP YOU FIND THE CORRECT SERIAL PORT
String serialPort;
String[] serialPorts = new String[Serial.list().length];
boolean serialPortFound = false;
Radio[] button = new Radio[Serial.list().length*2];
int numPorts = serialPorts.length;
boolean refreshPorts = false;

class PulseSensorAmpd_Processing_Visualizer extends PApplet {
  rando_fa(){
    super();
    PApplet.runSketch(new String[] {this.getClass().getSimpleName()},this);
  }


void setup() {
   //putting the sound file
   for(int i =0; i<5;i++){
  file = new SoundFile(this, "hb.mp3");
  file.play();
  file.play();
}
 
  smooth();
 //loading background image 
 //img = loadImage( "emo.jpg" );
 //image( img, 0, 0, width, height );


 
  
 
   //create a button 
  cp5 = new ControlP5(this);
  
  cp5.addButton("Options")
               .setPosition(1150,920)
               .setSize(250,100)
               .setFont(createFont("arial",50))
               .setColorBackground(color(3, 117, 13))
              ;
              
         
    

  size(1920, 1080);  // Stage size
  frameRate(100);
  font = loadFont("Arial-BoldMT-24.vlw");
  textFont(font);
  textAlign(CENTER);
  rectMode(CENTER);
  ellipseMode(CENTER);
// Scrollbar constructor inputs: x,y,width,height,minVal,maxVal
  scaleBar = new Scrollbar (400, 575, 180, 12, 0.5, 1.0);  // set parameters for the scale bar
  RawY = new int[PulseWindowWidth];          // initialize raw pulse waveform array
  ScaledY = new int[PulseWindowWidth];       // initialize scaled pulse waveform array
  rate = new int [BPMWindowWidth];           // initialize BPM waveform array
  zoom = 0.75;                               // initialize scale of heartbeat window

 // set the visualizer lines to 0
 resetDataTraces();

 background(0);
 
  //textSize(50);
//text("Keep your finger to the heartbeat sensor to detect your current mood", 950, 100); 
//textAlign(CENTER);
 // DRAW OUT THE PULSE WINDOW AND BPM WINDOW RECTANGLES
 drawDataWindows();
 drawHeart();

// GO FIND THE ARDUINO
  fill(eggshell);
  text("Select Your Serial Port",245,30);
  listAvailablePorts();

 // image( img, 0, 0, width, height );


}

void draw() {
 
    
  
  
  
  
  
  
  
  
  
  
  
  
   
  
  
  
  //drawing gif frames
   //image( img, 0, 0, width, height );
 bub[0]=loadImage("b2.gif");
    bub[1]=loadImage("b3.gif");
    bub[2]=loadImage("b4.gif"); 
    bub[3]=loadImage("b5.gif"); 
    bub[4]=loadImage("b6.gif"); 
    bub[5]=loadImage("b7.gif");
     bub[6]=loadImage("b8.gif");
      bub[7]=loadImage("b9.gif");
      
        frameRate( 10 );
     
     
     
     
     
     
      
   s[0]=loadImage("s1.gif");
    s[1]=loadImage("s2.gif");
    s[2]=loadImage("s3.gif"); 
    s[3]=loadImage("s4.gif"); 
    s[4]=loadImage("s5.gif"); 
    s[5]=loadImage("s6.gif");
     s[6]=loadImage("s7.gif");
      s[7]=loadImage("s8.gif");
  // create the collection of images making up the animation
  // for a given fish.

    c[0]=loadImage("c1.gif");
    c[1]=loadImage("c2.gif");
    c[2]=loadImage("c3.gif"); 


    a[0]=loadImage("a1.gif");
    a[1]=loadImage("a2.gif");
    a[2]=loadImage("a3.gif"); 
    a[3]=loadImage("a4.gif"); 
    a[4]=loadImage("a5.gif"); 
    a[5]=loadImage("a6.gif");
     a[6]=loadImage("a7.gif");
      a[7]=loadImage("a8.gif");
 


  
 
   //image( bub[frameCount%8], 600,500 );
  //image( bub[frameCount%8], 600,600 )
  
  
  
  
  
if(serialPortFound){
  // ONLY RUN THE VISUALIZER AFTER THE PORT IS CONNECTED
  background(0);
  // image( img, 0, 0, width, height );
  noStroke();
  
  drawDataWindows();
  drawPulseWaveform();
  drawBPMwaveform();
  drawHeart();
// PRINT THE DATA AND VARIABLE VALUES
  fill(eggshell);                                       // get ready to print text
  //text("Pulse Sensor Amped Visualizer v1.5",245,30);    // tell them what you are
  //text("IBI " + IBI + "mS",600,585);                    // print the time between heartbeats in mS
  text(Sensor + " Sensor",350,900);                           // print the Beats Per Minute
  text("Pulse Window Scale " + nf(zoom,1,2), 350, 785); // show the current scale of Pulse Window

//  DO THE SCROLLBAR THINGS
  scaleBar.update (mouseX, mouseY);
  scaleBar.display();

} else { // SCAN BUTTONS TO FIND THE SERIAL PORT

  autoScanPorts();

  if(refreshPorts){
    refreshPorts = false;
    drawDataWindows();
    drawHeart();
    listAvailablePorts();
  }

  for(int i=0; i<numPorts+1; i++){
    button[i].overRadio(mouseX,mouseY);
    button[i].displayRadio();
  }

}
 if((Sensor >= 920)&& (Sensor<=953)){
  image( bub[frameCount%8], 1100,570 );
  fill(0, 134, 166, 151);
  textSize(100);
text("Your mood is Happy!", 1300, 300); 
textAlign(CENTER);
  
  }
  if((Sensor >= 957)&& (Sensor<=975)){
  image( s[frameCount%8], 1100,370 );
 fill(0, 134, 156, 161);
  textSize(100);
text("Your mood is Sad!", 1300, 300); 
textAlign(CENTER);
  }
  if((Sensor >= 0)&& (Sensor<=5)){
   image( c[frameCount%3], 1100,570 );
   fill(0, 134, 66, 51);
  textSize(100);
text("Your mood is critical!", 1300, 300);

text("or you haven't", 1300, 400); 
text("selected the serial port!", 1300, 500); 
textAlign(CENTER);
   }
   if((Sensor >= 954)&& (Sensor<957)){
   
  image( a[frameCount%8], 1100,570 );
fill(0, 134, 166, 151);
  textSize(100);
text("Your mood is Angry!", 1300, 300); 
textAlign(CENTER);}
}  //end of draw loop


void drawDataWindows(){
    // DRAW OUT THE PULSE WINDOW AND BPM WINDOW RECTANGLES
    noStroke();
    fill(eggshell);  // color for the window background
    rect(255,300,PulseWindowWidth,PulseWindowHeight);
    rect(600,300,BPMWindowWidth,PulseWindowHeight);
}

void drawPulseWaveform(){
  // DRAW THE PULSE WAVEFORM
  // prepare pulse data points
  RawY[RawY.length-1] = (1023 - Sensor) - 212;   // place the new raw datapoint at the end of the array
  zoom = scaleBar.getPos();                      // get current waveform scale value
  offset = map(zoom,0.5,1,150,0);                // calculate the offset needed at this scale
  for (int i = 0; i < RawY.length-1; i++) {      // move the pulse waveform by
    RawY[i] = RawY[i+1];                         // shifting all raw datapoints one pixel left
    float dummy = RawY[i] * zoom + offset;       // adjust the raw data to the selected scale
    ScaledY[i] = constrain(int(dummy),44,556);   // transfer the raw data array to the scaled array
  }
  stroke(250,0,0);                               // red is a good color for the pulse waveform
  noFill();
  beginShape();                                  // using beginShape() renders fast
  for (int x = 1; x < ScaledY.length-1; x++) {
    vertex(x+10, ScaledY[x]);                    //draw a line connecting the data points
  }
  endShape();
}

void drawBPMwaveform(){
   textSize(50);
//text(BPM, 950, 100); 
//text(Sensor,300,100);
textAlign(CENTER);
// DRAW THE BPM WAVE FORM
// first, shift the BPM waveform over to fit then next data point only when a beat is found
 if (beat == true){   // move the heart rate line over one pixel every time the heart beats
   beat = false;      // clear beat flag (beat flag waset in serialEvent tab)
   for (int i=0; i<rate.length-1; i++){
     rate[i] = rate[i+1];                  // shift the bpm Y coordinates over one pixel to the left
   }
// then limit and scale the BPM value
   BPM = min(BPM,200);                     // limit the highest BPM value to 200
   float dummy = map(BPM,0,200,555,215);   // map it to the heart rate window Y
   rate[rate.length-1] = int(dummy);       // set the rightmost pixel to the new data point value
 }
 // GRAPH THE HEART RATE WAVEFORM
 stroke(250,0,0);                          // color of heart rate graph
 strokeWeight(2);                          // thicker line is easier to read
 noFill();
 beginShape();
 for (int i=0; i < rate.length-1; i++){    // variable 'i' will take the place of pixel x position
   vertex(i+510, rate[i]);                 // display history of heart rate datapoints
 }
 endShape();
}

void drawHeart(){
  // DRAW THE HEART AND MAYBE MAKE IT BEAT
    fill(250,0,0);
    stroke(250,0,0);
    // the 'heart' variable is set in serialEvent when arduino sees a beat happen
    heart--;                    // heart is used to time how long the heart graphic swells when your heart beats
    heart = max(heart,0);       // don't let the heart variable go into negative numbers
    if (heart > 0){             // if a beat happened recently,
      strokeWeight(8);          // make the heart big
    }
    smooth();   // draw the heart with two bezier curves
    bezier(width-100,50, width-20,-20, width,140, width-100,150);
    bezier(width-100,50, width-190,-20, width-200,140, width-100,150);
    strokeWeight(1);          // reset the strokeWeight for next time
}

void listAvailablePorts(){
  println(Serial.list());    // print a list of available serial ports to the console
  serialPorts = Serial.list();
  fill(0);
  textFont(font,16);
  textAlign(LEFT);
  // set a counter to list the ports backwards
  int yPos = 0;
  int xPos = 35;
  for(int i=serialPorts.length-1; i>=0; i--){
    button[i] = new Radio(xPos, 95+(yPos*20),12,color(180),color(80),color(255),i,button);
    text(serialPorts[i],xPos+15, 100+(yPos*20));

    yPos++;
    if(yPos > height-30){
      yPos = 0; xPos+=200;
    }
  }
  int p = numPorts;
   fill(233,0,0);
  button[p] = new Radio(35, 95+(yPos*20),12,color(180),color(80),color(255),p,button);
    text("Refresh Serial Ports List",50, 100+(yPos*20));

  textFont(font);
  textAlign(CENTER);
  
}

void autoScanPorts(){
  if(Serial.list().length != numPorts){
    if(Serial.list().length > numPorts){
      println("New Ports Opened!");
      int diff = Serial.list().length - numPorts;  // was serialPorts.length
      serialPorts = expand(serialPorts,diff);
      numPorts = Serial.list().length;
    }else if(Serial.list().length < numPorts){
      println("Some Ports Closed!");
      numPorts = Serial.list().length;
    }
    refreshPorts = true;
    return;
  }
}

void resetDataTraces(){
  for (int i=0; i<rate.length; i++){
     rate[i] = 555;      // Place BPM graph line at bottom of BPM Window
    }
  for (int i=0; i<RawY.length; i++){
     RawY[i] = height/2; // initialize the pulse window data line to V/2
  }
  
  
  
  
}
