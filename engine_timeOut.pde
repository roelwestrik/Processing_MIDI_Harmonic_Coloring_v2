void engine_timeOut(){
  background(0);
  textAlign(RIGHT, CENTER);
  float ypos = -60;  
  timeOutTest = 0; 

  graph_bars();
 
  if(timeOutCounter < waitScreen){
    timeOutTest = 1; 
  } 
  
  if(timeOutCounter >= waitHold + waitScreen       && timeOutCounter < waitHold + waitScreen*2){
    timeOutTest = 2;
  }
  
  if(timeOutCounter >= waitHold*2 + waitScreen*2   && timeOutCounter < waitHold*2 + waitScreen*6){
    timeOutTest = 3;
  }  

  if(timeOutCounter >= waitHold*3 + waitScreen*6   && timeOutCounter < waitHold*3 + waitScreen*7){
    timeOutTest = 4;
  }  
  
  if(timeOutCounter >= waitHold*3 + waitScreen*7){
    timeOutTest = 5;
  }  
  
  switch(timeOutTest){
    case 1:
      noStroke();
      fill(255, 1);
      text("fin",                                 0, ypos - TextSize * 1.5);
      
      noFill();
      stroke(255, 1); 
      strokeWeight(1); 
      line(-240, ypos, 0, ypos); 
    break;
  
    case 2:
      noStroke();
      fill(255, 1);
      text("meta (pt. 1)",                        0, ypos - TextSize * 1.5);
      text(noteCounter + " messages processed",   0, ypos + TextSize * 1.5); 
      text("in",                                  0, ypos + TextSize * 1.5 * 2); 
      text(myMillis/1000.0 + " s",                0, ypos + TextSize * 1.5 * 3); 
      text(myFrameCount + " frames",              0, ypos + TextSize * 1.5 * 4); 
      noFill();
      stroke(255, 1); 
      strokeWeight(1); 
      line(-240, ypos, 0, ypos); 
      
      if(timeOutCounter == waitHold + waitScreen){
        float AmpHistSum = 0;
        float maxval_ = max(AmpHist); 
        for(int i=0; i<12; i++){
          AmpHistSum += AmpHist[i];
        }
        for(int i=0; i<12; i++){
          AmpHist[i] = AmpHist[i] / maxval_; 
          //AmpHist[i] = AmpHist[i] / AmpHistSum; 
          boxWidthTarget[i] = (AmpHist[i]) * maxWidth;
        }
      }
      if(timeOutCounter+1 == waitHold + waitScreen*2){
        for(int i=0; i<12; i++){
          boxWidthTarget[i] = 10;
        }
      }
    break;
    
    case 3:
      if(timeOutCounter == waitHold*2 + waitScreen*2){
        graphCounter = 1;
      } else if (timeOutCounter == waitHold*2 + waitScreen*3){
        graphCounter = 2;
      } else if (timeOutCounter == waitHold*2 + waitScreen*4){
        graphCounter = 3;
      } else if (timeOutCounter == waitHold*2 + waitScreen*5){
        graphCounter = 4;
      }
    
      graph_wave(graphCounter);     

      noStroke();
      fill(255, 1);
      text("meta (pt. 2)",                                0, ypos - TextSize * 1.5);
      switch(graphCounter){
        case 1:
          text("Hue",                                     0, ypos + TextSize * 1.5);
          text("Amp",                                     0, ypos + TextSize * 1.5*2);
          text("------",                                  0, ypos + TextSize * 1.5*3);
          text("time",                                    0, ypos + TextSize * 1.5*4);  
        break;
        
        case 2:
          text("Sat",                                     0, ypos + TextSize * 1.5);
          text("Amp",                                     0, ypos + TextSize * 1.5*2);
          text("------",                                  0, ypos + TextSize * 1.5*3);
          text("time",                                    0, ypos + TextSize * 1.5*4); 
        break;
        
        case 3:
          text("Bri",                                     0, ypos + TextSize * 1.5);
          text("------",                                  0, ypos + TextSize * 1.5*2);
          text("time",                                    0, ypos + TextSize * 1.5*3); 
        break;  
        
        case 4:
          text("Hue",                                     0, ypos + TextSize * 1.5);
          text("Sat",                                     0, ypos + TextSize * 1.5*2);
          text("Bri",                                     0, ypos + TextSize * 1.5*3);
          text("time",                                    0, ypos + TextSize * 1.5*4); 
        break;        
      }
    
    case 4:
      noStroke();
      fill(255, 1);
      text("goodbye",                             0, ypos - TextSize * 1.5);
      noFill();
      stroke(255, 1); 
      strokeWeight(1); 
      line(-240, ypos, 0, ypos);
      if (timeOutCounter+1 == waitHold*3 + waitScreen*7){
        for(int i=0; i<12; i++){
          boxWidthTarget[i] = width;
        }
      }
    break;
    
    case 5:
      noStroke();
      for(int i=0; i<12; i++){
        float bw = map(timeOutCounter, waitHold*3 + waitScreen*7, waitHold*3 + waitScreen*7 + 90, 0, width * (((((i+9)*7)%12)/10.0)+1));
        fill(0, 1); 
        rect(-width/2, -height/2 + ((i/12.0) * height), bw, ((1/12.0) * height)); 
      }
      if(timeOutCounter > waitHold*3 + waitScreen*7 + 120){
        exit();
      }
    break;
  } 
    
  timeOutCounter = timeOutCounter +1;

}

void graph_bars(){
  noStroke();
  for(int i=0; i<12; i++){
    float dw = boxWidthTarget[i] - boxWidth[i];
    boxWidth[i] = boxWidth[i] + (dw/((((i+9)*7)%12)+1)); 
    fill((i/12.0) * 255, 255, 255, map(boxWidth[i], 10, maxWidth, 0.5, 1)); 
    rect(-width/2, -height/2 + ((i/12.0) * height), boxWidth[i], ((1/12.0) * height)); 
  }
}

void graph_wave(int switch_){
  int chunks = 88; 
  int chunkSize = floor(hueHist.size()/chunks);
  int padding = 400; 
  strokeWeight( max( (((width - padding*2) / chunks)/ 2), 1) );
  strokeCap(ROUND);
  noFill();   
  beginShape();
  for (int i=0; i<chunks; i++){
    float xTotal = 0;
    float yTotal = 0;
    float alpTotal = 0;
    float briTotal = 0;
    float satTotal = 0;
    for (int j=0; j<chunkSize; j++){
        float xco = sin((hueHist.get(i*chunkSize + j)/255) * TWO_PI);
        float yco = cos((hueHist.get(i*chunkSize + j)/255) * TWO_PI);
        xTotal = xTotal + xco;
        yTotal = yTotal + yco;
        alpTotal = alpTotal + alpHist.get(i*chunkSize + j);
        satTotal = satTotal + satHist.get(i*chunkSize + j);
        briTotal = briTotal + briHist.get(i*chunkSize + j);
    }
    float xavg = xTotal / chunkSize;
    float yavg = yTotal / chunkSize;
    
    float avgAngle = atan2(xavg, yavg); 
    float avgHue = (255 + map(avgAngle, PI, PI*-1, 128, -128))%255;
    float avgAlp = alpTotal / chunkSize; 
    float avgSat = satTotal / chunkSize;
    float avgBri = briTotal / chunkSize;
    
    float xpos = map(i, 0, chunks, -width/2 + padding, width/2 -padding);
    float height_ = 0;
    
    switch(switch_){
      case 1:
        stroke(avgHue, 255, 255, 1);
        height_ = map(avgAlp, 0, 1, 0, 100);
      break;
      
      case 2:
        stroke(i/float(chunks) * 255, avgSat, 255, 1);
        height_ = map(avgAlp, 0, 1, 0, 100);
      break;
      
      case 3:
        stroke(255, map(avgBri, 0, 255, 0, 1));
        height_ = map(avgAlp, 0, 1, 0, 100);
      break;
      
      case 4:
        stroke(avgHue, avgSat, avgBri, 1);
        height_ = map(avgAlp, 0, 1, 0, 100);
      break;
    }
    
    float ypos1 = 200 + height_;
    float ypos2 = 200 - height_; 
    line(xpos, ypos1, xpos, ypos2);
    
  } 
}
