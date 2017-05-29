remote : remote.c
	gcc -Wall -std=c11 -I. -I/home/walker/MyroC/include -L/home/walker/MyroC/lib -lm -lMyroC -lbluetooth -ljpeg -leSpeakPackage commands.c remote.c -o remote

.PHONY : clean
clean :
	rm -rf remote *.o *.core
