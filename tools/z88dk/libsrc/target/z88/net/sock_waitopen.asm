;
;	This file is automatically generated
;
;	Do not edit!!!
;
;	djm 12/2/2000
;
;	ZSock Lib function: sock_waitopen

        SECTION code_clib
	PUBLIC	sock_waitopen
	PUBLIC	_sock_waitopen

	EXTERN	no_zsock

	INCLUDE	"packages.def"
	INCLUDE	"zsock.def"

.sock_waitopen
._sock_waitopen
	ld	a,r_sock_waitopen
	call_pkg(tcp_all)
	ret	nc
; We failed..are we installed?
	cp	rc_pnf
	scf		;signal error
	ret	nz	;Internal error
	call_pkg(tcp_ayt)
	jr	nc,sock_waitopen
	jp	no_zsock