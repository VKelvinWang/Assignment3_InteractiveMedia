void feature2() {
  //Drawing Canvas
  if (!isConducted) {
    //All of the default presets are drawn once
    //This acts as the initial setup of the feature

    //initialization of default color
    shapeColor = colours.get("Black").colour;
    bgColor = colours.get("White").colour;

    //Background
    background(images.get("Feature Background"));
    shapeButtons.get("Circle").alternateColors = 1;

    //Caption text
    textAlign(CENTER, CENTER);
    fill(colours.get("White").colour);
    writeText("Default", width * 0.07, height * 0.03, "Background Music");

    fill(colours.get("White").colour);
    writeText("Default", width * 0.03, height * 0.06, "Volume: ");
    isConducted = true;

    //Title
    textAlign(CENTER, CENTER);
    writeText("Title", width /2, height * 0.05, "Drawing Canvas");

    //Canvas
    stroke(colours.get("Black").colour);
    strokeWeight(5);
    fill(bgColor);
    rect((int)(width * 0.15), (int)(height * 0.25), (int)(width * 0.8), (int)(height * 0.7), 28);

    //Color Palette (Top Left)
    stroke(colours.get("Black").colour);
    strokeWeight(5);
    fill(colours.get("White").colour);
    rect((int)(width * 0.01), (int)(height * 0.25), (int)(width * 0.125), (int)(height * 0.325), 28);
    fill(colours.get("Black").colour);
    rect((int)(width * 0.01), (int)(height * 0.25), (int)(width * 0.125), (int)(height * 0.05), 28, 28, 0, 0);
    fill(colours.get("White").colour);
    textAlign(CENTER, BASELINE);
    writeText("Default Bold", (int)(width * 0.075), (int)(height * 0.285), "Ink Color");

    //Background Color Palette (Bottom Left)
    stroke(colours.get("Black").colour);
    strokeWeight(5);
    fill(colours.get("White").colour);
    rect((int)(width * 0.01), (int)(height * 0.6), (int)(width * 0.125), (int)(height * 0.325), 28);
    fill(colours.get("Black").colour);
    rect((int)(width * 0.01), (int)(height * 0.6), (int)(width * 0.125), (int)(height * 0.05), 28, 28, 0, 0);
    fill(colours.get("White").colour);
    textAlign(CENTER, BASELINE);
    writeText("Default Bold", (int)(width * 0.075), (int)(height * 0.635), "Background Color");

    //Shapes Palette (Top Left)
    stroke(colours.get("Black").colour);
    strokeWeight(5);
    fill(colours.get("White").colour);
    rect((int)(width * 0.15), (int)(height * 0.1), (int)(width * 0.25), (int)(height * 0.125), 28);
    fill(colours.get("Black").colour);
    rect((int)(width * 0.15), (int)(height * 0.1), (int)(width * 0.25), (int)(height * 0.02), 28, 28, 0, 0);
    fill(colours.get("White").colour);
    textAlign(LEFT, BASELINE);
    writeText("Default Bold", (int)(width * 0.225), (int)(height * 0.115), "Shapes Palette");

    //Author Details (Top Right)
    stroke(colours.get("Black").colour);
    strokeWeight(5);
    fill(colours.get("White").colour);
    rect((int)(width * 0.7), (int)(height * 0.1), (int)(width * 0.25), (int)(height * 0.125), 28);
    fill(colours.get("Black").colour);
    rect((int)(width * 0.7), (int)(height * 0.1), (int)(width * 0.25), (int)(height * 0.02), 28, 28, 0, 0);
    fill(colours.get("White").colour);
    textAlign(LEFT, BASELINE);
    writeText("Default Bold", (int)(width * 0.775), (int)(height * 0.115), "Author Details");

    //Name Display
    fill(colours.get("Black").colour);
    textAlign(CENTER, BASELINE);
    writeText("Default Bold", (int)(width * 0.825), (int)(height * 0.145), "Name: " + name);

    //Age Display
    fill(colours.get("Black").colour);
    textAlign(CENTER, BASELINE);
    writeText("Default Bold", (int)(width * 0.825), (int)(height * 0.175), "Age: " + age);

    //Date Display
    fill(colours.get("Black").colour);
    textAlign(CENTER, BASELINE);
    writeText("Default Bold", (int)(width * 0.825), (int)(height * 0.205), "Date: " + formattedDate);
  }

  //Canvas Details (Top Middle)
  stroke(colours.get("Black").colour);
  strokeWeight(5);
  fill(colours.get("White").colour);
  rect((int)(width * 0.425), (int)(height * 0.1), (int)(width * 0.25), (int)(height * 0.125), 28);
  fill(colours.get("Black").colour);
  rect((int)(width * 0.425), (int)(height * 0.1), (int)(width * 0.25), (int)(height * 0.02), 28, 28, 0, 0);
  fill(colours.get("White").colour);
  textAlign(LEFT, BASELINE);
  writeText("Default Bold", (int)(width * 0.5), (int)(height * 0.115), "Canvas Configuration");

  //Shape Size Display
  fill(colours.get("Black").colour);
  textAlign(LEFT, BASELINE);
  writeText("Default Bold", (int)(width * 0.5), (int)(height * 0.15), "Shape Size: " + shapeSize);

  //error messages when importing
  if (!isAudioValid) {
    textAlign(LEFT, LEFT);
    fill(colours.get("Red").colour);
    writeText("Default Bold", width * 0.01, height * 0.25, "Uh oh! Something went wrong..");
    writeText("Default Bold", width * 0.01, height * 0.27, "Music is not loaded correcly. Try again?");
  }

  //display shapes palette
  shapeButtons.get("Circle").display();
  shapeButtons.get("Square").display();
  shapeButtons.get("Triangle").display();

  //creates a draw on the canvas using the buttons
  //call the alternateColors variable inside the shapeSelect class
  if (shapeButtons.get("Circle").alternateColors == 1 || shapeButtons.get("Square").alternateColors == 1 || shapeButtons.get("Triangle").alternateColors == 1) {
    if (shapeButtons.get("Circle").alternateColors == 1) {
      //when circle is selected, draw a circle when mouseclick
      if (mousePressed && (mouseX >= width * 0.15 && mouseX <= width * 0.95) && (mouseY >= height * 0.25 && mouseY <= height * 0.95)) {
        noStroke();
        fill(shapeColor);
        ellipse(mouseX, mouseY, shapeSize, shapeSize);
      }
    } else if (shapeButtons.get("Square").alternateColors == 1) {
      //when square is selected, draw a square when mouseclick
      if (mousePressed && (mouseX >= width * 0.15 && mouseX <= width * 0.95) && (mouseY >= height * 0.25 && mouseY <= height * 0.95)) {
        noStroke();
        fill(shapeColor);
        rect(mouseX, mouseY, shapeSize, shapeSize);
      }
    } else if (shapeButtons.get("Triangle").alternateColors == 1) {
      //when triangle is selected, draw a triangle when mosueclick
      if (mousePressed && (mouseX >= width * 0.15 && mouseX <= width * 0.95) && (mouseY >= height * 0.25 && mouseY <= height * 0.95)) {
        noStroke();
        fill(shapeColor);
        triangle(mouseX + shapeSize * 0.2, mouseY + shapeSize * 0.8, mouseX + shapeSize / 2, mouseY + shapeSize * 0.2, mouseX + shapeSize * 0.8, mouseY + shapeSize * 0.8);
      }
    }
  }

  //Back button
  buttons.get("Back Home").display();
  if (buttons.get("Back Home").mouseOver((int)(width * 0.9), (int)(height * 0.02), (int)(width * 0.05), (int)(height * 0.05)) && mousePressed && (mouseButton == LEFT)) {
    currMenu = 2;
  }

  //reset button
  buttons.get("Reset").display();

  //save picture as button
  buttons.get("Save").display();

  // - and + button beside the shape size button
  buttons.get("Plus").display();
  buttons.get("Minus").display();

  //Ink Color Palettes
  palettes.get("Dark Red").display();
  palettes.get("Brown").display();
  palettes.get("Red").display();
  palettes.get("Orange").display();
  palettes.get("Pink").display();

  palettes.get("Lime").display();
  palettes.get("Green").display();
  palettes.get("Olive").display();
  palettes.get("Yellow Green").display();
  palettes.get("Sea Green").display();

  palettes.get("Dark Blue").display();
  palettes.get("Blue").display();
  palettes.get("Light Blue").display();
  palettes.get("Cyan").display();
  palettes.get("Teal").display();

  palettes.get("Turquiose").display();
  palettes.get("Indigo").display();
  palettes.get("Violet").display();
  palettes.get("Magenta").display();
  palettes.get("Purple").display();

  palettes.get("Wheat").display();
  palettes.get("Chocolate").display();
  palettes.get("Dark Salmon").display();
  palettes.get("Salmon").display();
  palettes.get("Light Salmon").display();

  palettes.get("White").display();
  palettes.get("Silver").display();
  palettes.get("Grey").display();
  palettes.get("Dim Grey").display();
  palettes.get("Black").display();

  //Background color palettes
  palettes.get("Background Dark Red").display();
  palettes.get("Background Brown").display();
  palettes.get("Background Red").display();
  palettes.get("Background Orange").display();
  palettes.get("Background Pink").display();

  palettes.get("Background Lime").display();
  palettes.get("Background Green").display();
  palettes.get("Background Olive").display();
  palettes.get("Background Yellow Green").display();
  palettes.get("Background Sea Green").display();

  palettes.get("Background Dark Blue").display();
  palettes.get("Background Blue").display();
  palettes.get("Background Light Blue").display();
  palettes.get("Background Cyan").display();
  palettes.get("Background Teal").display();

  palettes.get("Background Turquiose").display();
  palettes.get("Background Indigo").display();
  palettes.get("Background Violet").display();
  palettes.get("Background Magenta").display();
  palettes.get("Background Purple").display();

  palettes.get("Background Wheat").display();
  palettes.get("Background Chocolate").display();
  palettes.get("Background Dark Salmon").display();
  palettes.get("Background Salmon").display();
  palettes.get("Background Light Salmon").display();

  palettes.get("Background White").display();
  palettes.get("Background Silver").display();
  palettes.get("Background Grey").display();
  palettes.get("Background Dim Grey").display();
  palettes.get("Background Black").display();
}
