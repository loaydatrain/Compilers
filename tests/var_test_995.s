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
	movq	$42, %rdx
	addq	$7, %rcx
	movq	%rcx, %rsi
	addq	%rdx, %rcx
	movq	%rsi, %rdx
	negq	%rdx
	movq	%rcx, %rax
	addq	%rdx, %rax
	jmp conclusion

	.align 16
conclusion:
	subq	$0, %r15
	addq	$0, %rsp
	popq	%rbp
	retq



