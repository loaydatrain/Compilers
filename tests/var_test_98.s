	.globl main
	.align 16
main:
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r13
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	subq	$48, %rsp
	movq	$16384, %rdi
	movq	$16384, %rsi
	callq	initialize
	movq	rootstack_begin(%rip), %r15
	addq	$0, %r15
	jmp start

	.align 16
start:
	callq	read_int
	movq	%rax, %rbx
	callq	read_int
	movq	%rax, -48(%rbp)
	callq	read_int
	movq	%rax, %r14
	callq	read_int
	movq	%rax, -80(%rbp)
	callq	read_int
	movq	%rax, %r13
	callq	read_int
	movq	%rax, -72(%rbp)
	callq	read_int
	movq	%rax, -40(%rbp)
	callq	read_int
	movq	%rax, -64(%rbp)
	callq	read_int
	movq	%rax, %r12
	callq	read_int
	movq	%rax, -56(%rbp)
	callq	read_int
	movq	%rax, %rcx
	movq	%rcx, %rdx
	addq	$100, %rdx
	movq	-56(%rbp), %rcx
	addq	%rdx, %rcx
	movq	%r12, %rsi
	addq	%rcx, %rsi
	movq	-64(%rbp), %rdx
	addq	%rsi, %rdx
	movq	-40(%rbp), %rcx
	addq	%rdx, %rcx
	movq	-72(%rbp), %rdx
	addq	%rcx, %rdx
	movq	%r13, %rcx
	addq	%rdx, %rcx
	movq	-80(%rbp), %rdx
	addq	%rcx, %rdx
	movq	%r14, %rcx
	addq	%rdx, %rcx
	movq	-48(%rbp), %rdx
	addq	%rcx, %rdx
	movq	%rbx, %rax
	addq	%rdx, %rax
	jmp conclusion

	.align 16
conclusion:
	subq	$0, %r15
	addq	$48, %rsp
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r13
	popq	%rbp
	retq



