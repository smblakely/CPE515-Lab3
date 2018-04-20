   .arch    armv6
   .fpu     vfp
   .extern  intadd

   .global  intmul
intmul:
   push  {r1, r2, r3, r4, lr}
   mov   r2, r1
   mov   r1, r0
   mov   r0, #0
   mov   r4, #1
loop:
   and   r3, r2, r4
   cmp   r3, #0
   beq   loopscan
   bl    intadd

loopscan:
   lsl   r1, r1, #1
   lsr   r2, r2, #1
   cmp   r1, #0
   beq   end
   cmp   r2, #0
   beq   end
   b     loop

end:
   pop   {r1, r2, r3, r4, lr}
   mov   pc, lr
