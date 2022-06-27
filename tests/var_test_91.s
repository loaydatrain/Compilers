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
	movq	$1, %rcx
	addq	$1, %rcx
	movq	$1, %rsi
	addq	%rcx, %rsi
	movq	$1, %rdx
	addq	%rsi, %rdx
	movq	$1, %rcx
	addq	%rdx, %rcx
	movq	$1, %rsi
	addq	%rcx, %rsi
	movq	$1, %rdx
	addq	%rsi, %rdx
	movq	$1, %rcx
	addq	%rdx, %rcx
	movq	$1, %rsi
	addq	%rcx, %rsi
	movq	$1, %rdx
	addq	%rsi, %rdx
	movq	$1, %rcx
	addq	%rdx, %rcx
	movq	$1, %rsi
	addq	%rcx, %rsi
	movq	$1, %rdx
	addq	%rsi, %rdx
	movq	$1, %rcx
	addq	%rdx, %rcx
	movq	$1, %rsi
	addq	%rcx, %rsi
	movq	$1, %rdx
	addq	%rsi, %rdx
	movq	$1, %rcx
	addq	%rdx, %rcx
	movq	$1, %rdx
	addq	%rcx, %rdx
	movq	$1, %rsi
	addq	%rdx, %rsi
	movq	$1, %rcx
	addq	%rsi, %rcx
	movq	$1, %rdx
	addq	%rcx, %rdx
	movq	$1, %rcx
	addq	%rdx, %rcx
	movq	$1, %rdx
	addq	%rcx, %rdx
	movq	$1, %rsi
	addq	%rdx, %rsi
	movq	$1, %rcx
	addq	%rsi, %rcx
	movq	$1, %rdx
	addq	%rcx, %rdx
	movq	$1, %rsi
	addq	%rdx, %rsi
	movq	$1, %rcx
	addq	%rsi, %rcx
	movq	$1, %rdx
	addq	%rcx, %rdx
	movq	$1, %rsi
	addq	%rdx, %rsi
	movq	$1, %rcx
	addq	%rsi, %rcx
	movq	$1, %rdx
	addq	%rcx, %rdx
	movq	$1, %rcx
	addq	%rdx, %rcx
	movq	$1, %rdx
	addq	%rcx, %rdx
	movq	$1, %rcx
	addq	%rdx, %rcx
	movq	$1, %rdx
	addq	%rcx, %rdx
	movq	$1, %rcx
	addq	%rdx, %rcx
	movq	$1, %rdx
	addq	%rcx, %rdx
	movq	$1, %rcx
	addq	%rdx, %rcx
	movq	$1, %rdx
	addq	%rcx, %rdx
	movq	$1, %rcx
	addq	%rdx, %rcx
	movq	$1, %rax
	addq	%rcx, %rax
	jmp conclusion

	.align 16
conclusion:
	subq	$0, %r15
	addq	$0, %rsp
	popq	%rbp
	retq



