/* End of RAM/Start of stack */
/* (4KB SRAM) */
_estack = 0x20001000;

MEMORY
{
    FLASH ( rx )      : ORIGIN = 0x08000000, LENGTH = 32K
    RAM ( rxw )       : ORIGIN = 0x20000000, LENGTH = 4K
}
