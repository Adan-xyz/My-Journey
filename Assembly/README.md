### A little info!

In the `Learn/` section, I learned this on a pretty good website! If you’d like, you can visit it [here](https://asmtutor.com/)

### To get started

I’m using the Replit platform to get started

To learn Assembly on Replit, the easiest and most standard way is to use NASM (Netwide Assembler) on a Linux operating system (which Replit is based on)

The first step after creating a new project is to go to the Shell tab and type `nasm -v`
if it’s not already installed, a notification will appear with the [Yn] option for installation

The folder structure I use is simple:

```
root/
    └── src/
        └── main.asm
```
To run it (compile and link), I use this: `nasm -f elf64 src/main.asm -o main.o && ld main.o -o main && ./main`
