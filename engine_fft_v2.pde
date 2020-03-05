void engine_FFT_v2(){
  
  for(int i=0; i<MidiAmp.length; i++){
    MidiAmpTarget[i] = MidiAmpTarget[i] * 0.995; 
    float dx = MidiAmpTarget[i] - MidiAmp[i]; 
    MidiAmp[i] = MidiAmp[i] + (dx /  pointerSmoothing); 
  }
  
  for(int i=0; i<12; i++){
    Amplitude[i] = 0;
    float maxMidiAmp=0; 
    for(int j=0; j<7; j++){
      if (MidiAmp[((i*7)%12)+(12*j)]>maxMidiAmp){
        maxMidiAmp = MidiAmp[((i*7)%12)+(12*j)];
      }
      Amplitude[i] = maxMidiAmp;
    }   
    AmpHist[i] += Amplitude[i];
  }  
  
  //----------Get Spectral Centroid---------//

  CentroidSum = 0; 
  for(int i=0; i<MidiAmp.length; i++){
    CentroidSum += MidiAmp[i];
  }

  if(CentroidSum > 0){
    CentroidAvg = 0; 
    for(int i=0; i<MidiAmp.length; i++){
      CentroidAvg = CentroidAvg + (MidiAmp[i] * i); 
    }
    CentroidAvg = (CentroidAvg / CentroidSum) / (MidiAmp.length-1); 
  } else {
    CentroidAvg = 0; 
  }
  
  //----------------POINTER POSITION---------------//  
  if((max(MidiAmp)) > (1.0/127)){
    PointerPosX = 0;
    PointerPosY = 0;

    float amplitudeMapSum = 0;
    for (int i =0; i<Amplitude.length; i++) {
      amplitudeMapSum += Amplitude[i];
    }

    for (int i=0; i<12; i++){
      float x_ = (mainRadius) * sin((TWO_PI/12) * i);
      float y_ = (mainRadius) * -cos((TWO_PI/12) * i);
      PointerPosX = PointerPosX + (Amplitude[i] * x_);
      PointerPosY = PointerPosY + (Amplitude[i] * y_);
    }
    PointerPosX = PointerPosX/amplitudeMapSum;
    PointerPosY = PointerPosY/amplitudeMapSum;
    pBRI = CentroidAvg * 255;  

  } else {
    for (int i=0; i<12; i++){
        Amplitude[i]=0;
    }
    PointerPosX = 0;
    PointerPosY = 0;
    pHUE = 0; 
    pBRI = 0; 
  }
  
  arrayPointerPosX.append(PointerPosX);
  arrayPointerPosY.append(PointerPosY);
  arraypBRI.append(pBRI); 
  
  if(arrayPointerPosX.size() > pointerSmoothing){
    for(int i=0; i < arrayPointerPosX.size() - pointerSmoothing; i++){
      arrayPointerPosX.remove(0);
      arrayPointerPosY.remove(0);
      arraypBRI.remove(0);
    }
  }

  PointerPosX = arrayPointerPosX.sum() / arrayPointerPosX.size();
  PointerPosY = arrayPointerPosY.sum() / arrayPointerPosY.size();
  anglePointer = atan2(PointerPosX - 0, PointerPosY - 0);
  
  pHUE = map(anglePointer, PI, PI*-1, 0, 255);
  pSAT = map(dist(PointerPosX, PointerPosY, 0, 0), 0, mainRadius, 0, 255);
  pBRI = arraypBRI.sum() / arraypBRI.size(); 
  pALP = max(MidiAmp);
 
  //hueHist.append(pHUE);
  //satHist.append(pSAT);
  //briHist.append(pBRI);
  //alpHist.append(pALP);
  
  //----------------GET CHASER---------------//
  float dX = PointerPosX - chaserPosX;
  float dY = PointerPosY - chaserPosY;

  chaserSpeedX = dX/chaserSmoothing;
  chaserSpeedY = dY/chaserSmoothing;

  chaserPosX = chaserPosX + chaserSpeedX;
  chaserPosY = chaserPosY + chaserSpeedY;

  angleChaser = atan2(chaserPosX, chaserPosY);
  
  cHUE = map(atan2(chaserPosX, chaserPosY), PI, PI*-1, 0, 255);
  cSAT = map(dist(chaserPosX, chaserPosY, 0, 0), 0, mainRadius, 0, 255);
  cBRI = pBRI;
  cALP = cALP + ((pALP - cALP) / chaserSmoothing);

  //----------------GET KEY---------------//
  for(int i=0; i<12; i++){
    keyAmp[i]=0; 
    for(int j=0; j<keyMULT.length; j++){
      keyAmp[i] += Amplitude[(i+keyMULT[j])%12]; 
    }
  }
  
  KeyPosXtarget = 0;
  KeyPosYtarget = 0;
  keySUM = 0;
  for (int i =0; i<12; i++) {
    keySUM += keyAmp[i];
  }
  
  if (keySUM > 0.0){
    for (int i=0; i<12; i++){
      float x_ = (mainRadius) * sin((TWO_PI/12) * i);
      float y_ = (mainRadius) * -cos((TWO_PI/12) * i);
      KeyPosXtarget += (keyAmp[i] * x_);
      KeyPosYtarget += (keyAmp[i] * y_);
    }
    KeyPosXtarget /= keySUM;
    KeyPosYtarget /= keySUM;
  } else {
    KeyPosXtarget = 0; 
    KeyPosYtarget = 0; 
  }
  
  angleKey = atan2(KeyPosXtarget, KeyPosYtarget);
  KeyPosXtarget = mainRadius * sin(angleKey); 
  KeyPosYtarget = mainRadius * cos(angleKey); 

  dX = KeyPosXtarget - KeyPosX;
  dY = KeyPosYtarget - KeyPosY;
  
  KeyPosX += (dX/50);
  KeyPosY += (dY/50); 
  angleKey = atan2(KeyPosX, KeyPosY);
 
  kHUE = map(angleKey, PI, PI*-1, 0, 255);
  kSAT = map(dist(KeyPosX, KeyPosY, 0, 0), 0, mainRadius, 0, 255);
  kBRI = pBRI;
  kALP = cALP;

}
