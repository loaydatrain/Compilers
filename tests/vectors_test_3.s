	.align 16
block7512:
	movq	%r15, %rdi
	movq	$16, %rsi
	callq	collect
	movq	free_ptr(%rip), %r11
	addq	$16, free_ptr(%rip)
	movq	$131, 0(%r11)
	movq	%r11, %rdx
	movq	%rdx, %r11
	movq	-8(%r15), %rax
	movq	%rax, 8(%r11)
	movq	$0, %rcx
	movq	%rdx, %rcx
	movq	%rcx, %r11
	movq	8(%r11), %rcx
	movq	%rcx, %r11
	movq	8(%r11), %rax
	jmp conclusion

	.align 16
block7511:
	movq	$0, %rcx
	movq	free_ptr(%rip), %r11
	addq	$16, free_ptr(%rip)
	movq	$131, 0(%r11)
	movq	%r11, %rdx
	movq	%rdx, %r11
	movq	-8(%r15), %rax
	movq	%rax, 8(%r11)
	movq	$0, %rcx
	movq	%rdx, %rcx
	movq	%rcx, %r11
	movq	8(%r11), %rcx
	movq	%rcx, %r11
	movq	8(%r11), %rax
	jmp conclusion

	.align 16
start:
	movq	$42, %rbx
	movq	free_ptr(%rip), %rsi
	movq	%rsi, %rdi
	addq	$16, %rdi
	movq	fromspace_end(%rip), %rsi
	cmpq	%rsi, %rdi
	jl block7513
	jmp block7514

	.align 16
conclusion:
	subq	$8, %r15
	addq	$8, %rsp
	popq	%rbx
	popq	%rbp
	retq

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
	movq	$0, 0(%r15)
	addq	$8, %r15
	jmp start

	.align 16
block7514:
	movq	%r15, %rdi
	movq	$16, %rsi
	callq	collect
	movq	free_ptr(%rip), %r11
	addq	$16, free_ptr(%rip)
	movq	$3, 0(%r11)
	movq	%r11, %rdi
	movq	%rdi, %r11
	movq	%rbx, 8(%r11)
	movq	$0, %rsi
	movq	%rdi, -8(%r15)
	movq	free_ptr(%rip), %rsi
	addq	$16, %rsi
	movq	fromspace_end(%rip), %rdi
	cmpq	%rdi, %rsi
	jl block7511
	jmp block7512

	.align 16
block7513:
	movq	$0, %rsi
	movq	free_ptr(%rip), %r11
	addq	$16, free_ptr(%rip)
	movq	$3, 0(%r11)
	movq	%r11, %rdi
	movq	%rdi, %r11
	movq	%rbx, 8(%r11)
	movq	$0, %rsi
	movq	%rdi, -8(%r15)
	movq	free_ptr(%rip), %rsi
	addq	$16, %rsi
	movq	fromspace_end(%rip), %rdi
	cmpq	%rdi, %rsi
	jl block7511
	jmp block7512



