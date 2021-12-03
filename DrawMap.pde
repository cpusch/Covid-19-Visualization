class DrawMap 
{
  PShape USMap;
  PShape state;
  PShape dc;
  PGraphics buffer;
  Table data;
  Table cases;
  float redFloat;
  color c;
  color buffercolor, mousecolor;
  float dataMin = -7;
  float dataMax = 11;
  String code;
  String nameOfState;
  color[] colorArray = new color[]{#FFE5D9, #FCAF92, #ffe699, #FA6948, #f93306, #DE2C26, #A60F14, #5d090b}; 
  //{#CC3D44, #E67378, #FFA6AA, #FFDF81, #A6BEFF, #7391E6, #3D63CC};

  DrawMap()
  {
    buffer = createGraphics(width, height, JAVA2D);
    USMap = loadShape("usa-wikipedia.svg");
    data = loadTable("StateAbbreviations.csv", "header");
    cases = loadTable("stateCasesPerCapita.csv", "header");
    dc = loadShape("DCSVG.svg");
    dc.scale(.3);
  }

  void draw(int week)
  {
    dc.disableStyle();
    background(255);
    noStroke();
    USMap.disableStyle();
    int rowCount = cases.getRowCount();
    //for loop traverses the stateabbreviations.csv and creates off screen buffer to be able to select states with buffer.get
    for (int row = 0; row < rowCount; row++) {
      String abbrev = cases.getRow(row).getString("State");
      String stateName = cases.getRow(row).getString("StateName");
      state = USMap.getChild(abbrev);
      //draws DC seperatly to be visable
      if(abbrev.equals("DC")) //<>//
      {
        buffer.beginDraw();
        buffer.background(255);
        buffercolor = row;
        buffer.noStroke();
        buffer.fill(buffercolor);
        buffer.shape(dc, 900, 440);
        buffer.endDraw();
        mousecolor = buffer.get(mouseX, mouseY);
        //println(buffer.get(mouseX, mouseY));
        redFloat = mousecolor >> 16 & 0xFF;
      }
      else
      {
        buffer.beginDraw();
        buffer.background(255);
        buffercolor = row;
        buffer.noStroke();
        buffer.fill(buffercolor);
        buffer.shape(state, MAPX, MAPY);
        buffer.endDraw();
        mousecolor = buffer.get(mouseX, mouseY);
        redFloat = mousecolor >> 16 & 0xFF; 
      }

      //draws states depending on mouse position
      if (state == null)
      {
        println("No state found for" + abbrev);
      } 
      else
      {
        stroke(255);
        TableRow currentRow = cases.getRow(row);
        Float currentCases    = currentRow.getFloat(Integer.toString(week));
        c = colorArray[Math.round(currentCases / 1909)];
        fill(c);
        //when mouse hovers over the buffer color(aka the state) it draws state as grey
        if (redFloat == row)
        {
          //println(abbrev);
          Info infoBox = new Info(stateName, abbrev, parseInt(week));
          infoBox.draw();
          
          LineGraph lGraph = new LineGraph(abbrev, parseInt(week));
          lGraph.draw();
          fill(160);
          
          code = abbrev;             // updated by Moeto 19/4/21
          nameOfState = stateName;
        }
        if(abbrev.equals("DC"))
        {
          shape(dc, 900, 440);
        }
        else
        {
          shape(state, MAPX, MAPY);
        }
      }
      
      noFill();
    }
  }
}
