// Corresponding assembly code brings the LED connected to pin 8 to a 1Hz frequency blinking state

extern "C" {
// function prototypes
void start();
void blink();
}

void setup() {
start();
}

void loop() {
blink();
}
