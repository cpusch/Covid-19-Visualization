DrawMap map;  
Slider slider;
PFont font, titleFont;
Legend legend;
ArrayList widgetList;
Widget link;
Widget forwardButton;
Widget backwardButton;
TextWidget focus;
String state2;
int screenSelect;

import peasy.*;
PeasyCam cam;
State state;
PApplet parent;

String code;
String stateName;
int week; // need to be modified

void settings() {
  size(SCREENX, SCREENY, P3D);
}

void setup() {
  screenSelect = SCREEN_ONE; //<>//
  map = new DrawMap();
  slider = new Slider();
  legend = new Legend();
  font = loadFont("Serif-10.vlw");
  titleFont = loadFont("AppleSDGothicNeo-Regular-36.vlw");

  link=new Widget(760, 75, 140, 30, "Click here for further info", color(#faed27),
    font, EVENT_BUTTON1);

  TextWidget textedit=new TextWidget(700, 20, 200, 30,
    "Enter state here: ", color(#DBDBDB), font, EVENT_BUTTON3, 20);
  focus = null;

  forwardButton = new Widget(780, 100, 200, 30,
    "Click here for state restrictions", color(#6668A0), font, EVENT_BUTTON2);

  backwardButton = new Widget(20, 20, 145, 30,
    "Press Tab to return to main page", color(#6668A0), font, EVENT_BUTTON4);

  widgetList = new ArrayList();
  widgetList.add(link);
  widgetList.add(forwardButton);
  widgetList.add(backwardButton);
  widgetList.add(textedit);
  frameRate(400);
}
//added switch to handle different screens
void draw() {
  pushStyle();
  background(46);
  switch (screenSelect) {
  case SCREEN_ONE:
    map.draw(slider.getWeek());
    slider.draw();
    legend.draw();
    textFont(titleFont);
    textAlign(CENTER);
    text("Total State Covid Cases per 100,000", 380, 40, 300, 100);
    textFont(font);
    textAlign(LEFT);
    textFont(font);
    forwardButton.draw();
    break;
  case SCREEN_TWO:
    state.draw();
    break;

  case SCREEN_THREE:
    restrictionsPage();
  default:
    break;
  }
  smooth();
  popStyle();
}

void mouseDragged() {
  slider.changeWeek(mouseX, mouseY);
}

void mouseClicked() {
  slider.changeWeek(mouseX, mouseY);
}

void mousePressed() 
{
  int event;
  for (int i = 0; i<widgetList.size(); i++)   // Input handaling
  {
    Widget aWidget = (Widget) widgetList.get(i);
    event = aWidget.getEvent(mouseX, mouseY);
    switch(event)
    {
    case EVENT_BUTTON1:
      link("https://covid.cdc.gov/covid-data-tracker/#datatracker-home");
      println("link");
      break;

    case EVENT_BUTTON2:
      println("forward to restrictions page");
      screenSelect = SCREEN_THREE;
      break;

    case EVENT_BUTTON3:
      focus= (TextWidget)aWidget;
      break;

 //   case EVENT_BUTTON4:
 //     println("back to main page page");
  //    screenSelect= SCREEN_ONE;
 //     break;
    }
  }

  if (mouseX >= 52 && mouseX <= 965 && mouseY >= 203 && mouseY < 788)  
  {
    if (screenSelect == SCREEN_ONE)
    {
      println("pressed");
      screenSelect = SCREEN_TWO;
      code = map.code;
      stateName = map.nameOfState;
      week = slider.getWeek() + 1;
      println(week);
      parent = this;
      state = new State(parent, code, stateName, week);
    }
  }
}

void keyPressed() { 
  if (screenSelect == SCREEN_TWO)
  {
    if (key == ENTER)
    {
      PeasyCam cam = state.getCam();
      cam.reset();
      cam.lookAt(500, 400, 0);
      cam.setDistance(700);
      cam.setActive(false);
      screenSelect = SCREEN_ONE;
    }
  }
  if (screenSelect == SCREEN_THREE) {
    if(key == TAB)                             // pressing tab returns to main screen
    screenSelect = SCREEN_ONE;
    
    if (focus != null) {
      focus.append(key);
      loop();
    }
    if (key == ENTER) {
      state2 = focus.getText();
      println(state);
      restrictions stateRestrictions = new restrictions(state2);
      stateRestrictions.draw();
      noLoop();
    }
  }
}

void restrictionsPage() {
  textFont(titleFont);
  text("Restrictions in your state", 200, 50);
  textFont(font);
  ((TextWidget)widgetList.get(3)).draw();
  link.draw();
  backwardButton.draw();
}
