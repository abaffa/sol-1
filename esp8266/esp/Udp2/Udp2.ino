#include <ESP8266WiFi.h>
#include <WiFiUdp.h>

#ifndef STASSID
#define STASSID "Quantum Mechanics"
#define STAPSK  "P@ulinhopj201"
#endif

unsigned int localPort = 51515;      // local port to listen on

// buffers for receiving and sending data
char packetBuffer[UDP_TX_PACKET_MAX_SIZE + 1]; //buffer to hold incoming packet,

WiFiUDP Udp;

void setup() {
  Serial.begin(38400);
  WiFi.mode(WIFI_STA);
  WiFi.begin(STASSID, STAPSK);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
  }
  
  Udp.begin(localPort);
}

void loop() {
  // if there's data available, read a packet
  int packetSize = Udp.parsePacket();
  if (packetSize) {
    Serial.printf("echo Received packet of size %d from %s : %d\n", packetSize, Udp.remoteIP().toString().c_str(), Udp.remotePort());

    // read the packet into packetBufffer
    int n = Udp.read(packetBuffer, UDP_TX_PACKET_MAX_SIZE);
    packetBuffer[n] = 0;
    Serial.println(packetBuffer);   
  }

  	size_t len = Serial.available();	
	if (len){
		char sbuf[UDP_TX_PACKET_MAX_SIZE + 1];
		Serial.readBytes(sbuf, len);
		
   	 	Udp.beginPacket(Udp.remoteIP(), Udp.remotePort());
    	Udp.write(sbuf);
    	Udp.endPacket();
	}

}
