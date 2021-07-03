
SECTION code_fp_am9511

PUBLIC cam32_sccz80_ldexp

EXTERN asm_am9511_ldexp_callee

; float ldexpf(float x, int16_t pw2);

.cam32_sccz80_ldexp
    ; Entry:
    ; Stack: float left, int right, ret
    ; Reverse the stack
    pop af                      ;my return
    pop bc                      ;int
    pop hl                      ;float
    pop de
    push af                     ;my return
    push bc                     ;int
    push de                     ;float
    push hl
    call asm_am9511_ldexp_callee

    pop af                      ;my return
    push af
    push af
    push af
    push af
    ret
