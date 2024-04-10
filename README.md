# Processing - OSC logger

This script allows for logging OSC messages from [IEM EnergyVisualizer](https://plugins.iem.at/docs/plugindescriptions/#energyvisualizer) into a CSV file.

## Description

This script allows for logging all the 426 values from the points on the [EnergyVisualizer's grid](https://plugins.iem.at/docs/energyvisualizergrid/) as well as the timestamp (in nanoseconds) into a CSV file. This could be used for a non-realtime processing of the ambisonic soundfield obtained with the EnergyVisualizer VST plugin and recorded with this script.

## Getting started & installation

1. Install [Processing IDE](https://processing.org/)
2. Download the script from this repository and open it via the Processing IDE
2. Install the VST host of your choice
    - Set up the DAW to message via OSC the beginning of the layback to the local port according to the listening port in the Processing script (by default the port number is 12001)
3. Install [IEM Plug-in Suite](https://plugins.iem.at/)
    - Set up EnergyVisualizer OSC to send messages to the listening port in the Processing script (by default the port number is 12001)

## Usage example

This example uses [Reaper DAW](https://www.reaper.fm/) by [Cockos](https://www.cockos.com/index.php).

1. Open `Options->Preferences`
2. Navigate to `Control/OSC/Web settings` page
3. Under `Control surfaces/OSC/Web control` click `Add`
4. Set the following settings:
    - Control surface mode: OSC (Open Sound Control)
    - Device name: whatever you prefer
    - Pattern config: Default
    - Mode: Device IP/port [send only]
    - Device port: 12001, Decive IP: 127.0.0.1
    - "Allow binding messages to REAPER actions and FX learn": leave unchecked
    - Outgoing max packet size: 1024, Wait between packets: 1 ms (although the default 10 ms might be just fine)
    - click `OK`
5. Set up an ambisonic track with IEM EnergyVisualizer
6. Set up EnergyVisualizer's OSC settings to IP 127.0.0.1 and port 12001. The interval value might be lowered to the minimum, so 1 ms.
7. Run the OSC logger script from Processing IDE.
8. Start the playback of the recording in Reaper. The logger will automatically create a CSV file in the script's home folder. The logger will stop autimatically with the playback. After stopping the logger, the timestamp and log size values will display 0 as in the initial state. Resuming playback will start new log and it will write up the file if it is present in the folder, so in order to avoid data loss, rename the file or copy it to another folder. Otherwise, the data will be lost.

#### Reaper Preferences, Control surfaces/OSC/Web control
![Reaper Preferences, Control surfaces/OSC/Web control](https://i.ibb.co/6WbvZLg/2024-04-10-14-39-35-REAPER-v7-14-Registered-to-Bart-omiej-Mr-z-Licensed-for-personal-small-busine.png)

#### EnergyVisualizer's OSC settings
![EnergyVisualizer's OSC settings](https://i.ibb.co/x7L9vTW/2024-04-10-14-46-43-unsaved-project-REAPER-v7-14-Registered-to-Bart-omiej-Mr-z-Licensed-for-p.png)

#### OSC logger
![OSC logger](https://i.ibb.co/z2Dj5qZ/2024-04-10-14-51-07.png)

## Support

All questions, comments and insights please address to me via e-mail: bartlomiej.mroz@pg.edu.pl

## License

This script is published under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/) license.

## Additional info

I recommend checking out Daniel Rudrich's script for real-time visualizations of EnergyVisualizer's data via OSC: https://github.com/DanielRudrich/EnergyVisualizerOscDemo
