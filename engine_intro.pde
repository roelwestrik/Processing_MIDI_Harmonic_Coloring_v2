void engine_intro(String title, String title1, String title2, String title3){
    background(0);
    float xpos_ = 0; 
    float ypos_ = -60;    
    introTest = 0;
    
    if(frameCount > waitHold && frameCount < waitHold+waitScreen){
      introTest = 1; 
    }
 
    if(frameCount > waitHold*2 + waitScreen && frameCount < waitHold*2 + waitScreen*2){
      introTest = 2;
    }
       
    if(frameCount > waitHold*3 + waitScreen*2 && frameCount < waitHold*3 + waitScreen*3){
      introTest = 3;
    }
    
    switch(introTest){
      case 1:
        textAlign(RIGHT, CENTER); 
        noStroke(); 
        fill(255, 1); 
        text("hello world", xpos_, ypos_ - (TextSize * 1.5 * 1));
        
        noFill();
        stroke(255, 1); 
        strokeWeight(1); 
        line(-240, ypos_, xpos_, ypos_); 
      break;
    
      case 2:  
        textAlign(RIGHT, CENTER); 
        noStroke(); 
        fill(255, 1); 
        text(title, xpos_, ypos_ - (TextSize * 1.5 * 1));
        text(title1,xpos_, ypos_ + (TextSize * 1.5 * 1)); 
        text(title2, xpos_, ypos_ + (TextSize * 1.5 * 2)); 
        text(title3, xpos_, ypos_ + (TextSize * 1.5 * 3)); 
        
        noFill();
        stroke(255, 1); 
        strokeWeight(1); 
        line(-240, ypos_, xpos_, ypos_); 
      break;
       
      case 3:
        textAlign(RIGHT, CENTER); 
        noStroke(); 
        fill(255, 1); 
        text("allegro", xpos_, ypos_ - (TextSize * 1.5 * 1));
        
        noFill();
        stroke(255, 1); 
        strokeWeight(1); 
        line(-240, ypos_, xpos_, ypos_); 
      break;
    }
    
    noStroke();
    for(int i=0; i<12; i++){
      fill((i/12.0) * 255, 255, 255, 0.5); 
      rect(-width/2, -height/2 + ((i/12.0) * height), 10, ((1/12.0) * height)); 
    } 
  
}
