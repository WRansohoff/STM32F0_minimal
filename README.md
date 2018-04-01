# Overview

This is just a project with the bare minimum amount of code required for booting a program onto an STM32F0xx chip.

It is not a good template for a new project, because it leaves out some important things which most programs rely on. But it is intended as more of a first step into understanding what makes these chips tick.

A makefile is provided, but the project can also be compiled for the target STM32F031K6 'Nucleo' board with these commands:

* arm-none-eabi-gcc -x assembler-with-cpp -c -O0 -mcpu=cortex-m0 -mthumb -Wall -fmessage-length=0 core.S -o core.o

* arm-none-eabi-gcc core.o -mcpu=cortex-m0 -mthumb -Wall --specs=nosys.specs -nostdlib -lgcc -T./STM32F031K6T6.ld -o main.elf 
