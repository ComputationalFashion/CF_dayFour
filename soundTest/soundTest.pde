import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

Minim minim;
AudioPlayer song;

float[][] vals;
float res = 20;

void setup() {
  size(1024, 1024);
  smooth();
  background(0);

  //set the length of our array
  int dimx = floor(width/res);
  int dimy = floor(height/res);

  vals = new float[dimx][dimy];

  for (int i = 0; i < vals.length; i++) {
    for (int j = 0; j < vals[i].length; j++) {
      vals[i][j] = res/4;
    }
  }

  //import mp3 into song
  minim = new Minim(this);
  song = minim.loadFile("one_mode_l_1.mp3");
  song.play();
}

void draw() {
  float factor = sin(radians(frameCount))*.5+.5;
  background(0);

  float songFactor = song.mix.get(frameCount%song.bufferSize());
  songFactor = songFactor*.5 + .5;

  if (frameCount < 300) {
    for (int i = 0; i < vals.length; i++) {
      for (int j = 0; j < vals[i].length; j++) {
        if ((i+j)%vals.length == frameCount -1) {
          vals[i][j] = res/2 + song.mix.get(frameCount)*res/2;
        }
      }
    }
  }else{
    exportPts();
    exit();
  }

  for (int i = 0; i < vals.length; i++) {
    for (int j = 0; j < vals[i].length; j++) {
      noFill();
      stroke(255*factor, 0, 255*(1-factor), 250);
      ellipse(i*res + res/2, j*res+res/2, 4*vals[i][j], 4*vals[i][j]);
    }
  }
}

