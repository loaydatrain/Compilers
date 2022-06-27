	.align 16
block7986:
	movq	$40, %rcx
	movq	%rcx, %rax
	addq	$2, %rax
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
	callq	read_int
	movq	%rax, %rcx
	cmpq	$0, %rcx
	je block7986
	jmp block7987

	.align 16
conclusion:
	subq	$0, %r15
	addq	$0, %rsp
	popq	%rbp
	retq

	.align 16
block7987:
	movq	$777, %rcx
	movq	%rcx, %rax
	addq	$2, %rax
	jmp conclusion



