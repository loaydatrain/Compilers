	.align 16
block7971:
	movq	%rsi, %rdx
	addq	%rdx, %rcx
	movq	%rsi, %rdx
	movq	$1, %rdi
	negq	%rdi
	movq	%rdx, %rsi
	addq	%rdi, %rsi
	jmp loop7969

	.align 16
block7970:
	movq	%rcx, %rax
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
	movq	$42, %rcx
	movq	$5, %rsi
	jmp loop7969

	.align 16
conclusion:
	subq	$0, %r15
	addq	$0, %rsp
	popq	%rbp
	retq

	.align 16
loop7969:
	jmp block7970



