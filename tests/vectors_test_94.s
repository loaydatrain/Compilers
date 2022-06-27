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
block7904:
	movq	%r15, %rdi
	movq	$32, %rsi
	callq	collect
	movq	free_ptr(%rip), %r11
	addq	$32, free_ptr(%rip)
	movq	$7, 0(%r11)
	movq	%r11, %r12
	movq	%r12, %r11
	movq	%r13, 8(%r11)
	movq	$0, %r10
	movq	%r12, %r11
	movq	%r14, 16(%r11)
	movq	$0, %r10
	movq	%r12, %r11
	movq	%rbx, 24(%r11)
	movq	$0, %r10
	movq	%r12, -8(%r15)
	movq	$0, %rbx
	jmp loop7898

	.align 16
block7903:
	movq	$0, %r10
	movq	free_ptr(%rip), %r11
	addq	$32, free_ptr(%rip)
	movq	$7, 0(%r11)
	movq	%r11, %r12
	movq	%r12, %r11
	movq	%r13, 8(%r11)
	movq	$0, %r10
	movq	%r12, %r11
	movq	%r14, 16(%r11)
	movq	$0, %r10
	movq	%r12, %r11
	movq	%rbx, 24(%r11)
	movq	$0, %r10
	movq	%r12, -8(%r15)
	movq	$0, %rbx
	jmp loop7898

	.align 16
loop7898:
	movq	%rbx, %r10
	cmpq	$2, %r10
	jl block7901
	jmp block7902

	.align 16
start:
	movq	$1, %r13
	movq	$2, %r14
	movq	$3, %rbx
	movq	free_ptr(%rip), %r10
	movq	%r10, %r12
	addq	$32, %r12
	movq	fromspace_end(%rip), %r10
	cmpq	%r10, %r12
	jl block7903
	jmp block7904

	.align 16
block7901:
	movq	%rbx, %r10
	movq	%r10, %rbx
	addq	$1, %rbx
	movq	%rbx, %r10
	movq	-8(%r15), %r11
	movq	%r10, 16(%r11)
	callq	read_int
	movq	-8(%r15), %r11
	movq	$-1, 24(%r11)
	movq	$1, %r13
	movq	$2, -40(%rbp)
	movq	$3, %r14
	movq	free_ptr(%rip), %r10
	movq	%r10, %r12
	addq	$32, %r12
	movq	fromspace_end(%rip), %r10
	cmpq	%r10, %r12
	jl block7899
	jmp block7900

	.align 16
block7900:
	movq	%r15, %rdi
	movq	$32, %rsi
	callq	collect
	movq	free_ptr(%rip), %r11
	addq	$32, free_ptr(%rip)
	movq	$7, 0(%r11)
	movq	%r11, %r12
	movq	%r12, %r11
	movq	%r13, 8(%r11)
	movq	$0, %r10
	movq	%r12, %r11
	movq	-40(%rbp), %rax
	movq	%rax, 16(%r11)
	movq	$0, %r10
	movq	%r12, %r11
	movq	%r14, 24(%r11)
	movq	$0, %r10
	movq	%r12, %r10
	movq	%r10, %r11
	movq	24(%r11), %r10
	movq	$10, %r12
	addq	%r10, %r12
	movq	-8(%r15), %r11
	movq	%r12, 8(%r11)
	jmp loop7898

	.align 16
block7899:
	movq	$0, %r10
	movq	free_ptr(%rip), %r11
	addq	$32, free_ptr(%rip)
	movq	$7, 0(%r11)
	movq	%r11, %r12
	movq	%r12, %r11
	movq	%r13, 8(%r11)
	movq	$0, %r10
	movq	%r12, %r11
	movq	-40(%rbp), %rax
	movq	%rax, 16(%r11)
	movq	$0, %r10
	movq	%r12, %r11
	movq	%r14, 24(%r11)
	movq	$0, %r10
	movq	%r12, %r10
	movq	%r10, %r11
	movq	24(%r11), %r10
	movq	$10, %r12
	addq	%r10, %r12
	movq	-8(%r15), %r11
	movq	%r12, 8(%r11)
	jmp loop7898

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
block7902:
	movq	-8(%r15), %r11
	movq	16(%r11), %rcx
	movq	$40, %rax
	addq	%rcx, %rax
	jmp conclusion



