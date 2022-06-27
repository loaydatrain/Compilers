	.globl main
	.align 16
main:
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r13
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	subq	$0, %rsp
	movq	$16384, %rdi
	movq	$16384, %rsi
	callq	initialize
	movq	rootstack_begin(%rip), %r15
	addq	$0, %r15
	jmp start

	.align 16
block7672:
	movq	%r15, %rdi
	movq	$40, %rsi
	callq	collect
	movq	free_ptr(%rip), %r11
	addq	$40, free_ptr(%rip)
	movq	$9, 0(%r11)
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
	movq	%rdx, %r11
	movq	%r14, 32(%r11)
	movq	$0, %rcx
	movq	%rdx, %rcx
	movq	%rcx, %r11
	movq	8(%r11), %rax
	jmp conclusion

	.align 16
block7671:
	movq	$0, %rcx
	movq	free_ptr(%rip), %r11
	addq	$40, free_ptr(%rip)
	movq	$9, 0(%r11)
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
	movq	%rdx, %r11
	movq	%r14, 32(%r11)
	movq	$0, %rcx
	movq	%rdx, %rcx
	movq	%rcx, %r11
	movq	8(%r11), %rax
	jmp conclusion

	.align 16
start:
	movq	$42, %rbx
	callq	read_int
	movq	%rax, %r13
	movq	$1, %rsi
	movq	%rsi, %r12
	movq	$5, %r14
	movq	free_ptr(%rip), %rsi
	addq	$40, %rsi
	movq	fromspace_end(%rip), %rdi
	cmpq	%rdi, %rsi
	jl block7671
	jmp block7672

	.align 16
conclusion:
	subq	$0, %r15
	addq	$0, %rsp
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r13
	popq	%rbp
	retq



