#include <stdio.h>
#include <math.h>
#include <sys/stat.h>
#include <string.h>

void writeValueAsBinaryString(int val, char digits[9]){
  
  int k;
  
  for(int i = 8; i>=0; i--){
    k = val>> i;
    if ((k&1)==1)
      digits[i] = '1';
    else
      digits[i] = '0';
  }
  
  for(int i = 0; i < 4; i++){
    char temp = digits[i];
    digits[i] = digits[8-i];
    digits[8-i] = temp;
  }
  
}

void convertOctToBinary(int octalNumber, char digits[9]){
  
  int decimalNumber, i, remainder = 0;
  
  while(octalNumber !=0)
    {
      remainder = octalNumber%10;
      octalNumber /= 10;
      decimalNumber += remainder * pow(8,i);
      ++i;
    }
  
  writeValueAsBinaryString(decimalNumber, digits);
}

void writePermissionString(int perms, char str[9]){
  
  char permString [9];
  convertOctToBinary(perms, permString);
  
  for(int i = 0; i < 9; i++){
    
    if(permString[i] == '1'){
      
      if ((i%3) == 2){
        permString[i] = 'x';
      }
      else if ((i%3) == 1){
        permString[i] = 'w';
      }
      else {
        permString[i] = 'r';
      }
      
    }else{
      permString[i] = '-';
    }
    
  }
  
  for(int i = 0; i < 9; i++){
    printf("%c", permString[i]);
  }
  printf("\n");
}
  
int generatePermissionBits(char str[9]){

  int permission = 0;
  
  for(int i = 0 ; i < 9; i++){
    if(str[8-i] == '-')
      str[8-i] = '0';
    else
      str[8-i] = '1';
  }
  
  for(int i = 0; i <9; i++){
    if (str[8-i] == '1')
      permission += (int) (pow(2, (i%3)) * pow(10, floor(i/3)));
  }
  
  return permission;
}

 int main(){
   
   char digits[9];
   char digits1[9];
   char str1[9] = "rw-r-----";
   char str2[9] = "rwxr-xr-x";
   
   writePermissionString(755, digits);
   writePermissionString(664, digits1);
 
   printf("%04d\n", generatePermissionBits(str1));
   printf("%04d\n", generatePermissionBits(str2));
   
   return 0;
 }
