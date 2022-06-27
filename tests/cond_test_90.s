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
block8002:
	cmpq	$0, %rcx
	je block8000
	jmp block7999

	.align 16
block8001:
	cmpq	$1, %rcx
	je block8000
	jmp block7999

	.align 16
block8000:
	movq	$1, %rcx
	cmpq	$1, %rcx
	je block7995
	jmp block7996

	.align 16
block7999:
	movq	$0, %rcx
	cmpq	$1, %rcx
	je block7995
	jmp block7996

	.align 16
block7996:
	movq	$10, %rax
	negq	%rax
	jmp conclusion

	.align 16
block7995:
	movq	$10, %rax
	jmp conclusion

	.align 16
conclusion:
	subq	$0, %r15
	addq	$0, %rsp
	popq	%rbp
	retq

	.align 16
start:
	movq	$1, %rcx
	cmpq	$1, %rcx
	je block8001
	jmp block8002



