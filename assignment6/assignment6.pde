PImage dead,Win,en;

int row = 7; 
int column = 7; 
int total = row * column; 
int score = 0; 
int gameScore = 0; 
int point = 0;  
int combo = 0;
int life = 3;
int powerS;

//Game Status
final int GAME_START   = 0;
final int GAME_PLAY    = 1;
final int GAME_PLAYING = 2;
final int GAME_WIN     = 3;
final int GAME_LOSE    = 4;
int status;
Board bar = new Board();
Ball ball2 = new Ball(); 
Brick[] box = new Brick[total];
PowerUp power = new PowerUp(int(random(15,585)), -10);

void setup(){
  size(600, 600);
  background(0);
  smooth();
  dead = loadImage("data/dead.png");
  Win = loadImage("data/Win.png");
  en = loadImage("data/en.png");
    
  status = GAME_START;
  
  //places all the bricks into the array
  for (int i = 0; i < row; i++)
  {
    for (int j = 0; j< column; j++)
    {
      box[i*row + j] = new Brick((i+1) *width/(row + 2), (j+1) * 50);
    }
  }
  for(int s =0;s < 3;s++)
  {
    int spec = int(random(0,49));
    if((box[spec].r==0 && box[spec].g==191 && box[spec].b==255)||
       (box[spec].r==255 && box[spec].g==48 && box[spec].b==48))
    {
      s-=1;
    }else{
    box[spec].r=255;
    box[spec].g=48;
    box[spec].b=48;
    }
  }
  for(int t =0;t < 3;t++)
  {
    int spec2 = int(random(0,49));
    if((box[spec2].r==255 && box[spec2].g==48 && box[spec2].b==48)||
       (box[spec2].r==0 && box[spec2].g==191 && box[spec2].b==255))
    {
      t-=1;
    }else{
    box[spec2].r=0;
    box[spec2].g=191;
    box[spec2].b=255;
    }
  }  
}

void draw(){
  
  switch(status) {

   case GAME_START:
     background(0);
     image(en,0,0);
     printText();
   break;
   case GAME_PLAY:
     background(0);
     powerS = int(random(200,480));
     //Draw
     for (int i = 0; i<total; i++)
     {
      box[i].display();
      box[i].specialR = false;
      box[i].specialB = false;
     } 
      bar.w = 100;     
      bar.display();
      ball2.display();
      ball2.move();
      drawLife();
    break;
   case GAME_PLAYING:
      background(0);
      //Draw
      for (int i = 0; i<total; i++)
      {
       box[i].display();
      } 
      bar.display();
      ball2.display();
      ball2.move();
      //Interaction I
      //Ball hits left side of bar
      float bottom = ball2.y+ ball2.D /2;
      float barl = bar.y;
      float barLeft = bar.x;
      float barRight = bar.x + bar.w;
      if ( bottom >= barl && ball2.x > barLeft && ball2.x<barRight)
      {
        if ( bottom > barl){
         ball2.y = barl - ball2.D/2;
         ball2.changeY();
         point = 0;
        }else{ 
        ball2.changeY();
        point = 0;
        }
      }
      //Ball hits the right wall  
      if (ball2.x + ball2.D /2 >= width)
      {
        ball2.goLeft();
      }
      //Ball hits the left wall
      if (ball2.x - ball2.D /2 <= 0)
      {
        ball2.goRight();
      }
    
      //Ball hits the ceiling
      if (ball2.y - ball2.D /2 <= 0)
      {
        ball2.changeY();
      }
        
      //Interactions II  
      //Ball hits bottom of brick
      for (int i = 0; i < total; i ++)
      {
        if (ball2.y - ball2. D /2 <= box[i].y + box[i].h &&  ball2.y - ball2.D /2 >= box[i].y && ball2.x >= box[i].x && ball2.x <= box[i].x + box[i].w  && box[i].hit == false )
        {
          ball2.changeY();
          box[i].gotHit();
          score += 1;
          gameScore += 10;
          point += 1;
    
          //Calculate final score
          if (point>combo)
          {
            combo = point;
          }
        } 
       //Ball hits top of brick
         if (ball2.y + ball2.D /2 >= box[i].y && ball2.y - ball2.D /2 <= box[i].y + box[i].h /2 && ball2.x >= box[i].x && ball2.x <= box[i].x + box[i].w && box[i].hit == false )
         {
          ball2.changeY();
          box[i].gotHit();
          score += 1;
          gameScore += 10;
          point += 1;
          //Calculate final score
          if (point>combo)
          {
            combo = point;
          }
        }
       //Ball hits left of brick
         if (ball2.x + ball2.D /2 >= box[i].x && ball2.x + ball2.D /2 <= box[i].x + box[i].w /2 && ball2.y >= box[i].y && ball2.y <= box[i].y + box[i].h  && box[i].hit == false){
          ball2.goLeft();
          box[i].gotHit();
          score += 1;
          gameScore += 10;
          point += 1;
          //Calculate final score
          if (point>combo)
          {
            combo = point;
          }
        }
       //Ball hits right of brick
        if (ball2.x - ball2.D /2 <= box[i].x + box[i].w && ball2.x +ball2.D /2 >= box[i].x + box[i].w /2 && ball2.y >= box[i].y && ball2.y <= box[i].y + box[i].h  && box[i].hit == false)
        {
          ball2.goRight();
          box[i].gotHit();
          score += 1;
          gameScore += 10;
          point += 1;
          //Calculate final score
          if (point>combo)
          {
            combo = point;
          }
        }
      }
      //Function
      gameCheck();
      drawLife();
      winLoseCheck();
      specialBar();
      
      //power
      checkPowerDrop(powerS);
      powerShow();
      checkPowerCatch();
   break;
   case GAME_WIN:
   background(0);
   image(Win,0,0);
   printText();
   break;
   case GAME_LOSE:
   background(255);
   image(dead,0,0);
   printText();
   break;
  }
}

void gameCheck(){
  if (ball2.y > height)
  {
    ball2.reset();
    life -= 1;
    bar.r = 255;
    bar.g = 255;
    bar.b = 255;
  }
}

void winLoseCheck(){    
   if (score == total)
   {
     status = GAME_WIN;
   }
   if (life <= 0)
   {
     status = GAME_LOSE;
   }
}
    
void mousePressed(){
        if(mouseButton == RIGHT){
          if(status == GAME_PLAY)
          {
             status = GAME_PLAYING;
          }
        }
}

void printText(){
  if (status==GAME_START)
  {
      textAlign(CENTER,CENTER);
      textSize(20);
      fill(int(random(256)));
      text("Press ENTER to Start",width/2+5,height-20);
  }
  if (status==GAME_WIN){
      textAlign(CENTER,CENTER);
      fill(255);
      textSize(20);
      text("Score ", width/2, height-120);
      text(gameScore, width/2, height-100);
      text("Combo", width/2, height-80); 
      text(combo, width/2, height/2-60);
      textSize(25);
      fill(255,165,0);
      text("Press ENTER to Replay",width/2,height-30);
  }
  if (status==GAME_LOSE){
      fill(0);
      textAlign(CENTER,CENTER);
      textSize(20);
      text("Score ", width/2, height-80);
      text(gameScore, width/2, height-60);
      textSize(25);
      fill(0);
      text("Press ENTER to Replay",width/2+8,height-30);
  }
}

void drawLife(){
  fill(230, 74, 96);
  textSize(15);
  text("LIFE:", 20, 12);
  for(int i = 0;i< life ;i++){
    int circleLifeX = 58;
    circleLifeX += 25*i;
    noStroke();
    ellipse(circleLifeX,15,15,15);
  }
}

void specialBar(){
   for (int i = 0; i < total; i ++)
   {
      if(box[i].specialR == true)
      {
       bar.w = 50;
       box[i].specialR =false;
      }
      if(box[i].specialB == true)
      {
        bar.w = 150;
        box[i].specialB = false;
      }
    }
}
    
void checkPowerDrop(int pointS){
  if (gameScore >= pointS)
  {
    power.show = true;
  } 
}

void powerShow(){
  if (power.show == true){
    power.display();
    power.move();
    if(power.pY>600){
      power.show = false;
    }
  }
}

void checkPowerCatch(){
  if (power.show == true){
      float bottom = power.pY+ power.pSize /2;
      float barl = bar.y;
      float barLeft = bar.x;
      float barRight = bar.x + bar.w;
      if ( bottom >= barl && power.pX > barLeft && power.pX<barRight)
      {
        power.show = false;
        bar.w = int(random(20,300));
        bar.r = random(256);
        bar.g = random(256);
        bar.b = random(256);
        }
      }
}

void resetGame(){
  for (int i = 0; i < row; i++)
  {
    for (int j = 0; j< column; j++)
    {
      box[i*row + j] = new Brick((i+1) *width /(row + 2), (j+1) * 50);
    }
  }
  for(int s =0;s < 3;s++)
  {
    int spec = int(random(0,49));
    if((box[spec].r==0 && box[spec].g==191 && box[spec].b==255)||
       (box[spec].r==255 && box[spec].g==48 && box[spec].b==48))
    {
      s-=1;
    }else{
    box[spec].r=255;
    box[spec].g=48;
    box[spec].b=48;
    }
  }
  for(int t =0;t < 3;t++)
  {
    int spec2 = int(random(0,49));
    if((box[spec2].r==255 && box[spec2].g==48 && box[spec2].b==48)||
       (box[spec2].r==0 && box[spec2].g==191 && box[spec2].b==255))
    {
      t-=1;
    }else{
    box[spec2].r=0;
    box[spec2].g=191;
    box[spec2].b=255;
    }
  }  
    //Reset
    score = 0;
    gameScore = 0;
    point = 0;
    combo = 0;
    life = 3;
    ball2.reset();
    bar.w = 100;
    bar.r = 255;
    bar.g = 255;
    bar.b = 255;
}

void keyPressed(){
  statusCtrl();
}

void statusCtrl(){
  if (key == ENTER)
  {
    switch(status){

    case GAME_START:
      status = GAME_PLAY;
    break;
    case GAME_WIN:
      resetGame();
      status = GAME_PLAY;
    break;
    case GAME_LOSE:
      resetGame();
      status= GAME_PLAY;
    break;
    }
  }
}


