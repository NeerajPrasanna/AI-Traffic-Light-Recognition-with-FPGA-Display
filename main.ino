#define PIN_RED     4
#define PIN_YELLOW  5
#define PIN_GREEN   6
#define PIN_NONE    7

void setup() {
  // Initialize serial communication
  Serial.begin(9600);
  // Configure output pins
  pinMode(PIN_RED, OUTPUT);
  pinMode(PIN_YELLOW, OUTPUT);
  pinMode(PIN_GREEN, OUTPUT);
  pinMode(PIN_NONE, OUTPUT);

  // Initialize all pins LOW
  digitalWrite(PIN_RED, LOW);
  digitalWrite(PIN_YELLOW, LOW);
  digitalWrite(PIN_GREEN, LOW);
  digitalWrite(PIN_NONE, LOW);

  Serial.println("Traffic Light UART Receiver Ready");
}

void loop() {
  // Check if data is available from UART
  if (Serial.available() > 0) {
    byte received = Serial.read(); // Read one byte
    byte data = received & 0x0F;   // Keep only the lower 4 bits

    Serial.print("Received byte: ");
    Serial.println(data, BIN);

    // Update output pins based on bits 0–3
    digitalWrite(PIN_RED,    data & 0b0001);
    digitalWrite(PIN_YELLOW, data & 0b0010);
    digitalWrite(PIN_GREEN,  data & 0b0100);
    digitalWrite(PIN_NONE,   data & 0b1000);
  }
}
