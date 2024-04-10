import oscP5.*;
import java.util.Arrays;
import java.text.DecimalFormat;

OscP5 oscP5;

PrintWriter output;

double[][] rms2 = new double[150000][427];
DecimalFormat df = new DecimalFormat("0.000000000"); // accuracy of the logged values 
int idx = 0;
double tmstmp = 0.0;

float play = 0;
int played = 0;

void settings() {
  size(400, 200, P2D);
}

void setup() {
  frameRate(60);
  OscProperties myProperties = new OscProperties();
  myProperties.setDatagramSize (10000); 
  myProperties.setListeningPort (12001); // port number to listen OSC messages
  oscP5 = new OscP5(this,myProperties);
  output = createWriter("osc_rms.csv"); // csv filename
}

void draw() {
  background(100, 100, 100);
  textSize(20);
  text("log.size=" + idx, 50, 50);
  textSize(20); //<>//
  text("timestamp=" + String.format("%.0f", tmstmp), 50, 100); //<>//
}

// Update RMS values
void oscEvent (OscMessage message) {
  if (message.checkAddrPattern("/play")==true) {
    play = message.get(0).floatValue();
    print("play=" + play + " ");
  }
  if (message.checkAddrPattern("/EnergyVisualizer/RMS")==true) {
    var data = message.arguments();
    for (int i = 0; i < 426; ++i) {
      rms2[idx][i] = (float) data[i];
    }
    if (play == 1.0) {
      rms2[idx][426] = System.nanoTime(); // timestamp in nanoseconds
      tmstmp = rms2[idx][426];
      //print(Arrays.toString(rms2[idx]));
      Arrays.stream(rms2[idx]).forEach(e -> output.print(df.format(e) + ";" ));
      output.println("");
      idx++;
      played = 1;
    }
    if (play == 0.0 && played == 1) {
      output.flush(); // Writes the remaining data to the file
      output.close(); // Finishes the file
      played = 0;
      idx = 0;
      tmstmp = 0;
    }
  }
}
