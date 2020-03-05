void draw_info(String title, String title1, String title2, String title3){
    textAlign(RIGHT, BOTTOM);
  
    int xpos = width/2-40; 
    int xpos1 = width/2-240; 
    int musicHeight = -height/2+80;
    textAlign(RIGHT, CENTER); 
    noStroke(); 
    fill(255, 1); 
    text(title,   xpos, musicHeight+TextSize*1.5*(0));
    text(title1,  xpos, musicHeight+TextSize*1.5*(2)); 
    text(title2,  xpos, musicHeight+TextSize*1.5*(3)); 
    text(title3,  xpos, musicHeight+TextSize*1.5*(4));
    noFill();
    strokeWeight(1);
    stroke(255);
    line(xpos1, musicHeight+TextSize*1.5*(1), width/2, musicHeight+TextSize*1.5*(1)); 
    
    int messageHeight = -height/2+230;
    fill(255, 1); 
    text("RECEIVED MESSAGES:", xpos, messageHeight+TextSize*1.5*(0)); 
    text("Messages /s: " + notePS.size(),     xpos,messageHeight+TextSize*1.5*(2)); 
    text("Message count: " + noteCounter,     xpos,messageHeight+TextSize*1.5*(3)); 
    
    if(MessageList.size() >= MessageCount){
      for(int i=0; i<=MessageList.size() - MessageCount; i++){
        MessageList.remove(i); 
      }
    }
    if(MessageList.size() >= 1){
      for(int i=0; i<min(MessageList.size(),MessageCount); i++){
       fill(255, map(i+1, 0, min(MessageCount, MessageList.size()), 0, 1)); 
       text(MessageList.get(i),               xpos, messageHeight+TextSize*1.5*(4.5+MessageList.size()-1-i) ); 
      }
    }

    if(notePS.size() >=1){
      if(myMillis - notePS.get(0) > 1000){
        notePS.remove(0); 
      }
    }  
    noFill();
    strokeWeight(1);
    stroke(255);
    line(xpos1, messageHeight+TextSize*1.5*(1), width/2, messageHeight+TextSize*1.5*(1)); 
    
    int colorHeight = -height/2+650;  
    text("CURRENT (A)HSB:",                                   xpos, colorHeight+TextSize*1.5*(0)); 
    text("Alpha: "+ round(pALP*255) + "|" + round(cALP*255),  xpos, colorHeight+TextSize*1.5*(2));
    text("Hue: "+ round(pHUE) + "|" + round(cHUE),            xpos, colorHeight+TextSize*1.5*(3)); 
    text("Saturation: "+ round(pSAT) + "|" + round(cSAT),     xpos, colorHeight+TextSize*1.5*(4)); 
    text("Brightness: " + round(pBRI) + "|" + round(cBRI),    xpos, colorHeight+TextSize*1.5*(5)); 
    noFill();
    strokeWeight(1);
    stroke(255);
    line(xpos1, colorHeight+TextSize*1.5*(1), width/2, colorHeight+TextSize*1.5*(1)); 
    
    int infoHeight = -height/2+850;  
    fill(255);
    noStroke();
    text("VERSION INFO:",                   xpos, infoHeight+TextSize*1.5*(0));    
    text("time: " + round(myMillis/1000),   xpos, infoHeight+TextSize*1.5*(2)); 
    text("frame " + myFrameCount,           xpos, infoHeight+TextSize*1.5*(3)); 
    text(int(frameRate) + " FPS",           xpos, infoHeight+TextSize*1.5*(4));
    text(version,                           xpos, infoHeight+TextSize*1.5*(5));
    noFill();
    strokeWeight(1);
    stroke(255);
    line(xpos1, infoHeight+TextSize*1.5*(1), width/2, infoHeight+TextSize*1.5*(1));    
}
