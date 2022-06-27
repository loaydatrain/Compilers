	.globl main
	.align 16
main:
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r13
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	subq	$96, %rsp
	movq	$16384, %rdi
	movq	$16384, %rsi
	callq	initialize
	movq	rootstack_begin(%rip), %r15
	addq	$0, %r15
	jmp start

	.align 16
start:
	movq	$1, -48(%rbp)
	movq	$1, -88(%rbp)
	movq	$1, %r9
	movq	$1, %rdi
	movq	$1, -40(%rbp)
	movq	$1, -80(%rbp)
	movq	$1, %rsi
	movq	$1, %rdx
	movq	$1, -72(%rbp)
	movq	$1, %r14
	movq	$1, -120(%rbp)
	movq	$1, %r13
	movq	$1, -64(%rbp)
	movq	$1, %r12
	movq	$1, -112(%rbp)
	movq	$1, %r10
	movq	$1, -56(%rbp)
	movq	$1, %rbx
	movq	$1, -104(%rbp)
	movq	$1, %rcx
	movq	$1, %r8
	addq	$100, %r8
	movq	%rcx, -96(%rbp)
	addq	%r8, -96(%rbp)
	movq	-104(%rbp), %rcx
	addq	-96(%rbp), %rcx
	movq	%rbx, %r8
	addq	%rcx, %r8
	movq	-56(%rbp), %rbx
	addq	%r8, %rbx
	movq	%r10, %rcx
	addq	%rbx, %rcx
	movq	-112(%rbp), %r8
	addq	%rcx, %r8
	movq	%r12, %rcx
	addq	%r8, %rcx
	movq	-64(%rbp), %r8
	addq	%rcx, %r8
	movq	%r13, %rcx
	addq	%r8, %rcx
	movq	-120(%rbp), %r8
	addq	%rcx, %r8
	movq	%r14, %rcx
	addq	%r8, %rcx
	movq	-72(%rbp), %r8
	addq	%rcx, %r8
	movq	%rdx, %rcx
	addq	%r8, %rcx
	movq	%rsi, %rdx
	addq	%rcx, %rdx
	movq	-80(%rbp), %rcx
	addq	%rdx, %rcx
	movq	-40(%rbp), %rsi
	addq	%rcx, %rsi
	movq	%rdi, %rdx
	addq	%rsi, %rdx
	movq	%r9, %rcx
	addq	%rdx, %rcx
	movq	-88(%rbp), %rdx
	addq	%rcx, %rdx
	movq	-48(%rbp), %rax
	addq	%rdx, %rax
	jmp conclusion

	.align 16
conclusion:
	subq	$0, %r15
	addq	$96, %rsp
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r13
	popq	%rbp
	retq



