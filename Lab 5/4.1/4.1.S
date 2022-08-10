#define __SFR_OFFSET 0

#include "avr/io.h"

.global start
.global blink

start:
  ret

blink:
call on
call pause
call off
call pause
ret

pause:
ldi r20, 0xE1
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

on:
ldi r16, 0xFF
out DDRB, r16
ldi r16, 0x0
out PORTB, r16
sbi PORTB, 0
ret

off:
ldi r16, 0xFF
out DDRB, r16
ldi r16, 0x0
cbi PORTB, 0
