import themidibus.*; 
import http.requests.*;

MidiBus myBus; 

//----------INFO---------//
String[] processing = {"!", "@", "#", "$", "%", "^", "&", "*"};
int loopTest;
int introTest;
int timeOutTest;
String[] midiINFO = {"chopin", "etude in c major", "op. 10 no. 1", "1829"};
String version = "v1.0";
int fps;
int myFPS = 60; 
int myFrameCount = 0; 
int TextSize = 15; 
int timeOutCounter = 0; 
StringList MessageList = new StringList(); 
int MessageCount = 12; 
int noteCounter = 0; 
IntList notePS = new IntList(); 
int myMillis = 0; 

//----------SETUP---------//
PFont font;
float[] XCoordinatesSetup = new float[12];
float[] YCoordinatesSetup = new float[12];
float[] textCoordinatesX = new float[12];
float[] textCoordinatesY = new float[12];
float[] minorLocX = new float[12];
float[] minorLocY = new float[12];
String[] PitchList = {"A", "E", "B", "F#", "Db", "Ab", "Eb", "Bb", "F", "C", "G", "D"};
String[] minorPitchList = {"f#", "c#", "g#", "d#", "bb", "f", "c", "g", "d", "a", "e", "b"};
int pedalON = 0; 
int waitScreen = 90; 
int waitHold = 30;

//----------MIDI TRANFORM---------//
ArrayList GroupPitch = new ArrayList();
ArrayList GroupVel = new ArrayList();
float[] MidiAmp = new float[88]; 
float[] MidiAmpTarget = new float[88]; 
IntList noteOffPedal = new IntList(); 
float[] Amplitude = new float[12]; 
float[] AmpHist = new float[12];
int noteNumber;

//----------FFTv2---------//
float[] keyAmp = new float[12];
int[] keyMULT = {0, 1, 2, 3, 4, 5, 11}; 
float keyAVG;
float keySUM; 
float KeyPosXtarget = 0;
float KeyPosYtarget = 0;
  
//----------MIDI COF---------//
PImage rainbow;

int mainRadius = 150; 
int mainOffset = mainRadius/2; 

float PointerPosX;
float PointerPosY; 
float anglePointer; 
int pointerSmoothing = 5;
FloatList arrayPointerPosX = new FloatList();
FloatList arrayPointerPosY = new FloatList();
FloatList arraypBRI = new FloatList();
float pHUE = 0;
float pSAT = 0; 
float pBRI = 0; 
float pALP = 0;

float chaserPosX = 0;
float chaserPosY = 0;
float chaserSpeedX = 0;
float chaserSpeedY = 0;
float angleChaser = 0;
FloatList arrayChaserPosX = new FloatList();
FloatList arrayChaserPosY = new FloatList();
int chaserSmoothing = 50;
float cHUE = 0;
float cSAT = 0; 
float cBRI = 0;
float cALP = 0;
FloatList hueHist = new FloatList();
FloatList satHist = new FloatList();
FloatList briHist = new FloatList();
FloatList alpHist = new FloatList();

float KeyPosX = 0;
float KeyPosY = 0;
float angleKey = 0;
int keySmoothing = 400; 
FloatList arrayKeyAlpha = new FloatList();
float kHUE = 0;
float kSAT = 0; 
float kBRI = 0;
float kALP = 0;

//----------SPECTRUM---------//
float Centroid; 
float CentroidSum; 
float CentroidAvg; 
float CentroidTarget; 
float padding = 200; 

//------------VANILLA BCK--------------//
int[] indexSort = new int[12]; 
float[] ampCopy = new float[12]; 
float[] boxWidth = {10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10};
float[] boxWidthTarget = {10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10};
int graphCounter = 0;
int maxWidth = 200; 

//------------Read from FILE--------------//
String[] midiTxt;
String FileLoc = "C:/Users/Roel Westrik/Documents/GitHub/FFT_to_color/python fft/miditxtOUT.csv";
int readIndex =0;

//----------Send to Bridge---------//
String ip_adress = "http://192.168.1.10/";
String API = "api/EZ6pJKOHH8JOFa2wtNUaKymfSnjYQ6Vh1yCiG0kK/";
String[] hue_ID = {"9", "11"}; 
String[] iris_ID = {"10"};
String[] ct_ID = {};
String[] lamp_Array;
PostRequest[] post; 
int lampCounter = 0;
int hueMax = 65535;
int hueMillis = 0; 
int sendCheck = 200; 
int lastMillis = 0;
int lightsMULT = 0; 
float[] lastMessage = new float[5]; 
String mText = "no msg";
int mHUE = 0;
int mBRI = 0;
int mSAT = 0; 

//----------Send to Bridge---------//
int RecCheck = 0; 
StringList RecMsgs; 
int RecMillis; 
PrintWriter RecPrint;

void setup() {
  fullScreen(); 
  //size(1280, 720);
  frameRate(myFPS);
  font = createFont("mono-bold.ttf", 2);
  textFont(font); 
  background(255);
  textSize(TextSize);
  ellipseMode(CENTER);
  rectMode(CORNER); 
  colorMode(HSB, 255, 255+0, 255, 1); 
  strokeCap(SQUARE);
  textAlign(RIGHT, BOTTOM); 
  
  rainbow = loadImage("rainbow_small.png");
  
  MidiBus.list(); 
  myBus = new MidiBus(this, 0, 3); 
  
  midiTxt = loadStrings(FileLoc);
  
  for (int i = 0; i<MidiAmp.length; i++){
     MidiAmp[i] = 0; 
     MidiAmpTarget[i] = 0; 
  }
  
  for (int i=0; i<12; i++){
    XCoordinatesSetup[i]=(mainRadius)*sin((i*TWO_PI)/12);
    YCoordinatesSetup[i]=(mainRadius)*-cos((i*TWO_PI)/12);
    textCoordinatesX[i]=(mainRadius+mainOffset*1.5)*sin((i*TWO_PI)/12);
    textCoordinatesY[i]=(mainRadius+mainOffset*1.5)*-cos((i*TWO_PI)/12);
    minorLocX[i] = (mainRadius + mainOffset) * sin((i*TWO_PI)/12); 
    minorLocY[i] = (mainRadius + mainOffset) * -cos((i*TWO_PI)/12); 
    AmpHist[i]=0;
  }
  
  RecPrint = createWriter("test.txt");
  RecMsgs = new StringList(); 
  engine_sndJSON_stp();
  
}

void draw(){ 
  translate(width/2, height/2); 
  
  midiListener(); 
  //midiPlayer();
 
}

void midiListener(){ 
  engine_FFT_v2();
  draw_bck_vanilla();
  draw_cof(); 
  draw_spectrum(); 
  engine_sndJSON();
  draw_info("Hue Lights", "Hue: " + hue_ID.length, "Iris: " + iris_ID.length, "CT: " + ct_ID.length);
  engine_Recorder(); 

}

void midiPlayer(){
  loopTest = 0;
  
  if(frameCount < waitScreen*3 + waitHold*4){
    loopTest = 1;
  }
  
  if(frameCount >= waitScreen*3 + waitHold*4 && readIndex < midiTxt.length-1){
    loopTest = 2; 
  }
  
  if(readIndex >= midiTxt.length-1){
    loopTest = 3;  
  }   
  
  switch(loopTest){
    case 1:
      engine_intro(midiINFO[0], midiINFO[1], midiINFO[2], midiINFO[3]);
      break;
    case 2:
      engine_midiReader();
      //engine_FFT(); 
      
      draw_bck_vanilla();
      
      draw_cof(); 
      draw_spectrum(); 
      draw_info(midiINFO[0], midiINFO[1], midiINFO[2], midiINFO[3]); 
      
      myFrameCount = myFrameCount +1; 
      myMillis = 1000 * myFrameCount / myFPS; 
      
      //engine_sndJSON();
      break;
    case 3:
      engine_timeOut();  
      break;
  } 
  //engine_printScreen();
}
