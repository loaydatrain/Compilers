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
	movq	%rax, %r10
	movq	%r10, %rbx
	addq	$3, %rbx
	callq	read_int
	movq	%rax, %rcx
	movq	$1, %rdx
	addq	%rcx, %rdx
	movq	%rbx, %rax
	addq	%rdx, %rax
	jmp conclusion

	.align 16
conclusion:
	subq	$0, %r15
	addq	$8, %rsp
	popq	%rbx
	popq	%rbp
	retq



