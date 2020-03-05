void engine_midiReader(){
  int TEST_ = 0; 

  while((TEST_ == 0) && (readIndex < midiTxt.length)){
    //println("frame " + myFrameCount + " has processed line " + readIndex + " of " + (midiTxt.length-1)); ]]
 
    String[] fragments = midiTxt[readIndex].split(","); 
    int mTime = Integer.parseInt(fragments[0]);
    float pTime = (myFrameCount-1) * (1000.0/myFPS);
    
    if(pTime < mTime){
      TEST_ = 1;
    } else {
      MidiAmpTarget[(Integer.parseInt(fragments[1]) - 21)] = Integer.parseInt(fragments[2]) / 127.0;
      
      if(Integer.parseInt(fragments[2]) == 0){
        MessageList.append("[noteOFF], pitch: " + (Integer.parseInt(fragments[1]) - 21)); 
        noteCounter = noteCounter+1;
        notePS.append(myMillis);
        
      } else if(Integer.parseInt(fragments[2]) > 0){
        MessageList.append("[noteON], pitch: " + (Integer.parseInt(fragments[1]) - 21) + ", vel: " + Integer.parseInt(fragments[2])); 
        noteCounter = noteCounter+1;
        notePS.append(myMillis);
        
      }
      
      if(MessageList.size() > MessageCount){
        MessageList.remove(0); 
      }
    
      readIndex = readIndex + 1; 
    }
  }  
}