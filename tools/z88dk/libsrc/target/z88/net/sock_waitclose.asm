;
;	This file is automatically generated
;
;	Do not edit!!!
;
;	djm 12/2/2000
;
;	ZSock Lib function: sock_waitclose

        SECTION code_clib
	PUBLIC	sock_waitclose
	PUBLIC	_sock_waitclose

	EXTERN	no_zsock

	INCLUDE	"packages.def"
	INCLUDE	"zsock.def"

.sock_waitclose
._sock_waitclose
	ld	a,r_sock_waitclose
	call_pkg(tcp_all)
	ret	nc
; We failed..are we installed?
	cp	rc_pnf
	scf		;signal error
	ret	nz	;Internal error
	call_pkg(tcp_ayt)
	jr	nc,sock_waitclose
	jp	no_zsock
