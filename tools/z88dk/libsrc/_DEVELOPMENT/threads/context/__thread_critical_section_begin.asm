SECTION code_clib
SECTION code_threads

PUBLIC __thread_critical_section_begin

EXTERN asm_cpu_push_di

defc __thread_critical_section_begin = asm_cpu_push_di
