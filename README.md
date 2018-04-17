# Overview

This is just a project with the bare minimum amount of code required for booting a program onto an STM32F0xx chip.

It is not a good template for a new project, because it leaves out some important things which most programs rely on. But it is intended as more of a first step into understanding what makes these chips tick.

A makefile is provided, but the project can also be compiled for the target STM32F031K6 'Nucleo' board with these commands:

* arm-none-eabi-gcc -x assembler-with-cpp -c -O0 -mcpu=cortex-m0 -mthumb -Wall -fmessage-length=0 core.S -o core.o

* arm-none-eabi-gcc core.o -mcpu=cortex-m0 -mthumb -Wall --specs=nosys.specs -nostdlib -lgcc -T./STM32F031K6T6.ld -o main.elf

To upload the resulting program, you can use your choice of uploader/debugger. I use GDB and Texane's "stlink" project:

https://github.com/texane/stlink

It's a fairly simple process to upload and debug a program:

1. Plug your board in - for ST's Nucleo boards, you can just use an ordinary micro-USB cable.

2. Enter 'st-util' in a terminal window after installing the utilities linked above. You should see some general information printed about your chip.

3. Run `arm-none-eabi-gdb main.elf` (or whatever your file is called, if it's not 'main.elf')

4. Point GDB to the port opened by 'st-util' - usually 4242: `target extended-remote :4242`

5. Enter `load` to upload your program.

6. You're code is uploaded! Enter `continue` to start it running, and hit `ctrl+C` a few times (followed by 'y' for 'yes') to interrupt it once it's started.

Once the code is uploaded, you can more or less treat the GDB debugging session like you would any other C/C++ program. You can set breakpoints, step through the code with `s`/`si`/`n`/`ni`, inspect variables or memory addresses, and so on.

This is very useful when you're getting started; even before you set up communications like the Arduino IDE's "Serial Monitor", it lets you quickly zero in on where problems might be in your code, inspect registers as you try to learn about peripherals, and other fun stuff like that.
