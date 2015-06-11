class agent{
  PVector pos;
  float rad;
  ArrayList history;
  
  agent(PVector _pos, float _rad){
    pos = _pos.get();
    rad = _rad;
    history = new ArrayList();
  }
  
  void update(){
    history.add(pos.get());
    //empty vector for summing all of the functions
    PVector acc = new PVector();
    
    //individual vector for behaviors
    PVector avd = avoid();
    PVector orb = orbit();
    PVector grav = new PVector(0,0,1);
    //add our vectors to acc
    avd.mult(1);
    orb.mult(4);
    
    acc.add(avd);
    acc.add(orb);
    //acc.add(grav);
    
    acc.limit(.25);
    pos.add(acc);    
  }
  
  PVector orbit(){
    PVector sum = new PVector();
    for(int i = 0; i < agents.size(); i++){
      agent other = (agent) agents.get(i);
      float dis = pos.dist(other.pos);
      if(dis < 1.1*(rad+other.rad) && dis > 0){
        PVector temp = pos.get();
        temp.sub(other.pos);
        temp.normalize();
        temp.rotate(PI/60);
        temp.normalize();
        temp.mult(dis);
        temp.add(other.pos);
        temp.sub(pos);
        sum.add(temp);
      }
    }
    return sum;
  }
  
  PVector avoid(){
    PVector sum = new PVector();
    for(int i = 0; i < agents.size(); i++){
      agent other = (agent) agents.get(i);
      float dis = pos.dist(other.pos);
      if(dis < rad+other.rad && dis > 0){
        PVector temp = pos.get();
        temp.sub(other.pos);
        temp.normalize();
        temp.mult((rad+other.rad - dis)/2);
        sum.add(temp);
      }
    }
    return sum;    
  }
  
  void render(){
    noStroke();
    fill(255,200,200);
    //ellipse(pos.x, pos.y, 2*rad, 2*rad);
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    //sphere(rad);
    popMatrix();
    
    stroke(255);
    if(history.size() > 2){
      for(int i = 1; i < history.size(); i++){
        PVector p1 = (PVector) history.get(i);
        PVector p2 = (PVector) history.get(i-1);
        line(p1.x, p1.y, i, p2.x, p2.y, i-1);
      }
    }
  }  
}
