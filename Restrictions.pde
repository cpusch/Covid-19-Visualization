// this class displays the restrictions in a state and the % of the state who have been vaccinated when the user types in the state
// the information was taken from the New York Times website and manually made into an excel table
class restrictions {
  Table stateTable;
  String state;
  String myState;
  PFont headingFont;
  PFont detailsFont;
  String currentState;

  restrictions(String state) {
    this.state = state;
    headingFont = loadFont("AppleSDGothicNeo-Regular-20.vlw");
    detailsFont = loadFont("AppleSDGothicNeo-Regular-12.vlw");
    stateTable = loadTable("stateRestrictions.csv", "header");
    getState();
    fullStateInfo();
  }

  void draw() {
    fullStateInfo();
  }

  String removeSpace(String str)           
  {
    str = str.replaceAll("\\s", "");
    return str;
  }


  void getState() {
    String aState = state;
    myState = removeSpace(aState);
  }



  void fullStateInfo() {
    getState();
    for (int row =0; row< stateTable.getRowCount(); row++) {
      currentState =  (stateTable.getRow(row).getString("State"));

      if (currentState.equalsIgnoreCase(myState)) {
        String bothDoses = stateTable.getRow(row).getString("bothDose");
        String firstDose = stateTable.getRow(row).getString("firstDose");
        String generalRestrictions = stateTable.getRow(row).getString("Restrictions");
        String retail = stateTable.getRow(row).getString("Retail");
        String foodAndDrink = stateTable.getRow(row).getString("F&D");
        String personalCare = stateTable.getRow(row).getString("PersonalCare");
        String houseOfWorship = stateTable.getRow(row).getString("HousesOfWorship");
        String entertainment = stateTable.getRow(row).getString("Entertainment");
        String outdoors = stateTable.getRow(row).getString("OutdoorAndRec");
        String industries = stateTable.getRow(row).getString("Industries");
        String closed = stateTable.getRow(row).getString("Closed");

        textFont(headingFont);
        fill(#FFFDB9);
        noStroke();
        rect(28, 100, 210, 50, 10);
        fill(0);
        text("% with first dose: " + firstDose+"\n% fully vaccinated: "+bothDoses, 30, 120);

        text("General restrictions ", 30, 210);
        fill(#DBCCFC);
        rect(30, 220, textWidth(generalRestrictions)+10, 30, 10);
        fill(0);
        text(generalRestrictions, 30, 240);

        text("What's open ", 30, 300);
        fill(#D3FFD5);
        rect(30, 310, 700, 250, 10);
        fill(0);
        textFont(detailsFont);
        text("Retail: "+retail, 30, 330);
        text("Food and Drink: "+foodAndDrink, 30, 350);
        text("Personal Care: "+personalCare, 30, 370);
        text("Houses of Worship: "+houseOfWorship, 30, 390);
        text("Entertainment: "+entertainment, 30, 410, 700, 50);
        text("Outdoor and Recreation: "+outdoors, 30, 410+50, 700, 40);
        text("Industries: "+industries, 30, 470+40);

        textFont(headingFont);
        text("What's closed ", 30, 600);
        fill(#FFB2B2);
        rect(30, 610, 700, 25, 10);
        fill(0);
        textFont(detailsFont);
        text("Closed: "+closed, 30, 625);
        noFill();
      }
    }
  }
}
