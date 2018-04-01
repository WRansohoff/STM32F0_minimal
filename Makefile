# Makefile for compiling ARM Cortex-M0 assembly projects.
TARGET = main

# Define the linker script location and chip architecture.
LD_SCRIPT = STM32F031K6T6.ld
MCU_SPEC = cortex-m0

# Toolchain definitions (ARM bare metal defaults)
TOOLCHAIN = /usr
CC = $(TOOLCHAIN)/bin/arm-none-eabi-gcc
AS = $(TOOLCHAIN)/bin/arm-none-eabi-as
LD = $(TOOLCHAIN)/bin/arm-none-eabi-ld
OC = $(TOOLCHAIN)/bin/arm-none-eabi-objcopy
OD = $(TOOLCHAIN)/bin/arm-none-eabi-objdump
OS = $(TOOLCHAIN)/bin/arm-none-eabi-size

# Assembly directives.
ASFLAGS += -c
ASFLAGS += -O0
ASFLAGS += -mcpu=$(MCU_SPEC)
ASFLAGS += -mthumb
ASFLAGS += -Wall
# (Set error messages to appear on a single line.)
ASFLAGS += -fmessage-length=0

# Linker directives.
LSCRIPT = ./$(LD_SCRIPT)
LFLAGS += -mcpu=$(MCU_SPEC)
LFLAGS += -mthumb
LFLAGS += -Wall
LFLAGS += --specs=nosys.specs
LFLAGS += -nostdlib
LFLAGS += -lgcc
#LFLAGS += -nostartfiles
#LFLAGS += -static
LFLAGS += -T$(LSCRIPT)

AS_SRC += ./core.S

OBJS =  $(AS_SRC:.S=.o)

.PHONY: all
all: $(TARGET).elf

%.o: %.S
	$(CC) -x assembler-with-cpp $(ASFLAGS) $< -o $@

$(TARGET).elf: $(OBJS)
	$(CC) $^ $(LFLAGS) -o $@

.PHONY: clean
clean:
	rm -f $(OBJS)
	rm -f $(TARGET).elf
