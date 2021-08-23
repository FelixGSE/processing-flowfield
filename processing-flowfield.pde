FlowField flowfield;
FlowFieldParticle flowFieldParticle;

public void settings() {
  size(1000, 1000);
}

void setup() {

  background(255);
  
  noLoop();

}

void draw() {

    // Initialize and visualize flowfield
    flowfield = new FlowField(0, 1000,  20,  0, 1000, 20 , 1);
    strokeWeight(0.5);
    stroke(1,36,67);
    flowfield.plotFlowField();

    // Create a single particle and plot path through field
    PVector l = new PVector(80,80);    
    PVector v = new PVector(0,0);    
    
    stroke(255, 107, 107);
    strokeWeight(1);
    noFill();
    flowFieldParticle = new FlowFieldParticle(l,v);
    
    beginShape();
    
    for(int i=0; i<=1250; i++){

      PVector currentPosition = flowFieldParticle.location;
      curveVertex(currentPosition.x, currentPosition.y);
      PVector acceleration = flowfield.getClostestPointFromFlowField(currentPosition);
      flowFieldParticle.updateLocation(acceleration,1);
      
    }
    endShape();
    
    saveFrame("./assets/sketch.jpeg");
}
  
  
