//Textbox class
public class Textbox {
  //parameters for textbox
  public int x, y, h, w;
  public int size;

  //Colors for the textbox
  public Colour Background = colours.get("Grey");
  public Colour Foreground = colours.get("Black");
  public Colour BackgroundSelected = colours.get("Silver");
  public Colour Border = colours.get("Black");

  //border specifications
  public boolean BorderEnable;
  public int BorderWeight = 1;

  //text specifications inside textbox
  public String Text = "";
  public int TextLength = 0;

  private boolean selected = false;

  Textbox() {
    //allows outside configuration of default constructor
  }

  Textbox(int x, int y, int w, int h, int size, boolean BorderEnable) {
    //constructor for textbox
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.size = size;
    this.BorderEnable = BorderEnable;
  }

  void drawTBox() {
    //fills the background and highlights it when hovered
    if (selected) {
      fill(BackgroundSelected.colour);
    } else {
      fill(Background.colour);
    }

    //Drawing of border in textbox
    if (BorderEnable) {
      strokeWeight(BorderWeight);
      stroke(Border.colour);
    } else {
      noStroke();
    }

    rect(x, y, w, h);

    //draw the text inside the textbox
    fill(Foreground.colour);
    textSize(size);
    text(Text, x + (textWidth("a") / 2), y + size);
  }

  boolean keyPress(char pressedKey, int pressedKeyCode) {
    if (selected) {
      if (pressedKeyCode == (int)BACKSPACE) {
        //checks for backspace input
        backspace();
      } else if (pressedKeyCode == 32) {
        //checks for space input
        addText(' ');
      } else if (pressedKeyCode == (int)ENTER) {
        //checks for enter input
        return true;
      } else {
        //checks for capital letters, small letters, and numbers inside the textbox
        boolean isKeyCapitalLetter = (pressedKey >= 'A' && pressedKey <= 'Z');
        boolean isKeySmallLetter = (pressedKey >= 'a' && pressedKey <= 'z');
        boolean isKeyNumber = (pressedKey >= '0' && pressedKey <= '9');

        if (isKeyCapitalLetter || isKeySmallLetter || isKeyNumber) {
          addText(pressedKey);
        }
      }
    }

    return false;
  }

  private void addText(char text) {
    //checks when the text is within boundaries of the rectangle
    if (textWidth(Text + text) < w) {
      Text += text;
      TextLength++;
    }
  }

  private void backspace() {
    //conducts the backspace mechanism inside the textbox
    if (TextLength - 1 >= 0) {
      Text = Text.substring(0, TextLength - 1);
      TextLength--;
    }
  }

  private boolean overBox(int borderX, int borderY) {
    //checks for the point when it is over the rectangle's hitbox
    if (borderX >= x && borderX <= x + w) {
      if (borderY >= y && borderY <= y + h) {
        return true;
      }
    }
    return false;
  }

  void pressed(int x, int y) {
    //changes the selected value
    if (overBox(x, y)) {
      selected = true;
    } else {
      selected = false;
    }
  }
}

//Checkbox class
class Checkbox {
  int x, y, w, h; //position & size
  color checkedColor, uncheckedColor, hoveredColor;
  boolean mouseHover;
  int alternateColors;
  Checkbox(int x, int y, int w, int h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    checkedColor = colours.get("Light Blue").colour;
    uncheckedColor = colours.get("Blue").colour;
    hoveredColor = colours.get("Teal").colour;
    mouseHover = false;
    alternateColors = 0;
  }

  boolean mouseOver(int x, int y, int w, int h) {
    if (mouseX >= x && mouseX <= x+w &&
      mouseY >= y && mouseY <= y+h) {
      return true;
    } else {
      return false;
    }
  }

  void display() {
    //put method on draw();
    hover();
    pushMatrix();
    if (alternateColors == 1 && mouseHover) {
      fill(checkedColor);
    } else if (alternateColors == 0 && mouseHover) {
      fill(hoveredColor);
    } else if (alternateColors == 0 && !mouseHover) {
      fill(uncheckedColor);
    }
    stroke(1);
    strokeWeight(2);
    rect( x, y, w, h);
    if (alternateColors == 1) {
      stroke(1);
      strokeWeight(2);
      line(x, y, x+w, y+h);
      stroke(1);
      strokeWeight(2);
      line(x, y+h, x+w, y);
    }
    popMatrix();
  }

  void hover() {
    if (mouseOver(x, y, w, h)) {
      mouseHover = true;
    } else {
      mouseHover = false;
    }
  }

  boolean onMouseClick() {
    //Put method in mousePressed()
    if (check() && alternateColors == 0) {
      alternateColors = 1;
      return true;
    } else if (check() && alternateColors == 1) {
      alternateColors = 0;
      return false;
    }
    return false;
  }

  boolean check() {
    if (mousePressed && (mouseButton == LEFT) && mouseOver(x, y, w, h)) {
      return true;
    } else {
      return false;
    }
  }
}

//Button class
class Button {
  int x, y; //position
  int w, h; //size
  color clickedColor, defaultColor, hoveredColor;
  String label;
  boolean mouseHover, mouseClicked;

  Button(int x, int y, int w, int h, String label) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.label = label;
    clickedColor = colours.get("Light Blue").colour;
    defaultColor = colours.get("Blue").colour;
    hoveredColor = colours.get("Teal").colour;
    mouseHover = false;
    mouseClicked = false;
  }

  boolean mouseOver(int x, int y, int w, int h) {
    if (mouseX >= x && mouseX <= x+w &&
      mouseY >= y && mouseY <= y+h) {
      return true;
    } else {
      return false;
    }
  }

  void display() {
    hover();
    click();
    pushMatrix();
    if (mouseHover && !mouseClicked) {
      fill(hoveredColor);
    } else if (mouseHover && mouseClicked) {
      fill(clickedColor);
    } else {
      fill(defaultColor);
    }
    stroke(1);
    strokeWeight(2);
    rect( x, y, w, h);
    if (mouseHover)
    {
      fill(colours.get("Black").colour);
    } else {
      fill(colours.get("White").colour);
    }
    textAlign(CENTER, CENTER);
    writeText("Default", x + (w / 2), y + (h / 2), label);
    popMatrix();
  }

  void hover() {
    if (mouseOver(x, y, w, h)) {
      mouseHover = true;
    } else {
      mouseHover = false;
    }
  }

  void click() {
    if (mousePressed && (mouseButton == LEFT) && mouseOver(x, y, w, h)) {
      mouseClicked = true;
    } else {
      mouseClicked = false;
    }
  }
}

//Color palette button class
class Palette {
  int x, y, w, h; //position & size
  color defaultBorder, selectedBorder;
  String palette;
  int alternateColors;

  Palette(int x, int y, int w, int h, String palette) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.palette = palette; //palette colour inside the hashmap
    defaultBorder = colours.get("Black").colour;
    selectedBorder = colours.get("Lime").colour;
    alternateColors = 0;
  }

  boolean mouseOver(int x, int y, int w, int h) {
    if (mouseX >= x && mouseX <= x+w &&
      mouseY >= y && mouseY <= y+h) {
      return true;
    } else {
      return false;
    }
  }

  void display() {
    //put method on draw();
    if (alternateColors == 1) {
      stroke(selectedBorder);
      strokeWeight(2);
    } else if (alternateColors == 0) {
      stroke(defaultBorder);
      strokeWeight(2);
    }
    fill(colours.get(palette).colour);
    rect( x, y, w, h);
  }

  void onMouseClick() {
    //Put method in mousePressed()
    if (check() && alternateColors == 0) {
      alternateColors = 1;
    } else if (check() && alternateColors == 1) {
      alternateColors = 0;
    }
  }

  boolean check() {
    if (mousePressed && (mouseButton == LEFT) && mouseOver(x, y, w, h)) {
      return true;
    } else {
      return false;
    }
  }
}

//Shape icon button palette class
class ShapeSelect {
  int x, y, w, h; //position & size
  color defaultBorder, selectedBorder;
  String shape;
  int alternateColors;

  ShapeSelect(int x, int y, int w, int h, String shape) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.shape = shape; //shape inside the select button
    defaultBorder = colours.get("Black").colour;
    selectedBorder = colours.get("Lime").colour;
    alternateColors = 0;
  }

  boolean mouseOver(int x, int y, int w, int h) {
    if (mouseX >= x && mouseX <= x+w &&
      mouseY >= y && mouseY <= y+h) {
      return true;
    } else {
      return false;
    }
  }

  void display() {
    //put method on draw();
    if (alternateColors == 1) {
      stroke(selectedBorder);
      strokeWeight(2);
    } else if (alternateColors == 0) {
      stroke(defaultBorder);
      strokeWeight(2);
    }
    fill(colours.get("Blue").colour);
    rect( x, y, w, h);
    if (shape == "Circle") {
      stroke(colours.get("White").colour);
      strokeWeight(2);
      ellipse(x + w / 2, y + h / 2, w / 2, h / 2);
    } else if (shape == "Square") {
      stroke(colours.get("White").colour);
      strokeWeight(2);
      rect(x + w / 4, y + h / 4, w / 2, h / 2);
    } else if (shape == "Triangle") {
      stroke(colours.get("White").colour);
      strokeWeight(2);
      triangle(x + w * 0.2, y + h * 0.8, x + w / 2, y + h * 0.2, x + w * 0.8, y + h * 0.8);
    }
  }

  void onMouseClick() {
    //Put method in mousePressed()
    if (check() && alternateColors == 0) {
      alternateColors = 1;
    } else if (check() && alternateColors == 1) {
      alternateColors = 0;
    }
  }

  boolean check() {
    if (mousePressed && (mouseButton == LEFT) && mouseOver(x, y, w, h)) {
      return true;
    } else {
      return false;
    }
  }
}

//clock class
class Clock {
  int cx, cy; //position of clock
  float secondsRadius;
  float minutesRadius;
  float hoursRadius;
  float clockDiameter;
  float second, minute, hour;

  Clock(int radius, int cx, int cy) {
    this.cx = cx;
    this.cy = cy;
    secondsRadius = radius * 0.72;
    minutesRadius = radius * 0.60;
    hoursRadius = radius * 0.50;
    clockDiameter = radius * 1.8;
  }

  void display() {
    drawBackground();
    mapping();
    drawHands();
    drawTicks();
  }

  private void drawBackground() {
    //create the clock frame
    fill(colours.get("Dim Grey").colour);
    rect(cx - (clockDiameter/2) - (clockDiameter * 0.15), cy - (clockDiameter/2) - (clockDiameter * 0.15), clockDiameter * 1.3, clockDiameter * 1.3);
    
    fill(colours.get("Silver").colour);
    rect(cx - (clockDiameter/2) - (clockDiameter * 0.1), cy - (clockDiameter/2) - (clockDiameter * 0.1), clockDiameter * 1.2, clockDiameter * 1.2);
    //create the clock background
    fill(colours.get("Black").colour);
    noStroke();
    ellipse(cx, cy, clockDiameter, clockDiameter);
  }

  private void mapping() {
    // Angles for sin() and cos() start at 3 o'clock
    // subtract HALF_PI to make them start at the top
    second = map(second(), 0, 60, 0, TWO_PI) - HALF_PI;
    minute = map(minute() + norm(second(), 0, 60), 0, 60, 0, TWO_PI) - HALF_PI;
    hour = map(hour() + norm(minute(), 0, 60), 0, 24, 0, TWO_PI * 2) - HALF_PI;
  }

  private void drawHands() {
    // Draw the hands of the clock
    stroke(colours.get("White").colour);
    strokeWeight(1);
    line(cx, cy, cx + cos(second) * secondsRadius, cy + sin(second) * secondsRadius);
    strokeWeight(2);
    line(cx, cy, cx + cos(minute) * minutesRadius, cy + sin(minute) * minutesRadius);
    strokeWeight(4);
    line(cx, cy, cx + cos(hour) * hoursRadius, cy + sin(hour) * hoursRadius);
  }

  private void drawTicks() {
    // Draw the minute ticks
    strokeWeight(2);
    beginShape(POINTS);
    for (int a = 0; a < 360; a+=6) {
      float angle = radians(a);
      float x = cx + cos(angle) * secondsRadius;
      float y = cy + sin(angle) * secondsRadius;
      vertex(x, y);
    }
    endShape();
  }
}

//Rain drop class
class Drop {
  float x = random(width);
  float y = random(-200, -100);
  float z = random(0, 20);
  float yspeed = map(z, 0, 20, 4, 10);
  int size = 8;

  void fall() {
    y = y + yspeed;
    yspeed = yspeed + 0.05;

    if (y > height * 0.6) {
      y = random(-200, -100);
      yspeed = random(4, 15);
    }
  }

  void show() {
    noStroke();
    for (int i = 2; i < size; i++ ) {
      fill(colours.get("Purple").colour);
      ellipse(x, y + i*4, i*2, i*2);
    }
    fill(colours.get("Black").colour);
  }
}
