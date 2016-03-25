# OS-papilio
A VHDL system without cpu originally designed for the papilio board (http://papilio.cc/)


You will find the VHDL sources in the vhdl folder. The wrapper is named OS.vhd.
Note: All comments are in french right now.

In the perl folder, you will find some tools to generate rom data (coe folder) or chunk of vhdl code.

# What can you do with this system ?
- We are using VGA (vga.vhd) to display something on a screen
- We can control the system with a mouse and keyboard (mouse.vhd, keyboard.vhd)
- We use PS/2 protocol to do that (ps2.vhd, ps2rx.vhd, ps2tx.vhd, ps2init.vhd)
- We have access to a console (console.vhd) waiting for a few commands (cmd.vhd)
- We can start a game (popcorn.vhd)
- We can play some melodies (audio.vhd) or play music with the keyboard (synthe.vhd)

# Note
I don't like the audio handling. Right now, its output is a sinus, so we cannot have a lot of variety. And I also neglected a few notes (didn't really think it was useful, I am not an expert in music).
Plan for the future, one day, if I am not too lazy, is to implement something looking a bit more like the NES audio system.

I also need to add the constraints (ucf) and binaries (bit) for the papilio, when I find them.