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
start:
	callq	read_int
	movq	%rax, %rbx
	callq	read_int
	movq	%rax, %rcx
	movq	%rbx, %rdx
	addq	%rcx, %rdx
	movq	%rdx, %rax
	jmp conclusion

	.align 16
conclusion:
	subq	$0, %r15
	addq	$8, %rsp
	popq	%rbx
	popq	%rbp
	retq



