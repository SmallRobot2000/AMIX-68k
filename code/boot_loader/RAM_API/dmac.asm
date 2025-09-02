    section .text

DMAC_base       equ     $FF4000

CH0_offset      equ     $00
CH1_offset      equ     $40
CH2_offset      equ     $80
CH3_offset      equ     $C0

DMAC_CH0_OCR    equ     CH0_offset+$05
DMAC_CH1_OCR    equ     CH1_offset+$05
DMAC_CH2_OCR    equ     CH2_offset+$05
DMAC_CH3_OCR    equ     CH3_offset+$05

DMAC_CH0_CCR    equ     CH0_offset+$07
DMAC_CH1_CCR    equ     CH1_offset+$07
DMAC_CH2_CCR    equ     CH2_offset+$07
DMAC_CH3_CCR    equ     CH3_offset+$07

DMAC_CH0_SCR    equ     CH0_offset+$06
DMAC_CH1_SCR    equ     CH1_offset+$06
DMAC_CH2_SCR    equ     CH2_offset+$06
DMAC_CH3_SCR    equ     CH3_offset+$06

DMAC_CH0_CSR    equ     CH0_offset+$00
DMAC_CH1_CSR    equ     CH1_offset+$00
DMAC_CH2_CSR    equ     CH2_offset+$00
DMAC_CH3_CSR    equ     CH3_offset+$00
init_DMAC:  
    lea     DMAC_base,a0
    ; Assume base address of DMAC and offsets for each OCR
    move.b  #2,(DMAC_CH0_OCR,a0)   ; Disable all interrupts for ch 0 external drq
    ;move.b  #0,(DMAC_CH1_OCR,a0)   ; Disable all interrupts for ch 1
    ;move.b  #0,(DMAC_CH2_OCR,a0)   ; Disable all interrupts for ch 2
    ;move.b  #0,(DMAC_CH3_OCR,a0)   ; Disable all interrupts for ch 3

    ;move.b  #$80,(DMAC_CH0_SCR,a0) ; Set SR bit (soft reset sequence)
    ;move.b  #$80,(DMAC_CH1_SCR,a0) ; Set SR bit (soft reset sequence)
    ;move.b  #$80,(DMAC_CH2_SCR,a0) ; Set SR bit (soft reset sequence)
    ;move.b  #$80,(DMAC_CH3_SCR,a0) ; Set SR bit (soft reset sequence)

    ;move.b  #0,(DMAC_CH0_CCR,a0)   ; Disable all interrupts for ch 0
    ;move.b  #0,(DMAC_CH1_CCR,a0)   ; Disable all interrupts for ch 1
    ;move.b  #0,(DMAC_CH2_CCR,a0)   ; Disable all interrupts for ch 2
    ;move.b  #0,(DMAC_CH3_CCR,a0)   ; Disable all interrupts for ch 3

    ;move.b  #$FF,(DMAC_CH0_CSR,a0)         ; Write ones to clear status bits 
    ;move.b  #$FF,(DMAC_CH1_CSR,a0)         ; Write ones to clear status bits 
    ;move.b  #$FF,(DMAC_CH2_CSR,a0)         ; Write ones to clear status bits 
    ;move.b  #$FF,(DMAC_CH3_CSR,a0)         ; Write ones to clear status bits 
    rts