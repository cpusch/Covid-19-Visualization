class Slider {
  PFont font;
  int rec = 800;
  int cir = 820;
  
  Slider()
  {
    font = loadFont("Serif-10.vlw");
  }
  
  int getWeek()
  {
    //checks that the calculated week is not greater than 53 and returns current week accordingly
     if(int((cir - 800) / 3) > 53)
       return 53; 
     else
       return int((cir - 800) / 3);
  }

  void draw() //slightly modified draw method from saif_map_2
  {
    pushStyle();
    strokeWeight(5);
    fill(#0000ff);
    //length of 162 since its evenly divisible by 54
    rect(rec, 35, 162, 10);
    fill(255);
    stroke(0);
    circle(cir, 40, 20);
    fill(0);
    text("Week " + (getWeek() + 1), 861, 25);
    text("3/19/2020", 780, 65);
    text("3/30/2021", 940, 65);
    noFill();
    noStroke();
    popStyle();
  }

  void changeWeek(int mousex, int mousey)
  {
    //only moves circle(slider) if in the right range of x and y cordinates
    if(mousey < 50 && mousey > 30)
    {
      if(mousex >= 800 && mousex <= 962)
      {
        if(mousex > 962)
          cir = 962;
        else if(mousex < 800)
          cir = 800;
        else
          cir = mousex;
      }
    }
  }
}
