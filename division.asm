global  division

section .text

; we want to operate on unsigned values
; remembers the original signs of x and y in r10b and r11b
; checks if x and y are negative
; if non are, great move along
; if y is, negete it
; if x is, negate it
division:
  ; initialize used variables 
  mov   rcx, rsi                   ; rcx = n
  mov   r15, rdx                   ; r15 := y
  xor   rdx, rdx                   ; rdx := 0
  xor   r10b, r10b                 ; clear r10b, sign of x (0->"+") 
  xor   r11b, r11b                 ; clear r11b, sign of y (0->"+") 

  ; check if y is negative
  cmp   r15, 0x0
  jge   .yPositive                 ; if y non-negative, skip next step
 
  ; y is negative:
  inc   r11b                       ; sign of y (1->"-") 
  neg   r15                        ; change -y to y (we now consider it an unsigned type)

.yPositive:
  call  .isXNegative               ; check if x is negative
  jge   .divBlock                  ; if non-negative, skip next step     

  ; if it is negative, we have to negate x first
  inc   r10b                       ; sign of x (1->"-") 
  call  .negateX                   ; change -x to x (we now consider it an unsigned type)

; we operate on unsigned values now
; divide each block (x[i]:x[i-1]) by y
; the quotient is our solution and we put it in x[]
; store the remainder in rdx to be used in next division
.divBlock:
  dec   rcx
 
  mov   rax, [rdi+rcx*8]           ; get next bloc from x
  div   r15                        ; quotient (rax), remainder (rdx)
  mov   [rdi+rcx*8], rax           ; put the quotient back in x

  jrcxz .results
  jmp   .divBlock

; the results of a program are prepared and returned here
.results:
  mov   rax, rdx                   ; we put the remainder of division in rax
  cmp   r10b, 0x0                  ; check the original sign of x
  je    .remainderPos              ; if x was positive skip next step

  neg   rax                        ; if x is negative, negate remainder

.remainderPos:
  xor   r11b, r10b
  jz    .xPositive                 ; if x and y had the same sign skip

  ; negate x and return
  call  .negateX 
  ret

; check if x fits in U2 representation as a positive number
; if it doesnt we have overflow
.xPositive:
  call  .isXNegative
  jl    .overflow
  ret

; changes x to positive and back
; we change each bit to the opposite one
; and add 1 to the result
.negateX:
  mov   rcx, rsi
.notX:
  dec   rcx
  not   qword [rdi+rcx*8]
  jrcxz .addOneX                   ; we notted entire x, now we need to add one
  jmp   .notX
.addOneX:                          
  add   qword [rdi+rcx*8], 0x1
  inc   rcx 
  jc    .addOneX                   ; while we carry keep adding
  mov   rcx, rsi                   ; set rcx back to n before returning back
  ret

; check if x is negative
; compare most significant 64-bits of x with 0
.isXNegative:
  cmp   qword [rdi+rsi*8 - 8], 0x0
  ret

; send signal SIGFPE
.overflow:
  mov   r8, 0x0
  div   r8
