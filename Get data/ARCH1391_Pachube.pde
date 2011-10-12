import processing.net.*;

ArrayList touch_time;
ArrayList touch_value;
ArrayList infra_time;
ArrayList infra_value;
ArrayList light_time;
ArrayList light_value;

Client c;
String data;
String host = "www.pachube.com";
String URL = "/feeds/35395/datastreams/0/archive.csv";
String key = "4R5ycTy1H6e-I6tzpkcLebZBam6X3jlMjYh5yaddvBM";

Client c2;
String data2;
String URL2 = "/feeds/35395/datastreams/1/archive.csv";

//this works in a browser:
//http://api.pachube.com/v2/feeds/28462/datastreams/4.csv?key=KEYXXXX&start=2011-08-24T00:00:00&end=2011-08-24T06:00:00&interval=0s&page=1

void setup() {
 
    size(200, 200);
    int pageNum = 1;
    String lastDate = "2011-10-01T14:00:00Z";
    String date = "2011-10-01T15:00:00Z";
    String getURL = String.format( "GET http://%s%s?key=%s&start=%s&end=%s&interval=0s&page=%d HTTP/1.1\n", host,URL,key,lastDate,date,pageNum ) ; 
    String getURL2 = String.format( "GET http://%s%s?key=%s&start=%s&end=%s&interval=0s&page=%d HTTP/1.1\n", host,URL2,key,lastDate,date,pageNum ) ;
    //?start=2011-08-14T00:00:00&end=2011-08-29T00:00:00&interval=0s&page=100";
    println( getURL );

    c = new Client(this, host, 80); // Connect to server on port 80
    c.write(getURL); // Use the HTTP "GET" command to ask for a Web page
    c.write("Host: pachube.com\n\n");

    c2 = new Client(this, host, 80); // Connect to server on port 80
    c2.write(getURL2); // Use the HTTP "GET" command to ask for a Web page
    c2.write("Host: pachube.com\n\n");

    touch_time = new ArrayList();
    touch_value = new ArrayList();
    infra_time= new ArrayList();
    infra_value= new ArrayList();

}

void draw() {
    if (c.available() > 0) { // If there's incoming data from the client...
        data = c.readString(); // ...then grab it and print it
        //print("xcxcxcxc");
        println("c: " + data);
        String[] ln = split(data,"\n\n");
        //println(ln[0]);
        for (int i = 1; i < ln.length; i++) {
            println(ln[i]);
            String[] temp = split(ln[i], ',');
            String[] time = split(temp[0], 'T');
            println(time[0]);
            println(time[1]);
            if (time.length > 1) {
                println("Time "+time[1]+ " Temperature"+temp[1]);
            }
        }
     //print("yyyyyyyy");
    }
 
    if (c2.available() > 0) { // If there's incoming data from the client...
        data2 = c2.readString(); // ...then grab it and print it
        //print("xcxcxcxc");
        //println(data2);
        String[] ln = split(data2,"\n\n");
        for (int i = 1; i < ln.length; i++) {
            String[] temp = split(ln[i], ',');
            String[] time = split(temp[0], 'T');
            if (time.length > 1) {
                println("Time "+time[1]+ " Touch "+temp[1]);
                light_time.add(time[1]);
                light_value.add(temp[1]);
            }
        }
        //print("yyyyyyyy");
    } 
}
