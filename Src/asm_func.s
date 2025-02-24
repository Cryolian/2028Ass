/*
 * asm_func.s
 *
 *  Created on: 7/2/2025
 *      Author: Hou Linxin
 */
   .syntax unified
	.cpu cortex-m4
	.fpu softvfp
	.thumb

		.global asm_func

@ Start of executable code
.section .text

@ CG/[T]EE2028 Assignment 1, Sem 2, AY 2024/25
@ (c) ECE NUS, 2025

@ Write Student 1’s Name here: A0252610U Tan Bingxue Gerard
@ Write Student 2’s Name here: A0252733H Tan Yi Xin

@ Look-up table for registers:

@ R0 Building pointer
@ R1 Entry pointer
@ R2 Exit pointer
@ R3 Result pointer
@ R4 Cars left to enter
@ R5 Loop Counter
@ R6 Store cars in section, or cars to add to section
@ R7 Store constant 12
@ R8 Store cars to exit from section
@ ...

@ write your program from here:

asm_func:

	PUSH {R4-R11,R14}

	// set register to 0
	EOR R5, R5
	EOR R4, R4

add_to_total:

	LDR R6, [R1], #4
	ADD R4, R6				// Add entries to r4
	ADD R5, #1				// Increment counter by 1
	CMP R5, #5				// Check number of loops
	BNE add_to_total		// Branch back if not 5

move_cars_in:

	EOR R5, R5

check_cars_to_add:

	LDR R8, [R2], #4		// Get exiting cars
	CMP R4, #0				// Check if any to add
	BLS else_compute_exit

	LDR R6, [R0], #4		// Load current section

	ADD R6, R4	 			// Add up entry + current section

	MOV R7, #12
	CMP R6, #12				// Check if result > 12\

	// Greater than 12
	ITTTT GT
	SUBGT R4, R6, #12		// Store excess in R4
	SUBGT R7, R8			// Get number at the end of day
	STRGT R7, [R3], #4		// Store result
	BGT check_loop

	// Not greater than 12
	MOV R4, #0				// Set cars left to enter to 0
	SUB R6, R8				// Get number at the end of day
	STR R6, [R3], #4		// Store result
	B check_loop

else_compute_exit:

	LDR R7, [R0], #4		// Get current cars in section
	SUB R7, R8				// Get final amount
	STR R7, [R3], #4		// Store to result

check_loop:

	ADD R5, #1
	CMP R5, #6
	BNE check_cars_to_add

	POP	{R4-R11,R14}

	BX LR

lr_demo:

 	PUSH {R14}

	BL SUBROUTINE

 	POP {R14}

	BX LR

SUBROUTINE:

	BX LR
