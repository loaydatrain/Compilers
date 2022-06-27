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
conclusion:
	subq	$0, %r15
	addq	$8, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%rbp
	retq

	.align 16
block7845:
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
	movq	$0, %rsi
	jmp loop7841

	.align 16
block7844:
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
	movq	$0, %rsi
	jmp loop7841

	.align 16
loop7841:
	movq	%rsi, %rcx
	cmpq	$42, %rcx
	jl block7842
	jmp block7843

	.align 16
block7843:
	movq	%rdx, %r11
	movq	16(%r11), %rax
	jmp conclusion

	.align 16
block7842:
	movq	%rsi, %rcx
	movq	%rcx, %rsi
	addq	$1, %rsi
	movq	%rsi, %rcx
	movq	%rdx, %r11
	movq	%rcx, 16(%r11)
	movq	%rdx, %r11
	movq	$-1, 24(%r11)
	jmp loop7841

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
	jl block7844
	jmp block7845



