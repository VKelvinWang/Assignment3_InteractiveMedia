void home() {
  //draws the home menu
  background(images.get("Background"));
  animate();
  drawHome();
}

void drawHome() {
  //resets the setup of every feature
  isConducted = false;
  
  //Displays working clock
  clock.display();
  
  //Background box
  stroke(colours.get("Black").colour);
  strokeWeight(5);
  fill(colours.get("Purple").colour);
  rect( width * 0.29, height * 0.225, (int)(width * 0.425), (int)(height * 0.5), 28);

  //Welcome message
  fill(colours.get("Black").colour);
  textAlign(CENTER, CENTER);
  writeText("Subtitle", width/2, height * 0.15, "Welcome, " + name + "!");
  //adds age to text + " (" + age + "Y/O) !");

  //Music text
  fill(colours.get("White").colour);
  writeText("Default", width * 0.07, height * 0.03, "Background Music");

  fill(colours.get("White").colour);
  writeText("Default", width * 0.03, height * 0.06, "Volume: ");

  //error messages when importing
  if (!isAudioValid) {
    textAlign(LEFT, LEFT);
    fill(colours.get("Red").colour);
    writeText("Default Bold", width * 0.01, height * 0.25, "Uh oh! Something went wrong..");
    writeText("Default Bold", width * 0.01, height * 0.27, "Music is not loaded correctly. Try again?");
  }

  fill(colours.get("Black").colour);
  textAlign(LEFT, CENTER);
  writeText("Default Bold", width * 0.3, height * 0.25, "Choose the feature you want to be displayed:  ");

  //Features Tab
  if (isF1Enabled) {
    fill(colours.get("Black").colour);
    textAlign(LEFT, CENTER);
    writeText("Default", width * 0.3, height * 0.32, "Open Text Editor");
    buttons.get("Feature 1").display();
    if ((buttons.get("Feature 1").mouseOver((int)(width * 0.3), (int)(height * 0.35), (int)(width * 0.10), (int)(height * 0.08))) && mousePressed && (mouseButton == LEFT)) {
      currMenu = 3;
    }
  }

  if (isF2Enabled) {
    fill(colours.get("Black").colour);
    textAlign(LEFT, CENTER);
    writeText("Default", width * 0.5, height * 0.32, "Open Drawing Canvas");
    buttons.get("Feature 2").display();
    if ((buttons.get("Feature 2").mouseOver((int)(width * 0.5), (int)(height * 0.35), (int)(width * 0.10), (int)(height * 0.08))) && mousePressed && (mouseButton == LEFT)) {
      currMenu = 4;
    }
  }

  //Back button
  buttons.get("Back Menu").display();
  if(buttons.get("Back Menu").mouseOver((int)(width * 0.9), (int)(height * 0.9), (int)(width * 0.05), (int)(height * 0.05)) && mousePressed && (mouseButton == LEFT)){
    currMenu = 1;
  }
}
