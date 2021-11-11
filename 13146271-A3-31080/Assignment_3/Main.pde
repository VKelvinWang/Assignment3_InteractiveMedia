void mainMenu() {
  //draws the main menu
  background(images.get("Background"));
  animate();
  drawHUD();
}

void animate() {
  for (int i = 0; i < drops.length; i++) {
    drops[i].fall();
    drops[i].show();
  }
}

void drawHUD() {
  //Displays working clock
  clock.display();

  //Title
  textAlign(CENTER, CENTER);
  writeText("Title", width /2, height * 0.1, "All-in-1 Work Hub");

  //Subtitle
  textAlign(CENTER, CENTER);
  writeText("Subtitle", width/2, height * 0.18, "A feature-rich Software for Working Purposes");

  //Caption text
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

  //addition of box behind name text & textbox
  stroke(1);
  strokeWeight(5);
  fill(colours.get("Purple").colour);
  rect( width * 0.29, height * 0.225, (int)(width * 0.425), (int)(height * 0.5), 28);

  //Name text
  fill(colours.get("Black").colour);
  textAlign(LEFT, CENTER);
  writeText("Default", width * 0.3, height * 0.25, "What is your name?");

  //Age text
  fill(colours.get("Black").colour);
  textAlign(LEFT, CENTER);
  writeText("Default", width * 0.3, height * 0.32, "What is your age?");

  //Feature text
  fill(colours.get("Black").colour);
  textAlign(LEFT, CENTER);
  writeText("Default", width * 0.3, height * 0.4, "Which feature(s) do you want to be enabled?");

  //warning text
  //checks if data is entered already
  if ((!name.isEmpty()) && (!age.isEmpty()) && (isF1Enabled || isF2Enabled) && isStringInt(age) && (convertStringToInt(age) <= 100)) {
    //allows user to continue to the main menu
    fill(colours.get("Green").colour);
    writeText("Default Bold", width * 0.45, height * 0.6, "You may continue..");
    showButton = true;
  } else if ((!name.isEmpty()) && (!age.isEmpty()) && (!isF1Enabled || !isF2Enabled) && isStringInt(age) && (convertStringToInt(age) <= 100)) {
    //age is filled but not an integer
    fill(colours.get("Red").colour);
    writeText("Default Bold", width * 0.3, height * 0.6, "Pick at least one feature in order to continue");
  } else if (!age.isEmpty() && (!isStringInt(age) || (convertStringToInt(age) >= 100))) {
    //age is filled but not an integer
    fill(colours.get("Red").colour);
    writeText("Default Bold", width * 0.3, height * 0.6, "Age is not valid. Please enter your proper age.");
  } else {
    //sends warning message so user fills out their details
    fill(colours.get("Red").colour);
    writeText("Default Bold", width * 0.3, height * 0.6, "Fill the following details and press enter in order to continue.");
  }

  //Store the enabling of features into boolean
  if (checkboxes.get("Feature 1").alternateColors == 1) {
    isF1Enabled = true;
  } else{
    isF1Enabled = false;
  }

  if (checkboxes.get("Feature 2").alternateColors == 1) {
    isF2Enabled = true;
  } else{
    isF2Enabled = false;
  }
  //addition of checkboxes for languages
  //Feature 1
  fill(colours.get("Black").colour);
  textAlign(LEFT, LEFT);
  writeText("Default", width * 0.33, height * 0.44, "Simple Text Editor (For text-related work)");
  fill(colours.get("Light Blue").colour);
  checkboxes.get("Feature 1").display();

  //Feature 2
  fill(colours.get("Black").colour);
  textAlign(LEFT, LEFT);
  writeText("Default", width * 0.33, height * 0.48, "Simple Drawing Canvas (For designing & sketching work)");
  fill(colours.get("Light Blue").colour);
  checkboxes.get("Feature 2").display();

  //addition of textbox to HUD
  for (Map.Entry<String, Textbox> set : textboxes.entrySet()) {
    textFont(fonts.get("Default"));
    textAlign(LEFT, LEFT);
    //iterates through all of the textboxes
    set.getValue().drawTBox();
  }

  //shows transition buttons
  if (showButton) {
    buttons.get("Home Button").display();
    if ((buttons.get("Home Button").mouseOver((int)(width * 0.45), (int)(height * 0.625), (int)(width * 0.10), (int)(height * 0.05))) && mousePressed && (mouseButton == LEFT)) {
      currMenu = 2;
    }
  }
}
