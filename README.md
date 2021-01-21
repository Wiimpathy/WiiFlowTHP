## WiiFlow Trailer Converter

Convert videos to WiiFlow trailers. It creates the .thp(video) and .ogg(audio) files.
THP ffmpeg encoding comes from this code: https://github.com/jackoalan/avthp


## Usage

### Windows

- Drag'n drop the video to convert or an entire folder to CONVWIN.bat.
- The converted files should be in the THP folder.


### Linux

- Install FFmpeg. Debian likes : sudo apt-get install ffmpeg
- In a terminal, type ./CONVLINUX.sh "/path_to_video/file.mp4" for a single file,
 or ./CONVLINUX.sh /path_to_videos/ to convert a whole folder.



The above scripts are just a convenient way to launch the 2 executables that reside in
the bin folder.
The conversion is done in 2 parts :
1) FFmpeg is forcing a framerate of 25 and adding a 6 pixels black border. The goal is to reduce final thp size.
2) avthp encodes the video to thp, then extract audio and encode to a seperate vorbis .ogg file.

You can remove the 1st ffmpeg pass. But be warned that any video >= 50fps will produce much larger files.
The options passed to avthp can also be modified/disabled in the scripts. In the .bat, line starting with REM means
the option is disabled.
In CONVLINUX.sh, just remove/add # to activate or disable an option.


Here are the options :


FFmpeg
------

FPS : framerate. (default 25)

BORDER : crop, replace with black borders (default 8)

avthp
------

-s WidthxHeight : Video Resolution (default 320x240)

-t <1-5000> : Video duration in seconds. (default DURATION=30)

-q <1-100> : Video quality. (default QUALITY=80)

--noaudio : Disable audio in THP file. (default NOAUDIO=--noaudio)

--frameskip : Used with low input fps = choppy but smaller size. (default Disabled)

