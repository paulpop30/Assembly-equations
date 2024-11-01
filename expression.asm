bits 32 ;assembling for the 32 bits architecture
global start 
; we ask the assembler to give global visibility to the symbol called start
;(the start label will be the entry point in the program)
extern exit ; we inform the assembler that the exit symbol is foreign; it exists even if we won't be
import exit msvcrt.dll ; we specify the external library that defines the symbol
 ; msvcrt.dll contains exit, printf and all the other important C-runtime functions
; our variables are declared here (the segment is called data)
segment data use32 class=data
 a dw 1234      
 b db 12         
 c dw 5678      
 d db 56 
 R dd 0 
; ...
; the program code will be part of a segment called code
segment code use32 class=code
start:
;c + 3 + d - (b - a)

mov ax,[c]    ; ax=c
add ax,3 ;ax=3+c
movzx bx,[d]   ; we complete the byte d with zeros on the left side to make it a word
add bx,ax  ;bx=3+c+d
movzx ax,[b]  ;we complete the byte b with zeros on the left side to make it a word
sub ax,word[a]  ;ax=b-a
sub bx,ax         ;bx=c + 3 + d - (b - a)
movzx eax,bx      ;eax=c + 3 + d - (b - a)
mov [R],eax



 
; ...
;here we will write the instructions to solve the problem
 ; call exit(0) ), 0 represents status code: SUCCESS
 push dword 0 ; saves on stack the parameter of the function exit
 call [exit] ; function exit is called in order to end the execution of the program
