#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#include <MyroC.h>
#include "parse.h"

int main(int argc, char *argv[]){

	rConnect("/dev/rfcomm0");

	printf("Press first time!");

	getchar();

	rMotors(0.25,0.25);

	printf("Press second time!");

	getchar();

	rStop();

	if (argc==4 && !strcmp(argv[1],"-log")){
		int i=parsefile(argv[3],argv[2]);
		if (i!=0){
			printf("Error in script!\n");
			rDisconnect();
			return -1;
		}
	}
	else if (argc==2){
		int i=parsefile(argv[1],NULL);
		if (i!=0){
			printf("Error in script!\n");
			rDisconnect();
			return -1;
		}
	}
	else {
		printf("Invalid command line arguments!\n");
		rDisconnect();
		return -1;
	}

	rForward (1.0, 2.0);

	rDisconnect();

	return 0;
}
