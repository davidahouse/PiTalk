PiTalk
======

iPhone app to control Raspberry Pi GPIO pins.

Background
------

This week some code was linked to from Rasmus Anderson (https://github.com/rsms/peertalk) that showed how to talk to the iPhone from a Mac application using the USB cable. My immediate thought was how this could be used to connect the iPhone to microcontrollers such as the Arduino, but quickly turned to how this could be used to connect the iPhone to the Raspberry Pi. It seems that Alasdair Allan (@aallan) had the same idea at the same time, although he was thinking about the BeagleBone instead of the Pi. So we worked together to understand the PeerTalk implementation and think about how it could be used for our purposes.

Quickly we realized that this method depends on the usbmuxd service that runs on the Mac and provides a bridge to the iPhone. Actually it is cool how easy this little piece of software makes everything. Esentially the usbmuxd provides a TCP/IP bridge between the host and the iPhone. So you can open a socket from the host to the iPhone and then do all the fun sockets stuff we have been doing for ages. On the iPhone, you simply open a socket on the localhost and then accept incoming connections. On the host side, there is a bit of work to do if you are interacting directly with the usbmuxd service. This site (http://www.theiphonewiki.com/wiki/index.php?title=Usbmux) has some details if you are interested. Luckily I found a bit of Python code that handles that implementation here: (http://code.google.com/p/iphone-dataprotection/source/browse/usbmuxd-python-client/).

So in order to make this method work on a Raspberry Pi or BeagleBone (or really any Linux system), you need to get usbmuxd installed on it. There is an implementation of it that works, and thankfully Alasdair has provided us with a nice set of instructions on his blog post: (http://www.dailyack.com/2012/08/blinking-beaglebones-heartbeat-led-from.html). He describes the differences between the BeagleBone setup and Raspberry Pi (there is extremely little that is different). Once you have usbmuxd installed and working, you are ready to download the python code included in this project to the host.

Note: I had some random errors when trying to run the python script, so I think timing and order of things might be important. I believe this is the correct order for things to work smoothly:
  - run usbmuxd on the host
  - connect the iPhone
  - start the app on the iPhone (make sure it is a fresh start, not a resume)
  - run the python script

The interaction between the python script and the iOS application is very simple. There are 17 GPIO ports on the Raspberry Pi, so whenever the value is changed in the app, it sends the status of the switches to the python script. The python script uses the GPIO library to set the pin to either True or False. Because this is just a socket connection, you could build very complex interaction between the Pi and iPhone, the possibilities are endless.

Both the script and the iOS were written hastily, so they should not be used as examples of great programming technique. They might blow up your computer, kick your cat or start the zombie apocolypse. You have been warned.

Oh, and a video:
http://www.youtube.com/watch?v=M7xaOeUutKY

