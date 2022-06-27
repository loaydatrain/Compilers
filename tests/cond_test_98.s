	.globl main
	.align 16
main:
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%rbx
	subq	$8, %rsp
	movq	$16384, %rdi
	movq	$16384, %rsi
	callq	initialize
	movq	rootstack_begin(%rip), %r15
	addq	$0, %r15
	jmp start

	.align 16
block8050:
	cmpq	$2, %rbx
	je block8048
	jmp block8047

	.align 16
block8049:
	cmpq	$0, %rbx
	je block8048
	jmp block8047

	.align 16
block8048:
	movq	%rcx, %rax
	addq	$2, %rax
	jmp conclusion

	.align 16
block8047:
	movq	%rcx, %rax
	addq	$10, %rax
	jmp conclusion

	.align 16
conclusion:
	subq	$0, %r15
	addq	$8, %rsp
	popq	%rbx
	popq	%rbp
	retq

	.align 16
start:
	callq	read_int
	movq	%rax, %rbx
	callq	read_int
	movq	%rax, %rcx
	cmpq	$1, %rbx
	jl block8049
	jmp block8050



