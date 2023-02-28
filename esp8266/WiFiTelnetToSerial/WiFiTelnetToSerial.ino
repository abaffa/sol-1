#include <ESP8266WiFi.h>

#include <algorithm>

#define STASSID "Quantum Mechanics"
#define STAPSK	"password"

#define BAUD_SERIAL 38400

#define RXBUFFERSIZE 1024*32
#define STACK_PROTECTOR	1024*32 // bytes
#define MAX_SRV_CLIENTS 5

const char* ssid = STASSID;
const char* password = STAPSK;

const int port = 51515;

WiFiServer server(port);
WiFiClient serverClients[MAX_SRV_CLIENTS];

void setup() {

	Serial.begin(BAUD_SERIAL);
	Serial.setRxBufferSize(RXBUFFERSIZE);

	WiFi.mode(WIFI_STA);
	WiFi.begin(ssid, password);
	while (WiFi.status() != WL_CONNECTED) {
		delay(500);
	}

	server.begin();
	server.setNoDelay(true);

}

void loop() {
	if (server.hasClient()) {
		int i;
		for (i = 0; i < MAX_SRV_CLIENTS; i++)
			if (!serverClients[i]) {
				serverClients[i] = server.available();
				
				break;
			}

		//no free/disconnected spot so reject
		if (i == MAX_SRV_CLIENTS) {
			server.available().println("busy");
			
		}
	}
	
	for (int i = 0; i < MAX_SRV_CLIENTS; i++){
		while (serverClients[i].available() && Serial.availableForWrite() > 0) {
			char c = serverClients[i].read();
			if(c != 0x0D){
			  Serial.write(c);
			}
			
		}
	}

	// determine maximum output size "fair TCP use"
	int maxToTcp = 0;
	for (int i = 0; i < MAX_SRV_CLIENTS; i++)
		if (serverClients[i]) {
			int afw = serverClients[i].availableForWrite();
			if (afw) {
				if (!maxToTcp) {
					maxToTcp = afw;
				} 
				else{
					maxToTcp = std::min(maxToTcp, afw);
				}
			}
		}

	size_t len = std::min(Serial.available(), maxToTcp);
	len = std::min(len, (size_t)STACK_PROTECTOR);
	
	if (len) {
		uint8_t sbuf[len];
		int serial_got = Serial.readBytes(sbuf, len);
		for (int i = 0; i < MAX_SRV_CLIENTS; i++)
			if (serverClients[i].availableForWrite() >= serial_got) {
				size_t tcp_sent = serverClients[i].write(sbuf, serial_got);
			}
	}
}
