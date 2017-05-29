#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#include <MyroC.h>
#include "parse.h"

void loginfo(FILE *fl,char *command){
	
	time_t curtime;
	time(&curtime);

	fputs(ctime(&curtime),fl);
	fputc(' ',fl);
	fputs(command,fl);
	fputc('(',fl);

	int ir[2];
	rGetIRAll (ir, 30);
	fprintf(fl,"%d,%d,",ir[0],ir[1]);

	int light[3];
	rGetLightsAll(light, 30);
	int avg=(light[0]+light[1]+light[2])/3;
	fprintf(fl,"%d)\n",avg);
}

void turn(int deg, char *dir){
	if (deg==45){
		if (!strcmp(dir,"left\n")){
			rTurnLeft (1.0,0.36);
		}else{
			rTurnRight (1.0,0.36);
		}
	}else{
		if (!strcmp(dir,"left\n")){
			rTurnLeft (1.0,0.73);
		}else{
			rTurnRight (1.0,0.73);
		}
	}
}

int execute(char *cmd){

	char *first=strtok(cmd," ");

	if (!strcmp(first,"forward")){
		char *second=strtok(NULL," ");
		if (second==NULL){
			printf("Invalid time!\n");
			return -1;
		}
		double time=atof(second);
		if (time==0.0){
			printf("Invalid time!\n");
			return -1;
		}
		rForward (1.0,time);
	}
	else if (!strcmp(first,"turn")){
		char *second=strtok(NULL," ");
		if (second==NULL){
			printf("Invalid degree!\n");
			return -1;
		}
		int degree=atoi(second);
		if (degree!=45 && degree!=90){
			printf("Invalid degree!\n");
			return -1;
		}

		char *third=strtok(NULL," ");
		if (strcmp(third,"left\n")!=0 && strcmp(third,"right\n")!=0){
			printf("Invalid direction!\n");
			return -1;
		}
		
		turn(degree,third);

	}
	else if (!strcmp(first,"spin")){
		char *second=strtok(NULL," ");
		if (strcmp(second,"left\n") && strcmp(second,"right\n")){
			printf("Invalid direction!\n");
			return -1;
		}else{
			if (!strcmp(second,"left\n")){
				rTurnLeft(1.0,2.9);
			}else{
				rTurnRight(1.0,2.9);
			}
		}
	}
	else if (!strcmp(first,"beep\n")){
		rBeep(1.0,698);
	}
	else if (!strcmp(first,"ditty\n")){
		rBeep(0.5,1000);
		rBeep(0.5,839);
	}
	else if (!strcmp(first,"song\n")){
		rBeep(0.5,1000);
		rBeep(0.5,900);
		rBeep(0.5,800);
		rBeep(0.5,700);
		rBeep(0.5,600);
		rBeep(0.5,700);	
	}
	else {
		printf("Unrecognized command: %s\n",first);
		return -1;
	}
	return 0;
}

int parsefile(char *script, char* log){

	FILE *fs=fopen(script,"r");
	if (fs==NULL){
		printf("Cannot open script file!\n");
		return -1;
	}
	FILE *fl=fopen(log,"w");

	char cmd[50];
	while(fgets(cmd,50,fs)!=NULL){
		int i=execute(cmd);	
		if (i!=0){
			printf("Error in command: %s!\n",cmd);
			fclose(fs);
			if (log!=NULL) fclose(fl);
			return -1;
		}
		if (log!=NULL) loginfo(fl,cmd);
	}

	fclose(fs);
	if (log!=NULL) fclose(fl);

	return 0;
}
