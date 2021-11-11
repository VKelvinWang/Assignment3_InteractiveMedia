/*
 *  Assignment 3 Final Interactive Media Project
 *  All-in-1 Work Hub
 *  Made by Vinsensius Kelvin Wang - 13146271
 */

//  IDEAS:
//  All-in-1 Work Hub with drawing canvas and text editor


//  TODO:
//  Add the caps lock and backspace functionality

/*
 *  Imports from external library using:
 *  Java default libraries for Input/Output & DateTime
 *  Sound & Video Processing Libraries
 *  Websockets
 *  OpenCV
 *  ControlP5s
 */

import processing.sound.*;
import java.util.*;
import java.io.File;
import java.io.IOException;
import processing.video.*;
import controlP5.*;
import javax.swing.*;
import java.awt.*;
import java.awt.Toolkit;
import processing.net.*;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

/*
 *  Global Variables
 */

//ControlP5 Variables
ControlP5 feature1;
ControlP5 fixed;

//HUD variables
Drop[] drops;
int defaultTextSize = 20;
String name = "", age = "", text = "";
int numDrops = 50;
Clock clock;

//For transition buttons between interfaces
boolean showButton = false;
boolean isF1Enabled = false, isF2Enabled = false;

//Audio variables
float volumeBG = 0.5; //default volume
String path = "";
boolean isAudioValid = true;
boolean playOnAwake = true;

//Variable for making custom setup() in each feature
boolean isConducted = false;

//Default Java Date Class
LocalDate date;
DateTimeFormatter formatter;
String formattedDate;

//stores the int that determines the current menu
int currMenu = 1;

//Hashmaps to store the details of every media
HashMap<String, Textbox> textboxes;
HashMap<String, SoundFile> sounds;
HashMap<String, PImage> images;
HashMap<String, Colour> colours;
HashMap<String, PFont> fonts;
HashMap<String, Checkbox> checkboxes;
HashMap<String, Button> buttons;

//Feature Variables
HashMap<String, ShapeSelect> shapeButtons;
HashMap<String, Palette> palettes;

//default shape properties
int shapeSize = 20;
color shapeColor;
color bgColor;

//default text editor components & properties
StringList lines = new StringList();
String word = "";
int textSize;
color textBG;
color textColor;
PFont textFont;


void writeText(String type, float x, float y, String text) {
  //simplifies writing a text
  textFont(fonts.get(type));
  text(text, x, y);
}

int convertStringToInt(String s) {
  try {
    int i = Integer.parseInt(s);
    return i;
  }
  catch(NumberFormatException e) {
    //returns a high number
    return 200;
  }
}

boolean isAnImage(String loadPath) {
  return (
    loadPath.endsWith(".jpg") ||
    loadPath.endsWith(".jpeg") ||
    loadPath.endsWith(".png")  ) ;
}

boolean isAnAudio(String loadPath) {
  return (
    loadPath.endsWith(".wav") ||
    loadPath.endsWith(".mp3") ) ;
}

boolean isStringInt(String check) {
  try {
    Integer.parseInt(check);
    return true;
  }
  catch(NumberFormatException s) {
    return false;
  }
}

void setup() {
  //default settings for the window
  size(1600, 900);
  surface.setTitle("Assignment 3 - Interactive Media");
  surface.setResizable(true);
  surface.setLocation(100, 100);
  drops = new Drop[numDrops];
  date = LocalDate.now();
  formatter = DateTimeFormatter.ofPattern("EEEE, dd MMMM yyyy");
  formattedDate = date.format(formatter);

  //ControlP5 Declaration
  fixed = new ControlP5(this);

  //Declaration of all hashmaps and arraylists
  textboxes = new HashMap<String, Textbox>();
  sounds = new HashMap<String, SoundFile>();
  images = new HashMap<String, PImage>();
  colours = new HashMap<String, Colour>();
  fonts = new HashMap<String, PFont>();
  checkboxes = new HashMap<String, Checkbox>();
  buttons = new HashMap<String, Button>();
  shapeButtons = new HashMap<String, ShapeSelect>();
  palettes = new HashMap<String, Palette>();

  //Initializations of standardized default clock
  clock = new Clock(100, (int)(width * 0.09), (int)(height * 0.375));

  initializeColours();
  initializeHUD();
  initializeSound();
  initializeFont();
  initializeImage();

  //initialize droplets for animation
  for (int i = 0; i < drops.length; i++) {
    drops[i] = new Drop();
  }
  println(formattedDate);
}

void draw() {
  //Plays the background music on loop
  if (!sounds.get("Background Music").isPlaying() && playOnAwake == true) {
    sounds.get("Background Music").play();
    playOnAwake = false;
  } else if (sounds.get("Background Music").isPlaying()) {
    sounds.get("Background Music").amp(volumeBG);
  }
  //transitions between menus
  if (currMenu == 1) {
    //main menu
    showButton = false;
    mainMenu();
  } else if (currMenu == 2) {
    //home page
    home();
  } else if (currMenu == 3) {
    //Feature 1
    feature1();
  } else if (currMenu == 4) {
    //Feature 2
    feature2();
  }
}

void mousePressed() {
  if (mouseButton == LEFT) {
    //conducts process if left mouse button is clicked
    if (!sounds.get("Mouse Click").isPlaying()) {
      sounds.get("Mouse Click").amp(0.5);
      sounds.get("Mouse Click").play();
    } else if (keyPressed && sounds.get("Mouse Click").isPlaying()) {
      sounds.get("Mouse Click").stop();
      sounds.get("Mouse Click").amp(0.5);
      sounds.get("Mouse Click").play();
    }

    if (isF1Enabled) {
      //functions inside feature 1
      if (buttons.get("Save").mouseOver((int)(width * 0.55), (int)(height * 0.165), (int)(width * 0.05), (int)(height * 0.05))) {
        //saves the picture to a sketch
        PImage savedSketch = get((int)(width * 0.15), (int)(height * 0.25), (int)(width * 0.8), (int)(height * 0.7));
        savedSketch.save("savedText.jpg");
      }

      //reset button clicking functionality
      if (buttons.get("Reset").mouseOver((int)(width * 0.475), (int)(height * 0.165), (int)(width * 0.05), (int)(height * 0.05))) {
        //prints out the canvas again and reset everything
        stroke(colours.get("Black").colour);
        strokeWeight(5);
        fill(colours.get("White").colour);
        rect((int)(width * 0.15), (int)(height * 0.25), (int)(width * 0.8), (int)(height * 0.7), 28);

        //resets the text font and size
        textFont = createFont("Arial", textSize);

        //clears the string list & contained word
        lines.clear();
        word = "";
      }

      //adding shape size functionality
      if (buttons.get("Plus").mouseOver((int)(width * 0.595), (int)(height * 0.13), (int)(width * 0.02), (int)(height * 0.02))) {
        //adds the shape size
        textSize = textSize + 1;
      }

      //subtracting shape size functionality
      if (buttons.get("Minus").mouseOver((int)(width * 0.465), (int)(height * 0.13), (int)(width * 0.02), (int)(height * 0.02)) && shapeSize >= 1) {
        if (textSize >= 1) {
          //subtracts the shape size
          textSize = textSize - 1;
        }
      }

      //ink color palette functionality
      //First row
      if (palettes.get("Dark Red").alternateColors == 1) {
        //changes the shape color
        textColor = colours.get("Dark Red").colour;
      }
      if (palettes.get("Red").alternateColors == 1) {
        //changes the shape color
        textColor = colours.get("Red").colour;
      }
      if (palettes.get("Brown").alternateColors == 1) {
        //changes the shape color
        textColor = colours.get("Brown").colour;
      }
      if (palettes.get("Orange").alternateColors == 1) {
        //changes the shape color
        textColor = colours.get("Orange").colour;
      }
      if (palettes.get("Pink").alternateColors == 1) {
        //changes the shape color
        textColor = colours.get("Pink").colour;
      }

      //Second row
      if (palettes.get("Lime").alternateColors == 1) {
        //changes the shape color
        textColor = colours.get("Lime").colour;
      }
      if (palettes.get("Green").alternateColors == 1) {
        //changes the shape color
        textColor = colours.get("Green").colour;
      }
      if (palettes.get("Olive").alternateColors == 1) {
        //changes the shape color
        textColor = colours.get("Olive").colour;
      }
      if (palettes.get("Yellow Green").alternateColors == 1) {
        //changes the shape color
        textColor = colours.get("Yellow Green").colour;
      }
      if (palettes.get("Sea Green").alternateColors == 1) {
        //changes the shape color
        textColor = colours.get("Sea Green").colour;
      }

      //Third row
      if (palettes.get("Dark Blue").alternateColors == 1) {
        //changes the shape color
        textColor = colours.get("Dark Blue").colour;
      }
      if (palettes.get("Blue").alternateColors == 1) {
        //changes the shape color
        textColor = colours.get("Blue").colour;
      }
      if (palettes.get("Light Blue").alternateColors == 1) {
        //changes the shape color
        textColor = colours.get("Light Blue").colour;
      }
      if (palettes.get("Cyan").alternateColors == 1) {
        //changes the shape color
        textColor = colours.get("Cyan").colour;
      }
      if (palettes.get("Teal").alternateColors == 1) {
        //changes the shape color
        textColor = colours.get("Teal").colour;
      }

      //Fourth row
      if (palettes.get("Turquiose").alternateColors == 1) {
        //changes the shape color
        textColor = colours.get("Turquiose").colour;
      }
      if (palettes.get("Violet").alternateColors == 1) {
        //changes the shape color
        textColor = colours.get("Violet").colour;
      }
      if (palettes.get("Indigo").alternateColors == 1) {
        //changes the shape color
        textColor = colours.get("Indigo").colour;
      }
      if (palettes.get("Magenta").alternateColors == 1) {
        //changes the shape color
        textColor = colours.get("Magenta").colour;
      }
      if (palettes.get("Purple").alternateColors == 1) {
        //changes the shape color
        textColor = colours.get("Purple").colour;
      }

      //Fifth row
      if (palettes.get("Wheat").alternateColors == 1) {
        //changes the shape color
        textColor = colours.get("Wheat").colour;
      }
      if (palettes.get("Chocolate").alternateColors == 1) {
        //changes the shape color
        textColor = colours.get("Chocolate").colour;
      }
      if (palettes.get("Dark Salmon").alternateColors == 1) {
        //changes the shape color
        textColor = colours.get("Dark Salmon").colour;
      }
      if (palettes.get("Salmon").alternateColors == 1) {
        //changes the shape color
        textColor = colours.get("Salmon").colour;
      }
      if (palettes.get("Light Salmon").alternateColors == 1) {
        //changes the shape color
        textColor = colours.get("Light Salmon").colour;
      }

      //Sixth row
      if (palettes.get("White").alternateColors == 1) {
        //changes the shape color
        textColor = colours.get("White").colour;
      }
      if (palettes.get("Silver").alternateColors == 1) {
        //changes the shape color
        textColor = colours.get("Silver").colour;
      }
      if (palettes.get("Grey").alternateColors == 1) {
        //changes the shape color
        textColor = colours.get("Grey").colour;
      }
      if (palettes.get("Dim Grey").alternateColors == 1) {
        //changes the shape color
        textColor = colours.get("Dim Grey").colour;
      }
      if (palettes.get("Black").alternateColors == 1) {
        //changes the shape color
        textColor = colours.get("Black").colour;
      }

      //background color palette functionality
      //First row
      if (palettes.get("Background Dark Red").alternateColors == 1) {
        //changes the shape color
        textBG = colours.get("Dark Red").colour;
        stroke(colours.get("Black").colour);
        strokeWeight(5);
        fill(textBG);
        rect((int)(width * 0.15), (int)(height * 0.25), (int)(width * 0.8), (int)(height * 0.7), 28);
      } else if (palettes.get("Background Red").alternateColors == 1) {
        //changes the shape color
        textBG = colours.get("Red").colour;
        stroke(colours.get("Black").colour);
        strokeWeight(5);
        fill(textBG);
        rect((int)(width * 0.15), (int)(height * 0.25), (int)(width * 0.8), (int)(height * 0.7), 28);
      } else if (palettes.get("Background Brown").alternateColors == 1) {
        //changes the shape color
        textBG = colours.get("Brown").colour;
        stroke(colours.get("Black").colour);
        strokeWeight(5);
        fill(textBG);
        rect((int)(width * 0.15), (int)(height * 0.25), (int)(width * 0.8), (int)(height * 0.7), 28);
      } else if (palettes.get("Background Orange").alternateColors == 1) {
        //changes the shape color
        textBG = colours.get("Orange").colour;
        stroke(colours.get("Black").colour);
        strokeWeight(5);
        fill(textBG);
        rect((int)(width * 0.15), (int)(height * 0.25), (int)(width * 0.8), (int)(height * 0.7), 28);
      } else if (palettes.get("Background Pink").alternateColors == 1) {
        //changes the shape color
        textBG = colours.get("Pink").colour;
        stroke(colours.get("Black").colour);
        strokeWeight(5);
        fill(textBG);
        rect((int)(width * 0.15), (int)(height * 0.25), (int)(width * 0.8), (int)(height * 0.7), 28);
      }

      //Second row
      else if (palettes.get("Background Lime").alternateColors == 1) {
        //changes the shape color
        textBG = colours.get("Lime").colour;
        stroke(colours.get("Black").colour);
        strokeWeight(5);
        fill(textBG);
        rect((int)(width * 0.15), (int)(height * 0.25), (int)(width * 0.8), (int)(height * 0.7), 28);
      } else if (palettes.get("Background Green").alternateColors == 1) {
        //changes the shape color
        textBG = colours.get("Green").colour;
        stroke(colours.get("Black").colour);
        strokeWeight(5);
        fill(textBG);
        rect((int)(width * 0.15), (int)(height * 0.25), (int)(width * 0.8), (int)(height * 0.7), 28);
      } else if (palettes.get("Background Olive").alternateColors == 1) {
        //changes the shape color
        textBG = colours.get("Olive").colour;
        stroke(colours.get("Black").colour);
        strokeWeight(5);
        fill(textBG);
        rect((int)(width * 0.15), (int)(height * 0.25), (int)(width * 0.8), (int)(height * 0.7), 28);
      } else if (palettes.get("Background Yellow Green").alternateColors == 1) {
        //changes the shape color
        textBG = colours.get("Yellow Green").colour;
        stroke(colours.get("Black").colour);
        strokeWeight(5);
        fill(textBG);
        rect((int)(width * 0.15), (int)(height * 0.25), (int)(width * 0.8), (int)(height * 0.7), 28);
      } else if (palettes.get("Background Sea Green").alternateColors == 1) {
        //changes the shape color
        textBG = colours.get("Sea Green").colour;
        stroke(colours.get("Black").colour);
        strokeWeight(5);
        fill(textBG);
        rect((int)(width * 0.15), (int)(height * 0.25), (int)(width * 0.8), (int)(height * 0.7), 28);
      }

      //Third row
      else if (palettes.get("Background Dark Blue").alternateColors == 1) {
        //changes the shape color
        textBG = colours.get("Dark Blue").colour;
        stroke(colours.get("Black").colour);
        strokeWeight(5);
        fill(textBG);
        rect((int)(width * 0.15), (int)(height * 0.25), (int)(width * 0.8), (int)(height * 0.7), 28);
      } else if (palettes.get("Background Blue").alternateColors == 1) {
        //changes the shape color
        textBG = colours.get("Blue").colour;
        stroke(colours.get("Black").colour);
        strokeWeight(5);
        fill(textBG);
        rect((int)(width * 0.15), (int)(height * 0.25), (int)(width * 0.8), (int)(height * 0.7), 28);
      } else if (palettes.get("Background Light Blue").alternateColors == 1) {
        //changes the shape color
        textBG = colours.get("Light Blue").colour;
        stroke(colours.get("Black").colour);
        strokeWeight(5);
        fill(textBG);
        rect((int)(width * 0.15), (int)(height * 0.25), (int)(width * 0.8), (int)(height * 0.7), 28);
      } else if (palettes.get("Background Cyan").alternateColors == 1) {
        //changes the shape color
        textBG = colours.get("Cyan").colour;
        stroke(colours.get("Black").colour);
        strokeWeight(5);
        fill(textBG);
        rect((int)(width * 0.15), (int)(height * 0.25), (int)(width * 0.8), (int)(height * 0.7), 28);
      } else if (palettes.get("Background Teal").alternateColors == 1) {
        //changes the shape color
        textBG = colours.get("Teal").colour;
        stroke(colours.get("Black").colour);
        strokeWeight(5);
        fill(textBG);
        rect((int)(width * 0.15), (int)(height * 0.25), (int)(width * 0.8), (int)(height * 0.7), 28);
      }

      //Fourth row
      else if (palettes.get("Background Turquiose").alternateColors == 1) {
        //changes the shape color
        textBG = colours.get("Turquiose").colour;
        stroke(colours.get("Black").colour);
        strokeWeight(5);
        fill(textBG);
        rect((int)(width * 0.15), (int)(height * 0.25), (int)(width * 0.8), (int)(height * 0.7), 28);
      } else if (palettes.get("Background Violet").alternateColors == 1) {
        //changes the shape color
        textBG = colours.get("Violet").colour;
        stroke(colours.get("Black").colour);
        strokeWeight(5);
        fill(textBG);
        rect((int)(width * 0.15), (int)(height * 0.25), (int)(width * 0.8), (int)(height * 0.7), 28);
      } else if (palettes.get("Background Indigo").alternateColors == 1) {
        //changes the shape color
        textBG = colours.get("Indigo").colour;
        stroke(colours.get("Black").colour);
        strokeWeight(5);
        fill(textBG);
        rect((int)(width * 0.15), (int)(height * 0.25), (int)(width * 0.8), (int)(height * 0.7), 28);
      } else if (palettes.get("Background Magenta").alternateColors == 1) {
        //changes the shape color
        textBG = colours.get("Magenta").colour;
        stroke(colours.get("Black").colour);
        strokeWeight(5);
        fill(textBG);
        rect((int)(width * 0.15), (int)(height * 0.25), (int)(width * 0.8), (int)(height * 0.7), 28);
      } else if (palettes.get("Background Purple").alternateColors == 1) {
        //changes the shape color
        textBG = colours.get("Purple").colour;
        stroke(colours.get("Black").colour);
        strokeWeight(5);
        fill(textBG);
        rect((int)(width * 0.15), (int)(height * 0.25), (int)(width * 0.8), (int)(height * 0.7), 28);
      }

      //Fifth row
      else if (palettes.get("Background Wheat").alternateColors == 1) {
        //changes the shape color
        textBG = colours.get("Wheat").colour;
        stroke(colours.get("Black").colour);
        strokeWeight(5);
        fill(textBG);
        rect((int)(width * 0.15), (int)(height * 0.25), (int)(width * 0.8), (int)(height * 0.7), 28);
      } else if (palettes.get("Background Chocolate").alternateColors == 1) {
        //changes the shape color
        textBG = colours.get("Chocolate").colour;
        stroke(colours.get("Black").colour);
        strokeWeight(5);
        fill(textBG);
        rect((int)(width * 0.15), (int)(height * 0.25), (int)(width * 0.8), (int)(height * 0.7), 28);
      } else if (palettes.get("Background Dark Salmon").alternateColors == 1) {
        //changes the shape color
        textBG = colours.get("Dark Salmon").colour;
        stroke(colours.get("Black").colour);
        strokeWeight(5);
        fill(textBG);
        rect((int)(width * 0.15), (int)(height * 0.25), (int)(width * 0.8), (int)(height * 0.7), 28);
      } else if (palettes.get("Background Salmon").alternateColors == 1) {
        //changes the shape color
        textBG = colours.get("Salmon").colour;
        stroke(colours.get("Black").colour);
        strokeWeight(5);
        fill(textBG);
        rect((int)(width * 0.15), (int)(height * 0.25), (int)(width * 0.8), (int)(height * 0.7), 28);
      } else if (palettes.get("Background Light Salmon").alternateColors == 1) {
        //changes the shape color
        textBG = colours.get("Light Salmon").colour;
        stroke(colours.get("Black").colour);
        strokeWeight(5);
        fill(textBG);
        rect((int)(width * 0.15), (int)(height * 0.25), (int)(width * 0.8), (int)(height * 0.7), 28);
      }

      //Sixth row
      else if (palettes.get("Background White").alternateColors == 1) {
        //changes the shape color
        textBG = colours.get("White").colour;
        stroke(colours.get("Black").colour);
        strokeWeight(5);
        fill(textBG);
        rect((int)(width * 0.15), (int)(height * 0.25), (int)(width * 0.8), (int)(height * 0.7), 28);
      } else if (palettes.get("Background Silver").alternateColors == 1) {
        //changes the shape color
        textBG = colours.get("Silver").colour;
        stroke(colours.get("Black").colour);
        strokeWeight(5);
        fill(textBG);
        rect((int)(width * 0.15), (int)(height * 0.25), (int)(width * 0.8), (int)(height * 0.7), 28);
      } else if (palettes.get("Background Grey").alternateColors == 1) {
        //changes the shape color
        textBG = colours.get("Grey").colour;
        stroke(colours.get("Black").colour);
        strokeWeight(5);
        fill(textBG);
        rect((int)(width * 0.15), (int)(height * 0.25), (int)(width * 0.8), (int)(height * 0.7), 28);
      } else if (palettes.get("Background Dim Grey").alternateColors == 1) {
        //changes the shape color
        textBG = colours.get("Dim Grey").colour;
        stroke(colours.get("Black").colour);
        strokeWeight(5);
        fill(textBG);
        rect((int)(width * 0.15), (int)(height * 0.25), (int)(width * 0.8), (int)(height * 0.7), 28);
      } else if (palettes.get("Background Black").alternateColors == 1) {
        //changes the shape color
        textBG = colours.get("Black").colour;
        stroke(colours.get("Black").colour);
        strokeWeight(5);
        fill(textBG);
        rect((int)(width * 0.15), (int)(height * 0.25), (int)(width * 0.8), (int)(height * 0.7), 28);
      }
    }

    if (isF2Enabled) {
      //functions inside feature 2
      if (buttons.get("Save").mouseOver((int)(width * 0.55), (int)(height * 0.165), (int)(width * 0.05), (int)(height * 0.05))) {
        //saves the picture to a sketch
        PImage savedSketch = get((int)(width * 0.15), (int)(height * 0.25), (int)(width * 0.8), (int)(height * 0.7));
        savedSketch.save("savedDocument.jpg");
      }

      //adding shape size functionality
      if (buttons.get("Plus").mouseOver((int)(width * 0.595), (int)(height * 0.13), (int)(width * 0.02), (int)(height * 0.02))) {
        //adds the shape size
        shapeSize = shapeSize + 1;
      }

      //subtracting shape size functionality
      if (buttons.get("Minus").mouseOver((int)(width * 0.465), (int)(height * 0.13), (int)(width * 0.02), (int)(height * 0.02)) && shapeSize >= 1) {
        //subtracts the shape size
        shapeSize = shapeSize - 1;
      }

      //ink color palette functionality
      //First row
      if (palettes.get("Dark Red").alternateColors == 1) {
        //changes the shape color
        shapeColor = colours.get("Dark Red").colour;
      }
      if (palettes.get("Red").alternateColors == 1) {
        //changes the shape color
        shapeColor = colours.get("Red").colour;
      }
      if (palettes.get("Brown").alternateColors == 1) {
        //changes the shape color
        shapeColor = colours.get("Brown").colour;
      }
      if (palettes.get("Orange").alternateColors == 1) {
        //changes the shape color
        shapeColor = colours.get("Orange").colour;
      }
      if (palettes.get("Pink").alternateColors == 1) {
        //changes the shape color
        shapeColor = colours.get("Pink").colour;
      }

      //Second row
      if (palettes.get("Lime").alternateColors == 1) {
        //changes the shape color
        shapeColor = colours.get("Lime").colour;
      }
      if (palettes.get("Green").alternateColors == 1) {
        //changes the shape color
        shapeColor = colours.get("Green").colour;
      }
      if (palettes.get("Olive").alternateColors == 1) {
        //changes the shape color
        shapeColor = colours.get("Olive").colour;
      }
      if (palettes.get("Yellow Green").alternateColors == 1) {
        //changes the shape color
        shapeColor = colours.get("Yellow Green").colour;
      }
      if (palettes.get("Sea Green").alternateColors == 1) {
        //changes the shape color
        shapeColor = colours.get("Sea Green").colour;
      }

      //Third row
      if (palettes.get("Dark Blue").alternateColors == 1) {
        //changes the shape color
        shapeColor = colours.get("Dark Blue").colour;
      }
      if (palettes.get("Blue").alternateColors == 1) {
        //changes the shape color
        shapeColor = colours.get("Blue").colour;
      }
      if (palettes.get("Light Blue").alternateColors == 1) {
        //changes the shape color
        shapeColor = colours.get("Light Blue").colour;
      }
      if (palettes.get("Cyan").alternateColors == 1) {
        //changes the shape color
        shapeColor = colours.get("Cyan").colour;
      }
      if (palettes.get("Teal").alternateColors == 1) {
        //changes the shape color
        shapeColor = colours.get("Teal").colour;
      }

      //Fourth row
      if (palettes.get("Turquiose").alternateColors == 1) {
        //changes the shape color
        shapeColor = colours.get("Turquiose").colour;
      }
      if (palettes.get("Violet").alternateColors == 1) {
        //changes the shape color
        shapeColor = colours.get("Violet").colour;
      }
      if (palettes.get("Indigo").alternateColors == 1) {
        //changes the shape color
        shapeColor = colours.get("Indigo").colour;
      }
      if (palettes.get("Magenta").alternateColors == 1) {
        //changes the shape color
        shapeColor = colours.get("Magenta").colour;
      }
      if (palettes.get("Purple").alternateColors == 1) {
        //changes the shape color
        shapeColor = colours.get("Purple").colour;
      }

      //Fifth row
      if (palettes.get("Wheat").alternateColors == 1) {
        //changes the shape color
        shapeColor = colours.get("Wheat").colour;
      }
      if (palettes.get("Chocolate").alternateColors == 1) {
        //changes the shape color
        shapeColor = colours.get("Chocolate").colour;
      }
      if (palettes.get("Dark Salmon").alternateColors == 1) {
        //changes the shape color
        shapeColor = colours.get("Dark Salmon").colour;
      }
      if (palettes.get("Salmon").alternateColors == 1) {
        //changes the shape color
        shapeColor = colours.get("Salmon").colour;
      }
      if (palettes.get("Light Salmon").alternateColors == 1) {
        //changes the shape color
        shapeColor = colours.get("Light Salmon").colour;
      }

      //Sixth row
      if (palettes.get("White").alternateColors == 1) {
        //changes the shape color
        shapeColor = colours.get("White").colour;
      }
      if (palettes.get("Silver").alternateColors == 1) {
        //changes the shape color
        shapeColor = colours.get("Silver").colour;
      }
      if (palettes.get("Grey").alternateColors == 1) {
        //changes the shape color
        shapeColor = colours.get("Grey").colour;
      }
      if (palettes.get("Dim Grey").alternateColors == 1) {
        //changes the shape color
        shapeColor = colours.get("Dim Grey").colour;
      }
      if (palettes.get("Black").alternateColors == 1) {
        //changes the shape color
        shapeColor = colours.get("Black").colour;
      }

      //background color palette functionality
      //First row
      if (palettes.get("Background Dark Red").alternateColors == 1) {
        //changes the shape color
        bgColor = colours.get("Dark Red").colour;
        stroke(colours.get("Black").colour);
        strokeWeight(5);
        fill(bgColor);
        rect((int)(width * 0.15), (int)(height * 0.25), (int)(width * 0.8), (int)(height * 0.7), 28);
      } else if (palettes.get("Background Red").alternateColors == 1) {
        //changes the shape color
        bgColor = colours.get("Red").colour;
        stroke(colours.get("Black").colour);
        strokeWeight(5);
        fill(bgColor);
        rect((int)(width * 0.15), (int)(height * 0.25), (int)(width * 0.8), (int)(height * 0.7), 28);
      } else if (palettes.get("Background Brown").alternateColors == 1) {
        //changes the shape color
        bgColor = colours.get("Brown").colour;
        stroke(colours.get("Black").colour);
        strokeWeight(5);
        fill(bgColor);
        rect((int)(width * 0.15), (int)(height * 0.25), (int)(width * 0.8), (int)(height * 0.7), 28);
      } else if (palettes.get("Background Orange").alternateColors == 1) {
        //changes the shape color
        bgColor = colours.get("Orange").colour;
        stroke(colours.get("Black").colour);
        strokeWeight(5);
        fill(bgColor);
        rect((int)(width * 0.15), (int)(height * 0.25), (int)(width * 0.8), (int)(height * 0.7), 28);
      } else if (palettes.get("Background Pink").alternateColors == 1) {
        //changes the shape color
        bgColor = colours.get("Pink").colour;
        stroke(colours.get("Black").colour);
        strokeWeight(5);
        fill(bgColor);
        rect((int)(width * 0.15), (int)(height * 0.25), (int)(width * 0.8), (int)(height * 0.7), 28);
      }

      //Second row
      else if (palettes.get("Background Lime").alternateColors == 1) {
        //changes the shape color
        bgColor = colours.get("Lime").colour;
        stroke(colours.get("Black").colour);
        strokeWeight(5);
        fill(bgColor);
        rect((int)(width * 0.15), (int)(height * 0.25), (int)(width * 0.8), (int)(height * 0.7), 28);
      } else if (palettes.get("Background Green").alternateColors == 1) {
        //changes the shape color
        bgColor = colours.get("Green").colour;
        stroke(colours.get("Black").colour);
        strokeWeight(5);
        fill(bgColor);
        rect((int)(width * 0.15), (int)(height * 0.25), (int)(width * 0.8), (int)(height * 0.7), 28);
      } else if (palettes.get("Background Olive").alternateColors == 1) {
        //changes the shape color
        bgColor = colours.get("Olive").colour;
        stroke(colours.get("Black").colour);
        strokeWeight(5);
        fill(bgColor);
        rect((int)(width * 0.15), (int)(height * 0.25), (int)(width * 0.8), (int)(height * 0.7), 28);
      } else if (palettes.get("Background Yellow Green").alternateColors == 1) {
        //changes the shape color
        bgColor = colours.get("Yellow Green").colour;
        stroke(colours.get("Black").colour);
        strokeWeight(5);
        fill(bgColor);
        rect((int)(width * 0.15), (int)(height * 0.25), (int)(width * 0.8), (int)(height * 0.7), 28);
      } else if (palettes.get("Background Sea Green").alternateColors == 1) {
        //changes the shape color
        bgColor = colours.get("Sea Green").colour;
        stroke(colours.get("Black").colour);
        strokeWeight(5);
        fill(bgColor);
        rect((int)(width * 0.15), (int)(height * 0.25), (int)(width * 0.8), (int)(height * 0.7), 28);
      }

      //Third row
      else if (palettes.get("Background Dark Blue").alternateColors == 1) {
        //changes the shape color
        bgColor = colours.get("Dark Blue").colour;
        stroke(colours.get("Black").colour);
        strokeWeight(5);
        fill(bgColor);
        rect((int)(width * 0.15), (int)(height * 0.25), (int)(width * 0.8), (int)(height * 0.7), 28);
      } else if (palettes.get("Background Blue").alternateColors == 1) {
        //changes the shape color
        bgColor = colours.get("Blue").colour;
        stroke(colours.get("Black").colour);
        strokeWeight(5);
        fill(bgColor);
        rect((int)(width * 0.15), (int)(height * 0.25), (int)(width * 0.8), (int)(height * 0.7), 28);
      } else if (palettes.get("Background Light Blue").alternateColors == 1) {
        //changes the shape color
        bgColor = colours.get("Light Blue").colour;
        stroke(colours.get("Black").colour);
        strokeWeight(5);
        fill(bgColor);
        rect((int)(width * 0.15), (int)(height * 0.25), (int)(width * 0.8), (int)(height * 0.7), 28);
      } else if (palettes.get("Background Cyan").alternateColors == 1) {
        //changes the shape color
        bgColor = colours.get("Cyan").colour;
        stroke(colours.get("Black").colour);
        strokeWeight(5);
        fill(bgColor);
        rect((int)(width * 0.15), (int)(height * 0.25), (int)(width * 0.8), (int)(height * 0.7), 28);
      } else if (palettes.get("Background Teal").alternateColors == 1) {
        //changes the shape color
        bgColor = colours.get("Teal").colour;
        stroke(colours.get("Black").colour);
        strokeWeight(5);
        fill(bgColor);
        rect((int)(width * 0.15), (int)(height * 0.25), (int)(width * 0.8), (int)(height * 0.7), 28);
      }

      //Fourth row
      else if (palettes.get("Background Turquiose").alternateColors == 1) {
        //changes the shape color
        bgColor = colours.get("Turquiose").colour;
        stroke(colours.get("Black").colour);
        strokeWeight(5);
        fill(bgColor);
        rect((int)(width * 0.15), (int)(height * 0.25), (int)(width * 0.8), (int)(height * 0.7), 28);
      } else if (palettes.get("Background Violet").alternateColors == 1) {
        //changes the shape color
        bgColor = colours.get("Violet").colour;
        stroke(colours.get("Black").colour);
        strokeWeight(5);
        fill(bgColor);
        rect((int)(width * 0.15), (int)(height * 0.25), (int)(width * 0.8), (int)(height * 0.7), 28);
      } else if (palettes.get("Background Indigo").alternateColors == 1) {
        //changes the shape color
        bgColor = colours.get("Indigo").colour;
        stroke(colours.get("Black").colour);
        strokeWeight(5);
        fill(bgColor);
        rect((int)(width * 0.15), (int)(height * 0.25), (int)(width * 0.8), (int)(height * 0.7), 28);
      } else if (palettes.get("Background Magenta").alternateColors == 1) {
        //changes the shape color
        bgColor = colours.get("Magenta").colour;
        stroke(colours.get("Black").colour);
        strokeWeight(5);
        fill(bgColor);
        rect((int)(width * 0.15), (int)(height * 0.25), (int)(width * 0.8), (int)(height * 0.7), 28);
      } else if (palettes.get("Background Purple").alternateColors == 1) {
        //changes the shape color
        bgColor = colours.get("Purple").colour;
        stroke(colours.get("Black").colour);
        strokeWeight(5);
        fill(bgColor);
        rect((int)(width * 0.15), (int)(height * 0.25), (int)(width * 0.8), (int)(height * 0.7), 28);
      }

      //Fifth row
      else if (palettes.get("Background Wheat").alternateColors == 1) {
        //changes the shape color
        bgColor = colours.get("Wheat").colour;
        stroke(colours.get("Black").colour);
        strokeWeight(5);
        fill(bgColor);
        rect((int)(width * 0.15), (int)(height * 0.25), (int)(width * 0.8), (int)(height * 0.7), 28);
      } else if (palettes.get("Background Chocolate").alternateColors == 1) {
        //changes the shape color
        bgColor = colours.get("Chocolate").colour;
        stroke(colours.get("Black").colour);
        strokeWeight(5);
        fill(bgColor);
        rect((int)(width * 0.15), (int)(height * 0.25), (int)(width * 0.8), (int)(height * 0.7), 28);
      } else if (palettes.get("Background Dark Salmon").alternateColors == 1) {
        //changes the shape color
        bgColor = colours.get("Dark Salmon").colour;
        stroke(colours.get("Black").colour);
        strokeWeight(5);
        fill(bgColor);
        rect((int)(width * 0.15), (int)(height * 0.25), (int)(width * 0.8), (int)(height * 0.7), 28);
      } else if (palettes.get("Background Salmon").alternateColors == 1) {
        //changes the shape color
        bgColor = colours.get("Salmon").colour;
        stroke(colours.get("Black").colour);
        strokeWeight(5);
        fill(bgColor);
        rect((int)(width * 0.15), (int)(height * 0.25), (int)(width * 0.8), (int)(height * 0.7), 28);
      } else if (palettes.get("Background Light Salmon").alternateColors == 1) {
        //changes the shape color
        bgColor = colours.get("Light Salmon").colour;
        stroke(colours.get("Black").colour);
        strokeWeight(5);
        fill(bgColor);
        rect((int)(width * 0.15), (int)(height * 0.25), (int)(width * 0.8), (int)(height * 0.7), 28);
      }

      //Sixth row
      else if (palettes.get("Background White").alternateColors == 1) {
        //changes the shape color
        bgColor = colours.get("White").colour;
        stroke(colours.get("Black").colour);
        strokeWeight(5);
        fill(bgColor);
        rect((int)(width * 0.15), (int)(height * 0.25), (int)(width * 0.8), (int)(height * 0.7), 28);
      } else if (palettes.get("Background Silver").alternateColors == 1) {
        //changes the shape color
        bgColor = colours.get("Silver").colour;
        stroke(colours.get("Black").colour);
        strokeWeight(5);
        fill(bgColor);
        rect((int)(width * 0.15), (int)(height * 0.25), (int)(width * 0.8), (int)(height * 0.7), 28);
      } else if (palettes.get("Background Grey").alternateColors == 1) {
        //changes the shape color
        bgColor = colours.get("Grey").colour;
        stroke(colours.get("Black").colour);
        strokeWeight(5);
        fill(bgColor);
        rect((int)(width * 0.15), (int)(height * 0.25), (int)(width * 0.8), (int)(height * 0.7), 28);
      } else if (palettes.get("Background Dim Grey").alternateColors == 1) {
        //changes the shape color
        bgColor = colours.get("Dim Grey").colour;
        stroke(colours.get("Black").colour);
        strokeWeight(5);
        fill(bgColor);
        rect((int)(width * 0.15), (int)(height * 0.25), (int)(width * 0.8), (int)(height * 0.7), 28);
      } else if (palettes.get("Background Black").alternateColors == 1) {
        //changes the shape color
        bgColor = colours.get("Black").colour;
        stroke(colours.get("Black").colour);
        strokeWeight(5);
        fill(bgColor);
        rect((int)(width * 0.15), (int)(height * 0.25), (int)(width * 0.8), (int)(height * 0.7), 28);
      }

      //reset button clicking functionality
      if (buttons.get("Reset").mouseOver((int)(width * 0.475), (int)(height * 0.165), (int)(width * 0.05), (int)(height * 0.05))) {
        //prints out the canvas again and reset everything
        stroke(colours.get("Black").colour);
        strokeWeight(5);
        fill(bgColor);
        rect((int)(width * 0.15), (int)(height * 0.25), (int)(width * 0.8), (int)(height * 0.7), 28);
      }
    }
  } else if (mouseButton == RIGHT) {
    //conducts process if right mouse button is clicked
    if (!sounds.get("Mouse Click").isPlaying()) {
      sounds.get("Mouse Click").amp(0.5);
      sounds.get("Mouse Click").play();
    } else if (keyPressed && sounds.get("Mouse Click").isPlaying()) {
      sounds.get("Mouse Click").stop();
      sounds.get("Mouse Click").amp(0.5);
      sounds.get("Mouse Click").play();
    }
  }

  //allows checkboxes to be clicked on
  checkboxes.get("Feature 1").onMouseClick();
  checkboxes.get("Feature 2").onMouseClick();

  //allows the shape palette to be clicked on
  shapeButtons.get("Circle").onMouseClick();
  shapeButtons.get("Square").onMouseClick();
  shapeButtons.get("Triangle").onMouseClick();

  //allows the color palette to be clicked on
  //ink color palette
  palettes.get("Dark Red").onMouseClick();
  palettes.get("Red").onMouseClick();
  palettes.get("Brown").onMouseClick();
  palettes.get("Orange").onMouseClick();
  palettes.get("Pink").onMouseClick();

  palettes.get("Lime").onMouseClick();
  palettes.get("Green").onMouseClick();
  palettes.get("Olive").onMouseClick();
  palettes.get("Yellow Green").onMouseClick();
  palettes.get("Sea Green").onMouseClick();

  palettes.get("Dark Blue").onMouseClick();
  palettes.get("Blue").onMouseClick();
  palettes.get("Light Blue").onMouseClick();
  palettes.get("Cyan").onMouseClick();
  palettes.get("Teal").onMouseClick();

  palettes.get("Turquiose").onMouseClick();
  palettes.get("Indigo").onMouseClick();
  palettes.get("Violet").onMouseClick();
  palettes.get("Magenta").onMouseClick();
  palettes.get("Purple").onMouseClick();

  palettes.get("Wheat").onMouseClick();
  palettes.get("Chocolate").onMouseClick();
  palettes.get("Dark Salmon").onMouseClick();
  palettes.get("Salmon").onMouseClick();
  palettes.get("Light Salmon").onMouseClick();

  palettes.get("White").onMouseClick();
  palettes.get("Silver").onMouseClick();
  palettes.get("Grey").onMouseClick();
  palettes.get("Dim Grey").onMouseClick();
  palettes.get("Black").onMouseClick();

  //background color palette
  palettes.get("Background Dark Red").onMouseClick();
  palettes.get("Background Red").onMouseClick();
  palettes.get("Background Brown").onMouseClick();
  palettes.get("Background Orange").onMouseClick();
  palettes.get("Background Pink").onMouseClick();

  palettes.get("Background Lime").onMouseClick();
  palettes.get("Background Green").onMouseClick();
  palettes.get("Background Olive").onMouseClick();
  palettes.get("Background Yellow Green").onMouseClick();
  palettes.get("Background Sea Green").onMouseClick();

  palettes.get("Background Dark Blue").onMouseClick();
  palettes.get("Background Blue").onMouseClick();
  palettes.get("Background Light Blue").onMouseClick();
  palettes.get("Background Cyan").onMouseClick();
  palettes.get("Background Teal").onMouseClick();

  palettes.get("Background Turquiose").onMouseClick();
  palettes.get("Background Indigo").onMouseClick();
  palettes.get("Background Violet").onMouseClick();
  palettes.get("Background Magenta").onMouseClick();
  palettes.get("Background Purple").onMouseClick();

  palettes.get("Background Wheat").onMouseClick();
  palettes.get("Background Chocolate").onMouseClick();
  palettes.get("Background Dark Salmon").onMouseClick();
  palettes.get("Background Salmon").onMouseClick();
  palettes.get("Background Light Salmon").onMouseClick();

  palettes.get("Background White").onMouseClick();
  palettes.get("Background Silver").onMouseClick();
  palettes.get("Background Grey").onMouseClick();
  palettes.get("Background Dim Grey").onMouseClick();
  palettes.get("Background Black").onMouseClick();

  //allows only one button to be selected in the bar
  if ((shapeButtons.get("Triangle").alternateColors == 1)) {
    //conducts process if triangle is not selected & either one of the shapes are selected
    shapeButtons.get("Circle").alternateColors = 0;
    shapeButtons.get("Square").alternateColors = 0;
  } else if ((shapeButtons.get("Square").alternateColors == 1)) {
    //conducts process if square is not selected & either one of the shapes are selected
    shapeButtons.get("Triangle").alternateColors = 0;
    shapeButtons.get("Circle").alternateColors = 0;
  } else if ((shapeButtons.get("Circle").alternateColors == 1)) {
    //conducts process if circle is not selected & either one of the shapes are selected
    shapeButtons.get("Square").alternateColors = 0;
    shapeButtons.get("Triangle").alternateColors = 0;
  } else if ((shapeButtons.get("Square").alternateColors == 0)) {
    shapeButtons.get("Circle").alternateColors = 1;
  } else if (shapeButtons.get("Triangle").alternateColors == 0) {
    shapeButtons.get("Circle").alternateColors = 1;
  }

  //allows the textbox functionality
  for (Map.Entry<String, Textbox> set : textboxes.entrySet()) {
    set.getValue().pressed(mouseX, mouseY);
  }
}

void keyTyped() {
  if (isF1Enabled) {
    if (keyCode == SHIFT && keyCode == 20) {
      //prints oout capital letter when shift and caps lock is pressed
      keyCode = 0;
      key = 0;
    }
  }
}

void keyPressed() {
  if (!sounds.get("Keyboard Click").isPlaying()) {
    sounds.get("Keyboard Click").amp(0.5);
    sounds.get("Keyboard Click").play();
  } else if (keyPressed && sounds.get("Keyboard Click").isPlaying()) {
    sounds.get("Keyboard Click").stop();
    sounds.get("Keyboard Click").amp(0.5);
    sounds.get("Keyboard Click").play();
  }
  //allows for the textbox functionality
  for (Map.Entry<String, Textbox> set : textboxes.entrySet()) {
    if (set.getValue().keyPress(key, keyCode)) {
      name = textboxes.get("Username").Text;
      age = textboxes.get("Age").Text;
    }
  }

  if (isF1Enabled) {
    //allow the + and - functionality towards shape height and width
    if ((key == '-' || key == '_') && shapeSize >= 1) {
      //make shape size smaller
      textSize = textSize - 1;
    } else if (key == '=' || key == '+') {
      //make shape size larger
      textSize = textSize + 1;
    }

    if (keyCode == RETURN) {
      //append the line to the current word for the array and remake word
      lines.append(word);
      word = "";
      lines.clear();
    } else if (keyCode == BACKSPACE) {
      if (word.length() - 1 >= 0) {
        word = word.substring(0, word.length() - 1);
      }
    } else if (keyCode == 9) {
      //prints out 2 spaces when tab is pressed
      word += "  ";
    } else if (keyCode == SHIFT && keyCode == 20){
      keyCode = 0;
      key = 0;
      word.toUpperCase();
    } else {
      word += key;
    }

    if (isF2Enabled) {
      //allow the + and - functionality towards shape height and width
      if ((key == '-' || key == '_') && shapeSize >= 1) {
        //make shape size smaller
        shapeSize = shapeSize - 1;
      } else if (key == '=' || key == '+') {
        //make shape size larger
        shapeSize = shapeSize + 1;
      }
    }
  }
}

void keyReleased() {
  //key release event
  if (keyCode == SHIFT && keyCode == 20){
    key = 0;
    keyCode = 0;
    word = word.substring(0, word.length() - 1);
  }
}
void mouseDragged() {
  //Hold and click mouse event
}
