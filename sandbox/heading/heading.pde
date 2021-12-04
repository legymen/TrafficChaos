PVector v;

void setup() {
  v = new PVector(1, -1);
  text(degrees(v.heading()), 20, 20);  // Prints "1.1071488"
}