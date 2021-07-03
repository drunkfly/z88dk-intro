
		SECTION		code_clib
		PUBLIC		nmi_uninstall_isr
		PUBLIC		_nmi_uninstall_isr

		EXTERN		nmi_vectors
		EXTERN		CLIB_NMI_VECTOR_COUNT
		EXTERN		asm_interrupt_remove_handler

nmi_uninstall_isr:
_nmi_uninstall_isr:
	pop	bc
	pop	de
	push	de
	push	bc
	ld	hl, nmi_vectors
	ld	b,  CLIB_NMI_VECTOR_COUNT
	call	asm_interrupt_remove_handler
	ld	hl,0
IF __CPU_INTEL__
	ld	a,l
	rla
	ld	l,a
ELSE
	rl	l
ENDIF
	ret
