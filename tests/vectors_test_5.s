	.globl main
	.align 16
main:
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r13
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	subq	$16, %rsp
	movq	$16384, %rdi
	movq	$16384, %rsi
	callq	initialize
	movq	rootstack_begin(%rip), %r15
	movq	$0, 0(%r15)
	addq	$8, %r15
	jmp start

	.align 16
conclusion:
	subq	$8, %r15
	addq	$16, %rsp
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r13
	popq	%rbp
	retq

	.align 16
block7594:
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
	movq	%rbx, 16(%r11)
	movq	$0, %rsi
	movq	%rdi, %r11
	movq	%r12, 24(%r11)
	movq	$0, %rsi
	movq	%rdi, -8(%r15)
	movq	$1, %r14
	movq	$2, %rbx
	movq	$3, %r12
	movq	free_ptr(%rip), %rsi
	addq	$32, %rsi
	movq	fromspace_end(%rip), %rdi
	cmpq	%rdi, %rsi
	jl block7591
	jmp block7592

	.align 16
block7593:
	movq	$0, %rsi
	movq	free_ptr(%rip), %r11
	addq	$32, free_ptr(%rip)
	movq	$7, 0(%r11)
	movq	%r11, %rdi
	movq	%rdi, %r11
	movq	%r14, 8(%r11)
	movq	$0, %rsi
	movq	%rdi, %r11
	movq	%rbx, 16(%r11)
	movq	$0, %rsi
	movq	%rdi, %r11
	movq	%r12, 24(%r11)
	movq	$0, %rsi
	movq	%rdi, -8(%r15)
	movq	$1, %r14
	movq	$2, %rbx
	movq	$3, %r12
	movq	free_ptr(%rip), %rsi
	addq	$32, %rsi
	movq	fromspace_end(%rip), %rdi
	cmpq	%rdi, %rsi
	jl block7591
	jmp block7592

	.align 16
start:
	movq	$1, -40(%rbp)
	movq	$1, %r13
	movq	$4, %r14
	movq	$5, %rbx
	movq	$6, %r12
	movq	free_ptr(%rip), %rsi
	addq	$32, %rsi
	movq	fromspace_end(%rip), %rdi
	cmpq	%rdi, %rsi
	jl block7593
	jmp block7594

	.align 16
block7591:
	movq	$0, %rsi
	movq	free_ptr(%rip), %r11
	addq	$32, free_ptr(%rip)
	movq	$7, 0(%r11)
	movq	%r11, %rdi
	movq	%rdi, %r11
	movq	%r14, 8(%r11)
	movq	$0, %rsi
	movq	%rdi, %r11
	movq	%rbx, 16(%r11)
	movq	$0, %rsi
	movq	%rdi, %r11
	movq	%r12, 24(%r11)
	movq	$0, %rsi
	movq	%rdi, %rsi
	movq	%rsi, %r11
	movq	0(%r11), %r11
	sarq	$1, %r11
	andq	$63, %r11
	movq	%r11, %rbx
	movq	free_ptr(%rip), %rsi
	addq	$40, %rsi
	movq	fromspace_end(%rip), %rdi
	cmpq	%rdi, %rsi
	jl block7589
	jmp block7590

	.align 16
block7590:
	movq	%r15, %rdi
	movq	$40, %rsi
	callq	collect
	movq	free_ptr(%rip), %r11
	addq	$40, free_ptr(%rip)
	movq	$521, 0(%r11)
	movq	%r11, %rdx
	movq	%rdx, %r11
	movq	-40(%rbp), %rax
	movq	%rax, 8(%r11)
	movq	$0, %rcx
	movq	%rdx, %r11
	movq	%r13, 16(%r11)
	movq	$0, %rcx
	movq	%rdx, %r11
	movq	-8(%r15), %rax
	movq	%rax, 24(%r11)
	movq	$0, %rcx
	movq	%rdx, %r11
	movq	%rbx, 32(%r11)
	movq	$0, %rcx
	movq	%rdx, %rcx
	movq	%rcx, %r11
	movq	0(%r11), %r11
	sarq	$1, %r11
	andq	$63, %r11
	movq	%r11, %rax
	jmp conclusion

	.align 16
block7589:
	movq	$0, %rcx
	movq	free_ptr(%rip), %r11
	addq	$40, free_ptr(%rip)
	movq	$521, 0(%r11)
	movq	%r11, %rdx
	movq	%rdx, %r11
	movq	-40(%rbp), %rax
	movq	%rax, 8(%r11)
	movq	$0, %rcx
	movq	%rdx, %r11
	movq	%r13, 16(%r11)
	movq	$0, %rcx
	movq	%rdx, %r11
	movq	-8(%r15), %rax
	movq	%rax, 24(%r11)
	movq	$0, %rcx
	movq	%rdx, %r11
	movq	%rbx, 32(%r11)
	movq	$0, %rcx
	movq	%rdx, %rcx
	movq	%rcx, %r11
	movq	0(%r11), %r11
	sarq	$1, %r11
	andq	$63, %r11
	movq	%r11, %rax
	jmp conclusion

	.align 16
block7592:
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
	movq	%rbx, 16(%r11)
	movq	$0, %rsi
	movq	%rdi, %r11
	movq	%r12, 24(%r11)
	movq	$0, %rsi
	movq	%rdi, %rsi
	movq	%rsi, %r11
	movq	0(%r11), %r11
	sarq	$1, %r11
	andq	$63, %r11
	movq	%r11, %rbx
	movq	free_ptr(%rip), %rsi
	addq	$40, %rsi
	movq	fromspace_end(%rip), %rdi
	cmpq	%rdi, %rsi
	jl block7589
	jmp block7590



