	.globl main
	.align 16
main:
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r13
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	subq	$112, %rsp
	movq	$16384, %rdi
	movq	$16384, %rsi
	callq	initialize
	movq	rootstack_begin(%rip), %r15
	addq	$0, %r15
	jmp start

	.align 16
start:
	movq	$1, %rdx
	movq	$1, %r10
	movq	$1, -128(%rbp)
	movq	$1, -48(%rbp)
	movq	$1, -88(%rbp)
	movq	$1, %rsi
	movq	$1, -104(%rbp)
	movq	$1, %rbx
	movq	$1, -64(%rbp)
	movq	$1, %r8
	movq	$1, -112(%rbp)
	movq	$1, %r12
	movq	$1, -72(%rbp)
	movq	$1, %r9
	movq	$1, -120(%rbp)
	movq	$1, %r13
	movq	$1, %r14
	movq	$1, -136(%rbp)
	movq	$1, %rdi
	movq	$1, -80(%rbp)
	movq	$1, -40(%rbp)
	movq	$1, -96(%rbp)
	movq	$100, %rcx
	movq	%rcx, -56(%rbp)
	addq	%rcx, -56(%rbp)
	movq	$2, %rcx
	addq	-56(%rbp), %rcx
	movq	%rcx, -56(%rbp)
	movq	-40(%rbp), %rcx
	addq	-56(%rbp), %rcx
	addq	%rcx, -40(%rbp)
	movq	%rdi, %rcx
	addq	-40(%rbp), %rcx
	addq	%rcx, -40(%rbp)
	movq	%r14, %rdi
	addq	-40(%rbp), %rdi
	movq	%r13, %rcx
	addq	%rdi, %rcx
	movq	-120(%rbp), %rdi
	addq	%rcx, %rdi
	movq	%r9, %rcx
	addq	%rdi, %rcx
	movq	-72(%rbp), %rdi
	addq	%rcx, %rdi
	movq	%r12, %rcx
	addq	%rdi, %rcx
	movq	-112(%rbp), %rdi
	addq	%rcx, %rdi
	movq	%r8, %rcx
	addq	%rdi, %rcx
	movq	-64(%rbp), %rdi
	addq	%rcx, %rdi
	movq	%rbx, %rcx
	addq	%rdi, %rcx
	movq	-104(%rbp), %rdi
	addq	%rcx, %rdi
	movq	%rsi, %rcx
	addq	%rdi, %rcx
	movq	-88(%rbp), %rsi
	addq	%rcx, %rsi
	movq	-48(%rbp), %rcx
	addq	%rsi, %rcx
	movq	-128(%rbp), %rsi
	addq	%rcx, %rsi
	movq	%r10, %rcx
	addq	%rsi, %rcx
	movq	%rdx, %rax
	addq	%rcx, %rax
	jmp conclusion

	.align 16
conclusion:
	subq	$0, %r15
	addq	$112, %rsp
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r13
	popq	%rbp
	retq



