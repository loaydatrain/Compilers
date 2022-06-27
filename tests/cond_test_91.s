	.globl main
	.align 16
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$0, %rsp
	movq	$16384, %rdi
	movq	$16384, %rsi
	callq	initialize
	movq	rootstack_begin(%rip), %r15
	addq	$0, %r15
	jmp start

	.align 16
block8009:
	movq	$1, %rax
	addq	$2, %rax
	jmp conclusion

	.align 16
block8008:
	movq	$5, %rcx
	negq	%rcx
	movq	$10, %rax
	addq	%rcx, %rax
	jmp conclusion

	.align 16
conclusion:
	subq	$0, %r15
	addq	$0, %rsp
	popq	%rbp
	retq

	.align 16
start:
	jmp block8009



