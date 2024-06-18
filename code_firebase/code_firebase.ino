#define BLYNK_TEMPLATE_ID "TMPL3HCL9LZJ8"   //including blynk auth token and device details
#define BLYNK_TEMPLATE_NAME "fire alarm"
#define BLYNK_AUTH_TOKEN "pMr5I5yOFqcWErrrm6utQMTEq02Qr7SX" 

#include <ESP8266WiFi.h>
#include <BlynkSimpleEsp8266.h>

#include <Firebase_ESP_Client.h>
#include "addons/TokenHelper.h"   //Providing the token generation process info.
#include "addons/RTDBHelper.h"   //Providing the RTDB payload printing info and other helper functions.

#define API_KEY "AIzaSyCJXlGqamUrGHs9uD-oFTlhhWmCvk4o7ts"   // Inserting Firebase project API Key
#define DATABASE_URL "https://blaze-buddy-default-rtdb.firebaseio.com/"   // Inserting RTDB URL

FirebaseData fbdo;   //Defining Firebase Data object
FirebaseAuth auth;
FirebaseConfig config;

char auth_[] = BLYNK_AUTH_TOKEN;  
char ssid[]= "Wifi name";
char pass[]="Your password";

#define LED1 D1   //defining LED, buzzer and sensor pins 
#define LED2 D2
#define Buzzer D3
#define Sensor D0

int pinValue = 0;   //Initialising the switch pin value (whether the fire alarm is ON or OFF)

BlynkTimer timer;
int flag=0;

bool signupOK = false;
unsigned long sendDataPrevMillis = 0;
String firestatus="";

const char* locations[5] = {
"37.7749,-122.4194", // San Francisco
"34.0522,-118.2437", // Los Angeles
"40.7128,-74.0060", // New York
"41.8781,-87.6298", // Chicago
"29.7604,-95.3698" // Houston
};


void sendSensor(){
  if(pinValue==0){   
    Serial.println("System is ON");
    if (Firebase.ready() && signupOK && (millis() - sendDataPrevMillis > 2000 || sendDataPrevMillis == 0)){
      sendDataPrevMillis = millis();
      int isButtonPressed = digitalRead(D0);   //This code takes the sensor values and puts them in the variable
      int randomValue = random(1,6);   // Generate a random number between 1 and 5
      
      const char* location = locations[randomValue - 1];
      
      if (isButtonPressed==0 && flag==0) {
        Serial.println("Fire in the House");  
        Blynk.logEvent("fire_alert","Fire Detected");
        digitalWrite(LED2, LOW);  // green- low, red- high
        digitalWrite(LED1, HIGH);
        digitalWrite(Buzzer, HIGH);
        flag=1;
        firestatus="Fire Detected";
        Firebase.RTDB.setString(&fbdo, "Flame sensor/Status", firestatus);   //updating the status in Firebase using the variable firestatus 
        Firebase.RTDB.setInt(&fbdo, "Flame sensor/SensorValue", randomValue);   //updating the random value in Firebase
        Firebase.RTDB.setString(&fbdo, "Flame sensor/Location", location);  // updating the location in Firebase
        delay(40000);
      }
      else if (isButtonPressed==1)
      {
        flag=0;
        Serial.println("No Fire! Relax");  
        digitalWrite(LED2, HIGH);   // green- high, red- low
        digitalWrite(LED1, LOW);
        digitalWrite(Buzzer, LOW);
        firestatus="No Fire";
        Firebase.RTDB.setString(&fbdo, "Flame sensor/Status", firestatus);   //updating the status
        Firebase.RTDB.setInt(&fbdo, "Flame sensor/SensorValue", randomValue);   //updating the random value in Firebase
        Firebase.RTDB.setString(&fbdo, "Flame sensor/Location", location);  // updating the location in Firebase
      }
    }
  }
  else if(pinValue==0){
    Serial.println("System is OFF");
    digitalWrite(LED2, LOW);   //if the system is OFF then green light should also be low
  }
}

void setup(){
  Serial.begin(115200);   //The serial monitor is beginning
  pinMode(D0, INPUT);   //The sensor pin is set as the input pin
  pinMode(LED1, OUTPUT);   //The LED and buzzer pins are set as the output pins
  pinMode(LED2, OUTPUT);
  pinMode(Buzzer, OUTPUT);
  Blynk.begin(auth_, ssid, pass);   //This initiates the Blynk library
  timer.setInterval(2000L, sendSensor);   //This line calls the main function i.e., sendSensor

  config.api_key = API_KEY;   //Assigning the api key (required)
  config.database_url = DATABASE_URL;   //Assign the RTDB URL (required)
  if (Firebase.signUp(&config, &auth, "", "")){   //Sign up
    Serial.println("ok");
    signupOK = true;
  }
  else{
    Serial.printf("%s\n", config.signer.signupError.message.c_str());
  }
  config.token_status_callback = tokenStatusCallback;   //Assign the callback function for the long running token generation task  //see addons/TokenHelper.h
  Firebase.begin(&config, &auth);
  Firebase.reconnectWiFi(true);
  
  randomSeed(analogRead(A0));  // Initialize random number generator
}

//This gets values from the Blink app button widget.
BLYNK_WRITE(V0) {
  pinValue = param.asInt();
}

//In the loop function, the Blynk library is run.
void loop(){
  Blynk.run();
  timer.run();
}
