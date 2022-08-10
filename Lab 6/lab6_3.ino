const int switchPin = 2; // the number of the input pin
float startTime; // store starting time here
float stopTime; // store ending time
float duration; 
float frequency; 

int buttonState;

void setup()
{
  Serial.begin(9600); //comm with serial monitor
  pinMode(switchPin, INPUT_PULLUP);

  TCCROB |= _BV(2);
  TCCROB &= ~(_BV(1));
}

void loop()
{
  buttonState = digitalRead(switchPin);
if (buttonState == LOW) {
  startTime = millis();
  while (buttonState == LOW) {
  }
  stopTime = millis();

  duration = (stopTime - startTime) * 2 / 1000;
  frequency = 1 / (duration * 16);
  Serial.print(frequency);
  }
}
