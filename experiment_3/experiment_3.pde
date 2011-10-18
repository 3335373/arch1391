// Controlling a servo position using a potentiometer (variable resistor) 
// by Michal Rinott <http://people.interaction-ivrea.it/m.rinott> 

#include <Servo.h> 
 
Servo myservo[3];  // create servo object to control a servo 
 
int potpin = 0;  // analog pin used to connect the potentiometer
int val;    // variable to read the value from the analog pin 
int lightPin = 0; 
int ledPin = 9;
int speakerPin = 5;
int length = 3; // the number of notes
char notes[] = "cdf "; // a space represents a rest
int beats[] = { 1, 2, 4 };
int tempo = 300;

void playTone(int tone, int duration) {
  for (long i = 0; i < duration * 1000L; i += tone * 2) {
    digitalWrite(speakerPin, HIGH);
    delayMicroseconds(tone);
    digitalWrite(speakerPin, LOW);
    delayMicroseconds(tone);
  }
}

void playNote(char note, int duration) {
  char names[] = { 'c', 'd', 'e', 'f', 'g', 'a', 'b', 'C' };
  int tones[] = { 1915, 1700, 1519, 1432, 1275, 1136, 1014, 956 };
  
  // play the tone corresponding to the note name
  for (int i = 0; i < 8; i++) {
    if (names[i] == note) {
      playTone(tones[i], duration);
    }
  }
}

void setup() 
{ 
  myservo[0].attach(8);  // attaches the servo on pin 9 to the servo object 
  myservo[1].attach(7);  
  myservo[2].attach(6);
  pinMode(speakerPin, OUTPUT);

} 
 
void loop() 
{ 
  val = analogRead(potpin);            // reads the value of the potentiometer (value between 0 and 1023) 
  val = map(val, 0, 1023, 0, 179); 
  if (val <= 36) {
       for (int i = 0; i < length; i++) {
    if (notes[i] == ' ') {
      delay(beats[i] * tempo); // rest
    } else {
      playNote(notes[i], beats[i] * tempo);
    }
    
    // pause between notes
    delay(tempo / 2); 
       }
      
  } else if (val <= 72) {
    myservo[0].write(val);
  } else if (val <= 108) {
    myservo[1].write(val); 
  } else if (val <= 144) {
    myservo[2].write(val);
  } else if (val <= 179) {     
    int lightLevel = analogRead(lightPin); //Read the
                                        // lightlevel
 lightLevel = map(lightLevel, 0, 900, 0, 255); 
         //adjust the value 0 to 900 to
         //span 0 to 255




 lightLevel = constrain(lightLevel, 0, 255);//make sure the 
                                           //value is betwween 
                                           //0 and 255
 analogWrite(ledPin, lightLevel);  //write the value
}
   
    
  // scale it to use it with the servo (value between 0 and 180) 
  //myservo[0].write(val);   
//myservo[1].write(val);
//myservo[2].write(val);// sets the servo position according to the scaled value 
  delay(15);                           // waits for the servo to get there 



}
