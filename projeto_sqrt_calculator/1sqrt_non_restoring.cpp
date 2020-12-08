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
    for(i = 31; i >= 0; i--)
        cout << b[i];
}

void show_binary(char c, int index, int num){
    printf("%c[%d] = %d", c, index, num);
    if(num >= 0){
        printf("\n%c[%d] = ", c, index);
        decimal_to_binary(num);
    }
}

unsigned square_root(unsigned D, int &r){
    unsigned Q = 0;
    int R = 0;
    int i;
    for (i = 15; i >= 0; i--){
        printf("i = %d\n", i);
        show_binary('D', i, D);
        printf("\n");
        if (R >= 0){ 
            printf("R = %d | %d\n", R << 2, (D >> (i + i)) & 3);
            R = (R << 2) | ((D >> (i + i)) & 3);
            printf("R = %d\n", R);
            printf("R -= %d | 1\n", (Q << 2));
            R -= ((Q << 2) | 1); //Q01
        }
        else{
            printf("R = %d | %d\n", R << 2, (D >> (i + i)) & 3);
            R = (R << 2) | ((D >> (i + i)) & 3);
            printf("R = %d\n", R);
            printf("R += %d | 3\n", (Q << 2));
            R += ((Q << 2) | 3); //Q11
        }
        show_binary('R', i, R);
        printf("\n");
        if (R >= 0)
            Q = (Q << 1) | 1; 
        else
            Q = (Q << 1) | 0; 
        show_binary('Q', i, Q);
        printf("\n\n");
    }
    printf("Apos iterações R = %d\n", R);
    if (R < 0)
        R += ((Q << 1) | 1);
    printf("R final = %d\n", R);
    r = R; 
    return Q;
}

int main(){
    int x, y = 0;
    x = 1024;
    printf("Resultado = %d\n", square_root(x, y));
    printf("Resto = %d\n", y);
    
    // srandom(time(0));
    // for(int k = 0; k <= 20; k++){
    //     x = random() % 400;
    //     y = 0;
    //     printf("Sqrt(%d) = %d, ", x, square_root(x, y));
    //     printf("R = %d\n", y);
    // }
    return 0;
}
