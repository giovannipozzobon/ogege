ca65 --listing testcode.lst --cpu 65SC02 --verbose testcode.asm
if [ $? -eq 0 ]; then
    echo ca65 OK
else
    echo ca65 FAIL
    exit
fi

ld65 -C testcode.cfg -o testcode.out --mapfile testcode.map testcode.o
if [ $? -eq 0 ]; then
    echo ld65 OK
else
    echo ld65 FAIL
fi
