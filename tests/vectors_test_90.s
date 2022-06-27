	.align 16
block7756:
	movq	$0, %rcx
	movq	free_ptr(%rip), %r11
	addq	$208, free_ptr(%rip)
	movq	$51, 0(%r11)
	movq	%r11, %rdx
	movq	%rdx, %r11
	movq	%r14, 8(%r11)
	movq	$0, %rcx
	movq	%rdx, %r11
	movq	-200(%rbp), %rax
	movq	%rax, 16(%r11)
	movq	$0, %rcx
	movq	%rdx, %r11
	movq	-72(%rbp), %rax
	movq	%rax, 24(%r11)
	movq	$0, %rcx
	movq	%rdx, %r11
	movq	%rbx, 32(%r11)
	movq	$0, %rcx
	movq	%rdx, %r11
	movq	-160(%rbp), %rax
	movq	%rax, 40(%r11)
	movq	$0, %rcx
	movq	%rdx, %r11
	movq	-96(%rbp), %rax
	movq	%rax, 48(%r11)
	movq	$0, %rcx
	movq	%rdx, %r11
	movq	-136(%rbp), %rax
	movq	%rax, 56(%r11)
	movq	$0, %rcx
	movq	%rdx, %r11
	movq	-56(%rbp), %rax
	movq	%rax, 64(%r11)
	movq	$0, %rcx
	movq	%rdx, %r11
	movq	-120(%rbp), %rax
	movq	%rax, 72(%r11)
	movq	$0, %rcx
	movq	%rdx, %r11
	movq	-104(%rbp), %rax
	movq	%rax, 80(%r11)
	movq	$0, %rcx
	movq	%rdx, %r11
	movq	-128(%rbp), %rax
	movq	%rax, 88(%r11)
	movq	$0, %rcx
	movq	%rdx, %r11
	movq	-40(%rbp), %rax
	movq	%rax, 96(%r11)
	movq	$0, %rcx
	movq	%rdx, %r11
	movq	-144(%rbp), %rax
	movq	%rax, 104(%r11)
	movq	$0, %rcx
	movq	%rdx, %r11
	movq	-80(%rbp), %rax
	movq	%rax, 112(%r11)
	movq	$0, %rcx
	movq	%rdx, %r11
	movq	-192(%rbp), %rax
	movq	%rax, 120(%r11)
	movq	$0, %rcx
	movq	%rdx, %r11
	movq	-48(%rbp), %rax
	movq	%rax, 128(%r11)
	movq	$0, %rcx
	movq	%rdx, %r11
	movq	-152(%rbp), %rax
	movq	%rax, 136(%r11)
	movq	$0, %rcx
	movq	%rdx, %r11
	movq	-88(%rbp), %rax
	movq	%rax, 144(%r11)
	movq	$0, %rcx
	movq	%rdx, %r11
	movq	-184(%rbp), %rax
	movq	%rax, 152(%r11)
	movq	$0, %rcx
	movq	%rdx, %r11
	movq	-112(%rbp), %rax
	movq	%rax, 160(%r11)
	movq	$0, %rcx
	movq	%rdx, %r11
	movq	%r13, 168(%r11)
	movq	$0, %rcx
	movq	%rdx, %r11
	movq	-168(%rbp), %rax
	movq	%rax, 176(%r11)
	movq	$0, %rcx
	movq	%rdx, %r11
	movq	-64(%rbp), %rax
	movq	%rax, 184(%r11)
	movq	$0, %rcx
	movq	%rdx, %r11
	movq	-176(%rbp), %rax
	movq	%rax, 192(%r11)
	movq	$0, %rcx
	movq	%rdx, %r11
	movq	%r12, 200(%r11)
	movq	$0, %rcx
	movq	%rdx, %rcx
	movq	%rcx, %r11
	movq	16(%r11), %rax
	jmp conclusion

	.globl main
	.align 16
main:
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r13
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	subq	$176, %rsp
	movq	$16384, %rdi
	movq	$16384, %rsi
	callq	initialize
	movq	rootstack_begin(%rip), %r15
	addq	$0, %r15
	jmp start

	.align 16
start:
	movq	$1, %r14
	movq	$42, -200(%rbp)
	movq	$3, -72(%rbp)
	movq	$4, %rbx
	callq	read_int
	movq	%rax, -160(%rbp)
	movq	$4, -96(%rbp)
	movq	$4, -136(%rbp)
	movq	$44, -56(%rbp)
	movq	$4, -120(%rbp)
	movq	$4, -104(%rbp)
	movq	$4, -128(%rbp)
	movq	$4, -40(%rbp)
	movq	$4, -144(%rbp)
	movq	$4, -80(%rbp)
	movq	$4, -192(%rbp)
	movq	$4, -48(%rbp)
	movq	$44, -152(%rbp)
	movq	$4, -88(%rbp)
	movq	$4, -184(%rbp)
	movq	$4, -112(%rbp)
	movq	$4, %r13
	movq	$4, -168(%rbp)
	movq	$4, -64(%rbp)
	movq	$4, -176(%rbp)
	movq	$4, %r12
	movq	free_ptr(%rip), %rsi
	addq	$208, %rsi
	movq	fromspace_end(%rip), %rdi
	cmpq	%rdi, %rsi
	jl block7756
	jmp block7757

	.align 16
conclusion:
	subq	$0, %r15
	addq	$176, %rsp
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r13
	popq	%rbp
	retq

	.align 16
block7757:
	movq	%r15, %rdi
	movq	$208, %rsi
	callq	collect
	movq	free_ptr(%rip), %r11
	addq	$208, free_ptr(%rip)
	movq	$51, 0(%r11)
	movq	%r11, %rdx
	movq	%rdx, %r11
	movq	%r14, 8(%r11)
	movq	$0, %rcx
	movq	%rdx, %r11
	movq	-200(%rbp), %rax
	movq	%rax, 16(%r11)
	movq	$0, %rcx
	movq	%rdx, %r11
	movq	-72(%rbp), %rax
	movq	%rax, 24(%r11)
	movq	$0, %rcx
	movq	%rdx, %r11
	movq	%rbx, 32(%r11)
	movq	$0, %rcx
	movq	%rdx, %r11
	movq	-160(%rbp), %rax
	movq	%rax, 40(%r11)
	movq	$0, %rcx
	movq	%rdx, %r11
	movq	-96(%rbp), %rax
	movq	%rax, 48(%r11)
	movq	$0, %rcx
	movq	%rdx, %r11
	movq	-136(%rbp), %rax
	movq	%rax, 56(%r11)
	movq	$0, %rcx
	movq	%rdx, %r11
	movq	-56(%rbp), %rax
	movq	%rax, 64(%r11)
	movq	$0, %rcx
	movq	%rdx, %r11
	movq	-120(%rbp), %rax
	movq	%rax, 72(%r11)
	movq	$0, %rcx
	movq	%rdx, %r11
	movq	-104(%rbp), %rax
	movq	%rax, 80(%r11)
	movq	$0, %rcx
	movq	%rdx, %r11
	movq	-128(%rbp), %rax
	movq	%rax, 88(%r11)
	movq	$0, %rcx
	movq	%rdx, %r11
	movq	-40(%rbp), %rax
	movq	%rax, 96(%r11)
	movq	$0, %rcx
	movq	%rdx, %r11
	movq	-144(%rbp), %rax
	movq	%rax, 104(%r11)
	movq	$0, %rcx
	movq	%rdx, %r11
	movq	-80(%rbp), %rax
	movq	%rax, 112(%r11)
	movq	$0, %rcx
	movq	%rdx, %r11
	movq	-192(%rbp), %rax
	movq	%rax, 120(%r11)
	movq	$0, %rcx
	movq	%rdx, %r11
	movq	-48(%rbp), %rax
	movq	%rax, 128(%r11)
	movq	$0, %rcx
	movq	%rdx, %r11
	movq	-152(%rbp), %rax
	movq	%rax, 136(%r11)
	movq	$0, %rcx
	movq	%rdx, %r11
	movq	-88(%rbp), %rax
	movq	%rax, 144(%r11)
	movq	$0, %rcx
	movq	%rdx, %r11
	movq	-184(%rbp), %rax
	movq	%rax, 152(%r11)
	movq	$0, %rcx
	movq	%rdx, %r11
	movq	-112(%rbp), %rax
	movq	%rax, 160(%r11)
	movq	$0, %rcx
	movq	%rdx, %r11
	movq	%r13, 168(%r11)
	movq	$0, %rcx
	movq	%rdx, %r11
	movq	-168(%rbp), %rax
	movq	%rax, 176(%r11)
	movq	$0, %rcx
	movq	%rdx, %r11
	movq	-64(%rbp), %rax
	movq	%rax, 184(%r11)
	movq	$0, %rcx
	movq	%rdx, %r11
	movq	-176(%rbp), %rax
	movq	%rax, 192(%r11)
	movq	$0, %rcx
	movq	%rdx, %r11
	movq	%r12, 200(%r11)
	movq	$0, %rcx
	movq	%rdx, %rcx
	movq	%rcx, %r11
	movq	16(%r11), %rax
	jmp conclusion



