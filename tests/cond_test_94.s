	.align 16
block8025:
	movq	$6, %rdx
	negq	%rdx
	movq	$9, %rcx
	addq	%rdx, %rcx
	movq	%rcx, %rdx
	addq	%rcx, %rdx
	movq	%rdx, %rax
	addq	$10, %rax
	jmp conclusion

	.align 16
block8024:
	movq	$4, %rcx
	addq	$2, %rcx
	movq	%rcx, %rdx
	addq	%rcx, %rdx
	movq	%rdx, %rax
	addq	$10, %rax
	jmp conclusion

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
start:
	jmp block8025

	.align 16
conclusion:
	subq	$0, %r15
	addq	$0, %rsp
	popq	%rbp
	retq



