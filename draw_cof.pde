void draw_cof(){
  textAlign(CENTER);
  
  int pointerRadius = 10;
  int chaserRadius = 20;
  int keyRadius = TextSize*2;
  
  fill(255,1);
  noStroke();
  ellipse(PointerPosX, PointerPosY, pointerRadius, pointerRadius);
  
  noStroke();
  fill(255,1);
  ellipse(chaserPosX, chaserPosY, chaserRadius/2, chaserRadius/2);
  noFill();
  stroke(255,1);
  strokeWeight(1);
  ellipse(chaserPosX, chaserPosY, chaserRadius, chaserRadius);
  
  noFill(); 
  stroke(255, 1); 
  strokeWeight(1); 
  ellipse(0, 0, mainRadius*2 + mainOffset, mainRadius*2 + mainOffset);

  noStroke(); 
  fill(255, 1); 
  for (int i=0; i<=11; i++){
    float r_ = Amplitude[i] * mainOffset/2; 
    ellipse(XCoordinatesSetup[i], YCoordinatesSetup[i], r_, r_); 
    text(PitchList[i], textCoordinatesX[i], textCoordinatesY[i]);
    text(minorPitchList[i], minorLocX[i], minorLocY[i]); 
  }
  
  for (int i=0;i<=11;i++){
      stroke(255,Amplitude[i]*255);
      strokeWeight(Amplitude[i]*3);
      line(XCoordinatesSetup[i], YCoordinatesSetup[i], PointerPosX, PointerPosY);
  }
  
  for(int i=0; i<12; i++){
    indexSort[i]=i;
    ampCopy[i] = Amplitude[i];
  }

  for (int i = ampCopy.length - 1; i > 0; i--) {
    for (int j = 0; j < i; j++) {
      if (ampCopy[j] < ampCopy[j + 1]) {
        float t = ampCopy[j];
        ampCopy[j] = ampCopy[j + 1];
        ampCopy[j + 1] = t;
        
        int u = indexSort[j];
        indexSort[j] = indexSort[j + 1];
        indexSort[j + 1] = u;
      }
    }
  }
  
  noFill();
  strokeWeight(1);
  stroke(255, pALP);

  if(Amplitude[indexSort[2]]*127 > 1){     
    beginShape();   
    for (int i=0; i<3; i++){
      vertex(XCoordinatesSetup[indexSort[i]], YCoordinatesSetup[indexSort[i]]);
    }
    endShape(CLOSE);
  }
  
  strokeWeight(1);
  float baseX = 200;
  float baseY = baseX; 
  float radius_ = 15;
  for (int i=0; i<3; i++){
    float xpos = baseX + radius_*sin((i/3.0) * TWO_PI);
    float ypos = baseY + radius_*-cos((i/3.0) * TWO_PI);
    stroke(255, Amplitude[indexSort[i]]);
    fill(1/12.0 * indexSort[i] * 255, 255, 255, Amplitude[indexSort[i]]);
    ellipse(xpos, ypos, radius_, radius_); 
  }
  
  for (int i=0; i<12; i++){
    float kPosX_ = (300) *  sin((i*TWO_PI)/12); 
    float kPosY_ = (300) * -cos((i*TWO_PI)/12);  
    noStroke(); 
    fill(255);
    ellipse(kPosX_, kPosY_, keyAmp[i]*20, keyAmp[i]*20); 
    
    noFill();
    strokeWeight(keyAmp[i]);
    stroke(255, keyAmp[i]/2); 
    line(kPosX_, kPosY_, KeyPosX, KeyPosY); 
  }
  
  noFill(); 
  strokeWeight(1);
  stroke(255); 
  ellipse(KeyPosX, KeyPosY, 10, 10); 
  float dist_ = dist(KeyPosX, KeyPosY, 0, 0);
  
  rotate(-angleKey);
  noFill(); 
  stroke(255); 
  line(0, dist_, 0, mainRadius+mainOffset/2); 
  noStroke();
  fill(255); 
  triangle(0, mainRadius + mainOffset/1.25, mainOffset/10, mainRadius+mainOffset/2, -mainOffset/10, mainRadius+mainOffset/2); 
  rotate(angleKey);

}
