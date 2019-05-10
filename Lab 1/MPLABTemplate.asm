; Lab 1
; Raj Joshi & Arihant Gupta
; 4/30/2019

#include <p16f887.inc>

SWITCH_BIT EQU 1
LED_BIT EQU 0

	ORG 0x0000
	GOTO setup
	ORG 0x0004
	GOTO isr

setup:
	BANKSEL ANSELH
    CLRF ANSELH ; digital I/O
	BANKSEL TRISB
	BSF TRISB, SWITCH_BIT ;bit 0 in input

	BANKSEL ANSEL
	CLRF ANSEL
	BANKSEL PORTC
	CLRF PORTC
	BANKSEL TRISC
	BCF TRISC, LED_BIT ;bit 1 in output
	
main:
    BANKSEL PORTB
	BTFSC PORTB, SWITCH_BIT 
    GOTO turnOn
    GOTO turnOff

turnOn:
	BANKSEL PORTC
	BSF PORTC, LED_BIT
	GOTO main

turnOff:
	BANKSEL PORTC
	BCF PORTC, LED_BIT
	GOTO main

isr:
	NOP
	RETFIE
	
	END