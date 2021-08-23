class FlowFieldParticle {

 PVector location;
 PVector velocity;
 PVector acceleration;
 boolean hitEdge;

 FlowFieldParticle(PVector initiallocation, PVector initialVelocity) {
    
   location = initiallocation;
   velocity = initialVelocity;
   acceleration = new PVector(0,0);
   hitEdge = false;
 
 }

 void updateLocation(PVector force, float topSpeed) {

   acceleration.add(force);
   
   velocity.add(acceleration);
   
   velocity.limit(topSpeed);
   
   location.add(velocity);

   acceleration.mult(0); 

 }

  public void edges() {
    if (location.x > width) {
      location.x = 0;
      hitEdge = true;
    }
    if (location.x < 0) {
      location.x = width;
      hitEdge = true;
    }

    if (location.y > height) {
      location.y = 0;
      hitEdge = true;
    }
    if (location.y < 0) {
      location.y = height;
      hitEdge = true;
    }
  }

}
