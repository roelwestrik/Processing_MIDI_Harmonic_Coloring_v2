void engine_sndJSON(){
  hueMillis += int((1/frameRate)*1000); 
  
  // send to HUE lights
  if(hueMillis > sendCheck){
    if(lampCounter < int(hue_ID.length)){
      if(abs((cALP*255) - lastMessage[lampCounter]) > 10){
        mHUE = int(map(cHUE, 0, 255, 0, hueMax)); 
        mSAT = int(map(cSAT, 0, 255, 1, 254)); 
        mBRI = int(map(cALP, 0, 1, 1, 254)); 
    
        sndmsg("{\"hue\":" + mHUE + ", \"sat\":" + mSAT + ", \"bri\":" + mBRI + "}"); 
        mText = millis() + " lamp: " + lampCounter + " Post: " + post[lampCounter].getContent(); 
        lastMessage[lampCounter] = cALP; 
        hueMillis = 0;
      }    
    }
    
    // send to IRIS lights
    if (lampCounter >= int(hue_ID.length) && lampCounter < int(hue_ID.length) + int(iris_ID.length)){
      if (abs(kHUE - lastMessage[lampCounter]) > 10){
        mHUE = int(map(kHUE, 0, 255, 0, hueMax)); 
        mSAT = int(map(kSAT, 0, 255, 1, 254)); 
        mBRI = int(map(kALP, 0, 1, 1, 254)); 
        
        sndmsg("{\"hue\":" + mHUE + ", \"sat\":" + mSAT + ", \"bri\":" + mBRI + "}" );
        mText = millis() + "lamp: " + lampCounter + " Post: " + post[lampCounter].getContent(); 
        lastMessage[lampCounter] = kHUE; 
        hueMillis = 0;
      }   
    } 
    
    // send to CT lights    
    if (lampCounter >= int(hue_ID.length) + int(iris_ID.length) && lampCounter < int(hue_ID.length) + int(iris_ID.length) + int(ct_ID.length)){
      if (abs(cBRI - lastMessage[lampCounter]) > 10){
        sndmsg("{\"bri\":" + int(map(cALP, 0, 1, 1, 254)) + "\"ct\":" + int(map(cBRI, 0, 255, 500, 153)) + "}");
        mText = millis() + " lamp: " + lampCounter + " Post: " + post[lampCounter].getContent(); 
        lastMessage[lampCounter] = cBRI; 
        hueMillis = 0;
      }
    }
    
    lampCounter = (lampCounter + 1)%lamp_Array.length; 
  }    
  
  noStroke();
  fill(255);
  textAlign(CENTER, CENTER);
  if (hueMillis<240){
    text(mText, 0, -height/2 + 40); 
  } else {
    text("no new messages", 0, -height/2 + 40); 
  }
}

void sndmsg(String mJSON){
    post[lampCounter].method("PUT");
    post[lampCounter].addJson(mJSON);
    post[lampCounter].send();
}

void engine_sndJSON_stp(){
  lamp_Array = concat(hue_ID, iris_ID);
  lamp_Array = concat(lamp_Array, ct_ID); 
  
  post = new PostRequest[int(lamp_Array.length)]; 

  for (int i = 0; i<int(lamp_Array.length); i++){
    post[i] = new PostRequest(ip_adress + API + "lights/" + lamp_Array[i] + "/state/");
    post[i].method("PUT");
    post[i].addJson("{\"bri\":" + mBRI + "}");
    post[i].send();
    println("Response Content: " + post[i].getContent());

    delay(100);
  }
  for(int j=0; j<lamp_Array.length; j++){
    lastMessage[j] = 254; 
  }
}
