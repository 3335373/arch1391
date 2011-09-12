import processing.serial.*;
import cc.arduino.*;
import eeml.*;

Arduino arduino;
float myValue;
float lastUpdate;

DataOut dOut;

void setup()
{
println(Arduino.list());
arduino = new Arduino(this, Arduino.list()[1], 57600);

dOut = new DataOut(this, "http://www.pachube.com/api/35395.xml", "M"); 

dOut.addData(0,"test, light sensor");
dOut.addData(1,"test, timer");

}

void draw()
{
myValue = arduino.analogRead(0);
//println(myValue);   
if ((millis() - lastUpdate) > 15000){ 
       println(myValue);
       println("ready to PUT: ");      
       dOut.update(0, myValue);
       dOut.update(1,millis());
       int response = dOut.updatePachube();
       println(response);
       lastUpdate = millis();
    }   
  

}
