class State {          
  String code;
  String stateName;
  Table table;
  Table table2;
  Table table3;
  int week;
  PImage state;
  PFont font;
  PFont font2;
  float bar;
  float hue;
  float lonTo;
  float lonFrom;
  float latTo;
  float latFrom;
  PeasyCam cam;



  State(PApplet parent, String code, String stateName, int week) {
    cam = new PeasyCam(parent, 1000);
    font = loadFont("Serif-13.vlw");
    font2 = loadFont("ArialHebrew-50.vlw");
    colorMode(HSB);
    this.code = code;
    this.stateName = stateName;
    this.week = week;
    loadState(code);
    loadTableOfState();
  }

  PeasyCam getCam() {
    return cam;
  }

  void setCam() {
    cam = null;
  }

  void loadState(String code) {
    state = loadImage(code + ".png");
  }

  void loadTableOfState() {
    table = loadTable("County_Weekly_Cases_with_GeoCode.csv", "header");
    table2 = loadTable("maximum_cases.csv", "header");
    table3 = loadTable("StateCordinates.csv", "header");
  }

  void draw() {
    background(0);
    translate(-state.width/2, -state.height/2);

    noStroke();
    beginShape();
    texture(state);
    vertex(0, 0, 0, 0, 0);
    vertex(state.width, 0, 0, state.width, 0);
    vertex(state.width, state.height, 0, state.width, state.height);
    vertex(0, state.height, 0, 0, state.height);
    endShape();

    fill(255);

    for (int i = 0; i < table.getRowCount(); i++)
    {
      String stateCode = table.getRow(i).getString("state");
      String countyName = table.getRow(i).getString("county");
      float lat = table.getRow(i).getFloat("latitude");
      float lon = table.getRow(i).getFloat("longitude");
      float cases = table.getRow(i).getFloat(week);

      if (code.equals(stateCode))
      {
        for (int n = 0; n < table3.getRowCount(); n++)
        {
          String codeForCordinates = table3.getRow(n).getString("State");
          float a = table3.getRow(n).getFloat("West");
          float b = table3.getRow(n).getFloat("East");
          float c = table3.getRow(n).getFloat("North");
          float d = table3.getRow(n).getFloat("South");

          if (code.equals(codeForCordinates))
          {
            lonTo = a;
            lonFrom = b;
            latTo = c;
            latFrom = d;
          }
        }

        float x = map(lon, lonFrom, lonTo, state.width, 0);    // need to declare lonFrom, lonTo, latFrom, and latTo of each state
        float y = map(lat, latFrom, latTo, state.height, 0);



        for (int p = 0; p < table2.getRowCount(); p++)
        {
          String codeForMax = table2.getRow(p).getString("state");
          float maxCases = table2.getRow(p).getFloat("max");
          if (code.equals(codeForMax))
          {
            bar = map(cases, 1, maxCases, 1, 400);

            hue = map(cases, 1, maxCases, 120, 0);
          }
        }

        pushMatrix();
        rotateX( radians(-90) );
        textFont(font2);
        text(stateName + " ( " + code + " ) : Week " + week, 0, -300, 0);
        popMatrix();

        if (cases >= 0)
        {
          fill(hue, 255, 255, 180);
          textFont(font);
          pushMatrix();
          translate(x, y, bar/2);
          box(3, 3, bar);
          popMatrix();

          pushMatrix();
          fill(0, 0, 255);
          translate(x, y, bar);
          rotateX( radians(-90) );
          text(countyName + ": " + cases, 0, 0);
          popMatrix();
        }
      }
    }
  }
}
