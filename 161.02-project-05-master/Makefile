hanoi: hanoi.c list.c list.h stack.c stack.h
	gcc -Wall -std=c11 -I/home/walker/MyroC/include -L/home/walker/MyroC/lib -lm -lMyroC -lbluetooth -ljpeg -leSpeakPackage hanoi.c list.c stack.c -o hanoi
.PHONY : clean
clean :
	rm -rf remote *.o *.core
