	.globl main
	.align 16
main:
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r13
	pushq	%r12
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
	movq	$10, %r12
	movq	$0, %rbx
	callq	read_int
	movq	%rax, %rbx
	movq	%r12, %r13
	callq	read_int
	movq	%rax, %r12
	movq	%rbx, %rdx
	movq	%r13, %rcx
	addq	%rdx, %rcx
	movq	%r12, %rdx
	movq	%rcx, %rax
	addq	%rdx, %rax
	jmp conclusion

	.align 16
conclusion:
	subq	$0, %r15
	addq	$8, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%rbp
	retq



