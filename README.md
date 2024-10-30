# Division Assembly Program

## Overview

This project implements an division algorithm in x86-64 assembly language, which performs integer division with remainder. The program takes two integers, `x` and `y`, and performs the division operation `x / y`. It handles negative values by storing their signs and converting them to unsigned values for the division process. This function is designed to be callable from C, allowing for easy integration with programs written in that language.

## Features

-   Handles both positive and negative inputs by adjusting their signs.
-   Performs division on blocks of 64 bits (8 bytes) of the input array.
-   Returns the remainder of the division operation.
-   Checks for overflow conditions based on the input values.

## Function Declaration

```
int64_t division(int64_t *x, size_t n, int64_t y);
```

## Parameters

-   `int64_t *x`: A pointer to an array of 64-bit integers representing the dividend.
-   `size_t n`: The number of elements in the array x, defining the length of the dividend.
-   `int64_t y`: The divisor.

## Usage

To use this program, you will need an x86-64 assembler and linker, such as NASM and GCC. Follow these steps to compile and run the program:

1. **Install NASM and GCC:** if you haven't already. You can install them using your package manager. For example, on Ubuntu:

    ```bash
    sudo apt-get install nasm gcc
    ```

2. **Compile the Assembly Code:**

    ```bash
    nasm -f elf64 division.asm -o division.o
    ```

3. **Link the Object File:**

    ```bash
    gcc main.c division.o -o main -no-pie
    ```

4. **Run the Program:**

    ```bash
    ./main
    ```

Note that a sample `main.c` file is already provided in this repository. This file demonstrates how to call the `division` function and can be used as a starting point for your own tests and experiments. Simply compile and link it with the assembly code as described above to run the example program.

## Code Structure

The assembly code is organized into several key sections that work together to perform the division operation. Below is an overview of the main components:

-   **Initialization**: This section sets up the necessary CPU registers and clears any sign flags before starting the division process.

-   **Input Handling**: This part checks the input values, determines their signs, and converts any negative values to their unsigned equivalents for processing.

-   **Division Algorithm**: The core logic of the program is implemented here. It processes the input values in blocks of 64 bits (8 bytes) and performs the division operation, calculating both the quotient and the remainder.

-   **Quotient Storage**: After the division, the calculated quotient is stored back into the original array or designated memory location.

-   **Remainder Calculation**: This section calculates the remainder of the division and adjusts its sign based on the original sign of the dividend.

-   **Overflow Handling**: This part checks for overflow conditions, particularly when attempting to divide by zero, and ensures that the program behaves correctly in such cases.

Each of these sections is critical to the overall functionality of the division algorithm and ensures that it operates correctly under various input conditions.

## Contributions

Contributions are welcome! Please feel free to open issues or submit pull requests for improvements or bug fixes.

## Author

Hanna Marszałek
