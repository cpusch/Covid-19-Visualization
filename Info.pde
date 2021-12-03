// this class reads in the weekly cases for each state from a table and displays them in an information box
// the state name, abbreviation and week are all passed in from the DrawMap class when the mouse hovers over a state

class Info {
  Table casesData;
  Table deathsData;
  String stateName;
  String stateAbbrev;
  int week;
  int theCases;
  int theDeaths;
  PFont font1;
  PFont font2;

  Info(String stateName, String stateAbbrev, int week) {
    this.week = week;
    this.stateAbbrev = stateAbbrev;
    this.stateName = stateName;
    casesData = loadTable("stateCasesPerCapita.csv", "header");
    deathsData = loadTable("stateDeathsPerCapita.csv", "header");
    font1 = loadFont(".SFNS-Bold-12.vlw");
    font2 = loadFont("Serif-12.vlw");
    getInfo();
  }

  void draw() {
    stroke(0);
    fill(255);
    rect(20, 5, textWidth(stateName)+300, 200);
    line(40, 40, textWidth(stateName)+150, 40);
    noStroke();
    fill(0);
    textFont(font1);
    text (stateName + " (" + stateAbbrev +")", 70, 30 );
    text ("Cases per 100k: ", 30, 60);
    text("Deaths per 100k: ", 30, 80);
    textFont(font2);
    text(theCases, 150, 60);
    text(theDeaths, 155, 80);
    
  }

  void getInfo() {
    theCases = 0;
    theDeaths = 0;
    int rowCount = casesData.getRowCount();
    for (int row = 0; row < rowCount; row++) {
      String myWeek = "" + week + "";

      int aCases = int(casesData.getRow(row).getString(myWeek));
      int aDeaths = int(deathsData.getRow(row).getString(myWeek));
      String aStateAbbrev = casesData.getRow(row).getString("State");

      if (aStateAbbrev.equals(stateAbbrev)) {
        theCases = aCases;
        theDeaths = aDeaths;
      }
    }
  }
}
