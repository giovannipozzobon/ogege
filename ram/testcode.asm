; testcode.asm - Use the display to test the 65C02S instruction set
;
;

                .DEFINE sub     .byte $03 ; subtract immediate from accumulator
                .DEFINE neg     .byte $13 ; negate accumulator
                .DEFINE not     .byte $23 ; bitwise invert accumulator
                .DEFINE wtx     .byte $33 ; write to text controller
                .DEFINE rtx     .byte $43 ; read from text controller

;    Text Area control register addresses and data:
;    (All hex addresses here are offsets from the text controller base address.)
;
;                                                   Addr   R W   Value  Purpose
;                                                   ----   - - -------- ------------------------------------------------------
                .DEFINE TC_FG_PAL_COLOR_0_GB        $00  ; r w GGGGBBBB Foreground palette color for index #0 (green & blue)
                .DEFINE TC_FG_PAL_COLOR_0_R         $01  ; r w ----RRRR Foreground palette color for index #0 (red)
                .DEFINE TC_FG_PAL_COLOR_15_GB       $1E  ; r w GGGGBBBB Foreground palette color for index #15 (green & blue)
                .DEFINE TC_FG_PAL_COLOR_15_R        $1F  ; r w ----RRRR Foreground palette color for index #15 (red)
                .DEFINE TC_BG_PAL_COLOR_0_GB        $20  ; r w GGGGBBBB Background palette color for index #0 (green & blue)
                .DEFINE TC_BG_PAL_COLOR_0_R         $21  ; r w ----RRRR Background palette color for index #0 (red)
                .DEFINE TC_BG_PAL_COLOR_15_GB       $3E  ; r w GGGGBBBB Background palette color for index #15 (green & blue)
                .DEFINE TC_BG_PAL_COLOR_15_R        $3F  ; r w ----RRRR Background palette color for index #15 (red)
                .DEFINE TC_H_SCROLL_POS_LO          $40  ; r w XXXXXXXX Horizontal scroll position in pixels (lower 8 bits)
                .DEFINE TC_H_SCROLL_POS_HI          $41  ; r w ------XX Horizontal scroll position in pixels (upper 2 bits)
                .DEFINE TC_V_SCROLL_POS_LO          $42  ; r w YYYYYYYY Vertical scroll position in pixels (lower 8 bits)
                .DEFINE TC_V_SCROLL_POS_HI          $43  ; r w -------Y Vertical scroll position in pixels (upper 1 bit)
                .DEFINE TC_TEXT_ROW_INDEX           $44  ; r w --RRRRRR Text row index
                .DEFINE TC_TEXT_COL_INDEX           $45  ; r w -CCCCCCC Text column index
                .DEFINE TC_CHAR_CODE_INDEX          $46  ; r w CCCCCCCC Character code index
                .DEFINE TC_CHAR_COLOR_PAL_INDEXES   $47  ; r w FFFFBBBB Character color palette indexes
                .DEFINE TC_CHAR_COLOR_FG_PAL_INDEX  $48  ; r w ----FFFF Character color foreground palette index
                .DEFINE TC_CHAR_COLOR_BG_PAL_INDEX  $49  ; r w ----BBBB Character color background palette index
                .DEFINE TC_RW_CHAR_CELL             $4A  ; r w -------- Read/write entire character cell to/from registers
                .DEFINE TC_TEXT_AREA_ALPHA          $4B  ; r w -----AAA Text area alpha value

                .ORG    $0000
zero_page:      .RES    $100
hw_stack:       .RES    $100

; === TEXT CONTROLLER ===

; A = GGGGBBBB Foreground palette color for index #0 (green & blue)
; X = palette index (0..15)
                .macro  set_fg_pal_color_gb index, ggggbbbb
                ldx     #(TC_FG_PAL_COLOR_0_GB + index)
                lda     #ggggbbbb
                wtx
                .endmacro

; A = ----RRRR Foreground palette color for index #0 (red)
; X = palette index (0..15)
                .macro  set_fg_pal_color_r index, rrrr
                ldx     #(TC_FG_PAL_COLOR_0_R + index)
                lda     #rrrr
                wtx
                .endmacro

; A = GGGGBBBB Background palette color for index #0 (green & blue)
; X = palette index (0..15)
                .macro  set_bg_pal_color_gb index, ggggbbbb
                ldx     #(TC_BG_PAL_COLOR_0_GB + index)
                lda     #ggggbbbb
                wtx
                .endmacro

; A = ----RRRR Background palette color for index #0 (red)
; X = palette index (0..15)
                .macro  set_bg_pal_color_r index, rrrr
                ldx     #(TC_BG_PAL_COLOR_0_R + index)
                lda     #rrrr
                wtx
                .endmacro

; A = XXXXXXXX Horizontal scroll position in pixels (lower 8 bits)
                ldx     #TC_H_SCROLL_POS_LO
                wtx

; A = ------XX Horizontal scroll position in pixels (upper 2 bits)
                ldx     #TC_H_SCROLL_POS_HI
                wtx

; A = YYYYYYYY Vertical scroll position in pixels (lower 8 bits)
                ldx     #TC_V_SCROLL_POS_LO
                wtx

; A = -------Y Vertical scroll position in pixels (upper 1 bit)
                ldx     #TC_V_SCROLL_POS_HI
                wtx

; A = --RRRRRR Text row index
                ldx     #TC_TEXT_ROW_INDEX
                wtx

; A = -CCCCCCC Text column index
                ldx     #TC_TEXT_COL_INDEX
                wtx

; A = CCCCCCCC Character code index
                ldx     #TC_CHAR_CODE_INDEX
                wtx

; A = FFFFBBBB Character color palette indexes
                ldx     #TC_CHAR_COLOR_PAL_INDEXES
                wtx

; A = ----FFFF Character color foreground palette index
                ldx     #TC_CHAR_COLOR_FG_PAL_INDEX
                wtx

; A = ----BBBB Character color background palette index
                ldx     #TC_CHAR_COLOR_BG_PAL_INDEX
                wtx

; A = -------- Read/write entire character cell to/from registers
                ldx     #TC_RW_CHAR_CELL
                wtx

; A = -----AAA Text area alpha value
                ldx     #TC_TEXT_AREA_ALPHA
                wtx

; === RESET ===
reset_handler:
                bra     reset_handler

; === BRK/IRQ ===
brk_irq_handler:
                bra     brk_irq_handler

; === NMI ===
nmi_handler:
                bra     nmi_handler


                .ORG    $FFFA
nmi_vector:     .WORD   nmi_handler
reset_vector:   .WORD   reset_handler
brk_irq_vector: .WORD   brk_irq_handler
