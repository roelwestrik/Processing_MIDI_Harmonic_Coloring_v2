void noteOn(Note note) {
  noteCounter = noteCounter +1; 
  MidiAmpTarget[note.pitch() - 21] = note.velocity()/127.0; 
  int hasValue_ = 0; 
  int index_ = 0; 
  for(int i=0; i<noteOffPedal.size(); i++){
    if (note.pitch() - 21 == noteOffPedal.get(i)){
      hasValue_ = 1; 
      index_ = i; 
    }
  }
  
  if(hasValue_ == 1){
    noteOffPedal.remove(index_);
  }
  
  notePS.append(millis());
  MessageList.append("[noteON], Pitch: " + (note.pitch() - 21) + ", vel: " + note.velocity());
  if(RecCheck == 1){
    RecMsgs.append(millis() - RecMillis + "," + (note.pitch() - 21) + "," + note.velocity()); 
  }
}

void noteOff(Note note) {
  if(pedalON == 0){
    notePS.append(millis());
    MidiAmpTarget[note.pitch() - 21] = 0;
    MessageList.append("[noteOFF], Pitch: " + (note.pitch() - 21)); 
    if(RecCheck == 1){
      RecMsgs.append(millis() - RecMillis + "," + (note.pitch() - 21) + "," + "0"); 
    }
    noteCounter = noteCounter +1; 

  } else {
    noteOffPedal.append(note.pitch() - 21); 
  }
  

}

void controllerChange(ControlChange change) {
 
  if(change.number() == 64 && change.value > 127.0/2){
    pedalON = 1;
  } else if(change.number() == 64 && change.value < 127.0/2){
    pedalON = 0;
  }
  
  if(pedalON == 0){
    for(int i=0; i<noteOffPedal.size(); i++){
      int index_ = noteOffPedal.get(i);
      MidiAmpTarget[index_] = 0;
      MessageList.append("[noteOFF], Pitch: " + noteOffPedal.get(i)); 
      if(RecCheck == 1){
        RecMsgs.append(millis() - RecMillis + "," + noteOffPedal.get(i) + "," + "0"); 
      }
      notePS.append(millis());
      noteCounter = noteCounter +1; 
    }
    
    noteOffPedal.clear(); 
  }
}
