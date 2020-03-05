void draw_bck_vanilla(){
    background(0); 
    background(kHUE, kSAT, kBRI/2, kALP);
         
    noStroke();
    for(int i=1; i<=4; i++){
      fill(cHUE, cSAT, cBRI, cALP); 
      ellipse(0, 0, (mainRadius*2 + mainOffset) + (i * mainOffset * pALP), (mainRadius*2 + mainOffset) + (i * mainOffset * pALP)); 
    }
        
    //image(rainbow, -mainRadius-mainOffset/2, -mainRadius-mainOffset/2, mainRadius*2+mainOffset, mainRadius*2+mainOffset);    

    noFill(); 
    stroke(pHUE, pSAT, pBRI, pALP); 
    strokeWeight(pALP * mainOffset); 
    ellipse(0, 0, mainRadius*2 + mainOffset, mainRadius*2 + mainOffset);
    
    rectMode(CORNER); 
    noStroke();
    for(int i=0; i<12; i++){
      fill((i/12.0) * 255, 255, 255, map(Amplitude[i], 0, 1, 0.5, 1)); 
      rect(-width/2, -height/2 + ((i/12.0) * height), 10+Amplitude[i]*30, ((1/12.0) * height)); 
    }
    
}
