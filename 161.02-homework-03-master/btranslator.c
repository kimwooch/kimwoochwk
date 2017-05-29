#include <stdio.h>
#include <math.h>

unsigned char binaryStringToValue(char digits[8]){
  
  unsigned char result = 0;

  for (int i =7; i >=0; i--){
    if (digits[i] == '1')
      result+= pow(2, (7-i));
  }
  
  return result;
  
  }

void writeValueAsBinaryString(unsigned char val, char digits[8]){
  
  int k;
  
  for(int i = 7; i >=0; i--){
    k = val >> i;
    if ((k & 1) == 1)
      digits[i] = '1';
    else
      digits[i] = '0';
  }
  
  for(int i = 0; i < 4; i++){
    char temp = digits[i];
    digits [i] = digits[7 -i];
    digits [7-i] = temp;
  }
  
  for(int i = 0; i < 8; i++){
    printf("%c", digits[i]);
  }
  
  printf("\n");
 
}

unsigned char hexStringToValue(char digits[2]){
  unsigned char result=0;
  int i = 0;
  unsigned char val;
  int length = 1;
  
  while(digits[i]){
    if(digits[i]>='0' && digits[i]<='9')
      val = digits[i]-48;
    else if (digits[i] >= 'A' && digits[i] <= 'F')
      val = digits[i]-55;

    result += val*(unsigned char)pow(16,length);
    length--;
    i++;
  }
  return result;
}

void writeValueAsHexString(unsigned char val, char digits[2]){
  char num16[16] = {'0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'};
  int num = val;
  
  for(int i = 1; i >= 0; i--){
    digits[i] = num16[num%16];
    num/=16;
  }
  
  for(int i = 0; i < 2; i++){
    printf("%c", digits[i]);
  }
  
  printf("\n");
}

int main(){
  unsigned char digits[8] = {'1','0','0','1','1','0','1','1'};
  unsigned char digits1[8] = {'1','1','0','1','1','0','1','1'};
  char binString[8];
  char HexToValue[2]= {'E','4'};
  char HexToValue1[2] = {'A','3'};
  char hexString[2];
  
  printf("%d\n", binaryStringToValue(digits));
  printf("%d\n", binaryStringToValue(digits1));
  writeValueAsBinaryString(155, binString);
  writeValueAsBinaryString(235, binString);
  writeValueAsHexString(155,hexString);
  writeValueAsHexString(235,hexString);
  printf("%d\n", hexStringToValue(HexToValue));
  printf("%d\n", hexStringToValue(HexToValue1));
  
  return 0;
}
