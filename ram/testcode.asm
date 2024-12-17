; testcode.asm - Use the display to test the 65C02S instruction set
;
;

;    Text Area control register addresses and data:
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

                .DEFINE COLOR_BLACK                 0
                .DEFINE COLOR_BLUE                  1
                .DEFINE COLOR_GREEN                 2
                .DEFINE COLOR_CYAN                  3
                .DEFINE COLOR_RED                   4
                .DEFINE COLOR_MAGENTA               5
                .DEFINE COLOR_YELLOW                6
                .DEFINE COLOR_WHITE                 7
                .DEFINE COLOR_DARK_GRAY             8
                .DEFINE COLOR_BRIGHT_BLUE           9
                .DEFINE COLOR_BRIGHT_GREEN          10
                .DEFINE COLOR_BRIGHT_CYAN           11
                .DEFINE COLOR_BRIGHT_RED            12
                .DEFINE COLOR_BRIGHT_MAGENTA        13
                .DEFINE COLOR_BRIGHT_YELLOW         14
                .DEFINE COLOR_BRIGHT_WHITE          15

                .ORG    $0000
zero_page:      .RES    $100
hw_stack:       .RES    $100

; New instructions (not found in 65C02S)

; Subtract immediate from accumulator
                .macro  sub value
                .byte   $03,value
                .endmacro

; Negate accumulator
                .macro  neg
                .byte   $13
                .endmacro

; Bitwise invert accumulator
                .macro  not
                .byte   $23
                .endmacro

; Write to text controller
                .macro  wtx
                .byte   $33
                .endmacro

; Read from text controller
                .macro  rtx
                .byte   $43
                .endmacro

; === TEXT CONTROLLER ===

; Foreground palette color for index (green & blue)
                .macro  set_const_fg_pal_color_gb index, ggggbbbb
                ldx     #(TC_FG_PAL_COLOR_0_GB + index)
                lda     #ggggbbbb
                wtx
                .endmacro

; Foreground palette color for index (red)
                .macro  set_const_fg_pal_color_r index, rrrr
                ldx     #(TC_FG_PAL_COLOR_0_R + index)
                lda     #rrrr
                wtx
                .endmacro

; Background palette color for index (green & blue)
                .macro  set_const_bg_pal_color_gb index, ggggbbbb
                ldx     #(TC_BG_PAL_COLOR_0_GB + index)
                lda     #ggggbbbb
                wtx
                .endmacro

; Background palette color for index (red)
                .macro  set_const_bg_pal_color_r index, rrrr
                ldx     #(TC_BG_PAL_COLOR_0_R + index)
                lda     #rrrr
                wtx
                .endmacro

; Horizontal scroll position in pixels
                .macro  set_const_h_scroll_pos pos
                lda     #(pos >> 8)
                ldx     #TC_H_SCROLL_POS_HI
                wtx
                ldx     #TC_H_SCROLL_POS_LO
                lda     #(pos & 0xFF)
                wtx
                .endmacro

; Vertical scroll position in pixels
                .macro  set_const_v_scroll_pos pos
                ldx     #TC_V_SCROLL_POS_HI
                lda     #(pos >> 8)
                wtx
                ldx     #TC_V_SCROLL_POS_LO
                lda     #(pos & 0xFF)
                wtx
                .endmacro

; Text row index (constant)
                .macro  set_const_text_row row
                ldx     #TC_TEXT_ROW_INDEX
                lda     #row
                wtx
                .endmacro

; Text row index (variable)
                .macro  set_var_text_row row
                ldx     #TC_TEXT_ROW_INDEX
                lda     row
                wtx
                .endmacro

; Text column index (constant)
                .macro  set_const_text_col col
                ldx     #TC_TEXT_COL_INDEX
                lda     #col
                wtx
                .endmacro

; Text column index (variable)
                .macro  set_var_text_col col
                ldx     #TC_TEXT_COL_INDEX
                lda     col
                wtx
                .endmacro

; Character code index (constant)
                .macro  set_const_text_char char
                ldx     #TC_CHAR_CODE_INDEX
                lda     #char
                wtx
                .endmacro

; Character code index (variable)
                .macro  set_var_text_char char
                ldx     #TC_CHAR_CODE_INDEX
                lda     char
                wtx
                .endmacro

; Character color palette indexes (constant)
                .macro  set_const_text_colors ffffbbbb
                ldx     #TC_CHAR_COLOR_PAL_INDEXES
                lda     #ffffbbbb
                wtx
                .endmacro

; Character color foreground palette index (constant)
                .macro  set_const_text_fg_color ffff
                ldx     #TC_CHAR_COLOR_FG_PAL_INDEX
                lda     #ffff
                wtx
                .endmacro

; Character color background palette index (constant)
                .macro  set_const_text_bg_color bbbb
                ldx     #TC_CHAR_COLOR_BG_PAL_INDEX
                lda     #bbbb
                wtx
                .endmacro

; Write entire character cell from registers (constant)
                .macro  write_char_cell
                ldx     #TC_RW_CHAR_CELL
                wtx
                .endmacro

; Text area alpha value (constant)
                .macro  set_const_text_area_alpha aaa
                ldx     #TC_TEXT_AREA_ALPHA
                lda     #aaa
                wtx
                .endmacro

; === RESET ===
reset_handler:
                clc ; 01
                bcs bcserr
                clv ; 40
                bvs bvserr
                lda #0 ; 02
                bne bneerr

                sec ; 01
                bcc secerr
                lda         #$FF
                adc #1 ; 40
                bvc bvcerr
                lda #1 ; 02
                beq beqerr

okee:           bra okee

bcserr: bra bcserr
bvserr: bra bvserr
bneerr: bra bneerr
secerr: bra secerr
bvcerr: bra bvcerr
beqerr: bra beqerr

loop:           bra                 loop

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
