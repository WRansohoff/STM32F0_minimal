/*
 * Test program to boot an STM32 chip with the absolute
 * minimum required code for teaching about the chips.
 *
 * Copyright William Ransohoff, Vivonomicon, LLC, 2017
 *
 * Open source under the MIT License
 */

.syntax unified
.cpu cortex-m0
.fpu softvfp
.thumb

// Global values.
.global vtable
.global reset_handler

/*
 * The vector table.
 * Most entries are ommitted for simplicity.
 */
.type vtable, %object
vtable:
    .word _estack
    .word reset_handler
.size vtable, .-vtable

/*
 * The Reset handler. Called on reset.
 */
.type reset_handler, %function
reset_handler:
  // Set the stack pointer to the end of the stack.
  // The '_estack' value is defined in our linker script.
  LDR  r0, =_estack
  MOV  sp, r0

  // Set some dummy values. When we see these values
  // in our debugger, we'll know that our program
  // is loaded on the chip and working.
  LDR  r7, =0xDEADBEEF
  MOVS r0, #0
  main_loop:
    // Add 1 to register 'r0'.
    ADDS r0, r0, #1
    // Loop back.
    B    main_loop
.size reset_handler, .-reset_handler
