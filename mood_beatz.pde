import processing.sound.*;
SoundFile file; 
import controlP5.*;
ControlP5 cp5;


PImage img;

rando_fa rando_fa;



//PImage[] bub=new PImage[8];
PImage[] h=new PImage[8];
//PImage[] c=new PImage[3];
//PImage[] a=new PImage[8];


//intializing gif positions


  //importing sound
 


void setup() {
  //putting the sound file
   for(int i =0; i<5;i++){
  file = new SoundFile(this, "hb.mp3");
  file.play();
  file.play();
}
 
  smooth();
 //loading background image 
 img = loadImage( "emo.jpg" );
    cp5 = new ControlP5(this);
  
 cp5.addButton("Go ")
               .setPosition(1450,850)
               .setSize(450,150)
               .setFont(createFont("arial",100))
               .setColorBackground(color(127, 0, 0));


 
  /* bub[0]=loadImage("b2.gif");
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
*/

    h[0]=loadImage("h1.gif");
    h[1]=loadImage("h2.gif");
    h[2]=loadImage("h3.gif"); 
    h[3]=loadImage("h4.gif"); 
    h[4]=loadImage("h5.gif"); 
    h[5]=loadImage("h6.gif");
     h[6]=loadImage("h7.gif");
      h[7]=loadImage("h8.gif");
 
 
   
}

public void settings() {
  size(1920,1080);
}
void draw() {
  //drawing gif frames
   image( img, 0, 0, width, height );



  
  
 // image( bub[frameCount%8], 450,10 );
  
  //image( s[frameCount%8], 200,600 );
   //image( c[frameCount%3], 1000,500 );
  image( h[frameCount%8], 700,400 );
  textSize(200);
  fill(127,0,0);
text("Mood Beatz", 950, 270); 
textAlign(CENTER);
   //image( bub[frameCount%8], 600,500 );
  //image( bub[frameCount%8], 600,600 );

}
void mouseClicked(){
  if((mouseX> 1450    && mouseX<850 ) && (mouseY>  1900  && mouseY< 1000)){
    if(rando_fa == null) rando_fa = new rando_fa();
  }
}
