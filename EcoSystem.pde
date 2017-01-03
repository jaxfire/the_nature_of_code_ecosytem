Mover mover;

void setup(){
  size(800,800);
  
  mover = new Mover();
  
}


void draw(){
  
  background(255);
  
  mover.update();
  mover.display();
  mover.checkEdges();
  
}