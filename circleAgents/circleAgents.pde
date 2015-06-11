import peasy.test.*;
import peasy.org.apache.commons.math.*;
import peasy.*;
import peasy.org.apache.commons.math.geometry.*;

ArrayList agents;
PeasyCam cam;

void setup(){
  size(1280,720, P3D);
  
  cam = new PeasyCam(this, 200);
  agents = new ArrayList();
  for(int i = 0; i < 100; i++){
    PVector temp = new PVector(random(width), random(height), 0);
    float tempRad = random(20,80);
    agent newA = new agent(temp, tempRad);
    agents.add(newA);
  }
}

void draw(){
  background(0);
  lights();
  for(int i = 0; i < agents.size(); i++){
    agent me = (agent) agents.get(i);
    me.update();
    me.render();
  }
  
  if(frameCount == 50){
    exportCrv();
    exit();
  }
}
