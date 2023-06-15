import processing.net.*;

Client myClient;

void setup() {
  size(200, 200);
  // Connect to the server's IP address and port
  myClient = new Client(this, "localhost", 9999);
}

void draw() {
  if (myClient.available() > 0) { 
    // Read data from the server
    String data = myClient.readString();
    println(data);
  }
}
