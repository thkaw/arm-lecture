	.syntax unified
	.arch armv7-a
	.text
	.align 2
	.thumb
	.thumb_func
	.global fibonacci
	.type fibonacci, function
//	.type .Ltest2, function

//.Ltest2:
//	nop	
//.L3:
//	nop

fibonacci:
				        // r0~r3 as parameters register.
					// r0 will store F("n")

        push {r4, r5, lr}    		// Push some register that may using in this subroutine.
        subs r4, r0, #0        		// r4 = r0 - 0 for zero or minus value check.
        ble .L3        			// If (r0 <= 0) goto .L3(Cause F(0)=0)

        cmp r4, #1        		// Compare r4 to 1
        beq .L4       			// If (r4 == 1) goto .L4(Cause F(1)=1)

        //add r0, r4, #4294967295  	// r0 = r4 + 4294967295 (or #0xFFFFFFFF), F(n-1), but using complement method.
	sub r0, r4, #1			// F(n-1), save n-1 to r0 for recursive.
        bl fibonacci          		// Goto fibonacci @PC relative address

        mov r5, r0        		// Save current n to r5, prepare to calling recursive.
        sub r0, r4, #2   		// r0 = r4 - 2, n-2
        bl fibonacci       		// Goto fibonacci @PC relative address

        adds r0, r5, r0 		// Here third r0 is return by F(n-1), r5 is return by F(n-2), first r0 is sum of two result.
        pop {r4, r5, pc} 		// Recover original content in stack, and return subroutine.

.L3:
	mov r0, #0			@ R0 = 0
	pop {r4, r5, pc}		@ EPILOG

.L4:
	mov r0, #1			@ R0 = 1
	pop {r4, r5, pc}		@ EPILOG

	.size fibonacci, .-fibonacci
	.end
