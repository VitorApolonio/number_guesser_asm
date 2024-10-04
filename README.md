# number_guesser_asm
An exercise from my school, thought it'd be fun to try and get the solution working in assembly so I did.

This is a x64 NASM program, and uses the Windows syntax.

To run, assemble it with [NASM](https://www.nasm.us/) and link it with something, I used gcc from [MSYS2](https://www.msys2.org/):

    $ nasm -f win64 -o advinhar.obj advinhar.asm
    $ gcc -o adivinhar.exe advinhar.obj

Then run the exe. Remember to install the development packages on MSYS2 to get the necessary libraries, or else the program won't work.

Also the UI is in portuguese, since the original exercise was as well.
