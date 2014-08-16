About terraPi
=======
The terraPi project is a collection of scripts to control a Terrarium using RaspberryPi, Embedded Pi, and Arduino Shields.

Sensor Modules
=======
Each sensor will be read using dedicated modules which can be loaded/unloaded with the terraPi script.

Requirements
=======
Hardware:
  Microcontroller:
    - Raspberry Pi Model B:       http://www.raspberrypi.org/
    - Embedded Pi:                http://www.coocox.org/epi.html
    - Grove Base Shield:          http://www.seeedstudio.com/wiki/Grove_-_Base_Shield

  Sensors:
    - Grove - Barometer Sensor:   http://www.seeedstudio.com/wiki/Grove_-_Barometer_Sensor

  Miscellaneous Equipment:
    - N/A
    
Software:
  Raspbian:
    - i2c tools:                  http://www.lm-sensors.org/wiki/I2CTools
    - python-smbus:               https://packages.debian.org/wheezy/python-smbus
    - Device::SMBus Perl Module:  https://metacpan.org/pod/Device::SMBus
