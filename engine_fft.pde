//void engine_FFT(){
  
//  for(int i=0; i<MidiAmp.length; i++){
//    MidiAmpTarget[i] = MidiAmpTarget[i] * 0.995; 
//    float dx = MidiAmpTarget[i] - MidiAmp[i]; 
//    MidiAmp[i] = MidiAmp[i] + (dx /  pointerSmoothing); 
//  }
  
//  for(int i=0; i<12; i++){
//    Amplitude[i] = 0;
//    float maxMidiAmp=0; 
//    for(int j=0; j<7; j++){
//      if (MidiAmp[((i*7)%12)+(12*j)]>maxMidiAmp){
//        maxMidiAmp = MidiAmp[((i*7)%12)+(12*j)];
//      }
//      Amplitude[i] = maxMidiAmp;
//    }   
//    AmpHist[i] += Amplitude[i];
//  }
  
//  //----------Get Key Angle---------//
//  for(int j=0; j<12; j++){
//    keyAmp[j]=0; 
//    for(int i=11; i<18; i++){
//      keyAmp[j] += Amplitude[(j+i)%12]; 
//    }
//  }
  
//  keyPosX_ = 0;///  KeyPosYtarget = 0;
//  keySUM = 0;
//  for (int i =0; i<12; i++) {
//    keySUM += keyAmp[i];
//  }
  
//  if (keySUM > 0.0){
//    for (int i=0; i<12; i++){
//      float x_ = (mainRadius) * sin((TWO_PI/12) * i);
//      float y_ = (mainRadius) * -cos((TWO_PI/12) * i);
//      keyPosX_ += (keyAmp[i] * x_);
//      keyPosY_ += (keyAmp[i] * y_);
//    }
//    keyPosX_ /= keySUM;
//    keyPosY_ /= keySUM;
//  } else {
//    keyPosX_ = 0; 
//    keyPosY_ = 0; 
//  }
//  println(keyPosX_);   
  
//  //----------Get Spectral Centroid---------//

//  CentroidSum = 0; 
//  for(int i=0; i<MidiAmp.length; i++){
//    CentroidSum += MidiAmp[i];
//  }

//  if(CentroidSum > 0){
//    CentroidAvg = 0; 
//    for(int i=0; i<MidiAmp.length; i++){
//      CentroidAvg = CentroidAvg + (MidiAmp[i] * i); 
//    }
//    CentroidAvg = (CentroidAvg / CentroidSum) / (MidiAmp.length-1); 
//  } else {
//    CentroidAvg = 0; 
//  }
  

  
//  //----------------POINTER POSITION---------------//  
//  if((max(MidiAmp)) > (1.0/127)){
//    PointerPosX = 0;
//    PointerPosY = 0;

//    float amplitudeMapSum = 0;
//    for (int i =0; i<Amplitude.length; i++) {
//      amplitudeMapSum += Amplitude[i];
//    }

//    for (int i=0; i<=11; i++){
//      float x_ = (mainRadius) * sin((TWO_PI/12) * i);
//      float y_ = (mainRadius) * -cos((TWO_PI/12) * i);
//      PointerPosX = PointerPosX + (Amplitude[i] * x_);
//      PointerPosY = PointerPosY + (Amplitude[i] * y_);
//    }
//    PointerPosX = PointerPosX/amplitudeMapSum;
//    PointerPosY = PointerPosY/amplitudeMapSum;
//    pBRI = CentroidAvg * 255;  

//  } else {
//    for (int i=0; i<12; i++){
//        Amplitude[i]=0;
//    }
//    PointerPosX = 0;
//    PointerPosY = 0;
//    pHUE = 0; 
//    pBRI = 0; 
//  }
  
//  arrayPointerPosX.append(PointerPosX);
//  arrayPointerPosY.append(PointerPosY);
//  arraypBRI.append(pBRI); 
  
//  if(arrayPointerPosX.size() > pointerSmoothing){
//    arrayPointerPosX.remove(0);
//    arrayPointerPosY.remove(0);
//    arraypBRI.remove(0);
//  }

 
//  PointerPosX = arrayPointerPosX.sum() / arrayPointerPosX.size();
//  PointerPosY = arrayPointerPosY.sum() / arrayPointerPosY.size();
//  anglePointer = atan2(PointerPosX - 0, PointerPosY - 0);
  
//  pHUE = map(anglePointer, PI, PI*-1, 0, 255);
//  pSAT = map(dist(PointerPosX, PointerPosY, 0, 0), 0, mainRadius, 0, 255);
//  pBRI = arraypBRI.sum() / arraypBRI.size(); 
//  pALP = max(MidiAmp);
 
//  hueHist.append(pHUE);
//  satHist.append(pSAT);
//  briHist.append(pBRI);
//  alpHist.append(pALP);
  
//  //----------------GET CHASER---------------//
//  float dX = PointerPosX - chaserPosX;
//  float dY = PointerPosY - chaserPosY;

//  chaserSpeedX = dX/chaserSmoothing;
//  chaserSpeedY = dY/chaserSmoothing;

//  chaserPosX = chaserPosX + chaserSpeedX;
//  chaserPosY = chaserPosY + chaserSpeedY;

//  angleChaser = atan2(chaserPosX - 0, chaserPosY - 0);
  
//  cHUE = map(atan2(chaserPosX, chaserPosY), PI, PI*-1, 0, 255);
//  cSAT = map(dist(chaserPosX, chaserPosY, 0, 0), 0, mainRadius, 0, 255);
//  cBRI = pBRI;
//  cALP = cALP + ((pALP - cALP) / chaserSmoothing);

//  //----------------GET KEY---------------//
//  arrayChaserPosX.append(chaserPosX);
//  arrayChaserPosY.append(chaserPosY);
//  arrayKeyAlpha.append(cALP);

//  if(arrayChaserPosX.size() > keySmoothing || arrayChaserPosY.size() > keySmoothing){
//    arrayChaserPosX.remove(0);
//    arrayChaserPosY.remove(0);
//    arrayKeyAlpha.remove(0);
//  }
  
//  KeyPosX = arrayChaserPosX.sum() / arrayChaserPosX.size();
//  KeyPosY = arrayChaserPosY.sum() / arrayChaserPosY.size();  
//  angleKey = atan2(keyPosX_ - 0, keyPosY_ - 0);
//  KeyPosX = (mainRadius) * sin(angleKey); 
//  KeyPosY = (mainRadius) * cos(angleKey); 
  
//  kHUE = map(angleKey, PI, PI*-1, 0, 255);
//  kSAT = 2
//  kBRI = pBRI;
//  kALP = arrayKeyAlpha.sum() / arrayKeyAlpha.size();
  
//  kHUE = int(map(kHUE, 0, 255, 0, 12)); 
//  kHUE = map(kHUE, 0, 12, 0, 255); 

//}
