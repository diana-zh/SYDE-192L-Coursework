#define __SFR_OFFSET 0

#include "avr/io.h"

.global start
.global blink

start:
  ret

blink:
ldi r16, 0xFF
out DDRB, r16
ldi r16, 0x0
out PORTB, r16
sbi PORTB, 0
