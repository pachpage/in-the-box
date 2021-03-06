   /* Copyright (C) 2008 The Android Open Source Project
    *
    * Licensed under the Apache License, Version 2.0 (the "License");
    * you may not use this file except in compliance with the License.
    * You may obtain a copy of the License at
    *
    * http://www.apache.org/licenses/LICENSE-2.0
    *
    * Unless required by applicable law or agreed to in writing, software
    * distributed under the License is distributed on an "AS IS" BASIS,
    * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    * See the License for the specific language governing permissions and
    * limitations under the License.
    */

   /*
    * File: binopF.S
    *
    * Code: Generic 32-bit binary operation.  Provides an "instr" line to
    *       specify an instruction that performs "%xmm0 = %xmm0 op %xmm1"
    *
    * For: add-float, mul-float, sub-float
    *
    * Description: Perform a binary operation on two source registers
    *              and store the result in a destination register.
    *
    * Format: AA|op CC|BB (23x)
    *
    * Syntax: op vAA, vBB, vCC
    */

    FETCH_BB    1, %ecx                 # %ecx<- BB
    FETCH_CC    1, %edx                 # %edx<- CC
    FFETCH_ADV  2, %eax                 # %eax<- next instruction hi; fetch, advance
    movss       (rFP, %ecx, 4), %xmm0   # %xmm0<-vBB
    movss       (rFP, %edx, 4), %xmm1   # %xmm1<- vCC
    $instr                              # %xmm0<- vBB op vCC
    movss       %xmm0, (rFP, rINST, 4)  # vAA<- %xmm0; result
    FGETOP_JMP  2, %eax                 # jump to next instruction; getop, jmp