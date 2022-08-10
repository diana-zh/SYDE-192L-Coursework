// Corresponding assembly language code implements a seven segment counter on Arduino

extern "C" {
// function prototypes
void start();
void light();
}

void setup() {
start();
}

void loop() {
light();
}
