	.globl main
	.align 16
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$0, %rsp
	movq	$16384, %rdi
	movq	$16384, %rsi
	callq	initialize
	movq	rootstack_begin(%rip), %r15
	addq	$0, %r15
	jmp start

	.align 16
block8070:
	callq	read_int
	movq	%rax, %rdx
	movq	$1, %rcx
	addq	%rdx, %rcx
	movq	%rcx, %rax
	addq	$2, %rax
	jmp conclusion

	.align 16
block8069:
	movq	$777, %rcx
	movq	%rcx, %rax
	addq	$2, %rax
	jmp conclusion

	.align 16
start:
	callq	read_int
	movq	%rax, %rcx
	movq	%rcx, %rax
	addq	$2, %rax
	jmp conclusion

	.align 16
conclusion:
	subq	$0, %r15
	addq	$0, %rsp
	popq	%rbp
	retq



