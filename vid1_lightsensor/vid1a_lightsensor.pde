 import processing.serial.*;
import cc.arduino.*;
import eeml.*;
import pachuino.*;

Pachuino p;

void setup(){   
    p = new Pachuino(this, Arduino.list()[1], 57600);   
    p.manualUpdate("http://www.pachube.com/api/35395.xml"); // change URL -- this is the feed you want to update
    p.setKey("");   

   
    // local sensors   
    p.addLocalSensor("analog", 0,"lightSensor");

}

void draw(){
  float tempVall = p.localSensor[0].value;
  println(tempVall);
 
    //p.debug();
}



// you don't need to change any of these

void onReceiveEEML(DataIn d){ 
    p.updateRemoteSensors(d);
}
