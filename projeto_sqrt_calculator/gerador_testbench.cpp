#include <bits/stdc++.h>

using namespace std;

void decimal_to_binary(int x){
    int z = 0, i, b[32];
    for(int k = 0; k < 32; k++)
        b[k] = 0;
    if(x < 1){
        for(i = 31; i >= 0; i--)
            cout << b[i];
        return;
    }
    while(x != 1){
        if(x % 2 == 0){
            x /= 2;
            z++;
        } else {
            b[z++] = 1;
            x = (x - 1) / 2;
        }
    }
    b[z++] = x % 2;
    while (z < 32)
        b[++z] = 0;
    printf("\"");
    for(i = 31; i >= 0; i--)
        cout << b[i];
    printf("\"");
}

// int proxima_raiz_quadrada_perfeita(int N){ 
// 	int nextN = floor(sqrt(N)) + 1; 
// 	return nextN * nextN; 
// } 

int main(){
    int x;
    int i = 0;
    srand(time(0));
    for(;i <= 14;){
        x = rand() % 1024;
        printf("%d => ", i++);
        decimal_to_binary(x);
        printf(",\n");
    }
    
    return 0;
}
