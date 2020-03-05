void engine_Recorder(){
  
  fill(255); 
  noStroke(); 
  textAlign(CENTER); 
  int TextYPos = -400; 

  switch(RecCheck){
    case 0: 
      text("press R to start recording MIDI input", 0, TextYPos); 
      break; 
    case 1: 
      text("Recording...", 0, TextYPos); 
      
      break; 
  }
  
}

void keyPressed(){
  if (RecCheck == 0){
    RecMillis = millis(); 
  } else if (RecCheck == 1){
    println(RecMsgs);
    for(int i = 0; i<RecMsgs.size(); i++){
      RecPrint.println(RecMsgs.get(i));
    }
    RecPrint.flush();
    RecPrint.close();
    RecMsgs.clear(); 
  }
  
  if ((key == 'r') || (key == 'R')){
    RecCheck = (RecCheck + 1) % 2;
  }
}
