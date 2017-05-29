//
//  main.c
//  function
//
//  Created by Kevin Kim on 2/15/17.
//  Copyright © 2017 Kevin Kim. All rights reserved.
//

#include <stdio.h>

//Slash
void slash(int n){
    for (int i = 1; i <= n ; i++){
        for (int j = 1; j <= i; j++)
        {
            if (j%i == 0){
                printf("\\*\\\n");
            }
            else{
                printf(" ");
            }
        }
    }
}
//Numsquare


void num_square(int n, int m){
    int c[20];
    int count = n;
    int count1= 0;
    
    int size = m-n+1;
    for (int i = 0; i < m-n+1; i++){
        c[i] = count;
        count++;
    }
    for(int j = 0; j < m-n+1; j++){
        for (int k = 0 ; k < m-n+1; k++){
            printf("%d",c[count1%(size)]);
            count1++;
            
        }
        count1++;
        printf("\n");
    }
    
    

}




//Change

int calculate_whole(int dollar, int denomination){
    int whole = 0;
    whole = dollar/denomination;
    return whole;
}

int calculate_remainder(int dollar, int denomination){
    int remainder = 0;
    remainder = dollar%denomination;
    return remainder;
}

void make_change(int cents){
    int dollars;
    int quarters;
    int dimes;
    int nickels;
    
    dollars = calculate_whole(cents, 100);
    cents = calculate_remainder(cents, 100);
    quarters = calculate_whole(cents, 25);
    cents = calculate_remainder(cents, 25);
    dimes = calculate_whole(cents, 10);
    cents = calculate_remainder(cents, 10);
    nickels = calculate_whole(cents, 5);
    cents = calculate_remainder(cents, 5);
    
    printf("dollars  = %d \n", dollars);
    printf("quarters = %d \n", quarters);
    printf("dimes    = %d \n", dimes);
    printf("nickels  = %d \n", nickels);
    printf("cents    = %d \n", cents);

    
    
    
    

}

int main(int argc, const char * argv[]) {
    slash(3);
    slash(7);
    num_square(3,7);
    num_square(4, 9);
    make_change(141);
    make_change(157);
    
    return 0;
}



