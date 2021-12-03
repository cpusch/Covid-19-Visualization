class Legend{
  color[] colors = new color[]{#FFE5D9, #FCAF92, #ffe699, #FA6948, #f93306, #DE2C26, #A60F14, #5d090b};;  
  PFont font;
  int casesMin = 0;
  int casesMax = 13363;
  final int legendY = 210;
  
  Legend()
  {
    font = loadFont("Serif-10.vlw");
  }
  
  void draw()
  {
    //draws rectangles with appropriate colors
    fill(colors[0]);
    rect(360, legendY, 40, 10);
    fill(colors[1]);
    rect(400, legendY, 40, 10);
    fill(colors[2]);
    rect(440, legendY, 40, 10);
    fill(colors[3]);
    rect(480, legendY, 40, 10);
    fill(colors[4]);
    rect(520, legendY, 40, 10);
    fill(colors[5]);
    rect(560, legendY, 40, 10);
    fill(colors[6]);
    rect(600, legendY, 40, 10);
    fill(colors[7]);
    rect(640, legendY, 40, 10);
    fill(0);
    //text to display min and max cases
    text(casesMin, 350, legendY + 9);
    text(casesMax, 685, legendY + 9);
    noFill();
  }
}
