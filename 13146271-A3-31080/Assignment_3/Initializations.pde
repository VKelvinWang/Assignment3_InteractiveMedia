public class Colour {
  color colour;
  Colour(color colour) {
    this.colour = colour;
  }
}

void initializeImage() {
  //Initialization of all images
  images.put("Background", loadImage( dataPath("") + "/images/Background.jpg"));
  images.get("Background").resize(width, height);
  images.put("Feature Background", loadImage( dataPath("") + "/images/BackgroundGallery.jpg"));
}

void initializeColours() {
  //initialization of all colour palletes used into the program
  //81 colours
  colours.put("Maroon", new Colour(color(128, 0, 0)));
  colours.put("Dark Red", new Colour(color(139, 0, 0)));
  colours.put("Brown", new Colour(color(165, 42, 42)));
  colours.put("Firebrick", new Colour(color(178, 34, 34)));
  colours.put("Crimson", new Colour(color(220, 20, 60)));
  colours.put("Sky blue", new Colour(color(135, 206, 235)));
  colours.put("Red", new Colour(color(255, 0, 0)));
  colours.put("Tomato", new Colour(color(255, 99, 71)));
  colours.put("Coral", new Colour(color(255, 127, 80)));
  colours.put("Indian Red", new Colour(color(205, 92, 92)));
  colours.put("Light Coral", new Colour(color(240, 128, 128)));
  colours.put("Dark Salmon", new Colour(color(233, 150, 122)));
  colours.put("Salmon", new Colour(color(250, 160, 122)));
  colours.put("Light Salmon", new Colour(color(255, 160, 122)));
  colours.put("Orange Red", new Colour(color(255, 69, 0)));
  colours.put("Dark Orange", new Colour(color(255, 140, 0)));
  colours.put("Orange", new Colour(color(255, 165, 0)));
  colours.put("Gold", new Colour(color(255, 125, 0)));
  colours.put("Dark Golden Rod", new Colour(color(184, 134, 11)));
  colours.put("Golden Rod", new Colour(color(218, 165, 32)));
  colours.put("Pale Golden Rod", new Colour(color(238, 232, 170)));
  colours.put("Dark Khaki", new Colour(color(189, 183, 107)));
  colours.put("Khaki", new Colour(color(240, 230, 140)));
  colours.put("Olive", new Colour(color(128, 128, 0)));
  colours.put("Yellow", new Colour(color(255, 255, 0)));
  colours.put("Yellow Green", new Colour(color(154, 205, 50)));
  colours.put("Dark Olive Green", new Colour(color(85, 107, 47)));
  colours.put("Olive Drab", new Colour(color(107, 142, 35)));
  colours.put("Lawn Green", new Colour(color(124, 252, 0)));
  colours.put("Green Yellow", new Colour(color(173, 255, 47)));
  colours.put("Dark Green", new Colour(color(0, 100, 0)));
  colours.put("Green", new Colour(color(0, 128, 0)));
  colours.put("Lime", new Colour(color(0, 255, 0)));
  colours.put("Pale Green", new Colour(color(152, 251, 152)));
  colours.put("Dark Sea Green", new Colour(color(143, 188, 143)));
  colours.put("Medium Spring Green", new Colour(color(0, 250, 154)));
  colours.put("Spring Green", new Colour(color(0, 255, 127)));
  colours.put("Sea Green", new Colour(color(46, 139, 87)));
  colours.put("Medium Aqua Marine", new Colour(color(102, 205, 170)));
  colours.put("Medium Sea Green", new Colour(color(60, 179, 113)));
  colours.put("Light Sea Green", new Colour(color(32, 178, 170)));
  colours.put("Dark Slate Gray", new Colour(color(47, 79, 79)));
  colours.put("Teal", new Colour(color(0, 128, 255)));
  colours.put("Dark Cyan", new Colour(color(0, 139, 139)));
  colours.put("Cyan", new Colour(color(0, 255, 255)));
  colours.put("Turquiose", new Colour(color(64, 224, 208)));
  colours.put("Pale Turquiose", new Colour(color(175, 238, 238)));
  colours.put("Aqua Marine", new Colour(color(127, 255, 212)));
  colours.put("Cadet Blue", new Colour(color(95, 158, 160)));
  colours.put("Steel Blue", new Colour(color(70, 130, 180)));
  colours.put("Corn Flower Blue", new Colour(color(100, 149, 237)));
  colours.put("Deep Sky Blue", new Colour(color(0, 191, 255)));
  colours.put("Dodger Blue", new Colour(color(30, 144, 255)));
  colours.put("Sky Blue", new Colour(color(135, 206, 235)));
  colours.put("Midnight Blue", new Colour(color(25, 25, 112)));
  colours.put("Dark Blue", new Colour(color(0, 0, 128)));
  colours.put("Light Blue", new Colour(color(0, 255, 255)));
  colours.put("Blue", new Colour(color(0, 0, 255)));
  colours.put("Violet", new Colour(color(138, 43, 226)));
  colours.put("Indigo", new Colour(color(75, 0, 130)));
  colours.put("Slate Blue", new Colour(color(106, 90, 205)));
  colours.put("Dark Slate Blue", new Colour(color(72, 61, 139)));
  colours.put("Dark Magenta", new Colour(color(139, 0, 139)));
  colours.put("Magenta", new Colour(color(255, 0, 255)));
  colours.put("Purple", new Colour(color(128, 0, 128)));
  colours.put("Dark Purple", new Colour(color(64, 0, 64)));
  colours.put("Pink", new Colour(color(255, 20, 147)));
  colours.put("Hot Pink", new Colour(color(255, 105, 180)));
  colours.put("Light Pink", new Colour(color(255, 182, 203)));
  colours.put("Wheat", new Colour(color(245, 222, 179)));
  colours.put("Chocolate", new Colour(color(210, 105, 30)));
  colours.put("Peru", new Colour(color(205, 133, 63)));
  colours.put("Rosy Brown", new Colour(color(188, 143, 143)));
  colours.put("White", new Colour(color(255, 255, 255)));
  colours.put("Silver", new Colour(color(160, 160, 160)));
  colours.put("Grey", new Colour(color(128, 128, 128)));
  colours.put("Dim Grey", new Colour(color(100, 100, 100)));
  colours.put("Black", new Colour(color(0, 0, 0)));
  colours.put("Invisible", new Colour(color(0, 0, 0, 0)));
}

void initializeHUD() {
  //creation of button array
  PImage[] imgs = {loadImage( dataPath("") + "/images/button_a.png"), loadImage( dataPath("") + "/images/button_b.png"), loadImage( dataPath("") + "/images/button_c.png")};
  PImage[] imgs2 = {loadImage( dataPath("") + "/images/stopbutton_a.png"), loadImage( dataPath("") + "/images/stopbutton_b.png"), loadImage( dataPath("") + "/images/stopbutton_c.png")};
  PImage[] imgs3 = {loadImage( dataPath("") + "/images/pausebutton_a.png"), loadImage( dataPath("") + "/images/pausebutton_b.png"), loadImage( dataPath("") + "/images/pausebutton_c.png")};
  PImage[] imgs4 = {loadImage( dataPath("") + "/images/exitbutton_a.png"), loadImage( dataPath("") + "/images/exitbutton_b.png"), loadImage( dataPath("") + "/images/exitbutton_c.png")};
  PImage[] imgs5 = {loadImage( dataPath("") + "/images/selectbutton_a.png"), loadImage( dataPath("") + "/images/selectbutton_b.png"), loadImage( dataPath("") + "/images/selectbutton_c.png")};

  //initialization of textbox
  textboxes.put("Username", new Textbox( (int)(width * 0.3), (int)(height * 0.27), (int)(width * 0.2), (int)(height * 0.03), defaultTextSize, true));
  textboxes.put("Age", new Textbox( (int)(width * 0.3), (int)(height * 0.34), (int)(width * 0.2), (int)(height * 0.03), defaultTextSize, true));

  //initialization of Control P5 library
  fixed = new ControlP5(this);

  //Initialization of checkboxes
  checkboxes.put("Feature 1", new Checkbox((int)(width * 0.3), (int)(height * 0.42), (int)(width * 0.02), (int)(height * 0.02)));
  checkboxes.put("Feature 2", new Checkbox((int)(width * 0.3), (int)(height * 0.46), (int)(width * 0.02), (int)(height * 0.02)));

  //Initialization of transition buttons
  buttons.put("Home Button", new Button((int)(width * 0.45), (int)(height * 0.625), (int)(width * 0.10), (int)(height * 0.05), "To main menu"));
  buttons.put("Feature 1", new Button((int)(width * 0.3), (int)(height * 0.35), (int)(width * 0.13), (int)(height * 0.08), "Simple Text Editor"));
  buttons.put("Feature 2", new Button((int)(width * 0.5), (int)(height * 0.35), (int)(width * 0.13), (int)(height * 0.08), "Drawing Canvas"));
  buttons.put("Back Menu", new Button((int)(width * 0.9), (int)(height * 0.9), (int)(width * 0.05), (int)(height * 0.05), "Back"));
  buttons.put("Back Home", new Button((int)(width * 0.9), (int)(height * 0.02), (int)(width * 0.05), (int)(height * 0.05), "Back"));
  buttons.put("Reset", new Button((int)(width * 0.475), (int)(height * 0.165), (int)(width * 0.05), (int)(height * 0.05), "Reset"));
  buttons.put("Minus", new Button((int)(width * 0.465), (int)(height * 0.13), (int)(width * 0.02), (int)(height * 0.02), "-"));
  buttons.put("Plus", new Button((int)(width * 0.595), (int)(height * 0.13), (int)(width * 0.02), (int)(height * 0.02), "+"));
  buttons.put("Save", new Button((int)(width * 0.55), (int)(height * 0.165), (int)(width * 0.05), (int)(height * 0.05), "Save"));
  
  //Initializations of font selection for feature 2
  buttons.put("Default", new Button((int)(width * 0.175), (int)(height * 0.135), 100, 25, "Default"));
  buttons.put("Bold", new Button((int)(width * 0.25), (int)(height * 0.135), 100, 25, "Bold"));
  buttons.put("Italic", new Button((int)(width * 0.325), (int)(height * 0.135), 100, 25, "Italic"));
  buttons.put("BoldItalic", new Button((int)(width * 0.24), (int)(height * 0.175), 125, 25, "Bold & Italic"));
  
  //Initializations of shape palettes for feature 2
  shapeButtons.put("Circle", new ShapeSelect((int)(width * 0.2), (int)(height * 0.15), 50, 50, "Circle"));
  shapeButtons.put("Square", new ShapeSelect((int)(width * 0.25), (int)(height * 0.15), 50, 50, "Square"));
  shapeButtons.put("Triangle", new ShapeSelect((int)(width * 0.3), (int)(height * 0.15), 50, 50, "Triangle"));

  //Initializations of background color palettes for feature 2
  //first row
  palettes.put("Background Dark Red", new Palette((int)(width * 0.02), (int)(height * 0.675), 25, 25, "Dark Red"));
  palettes.put("Background Brown", new Palette((int)(width * 0.04), (int)(height * 0.675), 25, 25, "Brown"));
  palettes.put("Background Red", new Palette((int)(width * 0.06), (int)(height * 0.675), 25, 25, "Red"));
  palettes.put("Background Orange", new Palette((int)(width * 0.08), (int)(height * 0.675), 25, 25, "Orange"));
  palettes.put("Background Pink", new Palette((int)(width * 0.1), (int)(height * 0.675), 25, 25, "Pink"));
  
  //second row
  palettes.put("Background Lime", new Palette((int)(width * 0.02), (int)(height * 0.71), 25, 25, "Lime"));
  palettes.put("Background Green", new Palette((int)(width * 0.04), (int)(height * 0.71), 25, 25, "Green"));
  palettes.put("Background Olive", new Palette((int)(width * 0.06), (int)(height * 0.71), 25, 25, "Olive"));
  palettes.put("Background Yellow Green", new Palette((int)(width * 0.08), (int)(height * 0.71), 25, 25, "Yellow Green"));
  palettes.put("Background Sea Green", new Palette((int)(width * 0.1), (int)(height * 0.71), 25, 25, "Sea Green"));
  
  //Third row
  palettes.put("Background Dark Blue", new Palette((int)(width * 0.02), (int)(height * 0.745), 25, 25, "Dark Blue"));
  palettes.put("Background Blue", new Palette((int)(width * 0.04), (int)(height * 0.745), 25, 25, "Blue"));
  palettes.put("Background Light Blue", new Palette((int)(width * 0.06), (int)(height * 0.745), 25, 25, "Light Blue"));
  palettes.put("Background Cyan", new Palette((int)(width * 0.08), (int)(height * 0.745), 25, 25, "Cyan"));
  palettes.put("Background Teal", new Palette((int)(width * 0.1), (int)(height * 0.745), 25, 25, "Teal"));
  
  //Fourth row
  palettes.put("Background Turquiose", new Palette((int)(width * 0.02), (int)(height * 0.78), 25, 25, "Turquiose"));
  palettes.put("Background Violet", new Palette((int)(width * 0.04), (int)(height * 0.78), 25, 25, "Violet"));
  palettes.put("Background Indigo", new Palette((int)(width * 0.06), (int)(height * 0.78), 25, 25, "Indigo"));
  palettes.put("Background Magenta", new Palette((int)(width * 0.08), (int)(height * 0.78), 25, 25, "Magenta"));
  palettes.put("Background Purple", new Palette((int)(width * 0.1), (int)(height * 0.78), 25, 25, "Purple"));
  
  //Fifth row
  palettes.put("Background Wheat", new Palette((int)(width * 0.02), (int)(height * 0.815), 25, 25, "Wheat"));
  palettes.put("Background Chocolate", new Palette((int)(width * 0.04), (int)(height * 0.815), 25, 25, "Chocolate"));
  palettes.put("Background Dark Salmon", new Palette((int)(width * 0.06), (int)(height * 0.815), 25, 25, "Dark Salmon"));
  palettes.put("Background Salmon", new Palette((int)(width * 0.08), (int)(height * 0.815), 25, 25, "Salmon"));
  palettes.put("Background Light Salmon", new Palette((int)(width * 0.1), (int)(height * 0.815), 25, 25, "Light Salmon"));
  
  //Sixth row
  palettes.put("Background White", new Palette((int)(width * 0.02), (int)(height * 0.85), 25, 25, "White"));
  palettes.put("Background Silver", new Palette((int)(width * 0.04), (int)(height * 0.85), 25, 25, "Silver"));
  palettes.put("Background Grey", new Palette((int)(width * 0.06), (int)(height * 0.85), 25, 25, "Grey"));
  palettes.put("Background Dim Grey", new Palette((int)(width * 0.08), (int)(height * 0.85), 25, 25, "Dim Grey"));
  palettes.put("Background Black", new Palette((int)(width * 0.1), (int)(height * 0.85), 25, 25, "Black"));
  
  //initialization of ink color palettes for feature 2
  //first row
  palettes.put("Dark Red", new Palette((int)(width * 0.02), (int)(height * 0.325), 25, 25, "Dark Red"));
  palettes.put("Brown", new Palette((int)(width * 0.04), (int)(height * 0.325), 25, 25, "Brown"));
  palettes.put("Red", new Palette((int)(width * 0.06), (int)(height * 0.325), 25, 25, "Red"));
  palettes.put("Orange", new Palette((int)(width * 0.08), (int)(height * 0.325), 25, 25, "Orange"));
  palettes.put("Pink", new Palette((int)(width * 0.1), (int)(height * 0.325), 25, 25, "Pink"));
  
  //second row
  palettes.put("Lime", new Palette((int)(width * 0.02), (int)(height * 0.36), 25, 25, "Lime"));
  palettes.put("Green", new Palette((int)(width * 0.04), (int)(height * 0.36), 25, 25, "Green"));
  palettes.put("Olive", new Palette((int)(width * 0.06), (int)(height * 0.36), 25, 25, "Olive"));
  palettes.put("Yellow Green", new Palette((int)(width * 0.08), (int)(height * 0.36), 25, 25, "Yellow Green"));
  palettes.put("Sea Green", new Palette((int)(width * 0.1), (int)(height * 0.36), 25, 25, "Sea Green"));
  
  //Third row
  palettes.put("Dark Blue", new Palette((int)(width * 0.02), (int)(height * 0.395), 25, 25, "Dark Blue"));
  palettes.put("Blue", new Palette((int)(width * 0.04), (int)(height * 0.395), 25, 25, "Blue"));
  palettes.put("Light Blue", new Palette((int)(width * 0.06), (int)(height * 0.395), 25, 25, "Light Blue"));
  palettes.put("Cyan", new Palette((int)(width * 0.08), (int)(height * 0.395), 25, 25, "Cyan"));
  palettes.put("Teal", new Palette((int)(width * 0.1), (int)(height * 0.395), 25, 25, "Teal"));
  
  //Fourth row
  palettes.put("Turquiose", new Palette((int)(width * 0.02), (int)(height * 0.43), 25, 25, "Turquiose"));
  palettes.put("Violet", new Palette((int)(width * 0.04), (int)(height * 0.43), 25, 25, "Violet"));
  palettes.put("Indigo", new Palette((int)(width * 0.06), (int)(height * 0.43), 25, 25, "Indigo"));
  palettes.put("Magenta", new Palette((int)(width * 0.08), (int)(height * 0.43), 25, 25, "Magenta"));
  palettes.put("Purple", new Palette((int)(width * 0.1), (int)(height * 0.43), 25, 25, "Purple"));
  
  //Fifth row
  palettes.put("Wheat", new Palette((int)(width * 0.02), (int)(height * 0.465), 25, 25, "Wheat"));
  palettes.put("Chocolate", new Palette((int)(width * 0.04), (int)(height * 0.465), 25, 25, "Chocolate"));
  palettes.put("Dark Salmon", new Palette((int)(width * 0.06), (int)(height * 0.465), 25, 25, "Dark Salmon"));
  palettes.put("Salmon", new Palette((int)(width * 0.08), (int)(height * 0.465), 25, 25, "Salmon"));
  palettes.put("Light Salmon", new Palette((int)(width * 0.1), (int)(height * 0.465), 25, 25, "Light Salmon"));
  
  //Sixth row
  palettes.put("White", new Palette((int)(width * 0.02), (int)(height * 0.5), 25, 25, "White"));
  palettes.put("Silver", new Palette((int)(width * 0.04), (int)(height * 0.5), 25, 25, "Silver"));
  palettes.put("Grey", new Palette((int)(width * 0.06), (int)(height * 0.5), 25, 25, "Grey"));
  palettes.put("Dim Grey", new Palette((int)(width * 0.08), (int)(height * 0.5), 25, 25, "Dim Grey"));
  palettes.put("Black", new Palette((int)(width * 0.1), (int)(height * 0.5), 25, 25, "Black"));
  
  //addition of volume slider
  fixed.addSlider("volumeBG")
    .setSize((int)(width * 0.12), (int)(height * 0.02))
    .setPosition((int)(width * 0.06), (int) (height * 0.055))
    .setRange(0, 1);

  fixed.getController("volumeBG")
    .getCaptionLabel().hide();

  fixed.getController("volumeBG")
    .getValueLabel().hide();

  //addition of play, pause & stop buton
  fixed.addButton("playMusic")
    .setPosition((int)(width * 0.01), (int) (height * 0.09))
    .setImages(imgs)
    .updateSize();

  fixed.addButton("pauseMusic")
    .setPosition((int)(width * 0.05), (int) (height * 0.09))
    .setImages(imgs3)
    .updateSize();

  fixed.addButton("stopMusic")
    .setPosition((int)(width * 0.09), (int) (height * 0.09))
    .setImages(imgs2)
    .updateSize();

  fixed.addButton("chooseMusic")
    .setPosition((int)(width * 0.05), (int) (height * 0.16))
    .setImages(imgs5)
    .updateSize();

  fixed.addButton("exitSketch")
    .setPosition((int)(width * 0.96), (int) (height * 0.02))
    .setImages(imgs4)
    .updateSize();
}

void initializeSound() {
  //Initialization of all sound effects & musics
  sounds.put("Keyboard Click", new SoundFile(this, dataPath("") + "/sounds/soundeffects/keyboardtyping.wav"));
  sounds.put("Mouse Click", new SoundFile(this, dataPath("") + "/sounds/soundeffects/drum.wav"));
  sounds.put("Background Music", new SoundFile(this, dataPath("") + "/sounds/backgroundmusic/background1.mp3"));
}

void initializeFont() {
  //Initialization of all fonts
  fonts.put("Default", createFont("Arial", defaultTextSize, true));
  fonts.put("Default Bold", createFont("Arial Bold", defaultTextSize, true));
  fonts.put("Title", createFont(dataPath("") + "/fonts/title.ttf", 64));
  fonts.put("Subtitle", createFont(dataPath("") + "/fonts/subtitle.ttf", 32));
}

void playMusic() {
  //conducts the process inside play button
  //plays the background music on loop
  if (!sounds.get("Background Music").isPlaying()) {
    sounds.get("Background Music").play();
  }
}

void pauseMusic() {
  //conducts the process inside pause button
  //pauses the background music
  if (sounds.get("Background Music").isPlaying()) {
    sounds.get("Background Music").pause();
  }
}

void exitSketch() {
  exit();
}

void stopMusic() {
  //conducts the process inside stop button
  //Stops the background music
  if (sounds.get("Background Music").isPlaying()) {
    sounds.get("Background Music").jump(0);
    sounds.get("Background Music").stop();
  }
}

void chooseMusic() {
  //conducts the process for importing music
  selectInput("Select a music for background", "fileSelected");
}

void fileSelected(File selection) {
  isAudioValid = true;
  path = selection.getAbsolutePath();
  if (!isAnAudio(selection.getAbsolutePath())) {
    // Not an audio file
    isAudioValid = false;
  } else {
    //Imports a music variable
    sounds.get("Background Music").stop();
    sounds.replace("Background Music", new SoundFile(this, path));
    sounds.get("Background Music").play();
  }
}
