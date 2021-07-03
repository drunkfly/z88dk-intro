dnl############################################################
dnl##        VGL_CRT_1.ASM.M4 - V-TECH GENIUS LEADER         ##
dnl############################################################
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                 V-Tech Genius Leader target               ;;
;;    generated from target/vgl/startup/vgl_crt_1.asm.m4     ;;
;;                                                           ;;
;;                      ROM minimal                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GLOBAL SYMBOLS ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; This will be a file containing all the defined constants from the config directory.  When the library is built, the file will be generated.
include "config_vgl_public.inc"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CRT AND CLIB CONFIGURATION ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

include "../crt_defaults.inc"
include "crt_config.inc"
include(`../crt_rules.inc')

; This file will process target-specific pragmas, of which you will initially have none.
include(`vgl_rules.inc')

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; SET UP MEMORY MAP ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

include "crt_memory_map.inc"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; INSTANTIATE DRIVERS ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


dnl############################################################
dnl## LIST OF AVAILABLE DRIVERS WITH STATIC INSTANTIATORS #####
dnl############################################################
dnl
dnl## input terminals
dnl
dnl#include(`driver/character/vgl_00_input_char.m4')dnl
dnl#include(`driver/terminal/vgl_01_input_kbd.m4')dnl
dnl
dnl## output terminals
dnl
dnl#include(`driver/character/vgl_00_output_char.m4')dnl
dnl#include(`driver/terminal/vgl_01_output_char.m4')dnl
dnl
dnl## file dup
dnl
dnl#include(`../m4_file_dup.m4')dnl
dnl
dnl## empty fd slot
dnl
dnl---dnl
dnl
dnl############################################################
dnl## INSTANTIATE DRIVERS #####################################
dnl############################################################


dnl	include(`../clib_instantiate_begin.m4')
dnl	
dnl	ifelse(eval(M4__CRT_INCLUDE_DRIVER_INSTANTIATION == 0), 1,
dnl	`
dnl	   include(`../m4_file_absent.m4')dnl
dnl	   m4_file_absentdnl
dnl	   
dnl	   include(`../m4_file_absent.m4')dnl
dnl	   m4_file_absentdnl
dnl	   
dnl	   include(`../m4_file_absent.m4')dnl
dnl	   m4_file_absentdnl
dnl	',
dnl	`
dnl	   include(`crt_driver_instantiation.asm.m4')
dnl	')
dnl	
dnl	include(`../clib_instantiate_end.m4')

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; STARTUP ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SECTION CODE

PUBLIC __Start, __Exit

EXTERN _main


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ROM SIGNATURE ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; The signature must be the first few bytes in ROM
SECTION CODE
include(`startup/vgl_signature_code.inc')


;	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	;; USER PREAMBLE ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	
;	IF __crt_include_preamble
;	
;	   include "crt_preamble.asm"
;	   SECTION CODE
;	
;	ENDIF
;	
;	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	;; PAGE ZERO ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	
;	IF (ASMPC = 0) && (__crt_org_code = 0)
;	
;	   include "../crt_page_zero_z80.inc"
;	
;	ENDIF
;	
;	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	;; CRT INIT ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	
;	
;	__Start:
;	
;	   include "../crt_start_di.inc"
;	   include "../crt_save_sp.inc"
;	
;	__Restart:
;	
;	;   include "../crt_init_sp.inc"
;	   
;	   ; command line
;	   
;	   IF (__crt_enable_commandline = 1) || (__crt_enable_commandline >= 3)
;	   
;	      include "../crt_cmdline_empty.inc"
;	   
;	   ENDIF
;	
;	__Restart_2:
;	
;	   IF __crt_enable_commandline >= 1
;	
;	      push hl                  ; argv
;	      push bc                  ; argc
;	
;	   ENDIF
;	
   ; initialize data section

   include "../clib_init_data.inc"

   ; initialize bss section

   include "../clib_init_bss.inc"

   ; interrupt mode
   
   include "../crt_set_interrupt_mode.inc"
;	
;	SECTION code_crt_init          ; user and library initialization
;	
;	   ; Prepare hardware (timers etc.)
;	   
;	   
SECTION code_crt_main
;	
;	   include "../crt_start_ei.inc"
;	
   ; call user program
   
   call _main                  ; hl = return status
;	
;	   ; run exit stack
;	
;	   IF __clib_exit_stack_size > 0
;	   
;	      EXTERN asm_exit
;	      jp asm_exit              ; exit function jumps to __Exit
;	   
;	   ENDIF
;	
__Exit:
;	
;	   IF !((__crt_on_exit & 0x10000) && (__crt_on_exit & 0x8))
;	   
;	      ; not restarting
;	      
;	      push hl                  ; save return status
;	   
;	   ENDIF
;	
;	SECTION code_crt_exit          ; user and library cleanup
;	SECTION code_crt_return
;	
;	   ; close files
;	   
;	   include "../clib_close.inc"
;	
;	   ; terminate
;	   
;	   include "../crt_exit_eidi.inc"
;	   include "../crt_restore_sp.inc"
;	   include "../crt_program_exit.inc"      

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; RUNTIME VARS ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

include "../crt_jump_vectors_z80.inc"

;	IF (__crt_on_exit & 0x10000) && ((__crt_on_exit & 0x6) || ((__crt_on_exit & 0x8) && (__register_sp = -1)))
;	
;	   SECTION BSS_UNINITIALIZED
;	   __sp_or_ret:  defw 0
;	
;	ENDIF
;	
include "../clib_variables.inc"
;	
;	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	;; CLIB STUBS ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	
;	include "../clib_stubs.inc"
