// this class maps the weekly cases and deaths on a line graph in the information box
// the vertical line indicates the current week the slider is on 

class LineGraph{

  Table casesData;
  Table deathsData;
  ArrayList<Integer> cases = new ArrayList();
  ArrayList<Integer> deaths = new ArrayList();
  String stateAbbrev;
  int margin;
  int graphHeight;
  float xSpacer;
  int min;
  int max;
  int week;
  PVector[] position = new PVector[54];
  PVector[] positionD = new PVector[54];
  PFont font = loadFont("Serif-10.vlw");

  LineGraph(String stateAbbrev, int week) {
    this.week = week;
    this.stateAbbrev = stateAbbrev;
    casesData = loadTable("stateCasesPerCapita.csv", "header");
    deathsData = loadTable("stateDeathsPerCapita.csv", "header");
    getInfo();
    processData();
  }

  void draw() {
    fill(0);
    text("Total cases and deaths in " + stateAbbrev, position[14].x, 100);
    stroke(0);
    for (int i = 0; i<position.length; i++) {
      if (i<53) {
        stroke(#F20000);
        line(position[i].x, position[i].y, position[i+1].x, position[i+1].y);
        stroke(#0C47F2);
        line(positionD[i].x, positionD[i].y, positionD[i+1].x, positionD[i+1].y);
        noStroke();
      }
      fill(#F20000);
      ellipse(position[i].x, position[i].y, 2.5, 2.5);
      fill(#0C47F2);
      ellipse(positionD[i].x, positionD[i].y, 2.5, 2.5);
      fill(0);
    }
    stroke(#A0A0A0);
    line(position[week].x, 200-margin, position[week].x, position[53].y);
    fill(#A0A0A0);
    textFont(font);
    text("week "+ (week + 1), position[week].x+7, position[53].y+5 );
    text(" = cases", position[53].x+20, 127);
    text(" = deaths", position[53].x+20, 157);
    stroke(0);
    line(margin+20, 200-margin, margin+20, position[53].y);
    line(margin+20, 200-margin, position[53].x, 200-margin);
    fill(#F20000);
    rect(position[53].x+10, 120, 10, 10);
    fill(#0C47F2);
    rect(position[53].x+10, 150, 10, 10);
    noStroke();
    noFill();
  }


  void getInfo() {
    int rowCount = casesData.getRowCount();
    for (int row = 0; row < rowCount; row++) {
      String aStateAbbrev = casesData.getRow(row).getString("State");

      if (aStateAbbrev.equals(stateAbbrev)) {
        for (int i=0; i<54; i++) {
          String myWeek = "" + i + "";
          int aCases = int(casesData.getRow(row).getString(myWeek));
          int aDeaths = int(deathsData.getRow(row).getString(myWeek));
          cases.add(aCases);
          deaths.add(aDeaths);
        }
      }
    }
    // println(cases);
    // println(deaths);
  }

  void processData() {
    margin = 5;
    graphHeight = 120 - margin - margin;
    xSpacer = (300 - margin - margin) / (cases.size() - 1);

    min = deaths.get(0);
    for (int i=0; i<deaths.size(); i++) {
      if (min > deaths.get(i))
        min = deaths.get(i);
    }
    max = cases.get(0);
    for (int i=0; i<cases.size(); i++) {
      if (max < cases.get(i))
        max = cases.get(i);
    }



    for (int i =0; i<cases.size(); i++) {
      float adjCase = map(float(cases.get(i)), min, max, 0, graphHeight);
      float yPos = 200 - margin - adjCase;
      float xPos = margin+20 +(xSpacer * i);
      position[i] = new PVector(xPos, yPos);
    }

    for (int i =0; i<deaths.size(); i++) {
      float adjCase = map(float(deaths.get(i)), min, max, 0, graphHeight);
      float yPos = 200 - margin - adjCase;
      float xPos = margin+20 +(xSpacer * i);
      positionD[i] = new PVector(xPos, yPos);
    }
  }
}
