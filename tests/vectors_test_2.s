	.align 16
block7487:
	movq	$0, %rcx
	movq	free_ptr(%rip), %r11
	addq	$24, free_ptr(%rip)
	movq	$5, 0(%r11)
	movq	%r11, %rdx
	movq	%rdx, %r11
	movq	%r12, 8(%r11)
	movq	$0, %rcx
	movq	%rdx, %r11
	movq	%rbx, 16(%r11)
	movq	$0, %rcx
	movq	%rdx, %r11
	movq	8(%r11), %rcx
	movq	%rdx, %r11
	movq	16(%r11), %rdx
	movq	%rcx, %rax
	addq	%rdx, %rax
	jmp conclusion

	.globl main
	.align 16
main:
	pushq	%rbp
	movq	%rsp, %rbp
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
start:
	movq	$20, %r12
	movq	$22, %rbx
	movq	free_ptr(%rip), %rsi
	addq	$24, %rsi
	movq	fromspace_end(%rip), %rdi
	cmpq	%rdi, %rsi
	jl block7487
	jmp block7488

	.align 16
conclusion:
	subq	$0, %r15
	addq	$0, %rsp
	popq	%rbx
	popq	%r12
	popq	%rbp
	retq

	.align 16
block7488:
	movq	%r15, %rdi
	movq	$24, %rsi
	callq	collect
	movq	free_ptr(%rip), %r11
	addq	$24, free_ptr(%rip)
	movq	$5, 0(%r11)
	movq	%r11, %rdx
	movq	%rdx, %r11
	movq	%r12, 8(%r11)
	movq	$0, %rcx
	movq	%rdx, %r11
	movq	%rbx, 16(%r11)
	movq	$0, %rcx
	movq	%rdx, %r11
	movq	8(%r11), %rcx
	movq	%rdx, %r11
	movq	16(%r11), %rdx
	movq	%rcx, %rax
	addq	%rdx, %rax
	jmp conclusion



