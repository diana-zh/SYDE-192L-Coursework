// Corresponding assembly language code brings an LED on Arduino to a blinking state

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
