const int switchPin = 2; // the number of the input pin
long startTime; // store starting time here
long stopTime; // store starting time here
long duration; // variable to store how long the timer has been running
float secduration; // variable to store the duration in seconds
int isRunning = 0;

void setup()
{
  Serial.begin(9600); //this will allow the Uno to comunicate with the serial monitor
  pinMode(switchPin, INPUT_PULLUP);
}

void loop()
{

  if (isRunning == 0 && digitalRead(switchPin) == LOW){ 
    startTime = millis();
    isRunning = 1;
  }
  if (isRunning == 1 && digitalRead(switchPin) == HIGH){
      stopTime = millis();
      duration = stopTime - startTime;
      secduration = (float)duration / 1000;
      Serial.print("Milliseconds: ");
      Serial.print(duration);
      Serial.print(" Seconds: ");
      Serial.print(secduration);
  }
 
   
  
}
