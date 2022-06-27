	.align 16
block7632:
	movq	$0, %rcx
	movq	free_ptr(%rip), %r11
	addq	$32, free_ptr(%rip)
	movq	$7, 0(%r11)
	movq	%r11, %rdx
	movq	%rdx, %r11
	movq	%r12, 8(%r11)
	movq	$0, %rcx
	movq	%rdx, %r11
	movq	%rbx, 16(%r11)
	movq	$0, %rcx
	movq	%rdx, %r11
	movq	%r13, 24(%r11)
	movq	$0, %rcx
	movq	%rdx, %rcx
	movq	%rcx, %r11
	movq	16(%r11), %rax
	jmp conclusion

	.align 16
start:
	movq	$1, %rbx
	movq	$2, %r12
	movq	$42, %r13
	movq	free_ptr(%rip), %rsi
	movq	%rsi, %rdi
	addq	$32, %rdi
	movq	fromspace_end(%rip), %rsi
	cmpq	%rsi, %rdi
	jl block7635
	jmp block7636

	.align 16
conclusion:
	subq	$0, %r15
	addq	$8, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%rbp
	retq

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
block7636:
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
	movq	%r12, 16(%r11)
	movq	$0, %rsi
	movq	%rdi, %r11
	movq	%r13, 24(%r11)
	movq	$0, %rsi
	movq	%rdi, %rsi
	movq	$1, %r12
	movq	%rsi, %r11
	movq	24(%r11), %rbx
	movq	$3, %r13
	movq	free_ptr(%rip), %rsi
	addq	$32, %rsi
	movq	fromspace_end(%rip), %rdi
	cmpq	%rdi, %rsi
	jl block7632
	jmp block7633

	.align 16
block7635:
	movq	$0, %rsi
	movq	free_ptr(%rip), %r11
	addq	$32, free_ptr(%rip)
	movq	$7, 0(%r11)
	movq	%r11, %rdi
	movq	%rdi, %r11
	movq	%rbx, 8(%r11)
	movq	$0, %rsi
	movq	%rdi, %r11
	movq	%r12, 16(%r11)
	movq	$0, %rsi
	movq	%rdi, %r11
	movq	%r13, 24(%r11)
	movq	$0, %rsi
	movq	%rdi, %rsi
	movq	$1, %r12
	movq	%rsi, %r11
	movq	24(%r11), %rbx
	movq	$3, %r13
	movq	free_ptr(%rip), %rsi
	addq	$32, %rsi
	movq	fromspace_end(%rip), %rdi
	cmpq	%rdi, %rsi
	jl block7632
	jmp block7633

	.align 16
block7633:
	movq	%r15, %rdi
	movq	$32, %rsi
	callq	collect
	movq	free_ptr(%rip), %r11
	addq	$32, free_ptr(%rip)
	movq	$7, 0(%r11)
	movq	%r11, %rdx
	movq	%rdx, %r11
	movq	%r12, 8(%r11)
	movq	$0, %rcx
	movq	%rdx, %r11
	movq	%rbx, 16(%r11)
	movq	$0, %rcx
	movq	%rdx, %r11
	movq	%r13, 24(%r11)
	movq	$0, %rcx
	movq	%rdx, %rcx
	movq	%rcx, %r11
	movq	16(%r11), %rax
	jmp conclusion



