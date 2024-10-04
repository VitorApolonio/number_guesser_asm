# number_guesser_asm
An exercise from my school, thought it'd be fun to try and get the solution working in assembly so I did.

Basically you think of some number between 1 and 100, and the program tries to guess it in a max of 7 attempts. It does this with a binary search algorithm, asking the user whether the right number is greater than or less than the guess, and eliminating half the possibilities each time.

This is a x64 NASM program, and uses the Windows syntax.

To run, assemble it with [NASM](https://www.nasm.us/) and link it with something, I used gcc from [MSYS2](https://www.msys2.org/):

    $ nasm -f win64 -o advinhar.obj advinhar.asm
    $ gcc -o adivinhar.exe advinhar.obj

Then run the exe. Remember to install the base-devel and gcc packages on MSYS2 to get the necessary libraries, or else the program won't work.

Also the UI is in portuguese, since the original exercise was as well.
