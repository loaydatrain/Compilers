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
block7537:
	movq	%r15, %rdi
	movq	$32, %rsi
	callq	collect
	movq	free_ptr(%rip), %r11
	addq	$32, free_ptr(%rip)
	movq	$7, 0(%r11)
	movq	%r11, %rdx
	movq	%rdx, %r11
	movq	%rbx, 8(%r11)
	movq	$0, %rcx
	movq	%rdx, %r11
	movq	%r13, 16(%r11)
	movq	$0, %rcx
	movq	%rdx, %r11
	movq	%r12, 24(%r11)
	movq	$0, %rcx
	movq	%rdx, %rcx
	movq	%rcx, %r11
	movq	16(%r11), %rcx
	cmpq	$1, %rcx
	je block7534
	jmp block7535

	.align 16
block7536:
	movq	$0, %rcx
	movq	free_ptr(%rip), %r11
	addq	$32, free_ptr(%rip)
	movq	$7, 0(%r11)
	movq	%r11, %rdx
	movq	%rdx, %r11
	movq	%rbx, 8(%r11)
	movq	$0, %rcx
	movq	%rdx, %r11
	movq	%r13, 16(%r11)
	movq	$0, %rcx
	movq	%rdx, %r11
	movq	%r12, 24(%r11)
	movq	$0, %rcx
	movq	%rdx, %rcx
	movq	%rcx, %r11
	movq	16(%r11), %rcx
	cmpq	$1, %rcx
	je block7534
	jmp block7535

	.align 16
block7535:
	movq	$5, %rax
	jmp conclusion

	.align 16
block7534:
	movq	$42, %rax
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

	.align 16
start:
	movq	$1, %rbx
	movq	$1, %r13
	movq	$42, %r12
	movq	free_ptr(%rip), %rsi
	movq	%rsi, %rdi
	addq	$32, %rdi
	movq	fromspace_end(%rip), %rsi
	cmpq	%rsi, %rdi
	jl block7536
	jmp block7537



