//This creature wanders around blind trying to smell out a target (e.g.food). When it can smell a target it will home in on it.
//This creature also has a small chance to fall asleep for a short period.

class Mover{
  
  PVector acc, vel, loc, mouse;
  float xoff, yoff, sleepChance, perlinOffset, maxMoveSpeed;
  int sleepCounter, sleepTime;
  boolean sleeping;
  boolean canSmellTarget;
   
  Mover(int offset){
    
    acc = new PVector(0,0);
    vel = new PVector(0,0);
    loc = new PVector(width / 2, height / 2);
    
    //This is a target. It could be replaced with anything. e.g. food.
    mouse = new PVector(0,0);
    
    xoff = offset;
    yoff = offset + 10000;
    
    perlinOffset = 0.01;
    
    maxMoveSpeed = 2;
    
    sleepChance = 0.02;
    sleepTime = 30;
  
  }

  void update(){
  
    //Get the target's position
    mouse.x = mouseX;
    mouse.y = mouseY; 
    PVector targetHint = PVector.sub(mouse, loc);
    
    //If the target is with in smelling range then we apply a slight acceleration towards it
    if(targetHint.mag() < 250){
      
      canSmellTarget = true;
      targetHint.mult(0.002); 
      
    } else {
      
      //No acceleration is applied
      canSmellTarget = false;
      targetHint.x = 0;
      targetHint.y = 0;
      
    }
    
    //Our creature has a movement stutter, kind of like narcolepsy. Every few steps it will stop its movement and decelerate.
    if(!sleeping){ // The creature is awake
    
      if(random(1) < 1 - sleepChance){
   
        //Move normally
        acc.x = map(noise(xoff), 0, 1, -1, 1);
        acc.y = map(noise(yoff),0, 1, -1, 1);
        
        //Apply any target acceleration
        acc.add(targetHint);
        
      } else{
        
        //Fall asleep
        sleeping = true;
        
      }
      
    } else{ //The creature is asleep
    
      //Decelerate
      acc.x = 0;
      acc.y = 0;
      //Note: We need to apply friction to bring the creature to a halt.
      
      sleepCounter++;
      
      if(sleepCounter > sleepTime){
        
        //Awaken the creature
        sleepCounter = 0;
        sleeping = false;
        
      }
   
    }
  
    //Increase the Perlin noise offsets. We purposefully still increment this even when the creature is sleeping
    //This can add a 'jumpy' or sharp movement pattern upon waking
    xoff += perlinOffset;
    yoff += perlinOffset;
    
    //Apply the acceleration to the velocity, which then determines the location.
    vel.add(acc);
    vel.limit(maxMoveSpeed);  
    loc.add(vel); 
  
  }


  void display(){
  
    stroke(0);
    
    //Colour the creature
    color col = color(87,105,201); // Defualt
    
    //If the creature can smell food
    if(canSmellTarget){
      col =  color(69,196,67);   
    }
    
    //If the creature is asleep
    if(sleeping){
      col = color(15,25,80);
    }
    
    fill(col);
    ellipse(loc.x, loc.y, 25,25);
  
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