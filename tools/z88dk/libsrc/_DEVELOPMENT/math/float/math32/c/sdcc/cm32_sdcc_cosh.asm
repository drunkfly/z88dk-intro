
SECTION code_fp_math32

PUBLIC cm32_sdcc_cosh

EXTERN cm32_sdcc_fsread1, _m32_coshf

cm32_sdcc_cosh:
    call cm32_sdcc_fsread1
    jp _m32_coshf
