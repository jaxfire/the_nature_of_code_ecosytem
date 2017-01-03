 
class Mover{
  
  PVector acc, vel, loc, mouse;
  float xoff, yoff;
  int sleepCounter, sleepTime;
  boolean sleeping;
  
  Mover(){
    
  acc = new PVector(0,0);
  vel = new PVector(0,0);
  loc = new PVector(width / 2, height / 2);
  
  //This is a target. It could be replaced with anything. e.g. food.
  mouse = new PVector(0,0);
  
  xoff = 0;
  yoff = 10000;
  
  sleepTime = 50;
  
  }

  void update(){
  
  //Get the target's position
  mouse.x = mouseX;
  mouse.y = mouseY; 
  PVector targetHint = PVector.sub(mouse, loc);
  
  //If the target is withing smelling range then we apply a slight acceleration towards it
  if(targetHint.mag() < 250){
    targetHint.mult(0.002);
  
  } else {
   //Else no acceleration is applied
   targetHint.x = 0;
   targetHint.y = 0;
    
  }
  
  //Our creature has a movement stutter, kind of like narcolepsy. Every few steps it will stop its movement and decelerate.
  if(!sleeping){
    if(random(1) < 0.95){
      sleeping = false;
      //Move normally
      acc.x = map(noise(xoff), 0, 1, -1, 1);
      acc.y = map(noise(yoff),0, 1, -1, 1);
      
      //Apply any targer acceleration
      acc.add(targetHint);
    }
  } else{
    //The creature is asleep
    sleeping = true;
  
    //Decelerate
    acc.x = 0;
    acc.y = 0;
    //Note: This needs friction to bring the creature to a halt.
    
    if(sleepCounter > sleepTime){
      
      sleepCounter = 0;
      sleeping = false;
      
    }
  }
  
  xoff += 0.03;
  yoff += 0.03;
  
  vel.add(acc);
  vel.limit(3);  
  loc.add(vel);
  
  }


  void display(){
  
  stroke(0);
  
  color col = color(85,175,65);
  
  //If the creature is asleep.
  if(!awake){
    col = color(142,114,62);
  }
  
  fill(col);
  
  ellipse(loc.x, loc.y, 15,15);
  
  }
  
  void checkEdges(){
    
   if(loc.x < 0){
     loc.x = 0;
   }
   if(loc.x > width){
     loc.x = width;
   }
   if(loc.y < 0){
     loc.y = 0;
   }
   if(loc.y > height){
     loc.y = height;
   }
   
  }

}