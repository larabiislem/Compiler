flex rayan.l
bison -d rayan.y
gcc lex.yy.c rayan.tab.c -o pgr -lfl -ly
pgr <EXEMPLE.txt