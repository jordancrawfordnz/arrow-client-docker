# Arrow Client on Docker
### What is this?
AngelCam is service that allows you to access your cameras from the cloud with features like cloud recording.

The Arrow client provides a secure connection between AngelCam and your network, rather than needing to make your camera web facing. AngelCam sells the AngelBox, a Raspberry Pi that can perform this task on your home network. However, advanced users can use the Arrow client directly on their existing equipment.

This Docker image makes it easy to setup and run the Arrow client, independant of your computer's operating system.

## Building
Use ``docker build -t jordancrawford/arrow-client .``.

## Running
Make a directory for your Arrow configuration. This is worth retaining as the ID will need to remain consistant between attempts.

``docker run --mac-address=[MAC address] -v [path to config]:/arrow-config -d --name arrow --rm jordancrawford/arrow-client [camera configuration parameters]``

### Getting a MAC Address
A MAC address identifies physical equipment on a network. Because Docker uses virtual machines, a random MAC address is given to a container when it starts. AngelCam identifies your Arrow client with a MAC address so this should stay constant for your configuration files.

Generate a MAC address using a tool like the [MAC Address Generator](http://www.miniwebtool.com/mac-address-generator/), then include the MAC address in the Docker run command.

### Keeping configuration constant
The Arrow client must be verified by showing a QR code to the camera. To avoid having to repeat this process, you'll want to keep your configuration file stored somewhere constant. The configuration folder (``/arrow-config``) is a volume in the image, but it is recommended that you map this to a location on your filesystem.

### Adding cameras
#### Network discovery
Arrow supports network discovery. This image compiles with the network discovery functunality included, however this has not been tested (@jordancrawfordnz couldn't get this working). This is likely due to the Docker environment.

Please create an issue or pull request if you have any thoughts or solutions.


#### Manually adding cameras
To manually add cameras, include a camera configuration parameter for each camera.

These follow the syntax:

- ``-r URL`` for RTSP services.
- ``-m URL`` for MJPEG services.
- ``-h addr`` for HTTP services.
- ``-t addr`` for TCP services.

([full details in the Arrow client source](https://github.com/angelcam/arrow-client/blob/master/src/main.rs))

For example, if you have a RTSP camera with the IP of 192.168.1.20, use:
``docker run --mac-address=[MAC address] -v [path to config]:/arrow-config -d --name arrow --rm jordancrawford/arrow-client -r 192.168.1.20``

### Setting up in AngelCam
[Please refer to the Arrow client quick start guide](https://github.com/angelcam/arrow-client/wiki/Quick-Start).

#### Using multiple cameras
If you want to use the Arrow client with multiple cameras, you may encounter an issue with the AngelCam website where you aren't given the option to pair two cameras. This is a known issue that they are working on, and the solution is to request an AngelBox ID from their support team with your Arrow client UUID (can obtain this from the config JSON file that gets created). [See more about this issue.](https://github.com/angelcam/arrow-client/issues/5).