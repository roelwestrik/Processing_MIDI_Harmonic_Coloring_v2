void draw_spectrum(){
  textAlign(CENTER, CENTER); 
  strokeCap(ROUND);
  for (int i = 0; i<MidiAmp.length; i++){
    noFill();
    stroke(255);
    strokeWeight(((width-(padding*2)) / 88) / map(MidiAmp[i],0,1,5,1));
    float xpos_ = ((width-(padding*2)) * i / (MidiAmp.length-1)) - (width-(padding*2))/2; 
    line(xpos_, height/2-TextSize*5, xpos_, height/2-TextSize*5 - MidiAmp[i] * height/4); 
   
    fill(255); 
    text(PitchList[((i*7))%12], xpos_, (height/2)-TextSize*3); 
  }
  
  noStroke();
  fill(255);
  textAlign(RIGHT, CENTER); 
  float xpos_ = map(cBRI, 0, 255, -width/2 + (padding), width/2 - (padding)); 
  triangle(xpos_, height/2 - 10, xpos_-10, height/2, xpos_+10, height/2); 
}
