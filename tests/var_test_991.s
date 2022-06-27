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
	movq	$1, -80(%rbp)
	movq	$1, %r9
	movq	$1, -104(%rbp)
	movq	$1, %rdx
	movq	$1, %r8
	movq	$1, %rbx
	movq	$1, -40(%rbp)
	movq	$1, %rdi
	movq	$1, -88(%rbp)
	movq	$1, -56(%rbp)
	movq	$1, -120(%rbp)
	movq	$1, %rcx
	movq	$1, %r10
	movq	$1, -48(%rbp)
	movq	$1, -112(%rbp)
	movq	$1, -64(%rbp)
	movq	$1, %r14
	movq	$1, -72(%rbp)
	movq	$1, %r12
	movq	$1, %rsi
	movq	$1, %r13
	movq	%rsi, -96(%rbp)
	addq	%r13, -96(%rbp)
	movq	%r12, %rsi
	addq	-96(%rbp), %rsi
	movq	-72(%rbp), %r13
	addq	%rsi, %r13
	movq	%r14, %r12
	addq	%r13, %r12
	movq	-64(%rbp), %rsi
	addq	%r12, %rsi
	movq	-112(%rbp), %r12
	addq	%rsi, %r12
	movq	-48(%rbp), %rsi
	addq	%r12, %rsi
	addq	%rsi, %r10
	movq	%rcx, %rsi
	addq	%r10, %rsi
	movq	-120(%rbp), %rcx
	addq	%rsi, %rcx
	movq	-56(%rbp), %rsi
	addq	%rcx, %rsi
	movq	-88(%rbp), %rcx
	addq	%rsi, %rcx
	movq	%rdi, %rsi
	addq	%rcx, %rsi
	movq	-40(%rbp), %rdi
	addq	%rsi, %rdi
	movq	%rbx, %rcx
	addq	%rdi, %rcx
	movq	%r8, %rsi
	addq	%rcx, %rsi
	movq	%rdx, %rcx
	addq	%rsi, %rcx
	movq	-104(%rbp), %rdx
	addq	%rcx, %rdx
	movq	%r9, %rcx
	addq	%rdx, %rcx
	addq	%rcx, -48(%rbp)
	movq	$1, -104(%rbp)
	movq	$1, %r8
	movq	$1, %r12
	movq	$1, -40(%rbp)
	movq	$1, %rdx
	movq	$1, %rcx
	movq	$1, -56(%rbp)
	movq	$1, -120(%rbp)
	movq	$1, %r14
	movq	$1, -96(%rbp)
	movq	$1, -80(%rbp)
	movq	$1, -88(%rbp)
	movq	$1, %rbx
	movq	$1, %rdi
	movq	$1, -72(%rbp)
	movq	$1, -112(%rbp)
	movq	$1, %r13
	movq	$1, %rsi
	movq	$1, -64(%rbp)
	movq	$1, %r9
	movq	$100, %r10
	addq	%r10, %r9
	movq	-64(%rbp), %r10
	addq	%r9, %r10
	addq	%r10, %rsi
	movq	%r13, %r9
	addq	%rsi, %r9
	movq	-112(%rbp), %rsi
	addq	%r9, %rsi
	movq	-72(%rbp), %r9
	addq	%rsi, %r9
	movq	%rdi, %rsi
	addq	%r9, %rsi
	movq	%rbx, %rdi
	addq	%rsi, %rdi
	movq	-88(%rbp), %rsi
	addq	%rdi, %rsi
	movq	-80(%rbp), %rdi
	addq	%rsi, %rdi
	movq	-96(%rbp), %rsi
	addq	%rdi, %rsi
	movq	%r14, %rdi
	addq	%rsi, %rdi
	movq	-120(%rbp), %rsi
	addq	%rdi, %rsi
	movq	-56(%rbp), %rdi
	addq	%rsi, %rdi
	addq	%rdi, %rcx
	addq	%rcx, %rdx
	movq	-40(%rbp), %rcx
	addq	%rdx, %rcx
	movq	%r12, %rdx
	addq	%rcx, %rdx
	movq	%r8, %rcx
	addq	%rdx, %rcx
	movq	-104(%rbp), %rdx
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



