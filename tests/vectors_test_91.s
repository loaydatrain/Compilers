	.align 16
block7812:
	movq	%r15, %rdi
	movq	$32, %rsi
	callq	collect
	movq	free_ptr(%rip), %r11
	addq	$32, free_ptr(%rip)
	movq	$7, 0(%r11)
	movq	%r11, %rdi
	movq	%rdi, %r11
	movq	%r12, 8(%r11)
	movq	$0, %rsi
	movq	%rdi, %r11
	movq	%rbx, 16(%r11)
	movq	$0, %rsi
	movq	%rdi, %r11
	movq	%r13, 24(%r11)
	movq	$0, %rsi
	movq	%rdi, -8(%r15)
	movq	$0, %r14
	jmp loop7806

	.align 16
block7811:
	movq	$0, %rsi
	movq	free_ptr(%rip), %r11
	addq	$32, free_ptr(%rip)
	movq	$7, 0(%r11)
	movq	%r11, %rdi
	movq	%rdi, %r11
	movq	%r12, 8(%r11)
	movq	$0, %rsi
	movq	%rdi, %r11
	movq	%rbx, 16(%r11)
	movq	$0, %rsi
	movq	%rdi, %r11
	movq	%r13, 24(%r11)
	movq	$0, %rsi
	movq	%rdi, -8(%r15)
	movq	$0, %r14
	jmp loop7806

	.align 16
loop7806:
	movq	%r14, %rsi
	cmpq	$42, %rsi
	jl block7809
	jmp block7810

	.align 16
block7810:
	movq	-8(%r15), %r11
	movq	16(%r11), %rax
	jmp conclusion

	.align 16
block7809:
	movq	%r14, %rsi
	movq	%rsi, %r14
	addq	$1, %r14
	movq	%r14, %rsi
	movq	-8(%r15), %r11
	movq	%rsi, 16(%r11)
	movq	-8(%r15), %r11
	movq	$-1, 24(%r11)
	movq	$1, %rbx
	movq	$2, %r13
	movq	$3, %r12
	movq	free_ptr(%rip), %rsi
	movq	%rsi, %rdi
	addq	$32, %rdi
	movq	fromspace_end(%rip), %rsi
	cmpq	%rsi, %rdi
	jl block7807
	jmp block7808

	.align 16
block7808:
	movq	%r15, %rdi
	movq	$32, %rsi
	callq	collect
	movq	free_ptr(%rip), %r11
	addq	$32, free_ptr(%rip)
	movq	$7, 0(%r11)
	movq	%r11, %rdi
	movq	%rdi, %r11
	movq	%rbx, 8(%r11)
	movq	$0, %rsi
	movq	%rdi, %r11
	movq	%r13, 16(%r11)
	movq	$0, %rsi
	movq	%rdi, %r11
	movq	%r12, 24(%r11)
	movq	$0, %rsi
	movq	%rdi, %rsi
	movq	%rsi, %r11
	movq	24(%r11), %rsi
	movq	$10, %rdi
	addq	%rsi, %rdi
	movq	-8(%r15), %r11
	movq	%rdi, 8(%r11)
	jmp loop7806

	.align 16
block7807:
	movq	$0, %rsi
	movq	free_ptr(%rip), %r11
	addq	$32, free_ptr(%rip)
	movq	$7, 0(%r11)
	movq	%r11, %rdi
	movq	%rdi, %r11
	movq	%rbx, 8(%r11)
	movq	$0, %rsi
	movq	%rdi, %r11
	movq	%r13, 16(%r11)
	movq	$0, %rsi
	movq	%rdi, %r11
	movq	%r12, 24(%r11)
	movq	$0, %rsi
	movq	%rdi, %rsi
	movq	%rsi, %r11
	movq	24(%r11), %rsi
	movq	$10, %rdi
	addq	%rsi, %rdi
	movq	-8(%r15), %r11
	movq	%rdi, 8(%r11)
	jmp loop7806

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
	movq	$0, 0(%r15)
	addq	$8, %r15
	jmp start

	.align 16
conclusion:
	subq	$8, %r15
	addq	$0, %rsp
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r13
	popq	%rbp
	retq

	.align 16
start:
	movq	$1, %r12
	movq	$2, %rbx
	movq	$3, %r13
	movq	free_ptr(%rip), %rsi
	movq	%rsi, %rdi
	addq	$32, %rdi
	movq	fromspace_end(%rip), %rsi
	cmpq	%rsi, %rdi
	jl block7811
	jmp block7812



