# Installation

1. Clone the repository:
```bash
git clone https://github.com/tesm1/lab_work.git
```


# Usage
- Change names at the top of the Makefile to test with different processors.

## Compile and run ttasim
- Compiles program and displays how many clock cycles simulation takes
```bash
make cycles
```

## Build fpga files
- Default target that compiles program and builds all needed files for fpga simulation.
```bash
make
```

### NOTE

```bash
make clean
```
- Deletes vhdl files from the quartus project
- You need to recheck/readd included project files inside quartus

