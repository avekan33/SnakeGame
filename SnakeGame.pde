//Snake Game
Snake snake;
Food cherry;
boolean gameOver;
void setup()
{
  size(600,300);
  background(0);
  snake = new Snake();
  cherry = new Food();
  frameRate(15);
  gameOver = false;
}
void draw()
{
  background(0);
  snake.show();
  snake.move();
  snake.score();
  snake.check();
  cherry.show();
  if(gameOver)
  {
    fill(0,0,255);
    rect(0,0,600,300);
    fill(255,255,0);
    textSize(32);
    textAlign(CENTER);
    text("GAME OVER", 300, 150);
    textSize(20);
    text("Score: "+snake.count, 300, 170);
    text("Length: "+snake.currentLength, 300, 190);
  }
  if(cherry.isEaten(snake.direction))
  {
    cherry.randomize();
    snake.count++;
    if(snake.currentLength<snake.maxLength)
    {
      snake.currentLength++;
    }
  }
}
void keyPressed()
{
  snake.direction = keyCode;
}
class Segment
{
  int x;
  int y;
  int side;
  color snakeColor;
  Segment()
  {
    x = 285;
    y = 135;
    side = 15;
    snakeColor = color(255,0,0);
  }
  void show()
  {
    stroke(255);
    fill(snakeColor);
    rect(x,y,side,side);
  }
}
class Snake
{
  Segment segments[];
  int direction;
  int currentLength;
  int maxLength;
  int count;
  Snake()
  { 
    direction = RIGHT;
    currentLength = 3;
    count = currentLength - 3;
    maxLength = 30;
    segments = new Segment[maxLength];
    for(int i =0; i< maxLength;i++)
    {
      segments[i] = new Segment();
    }
    segments[0].snakeColor = color(255,255,0);
  }
  void move()
  {
    for(int i = currentLength -1 ; i>0;i--)
    {
      segments[i].x = segments[i-1].x;
      segments[i].y = segments[i-1].y;
    }
    if(direction == RIGHT)
    {
      segments[0].x += segments[0].side;
    }
    else if(direction == LEFT)
    {
      segments[0].x -= segments[0].side;
    }
    else if(direction == UP)
    {
      segments[0].y -= segments[0].side;
    }
    else if(direction == DOWN)
    {
      segments[0].y += segments[0].side;
    }
  }
  void show()
  {
    for(int i =0; i< currentLength;i++)
    {
      segments[i].show();
    }
  }
  void score()
  {
    fill(255,0,255);
    text("Score:"+count, 30,30);
    fill(0,255,0);
    text("Length: "+currentLength, 30, 50);
  }
  void check()
  {
    if(segments[0].x >600 || segments[0].x<0)
    {
      gameOver = true;
    }
    else if(segments[0].y>300 || segments[0].y <0)
    {
      gameOver = true;
    }
    if(direction == RIGHT && get(segments[0].x+segments[0].side+1, segments[0].y+(segments[0].side/2)) == color(255,0,0))
    {
      gameOver = true;
    }
    else if(direction == LEFT && get(segments[0].x-1, segments[0].y+(segments[0].side/2)) == color(255,0,0))
    {
      gameOver = true;
    }
    else if(direction == UP && get(segments[0].x+(segments[0].side/2), segments[0].y-1) == color(255,0,0))
    {
      gameOver = true;
    }
    else if(direction == DOWN && get(segments[0].x+(segments[0].side/2), segments[0].y+(segments[0].side/2)+1) == color(255,0,0))
    {
      gameOver = true;
    }
  }
}
class Food
{
  int x;
  int y;
  int diam;
  color checkColor;
  Food()
  {
    x = 400;
    y = 100;
    diam = 10;
    checkColor = color(255,255,0);
  }
  void randomize()
  {
    x = int(random(50,550));
    y = int(random(50,250));
  }
  void show()
  {
    stroke(0,255,255);
    fill(0,255,255);
    ellipse(x,y,diam,diam);
  }
  boolean isEaten(int direction)
  {//a bunch of clauses probing around the food for contact
    if(direction == RIGHT && get(x-(diam/2)-1,y) == checkColor)
    {
      return true;
    }
    else if(direction == LEFT && get(x+(diam/2)+1,y) == checkColor)
    {
      return true;
    }
    else if(direction == UP && get(x,y+(diam/2)+1) == checkColor)
    {
      return true;
    }
    else if(direction == DOWN && get(x,y-(diam/2)-1) == checkColor)
    {
      return true;
    }
    else
    {
      return false;
    }
  }
}

