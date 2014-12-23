class Board{
  float x; 
  float y; 
  float w; 
  float h; 
  float r;
  float g; 
  float b;

  Board(){
    x = width/2;
    y = 590;
    w = 100;
    h = 10;
    r=255;
    g=255;
    b=255;
  }

  void display(){
    x = mouseX;    
    fill(r, g, b);
    if (this.x >= width-w)
    {
      rect(width-w,y,w,h);
    }
    rect(x, y, w, h);
  }
}
