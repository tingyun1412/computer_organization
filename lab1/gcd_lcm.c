#include <stdio.h>

int gcd(int a, int b) {
    // TODO
    if (b == 0){
        return a;
    }else{
        return gcd(b, a % b);
    }

}

int lcm(int a, int b) {
    // TODO
    return (a*b)/gcd(a, b);
}

int main() {
    // DO NOT modify this section
    int n1, n2;
    printf("Please enter the first number: ");
    scanf("%d", &n1);
    printf("Please enter the second number: ");
    scanf("%d", &n2);

    printf("%d %d\n", gcd(n1, n2), lcm(n1, n2));

    return 0;
}
