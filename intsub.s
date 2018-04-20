   .arch    armv6
   .fpu     vfp
   .extern  intadd

   .global  intsub
intsub:
   push  {r1, r2, r3, lr}
   mov   r2, #-1
   eor   r1, r1, r2
   mov   r3, r0
   mov   r0, #1
   bl    intadd
   mov   r1, r0
   mov   r0, r3
   bl    intadd
   pop   {r1, r2, r3, lr}
   mov   pc, lr
