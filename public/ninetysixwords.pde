/* @pjs font="mplus-2p-regular.ttf"; */

PFont myFont;

float[]flakesListX = new float[100];
float[]flakesListY = new float[100];
color[]flakesListC = new color[100];
snowFlake[] snowFlakeList = new snowFlake[10];
int snowFlakeIDX = 0;
int flakesListIDX = 0;
String title = "recognize love and hate is born...";
String autorT = "web development";
String autorN = "Fernando Pires";
String musicT = "music";
String musicN = "Tomuto Suda";
String contact = "info@gmail.com";
float alphaV;

void setup()
{
size( document.documentElement.clientWidth,document.documentElement.clientHeight);
background(177,210,217);
smooth();

myFont = createFont("mplus-2p-regular.ttf",12,true);

}


class snowFlake
{
  
  float posX, posY, posXPrev;
  float xoff = 0.1;
  float angleInc = 0;
  float angleSign;
  String[] tokenList;
  float maxLength = 0;
  float fontS;
  float coord;
  boolean writePos = true;
  float xoffinc;
  color flakeColor;

   snowFlake(int _height, String message, String msgType)
    {
      if(msgType == "love") 
        flakeColor = color(255, 255, 255, 50);
      else
        flakeColor = color(134, 138, 141, 50);
      
      coord = random(20,_height - 20);
       
      tokenList = split(message,' ');
      xoffinc = map(tokenList.length,1,40,0.0125,0.010);
      if (xoffinc == 0.0) xoffinc = 0.01;
     
      String element;
      
      for(int i=0;i<tokenList.length;i=i+1)
      {
        element = tokenList[i];
        if(element.length() > maxLength) 
          maxLength = tokenList[i].length(); 
      }
      
      if (tokenList.length < 6)
      {
        int aux = tokenList.length;
        tokenList = expand(tokenList, 6);
        for(int i=aux;i<6;i=i+1)
        {
         tokenList[i]= "";
        } 
      
      }
      
      fontS = map(tokenList.length,1,40,18,4);
      if (fontS == 0.0) fontS = 12;
      
     
      //posX = random( (message.length())/2, width - (message.length())/2);
      posY = - (maxLength * fontS * 1.25 );
      
      maxLength = maxLength + 9;

      for(int i=0;i<tokenList.length;i=i+1)
      {
       tokenList[i] = "  . " + tokenList[i];
       float dots = maxLength - tokenList[i].length() - 2;
      
       for(int j=0;j< max(dots/3,1);j=j+1)
       { 
         if (j==0)
           tokenList[i] =  tokenList[i] + " ";
         else
           tokenList[i] =  tokenList[i] + "-";  
       }
      
       tokenList[i] =  tokenList[i] + "<";
       tokenList[i] =  tokenList[i] + "-";
       
      } 
      
    }
    
  void drawFlake()
  {
    
    xoff = xoff + xoffinc;
    posXPrev = posX;
    posX = noise(xoff)* width ;

    posY = posY + 1.5 * noise(xoff);
   
    
    if(posX > posXPrev)
      angleSign = 1;
    else 
      angleSign = -1;
    
     if (frameCount % 5 == 0)
      {
      if (angleInc == 360)
         angleInc = 0.01;
      else
        angleInc = angleInc + 0.01 * angleSign ; 
      }
      float angle = TWO_PI/tokenList.length;
    
    for(int i=0;i<tokenList.length;i=i+1)
    {
      
      fill(flakeColor,map(i,0,tokenList.length,255,100));
      textAlign(LEFT);
      textFont(myFont,fontS);
      textSize(fontS); 
      
      pushMatrix();
        translate(posX,posY);
        rotate(angle  * i);
        rotate(angleInc);
        text(tokenList[i],0,0);
      popMatrix();
    }

   if (posY>= coord & writePos == true) 
    {
      flakesListX[flakesListIDX] = posX/width;
      flakesListY[flakesListIDX] = posY/height;
      flakesListC[flakesListIDX] = flakeColor;
      flakesListIDX++;
      if(flakesListIDX==100) 
      {
         flakesListIDX = 0;
      }
      writePos = false;
     
      
    }
    
  }

}

void drawCrumbs ()
{
  
  for(int i=0;i<flakesListX.length;i=i+1)
    {
      fill(flakesListC[i]);
      textAlign(CENTER);
      textFont(myFont,36);
      text("*",width * flakesListX[i],height * flakesListY[i]); 
    }
}

void injectFlake (String message, String msgType)
{
  snowFlake thisSnowFlake = new snowFlake(height,message,msgType);
  snowFlakeList[snowFlakeIDX] = thisSnowFlake;
  snowFlakeIDX++;
  if (snowFlakeIDX == 10) snowFlakeIDX = 0;
}

void setSize (int scrWidth, int scrHeight)
{
   size(scrWidth,scrHeight);
}



void draw()
{
   if(frameCount < 1000)
   { 
     if(frameCount < 600)
       alphaV = map(frameCount,1,600,0,255);
     else
       alphaV = map(frameCount,600,1000,255,0);
     background(177,210,217);
     fill(0,0,0,alphaV);
     textAlign(CENTER);
     textFont(myFont,14);
     text(title,width/2 ,height/3); 
     textSize(36); 
     text("*",width/2 ,height/2); 
     textSize(14); 
     fill(150,150,150,alphaV);
     text(autorT,width/3 ,height/3 * 2); 
     text(autorN,width/3 ,height/3 * 2 + 20); 
     text(musicT,width/3 * 2 ,height/3 * 2); 
     text(musicN,width/3 * 2 ,height/3 * 2 + 20);
     text(contact,width/2 ,height/2 + 20);
   }  
   else
   {
    noCursor();
    if (frameCount % 5 == 0) 
    {
      
      background(177,210,217);
       
      for(int i=0;i<snowFlakeList.length;i=i+1)
        {
          if(snowFlakeList[i] != null)
          {
            snowFlakeList[i].drawFlake();
            if (snowFlakeList[i].posY > (height + snowFlakeList[i].maxLength * snowFlakeList[i].fontS * 1.25 ))
              {
                snowFlakeList[i] = null;
              } 
          }  
        }
    drawCrumbs();    
    } 
   }
  
}
