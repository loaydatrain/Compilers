	.globl main
	.align 16
main:
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r13
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	subq	$32, %rsp
	movq	$16384, %rdi
	movq	$16384, %rsi
	callq	initialize
	movq	rootstack_begin(%rip), %r15
	addq	$0, %r15
	jmp start

	.align 16
start:
	movq	$0, %r13
	movq	$1, %rbx
	movq	$2, -56(%rbp)
	movq	$3, -40(%rbp)
	jmp loop7951

	.align 16
conclusion:
	subq	$0, %r15
	addq	$32, %rsp
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r13
	popq	%rbp
	retq

	.align 16
loop7951:
	movq	%r13, %rsi
	cmpq	$42, %rsi
	jl block7954
	jmp block7955

	.align 16
block7955:
	movq	%r13, %r12
	movq	free_ptr(%rip), %rsi
	movq	%rsi, %rdi
	addq	$40, %rdi
	movq	fromspace_end(%rip), %rsi
	cmpq	%rsi, %rdi
	jl block7949
	jmp block7950

	.align 16
block7954:
	movq	%r13, %rsi
	movq	%rsi, %r13
	addq	$1, %r13
	movq	$1, %r14
	movq	$2, %r12
	movq	$3, -48(%rbp)
	movq	free_ptr(%rip), %rsi
	movq	%rsi, %rdi
	addq	$32, %rdi
	movq	fromspace_end(%rip), %rsi
	cmpq	%rsi, %rdi
	jl block7952
	jmp block7953

	.align 16
block7953:
	movq	%r15, %rdi
	movq	$32, %rsi
	callq	collect
	movq	free_ptr(%rip), %r11
	addq	$32, free_ptr(%rip)
	movq	$7, 0(%r11)
	movq	%r11, %rdi
	movq	%rdi, %r11
	movq	%r14, 8(%r11)
	movq	$0, %rsi
	movq	%rdi, %r11
	movq	%r12, 16(%r11)
	movq	$0, %rsi
	movq	%rdi, %r11
	movq	-48(%rbp), %rax
	movq	%rax, 24(%r11)
	movq	$0, %rsi
	movq	%rdi, %rsi
	jmp loop7951

	.align 16
block7952:
	movq	$0, %rsi
	movq	free_ptr(%rip), %r11
	addq	$32, free_ptr(%rip)
	movq	$7, 0(%r11)
	movq	%r11, %rdi
	movq	%rdi, %r11
	movq	%r14, 8(%r11)
	movq	$0, %rsi
	movq	%rdi, %r11
	movq	%r12, 16(%r11)
	movq	$0, %rsi
	movq	%rdi, %r11
	movq	-48(%rbp), %rax
	movq	%rax, 24(%r11)
	movq	$0, %rsi
	movq	%rdi, %rsi
	jmp loop7951

	.align 16
block7950:
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
	movq	-56(%rbp), %rax
	movq	%rax, 16(%r11)
	movq	$0, %rcx
	movq	%rdx, %r11
	movq	-40(%rbp), %rax
	movq	%rax, 24(%r11)
	movq	$0, %rcx
	movq	%rdx, %r11
	movq	%r12, 32(%r11)
	movq	$0, %rcx
	movq	%rdx, %rcx
	movq	%rcx, %r11
	movq	32(%r11), %rax
	jmp conclusion

	.align 16
block7949:
	movq	$0, %rcx
	movq	free_ptr(%rip), %r11
	addq	$40, free_ptr(%rip)
	movq	$9, 0(%r11)
	movq	%r11, %rdx
	movq	%rdx, %r11
	movq	%rbx, 8(%r11)
	movq	$0, %rcx
	movq	%rdx, %r11
	movq	-56(%rbp), %rax
	movq	%rax, 16(%r11)
	movq	$0, %rcx
	movq	%rdx, %r11
	movq	-40(%rbp), %rax
	movq	%rax, 24(%r11)
	movq	$0, %rcx
	movq	%rdx, %r11
	movq	%r12, 32(%r11)
	movq	$0, %rcx
	movq	%rdx, %rcx
	movq	%rcx, %r11
	movq	32(%r11), %rax
	jmp conclusion



