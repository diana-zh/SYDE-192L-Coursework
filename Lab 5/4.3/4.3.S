#define __SFR_OFFSET 0
  
#include "avr/io.h"

.global start
.global go

start:


ldi r16, 0xFD
out DDRB, r16
ldi r16, 0x02
out PORTB, r16

ldi r16, 0xFF
out DDRD, r16
ldi r16, 0x0
out PORTD, r16

go:
ldi r17, 0x0
call begin_display_0
infinite:
in r16, PINB
andi r16, 0x02
cpi r16, 0x00
brne infinite
jmp loop

loop:
  inc r17
  andi r17, 0x0F
  call pause

  cpi r17, 0x00
  brne check_0
  call display_0
  jmp infinite

check_0:
  cpi r17, 0x01
  brne check_1
  jmp display_1

check_1:
  cpi r17, 0x02
  brne check_2
  jmp display_2

check_2:
  cpi r17, 0x03
  brne check_3
  jmp display_3

check_3:
  cpi r17, 0x04
  brne check_4
  jmp display_4

check_4:
  cpi r17, 0x05
  brne check_5
  jmp display_5

check_5:
  cpi r17, 0x06
  brne check_6
  jmp display_6

check_6:
  cpi r17, 0x07
  brne check_7
  jmp display_7

check_7:
  cpi r17, 0x08
  brne check_8
  jmp display_8

check_8:
  cpi r17, 0x09
  brne check_9
  jmp display_9

check_9:
  cpi r17, 0x0A
  brne check_A
  jmp display_A

check_A:
  cpi r17, 0x0B
  brne check_B
  jmp display_B

check_B:
  cpi r17, 0x0C
  brne check_C
  jmp display_C

check_C:
  cpi r17, 0x0D
  brne check_D
  jmp display_D

check_D:
  cpi r17, 0x0E
  brne check_E
  jmp display_E

check_E:
  cpi r17, 0x0F
  jmp display_F

jmp loop

begin_display_0:
  call clear_all
  sbi PORTB, 0
  sbi PORTB, 2
  sbi PORTD, 2
  sbi PORTD, 3
  sbi PORTD, 5
  sbi PORTD, 7
  call pause
  ret
  
display_0:
  call clear_all
  sbi PORTB, 0
  sbi PORTB, 2
  sbi PORTD, 2
  sbi PORTD, 3
  sbi PORTD, 5
  sbi PORTD, 7
  jmp loop

display_1:
  call clear_all
  sbi PORTD, 7
  sbi PORTD, 5
  jmp loop

display_2:
  call clear_all
  sbi PORTB, 0
  sbi PORTD, 7
  sbi PORTB, 3
  sbi PORTD, 2
  sbi PORTD, 3
  jmp loop

display_3:
  call clear_all
  sbi PORTB, 0
  sbi PORTD, 7
  sbi PORTB, 3
  sbi PORTD, 5
  sbi PORTD, 3
  jmp loop

display_4:
  call clear_all
  sbi PORTB, 2
  sbi PORTB, 3
  sbi PORTD, 7
  sbi PORTD, 5
  jmp loop

display_5:
  call clear_all
  sbi PORTB, 0
  sbi PORTB, 2
  sbi PORTB, 3
  sbi PORTD, 5
  sbi PORTD, 3
  jmp loop

display_6:
  call clear_all
  sbi PORTB, 0
  sbi PORTB, 2
  sbi PORTB, 3
  sbi PORTD, 2
  sbi PORTD, 3
  sbi PORTD, 5
  jmp loop

display_7:
  call clear_all
  sbi PORTB, 0
  sbi PORTD, 7
  sbi PORTD, 5
  jmp loop

display_8:
  call clear_all
  sbi PORTB, 0
  sbi PORTD, 7
  sbi PORTD, 5
  sbi PORTD, 3
  sbi PORTD, 2
  sbi PORTB, 2
  sbi PORTB, 3
  jmp loop

display_9:
  call clear_all
  sbi PORTB, 0
  sbi PORTB, 2
  sbi PORTD, 7
  sbi PORTB, 3
  sbi PORTD, 5
  sbi PORTD, 3
  jmp loop

display_A:
  call clear_all
  sbi PORTB, 0
  sbi PORTB, 2
  sbi PORTD, 7
  sbi PORTB, 3
  sbi PORTD, 2
  sbi PORTD, 5
  jmp loop

display_B:
  call clear_all
  sbi PORTB, 2
  sbi PORTB, 3
  sbi PORTD, 2
  sbi PORTD, 3
  sbi PORTD, 5
  jmp loop

display_C:
  call clear_all
  sbi PORTB, 0
  sbi PORTB, 2
  sbi PORTD, 2
  sbi PORTD, 3
  jmp loop

display_D:
  call clear_all
  sbi PORTD, 7
  sbi PORTB, 3
  sbi PORTD, 5
  sbi PORTD, 3
  sbi PORTD, 2
  jmp loop

display_E:
  call clear_all
  sbi PORTD, 2
  sbi PORTD, 3
  sbi PORTB, 0
  sbi PORTB, 2
  sbi PORTB, 3
  jmp loop

display_F:
  call clear_all
  sbi PORTD, 2
  sbi PORTB, 0
  sbi PORTB, 2
  sbi PORTB, 3
  call pause
  jmp infinite

clear_all:
  cbi PORTB, 0
  cbi PORTD, 7
  cbi PORTD, 5
  cbi PORTD, 3
  cbi PORTD, 2
  cbi PORTB, 2
  cbi PORTB, 3 
  ret


pause:
ldi r20, 0xDB
loop_3:
  ldi r19, 0x0
  loop_2:
    ldi r18, 0x0
    loop_1:
      mul r17, r17
      inc r18
      brne loop_1
    inc r19
    brne loop_2
  inc r20
  brne loop_3
ret
