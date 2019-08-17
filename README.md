# 8bit-computer
This is an implementation of [Ben Eater's 8-bit computer](https://eater.net/8bit/) using the Digilent Basys3 board.

## Instruction set
| Instruction | Binary | Argument | Description |
|:---:|:----:|:--------:|--|
| LDA | 0001 | \<ADDR\> | Load the value from the given RAM address into t he A register |
| ADD | 0010 | \<ADDR\> | Add to the value in the A register, the value in the given RAM address |
| SUB | 0011 | \<ADDR\> | Subtract from the value in the A register, the value in the given RAM address |
| STA | 0100 | \<ADDR\> | Store the value from the A register into the given RAM address|
| LDI | 0101 | #VALUE   | Load the value into the A register |
| JMP | 0110 | \<ADDR\> | Jump to the given address |
| JC  | 0111 | \<ADDR\> | Jump to the given address if last ADD/SUB operation had a carry |
| JZ  | 1000 | \<ADDR\> | Jump to the given address if last ADD/SUB operation result was zero |
| OUT | 1110 | 0000 | Output the value of the A register to the display |
| HLT | 1111 | 0000 | Halt the computer |

## Important information

### CPU Control Logic
The CPU control logic is implemented using a single EEPROM with 512 16-bit words.

The file containing the EEPROM contents needs to be located in `ROM/microcode.coe`. In the same folder, you can find the control logic with the CF and ZF flags as well as the control logic without the flags.

If you want to change something in the control logic, you can use the `ROM/generator.py` script to generate the `coe` file.

### RAM memory
This computer has a RAM memory with 16 8-bit words. In Ben's series, he had to "add" his program to memory every time he powered on the computer.

To make life easier, the RAM IP I use is pre-loaded with the contents of the `ROM/rom.coe` file. This means that you can write your program to that file and have your board ready to go after programming.

## Importing the project
To import the project, open Vivado, go to the TCL console, navigate to the repository folder and run `source 8bit-computer.tcl`.

This will create the project and import all needed files. You can then generate the bitstream and program your board. 
