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
conclusion:
	subq	$0, %r15
	addq	$0, %rsp
	popq	%rbp
	retq

	.align 16
start:
	callq	read_int
	movq	%rax, %rdx
	movq	%rdx, %rax
	addq	$2, %rax
	jmp conclusion

	.align 16
block8060:
	callq	read_int
	movq	%rax, %rcx
	movq	$1, %rdx
	addq	%rcx, %rdx
	movq	%rdx, %rax
	addq	$2, %rax
	jmp conclusion

	.align 16
block8059:
	movq	$777, %rdx
	movq	%rdx, %rax
	addq	$2, %rax
	jmp conclusion



