import java.util.ArrayList;
import smile.neighbor.KNNSearch;
import smile.math.distance.EuclideanDistance;
import smile.neighbor.CoverTree;
import smile.neighbor.KDTree;
import smile.neighbor.Neighbor;

class FlowField {

  int xStart;
  int xEnd; 
  int xStep;
  int yStart;
  int yEnd; 
  int yStep; 
  float mag;
  ArrayList<PVector> flowField;
  ArrayList<float[]> vectorCoordinates;
  KNNSearch<double[], double[]> knn;
  
  FlowField(int xStart, int xEnd, int xStep, int yStart, int yEnd, int yStep, float mag) {
    
    flowField = new ArrayList<PVector>(); 
    vectorCoordinates = new ArrayList<float[]>(); 
    
    for(int y = yStart; y <= yEnd; y+=xStep) {
      
      for(int x = xStart; x <= xEnd ; x+=yStep) {
        
        float angle =  (y / float(yEnd)) * PI;
        
        PVector v = PVector.fromAngle(angle);
        v.setMag( mag );
        
        flowField.add(v);

        float[] coordinates = {y,x};

        vectorCoordinates.add(coordinates);
  
      }
    }
    
    int lenVectorCoordinates = vectorCoordinates.size();
    double[][] arrayCords = new double[lenVectorCoordinates][2];
    
    for (int a = 0; a<lenVectorCoordinates; a++) {

      double[] coordinates = floatArrayToDoubleArray(vectorCoordinates.get(a));

      arrayCords[a][0] = coordinates[0];
      arrayCords[a][1] = coordinates[1];

    }
    
    if (lenVectorCoordinates < 10) {
        knn = new KDTree(arrayCords, arrayCords);
    } else {
        knn = new CoverTree(arrayCords, new EuclideanDistance());
    }    
  }
  void rotateVectors(){

  }

  PVector getClostestPointFromFlowField(PVector v){

    double[] pointArray = floatArrayToDoubleArray(v.array());
    double[] newa = {pointArray[1],pointArray[0]};
    Neighbor[] neighbor = knn.knn(newa,1);
    
    int neighborIndex = neighbor[0].index;

    PVector closestVector = flowField.get(neighborIndex);
    
    float[] co = vectorCoordinates.get(neighborIndex);

    return closestVector;
  }

  double[] floatArrayToDoubleArray(float[] a) {
    
    float a0 = a[0];
    float a1 = a[1];
    double a0Float = a0;
    double a1Float = a1;
    double[] b = {a0,a1};
    
    return b;
  }

  void plotFlowField() {
    
    int vectorLength = 10;
    
    for(int i=0; i < flowField.size();i++){

        pushMatrix();
        
        PVector v = flowField.get(i);
        float[] coordinates = vectorCoordinates.get(i);

        translate(coordinates[1], coordinates[0]);
        rotate(v.heading());
        
        // Plot vectors
        line(0, 0, 5, 0);
        line(vectorLength, 0, vectorLength - 4, -2);
        line(vectorLength, 0, vectorLength - 4, 2);
      
        popMatrix();

    }
  }
  

}
