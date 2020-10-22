# esp-idf-docker

## Quickstart

In order to quickly use this image you can directly run it.

Before you do so, you have to find out what device file your ESP32 is listed
as.

To do so run this command:

```
$ ls /dev/ttyUSB?*
/dev/ttyUSB0
```

Your output may vary a bit, on my machine, the device file for my ESP32 would
be `/dev/ttyUSB0`.

Assuming your are in your project directory, you can then just use normal
`idf.py` commands.

For example, to build and flash your project you could do:

```
$ docker run --device=/dev/ttyUSB0 -v $PWD:/code zuh0/esp-idf-docker idf.py fullclean build flash
```

If you don't specify any command, the image willl drop a `bash` shell for you
in the `/code` directory (where you're code should be).
