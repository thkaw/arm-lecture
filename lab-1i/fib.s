	.syntax unified
	.arch armv7-a
	.text
	.align 2
	.thumb
	.thumb_func

	.global fibonacci
	.type fibonacci, function

fibonacci:
					// r0 will recieve F("n").
					// r4 as for-loop index.
					// r5 will store fibonacci result.
					// r6 as f(n-2)
					// r7 as f(n-1)
	push {r4, r5, r6, r7, lr}
	mov r6, #0			// Assign f(n-2) = 0	
	mov r7, #1			// Assign f(n-1) = 1

	cmp r0, #0			// if(n == 0), jump to .LRT0, return 0.
	beq .LRT0
	
	cmp r0, #1			// if(n == 1), jump to .LTR1, retrun 1.
	beq .LRT1

	mov r4, #2			// Assign for-loop index start at 2.

.LLoop:

	add r5, r6, r7			// fib = f(n-2) + f(n-1)
	mov r6, r7			// f(n-2) = f(n-1)
	mov r7, r5			// f(n-1) = fib

	add r4, r4, #1			// for-loop index++
	cmp r4, r0			// Check index range whether reach limmit
	ble .LLoop

	mov r0, r5			// Move result to r0 for return.
	pop {r4, r5, r6, r7, pc}	

.LRT0:
	mov r0, #0
	pop {r4, r5, r6, r7, pc}

.LRT1:
	mov r0, #1
	pop {r4, r5, r6, r7, pc}	
	
	.size fibonacci, .-fibonacci
	.end
