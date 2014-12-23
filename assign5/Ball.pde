//BALL CLASS
class Ball{

  float x;  
  float y; 
  float vx;
  float vy; 
  float D;
  int p; 

  Ball(){
    x = bar.x + bar.w/2;
    y = bar.y - D/2;
    randomSeed(0);
    vx = int(random(-4,4));
    vy = -3; 
    D = 10;
  }
  void display(){
    stroke(255);
    fill(0);
    ellipse(x, y, D, D);
  }
  void move(){
    if(status == GAME_PLAY)
    {
      x = bar.x + bar.w/2;
      if(bar.x >= width-100)
      {
        x = width -bar.w /2;
      }
      y = bar.y - D/2;
    }
    if(status == GAME_PLAYING)
    {
    y += vy;
    x += vx; 
    }
  }
  void goLeft(){
    vx = -3; 
  }
  void goRight(){
    vx = 3; 
  }
  void changeY(){
    vy *= -1; 
  }
  void reset(){
    x = bar.x + bar.w/2;
    y = bar.y - D/2;
    randomSeed(0);
    vx = int(random(-4,4));
    vy = -3; 
    D =10;
    status = GAME_PLAY;
  }
}


