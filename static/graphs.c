#include "graphs.h"
#include <math.h>

//Functions calculate proper values
float spiroX(float R, float r, float x, float a){
  return ((R-r)*cos((r/R)*x)) + (a*cos((1-(r/R))*x));
}

float spiroY(float R, float r, float y, float a){
  return ((R-r)*sin((r/R)*y)) - (a*sin((1-(r/R))*y));
}