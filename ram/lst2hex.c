#include <stdio.h>
#include <stdint.h>
#include <ctype.h>
#include <string.h>
#include <stdlib.h>

uint8_t memory[65536];

/*
Sample input text:
000000000011111111112222222222
012345678901234567890123456789

000200  1               ; === RESET ===
000200  1               reset_handler:
000200  1  A2 47 A9 E1                  set_text_colors     ((COLOR_BRIGHT_YELLOW<<4)|COLOR_BLUE)
000204  1  33           
000205  1  A2 46 A9 73                  set_text_char       's'
000209  1  33           
00020A  1  A2 4A 33                     write_char_cell
00020D  1  80 FE        loop:           bra                 loop
*/

int convert(FILE* fin, FILE* fout) {
    char line[200];
    while (1) {
        memset(line, 0, sizeof(line));
        if (fgets(line, sizeof(line)-1, fin)) {
            if (isxdigit(line[0]) &&
                isxdigit(line[1]) &&
                isxdigit(line[2]) &&
                isxdigit(line[3]) &&
                isxdigit(line[4]) &&
                isxdigit(line[5]) &&
                isspace(line[6])) {
                int address;
                sscanf(line, "%x", &address);
                int pos = 11;
                printf("(%i) %s", address, line);
                while (isxdigit(line[pos]) &&
                        isxdigit(line[pos+1]) &&
                        isspace(line[pos+2])) {
                    int value;
                    sscanf(&line[pos], "%x", &value);
                    memory[address++] = (uint8_t)value;
                    pos += 3;
                }
            }
        } else {
            for (int i = 0; i < 65536; i++) {
                fprintf(fout, "%02hX", memory[i]);
                if ((i+1) & 31) {
                    fprintf(fout, " ");
                } else {
                    fprintf(fout, "\n");
                }
            }
            break;
        }
    }
    return 0;
}

int main() {
    FILE* fin = fopen("testcode.lst", "r");
    if (fin) {
        FILE* fout = fopen("ram.bits", "w");
        if (fout) {
            int rc = convert(fin, fout);
            fclose(fout);
            fclose(fin);
        } else {
            fclose(fin);
            printf("Cannot open BITS file\n");
            return 2;
        }
    } else {
        printf("Cannot open LST file\n");
        return 1;
    }
}
