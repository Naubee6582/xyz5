//BRICK CLASS
class Brick{
  float x;
  float y; 
  float w; 
  float h; 
  float r; 
  float g; 
  float b; 

  boolean hit;
  boolean specialR;
  boolean specialB;
  
    Brick(float x0, float y0){
    x = x0;
    y = y0;
    //pastel colors
    r = 255;
    g = 215;
    b = 0;
    w = 50; 
    h = 25; 

    hit = false;
    specialR = false;
    specialB = false; 
  }

  void display(){
    noStroke();
    fill(r, g, b);
    rect(x, y, w, h);
  }

  void gotHit(){
    hit = true; 
    if(r ==255 && g ==48 && b ==48)
    {
       specialR = true;
    }
    if(r ==0 && g ==191 && b ==255)
     {
       specialB = true;
     }  

    r = 0;
    g = 0;
    b = 0;
    rect(x, y, w, h);
  }
}


