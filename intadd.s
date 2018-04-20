   .arch    armv6
   .fpu     vfp

   .global  intadd
intadd:
   push  {r1, r2, r3, r4, r5, r6, r7, lr}
   @Initialize carry to 0
   mov   r4, #0
   @Initialize mask to 1
   mov   r5, #1
   @Initialize temp to 0
   mov   r6, #0
   @Initialize sum to 0
   mov   r7, #0
loop:
   and   r2, r0, r5        @Bitmask op A
   and   r3, r1, r5        @Bitmask op B
   eor   r6, r2, r3        @Exor op A and op B
   eor   r6, r6, r4        @Exor result with carry
   orr   r7, r7, r6        @Set sum bit to result
   eor   r6, r2, r3        @Exor op A and op B for carry update
   and   r4, r4, r6        @r4 = Cin and (A eor B)
   and   r6, r2, r3        @r6 = A and B
   orr   r4, r4, r6        @Cout = r4 or r6
   mov   r6, #0            @Reset temp to 0
   cmp   r4, r5
   bne   else
   lsl   r4, r4, #1
else:
   lsl   r5, r5, #1
   cmp   r5, #0
   bne   loop

end:
   mov   r0, r7
   pop   {r1, r2, r3, r4, r5, r6, r7, lr}
   mov   pc, lr
