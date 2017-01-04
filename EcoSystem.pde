Mover[] movers;

void setup(){
  size(800,800);
  
  movers = new Mover[50];
  for(int i = 0; i < movers.length; i++){
    movers[i] = new Mover((int)random(5000));
  }
  
}


void draw(){
  
  background(255);
  
  for(int i = 0; i < movers.length; i++){
    movers[i].update();
    movers[i].display();
    movers[i].checkEdges();
  }
}