   .arch    armv6
   .fpu     vfp
   .text

   .extern  intadd
   .extern  intsub
   .extern  intmul

   .global  main
main:
   push     {r0, r1, r2, r3, r4, r5, r6, r7, lr}
   b        loop

loop:
   ldr      r0, printdatan                   @Print num 1 line
   bl       printf
   ldr      r0, =scannum                     @Scan for int 1 input
   mov      r1, sp
   bl       scanf
   ldr      r4, [sp]                         @Store int 1 in r4
   ldr      r0, printdatan+4                 @Print num 2 line
   bl       printf
   ldr      r0, =scannum                     @Scan for int 2 input
   mov      r1, sp
   bl       scanf
   ldr      r5, [sp]                         @Store int 2 in r5
   ldr      r0, printdatan+8                 @Print operation line
   bl       printf
   ldr      r0, =scanchar                    @Scan for operator
   mov      r1, sp
   bl       scanf
   ldr      r1, =stradd
   ldrb     r1, [r1]
   ldrb     r0, [sp]
   cmp      r0, r1                           @Compare user's op to +
   beq      iadd                             @Branch to add if equal
   ldr      r1, =strsub
   ldrb     r1, [r1]
   cmp      r0, r1                           @Compare user's op to -
   beq      isub                             @Branch to sup if equal
   ldr      r1, =strmul
   ldrb     r1, [r1]
   cmp      r0, r1                           @Compare user's op to *
   beq      imul                             @Branch to mul if equal
   b        inv                              @Branch to invalid input

iadd:
   mov      r0, r4
   mov      r1, r5
   bl       intadd
   b        result
isub:
   mov      r0, r4
   mov      r1, r5
   bl       intsub
   b        result
imul:
   mov      r0, r4
   mov      r1, r5
   bl       intmul

result:
   mov      r1, r0
   ldr      r0, printresult
   bl       printf
   b        loopscan

inv:
   ldr      r0, printdatai
   bl       printf

loopscan:
   ldr      r0, printdatar
   bl       printf
   ldr      r0, =scanchar
   mov      r1, sp
   bl       scanf
   ldr      r1, =yes
   ldrb     r1, [r1]
   ldrb     r0, [sp]
   cmp      r0, r1
   beq      loop
   b        end

end:
   pop      {r0, r1, r2, r3, r4, r5, r6, r7, lr}
   mov      pc, lr

yes:
   .byte    'y'
stradd:
   .byte    '+'
strsub:
   .byte    '-'
strmul:
   .byte    '*'
scanchar:
   .asciz   " %c"
scannum:
   .asciz   " %d"

printdatai:
   .word    stringi
stringi:
   .asciz   "Invalid                    Operation                    Entered.\n"

printdatan:
   .word    stringn1
   .word    stringn2
   .word    stringn3
stringn1:
   .asciz   "Enter Number 1: "
stringn2:
   .asciz   "Enter Number 2: "
stringn3:
   .asciz   "Enter Operation: "

printdatar:
   .word    stringr1
stringr1:
   .asciz   "Again? "

printresult:
   .word    stringresult
stringresult:
   .asciz   "Result is: %d\n"

test:
   .word    stringtest
stringtest:
   .asciz   "%d + %d = %d\n"

