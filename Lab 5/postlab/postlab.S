#define __SFR_OFFSET 0
  
#include "avr/io.h"

.global start
.global postlab

start:


ldi r16, 0xF9
out DDRB, r16
ldi r16, 0x06
out PORTB, r16

ldi r16, 0xFF
out DDRD, r16
ldi r16, 0x00
out PORTD, r16

call display_question

postlab:
  sbi PORTB, 1
  sbi PORTB, 2
  ldi r17, 0x0F
  ldi r18, 0x00
  ldi r20, 0x00
  ldi r24, 0x00
  ldi r23, 0x00

infinite_btn1:
  in r16, PINB
  andi r16, 0x06
  cpi r16, 0x02
  brne get_input_1
  inc r17
  call loop

get_input_1:
  in r16, PINB
  andi r16, 0x06
  cpi r16, 0x04
  brne infinite_btn1
  call get_press
  mov r18, r17
  ldi r17, 0x0F
  call display_question
  jmp infinite_btn2

infinite_btn2:
  in r16, PINB
  andi r16, 0x06
  cpi r16, 0x02
  brne get_input_2
  inc r17
  call loop

get_input_2:
  in r16, PINB
  andi r16, 0x06
  cpi r16, 0x04
  brne infinite_btn2
  call get_press
  jmp multiply

multiply:
  call clear_all
  mul r17, r18
  ldi r17, 0x00
  mov r17, r0
  mov r25, r0
  cpi r17, 0x00
  brne display_loop
  jmp display_F

display_loop:
  call pause
  call loop
  call flash_slow
  call check_loop
  call flash_slow
  call display_dash
  call flash_slow
  jmp display_loop

flash_slow:
  call pause
  call pause
  call clear_all
  call pause
  call pause
  ret

get_press:
  call pause
  call clear_all
  call loop
  call clear_all
  call pause
  call loop
  call clear_all
  call pause
  call loop
  call clear_all
  call pause
  call loop
  ret

loop:
  andi r17, 0x0F

  cpi r17, 0x00
  brne check_0
  call display_0
  ret

check_0:
  cpi r17, 0x01
  brne check_1
  call display_1
  ret

check_1:
  cpi r17, 0x02
  brne check_2
  call display_2
  ret

check_2:
  cpi r17, 0x03
  brne check_3
  call display_3
  ret

check_3:
  cpi r17, 0x04
  brne check_4
  call display_4
  ret

check_4:
  cpi r17, 0x05
  brne check_5
  call display_5
  ret

check_5:
  cpi r17, 0x06
  brne check_6
  call display_6
  ret

check_6:
  cpi r17, 0x07
  brne check_7
  call display_7
  ret

check_7:
  cpi r17, 0x08
  brne check_8
  call display_8
  ret

check_8:
  cpi r17, 0x09
  brne check_9
  call display_9
  ret

check_9:
  cpi r17, 0x0A
  brne check_A
  call display_A
  ret

check_A:
  cpi r17, 0x0B
  brne check_B
  call display_B
  ret

check_B:
  cpi r17, 0x0C
  brne check_C
  call display_C
  ret

check_C:
  cpi r17, 0x0D
  brne check_D
  call display_D
  ret

check_D:
  cpi r17, 0x0E
  brne check_E
  call display_E
  ret

check_E:
  cpi r17, 0x0F
  call display_F
  ret

ret

check_loop:
  andi r25, 0xF0

  cpi r25, 0x10
  brne check_12
  call display_1
  ret

  check_12:
    cpi r25, 0x20
    brne check_22
    call display_2
    ret
  
  check_22:
    cpi r25, 0x30
    brne check_32
    call display_3
    ret
  
  check_32:
    cpi r25, 0x40
    brne check_42
    call display_4
    ret
  
  check_42:
    cpi r25, 0x50
    brne check_52
    call display_5
    ret
  
  check_52:
    cpi r25, 0x60
    brne check_62
    call display_6
    ret
  
  check_62:
    cpi r25, 0x70
    brne check_72
    call display_7
    ret
  
  check_72:
    cpi r25, 0x80
    brne check_82
    call display_8
    ret
  
  check_82:
    cpi r25, 0x90
    brne check_92
    call display_9
    ret
  
  check_92:
    cpi r25, 0xA0
    brne check_A2
    call display_A
    ret
  
  check_A2:
    cpi r25, 0xB0
    brne check_B2
    call display_B
    ret
  
  check_B2:
    cpi r25, 0xC0
    brne check_C2
    call display_C
    ret
  
  check_C2:
    cpi r25, 0xD0
    brne check_D2
    call display_D
    ret
  
  check_D2:
    cpi r25, 0xE0
    brne check_E2
    call display_E
    ret
  
  check_E2:
    cpi r25, 0xF0
    call display_0
    ret

    ret

  
display_0:
  call clear_all
  sbi PORTB, 0
  sbi PORTB, 4
  sbi PORTD, 2
  sbi PORTD, 3
  sbi PORTD, 5
  sbi PORTD, 7
  call pause
  ret

display_1:
  call clear_all
  sbi PORTD, 7
  sbi PORTD, 5
  call pause
  ret

display_2:
  call clear_all
  sbi PORTB, 0
  sbi PORTD, 7
  sbi PORTB, 3
  sbi PORTD, 2
  sbi PORTD, 3
  call pause
  ret

display_3:
  call clear_all
  sbi PORTB, 0
  sbi PORTD, 7
  sbi PORTB, 3
  sbi PORTD, 5
  sbi PORTD, 3
  call pause
  ret

display_4:
  call clear_all
  sbi PORTB, 4
  sbi PORTB, 3
  sbi PORTD, 7
  sbi PORTD, 5
  call pause
  ret

display_5:
  call clear_all
  sbi PORTB, 0
  sbi PORTB, 4
  sbi PORTB, 3
  sbi PORTD, 5
  sbi PORTD, 3
  call pause
  ret

display_6:
  call clear_all
  sbi PORTB, 0
  sbi PORTB, 4
  sbi PORTB, 3
  sbi PORTD, 2
  sbi PORTD, 3
  sbi PORTD, 5
  call pause
  ret

display_7:
  call clear_all
  sbi PORTB, 0
  sbi PORTD, 7
  sbi PORTD, 5
  call pause
  ret

display_8:
  call clear_all
  sbi PORTB, 0
  sbi PORTD, 7
  sbi PORTD, 5
  sbi PORTD, 3
  sbi PORTD, 2
  sbi PORTB, 4
  sbi PORTB, 3
  call pause
  ret

display_9:
  call clear_all
  sbi PORTB, 0
  sbi PORTB, 4
  sbi PORTD, 7
  sbi PORTB, 3
  sbi PORTD, 5
  sbi PORTD, 3
  call pause
  ret

display_A:
  call clear_all
  sbi PORTB, 0
  sbi PORTB, 4
  sbi PORTD, 7
  sbi PORTB, 3
  sbi PORTD, 2
  sbi PORTD, 5
  call pause
  ret

display_B:
  call clear_all
  sbi PORTB, 4
  sbi PORTB, 3
  sbi PORTD, 2
  sbi PORTD, 3
  sbi PORTD, 5
  call pause
  ret

display_C:
  call clear_all
  sbi PORTB, 0
  sbi PORTB, 4
  sbi PORTD, 2
  sbi PORTD, 3
  call pause
  ret

  jmp infinite_btn2
  
display_D:
  call clear_all
  sbi PORTD, 7
  sbi PORTB, 3
  sbi PORTD, 5
  sbi PORTD, 3
  sbi PORTD, 2
  call pause
  ret

display_E:
  call clear_all
  sbi PORTD, 2
  sbi PORTD, 3
  sbi PORTB, 0
  sbi PORTB, 4
  sbi PORTB, 3
  call pause
  ret

display_F:
  call clear_all
  sbi PORTD, 2
  sbi PORTB, 0
  sbi PORTB, 4
  sbi PORTB, 3
  call pause
  ret

display_question:
  call clear_all
  sbi PORTB, 0
  sbi PORTD, 7
  sbi PORTD, 2
  sbi PORTB, 3
  ret

display_dash:
  call clear_all
  sbi PORTB, 3
  ret

clear_all:
  cbi PORTB, 0
  cbi PORTD, 7
  cbi PORTD, 5
  cbi PORTD, 3
  cbi PORTD, 2
  cbi PORTB, 4
  cbi PORTB, 3 
  ret


pause:
ldi r19, 0xEF
loop_3:
  ldi r23, 0x0
  loop_2:
    ldi r22, 0x0
    loop_1:
      mul r21, r21
      inc r22
      brne loop_1
    inc r23
    brne loop_2
  inc r19
  brne loop_3
ret
