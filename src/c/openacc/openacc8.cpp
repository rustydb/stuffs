#include<stdio.h>
#include<limits.h>

int max(int a, int b) { return (a > b)? a : b;}

int cut_rod(int price[], int n) {
    if (n <= 0)
        return 0;
    int max_val = INT_MIN;
    // Recursively cut the rod in different pieces and compare different
    // configurations
    #pragma acc kernels
    for (int i = 0; i < n; i++)
        max_val = max(max_val, price[i] + cut_rod(price, n-i-1));
    return max_val;
}

int main() {
    int arr[] = {1, 5, 8, 9, 10, 17, 17, 20, 25, 30, 31, 32, 32};
    int size = sizeof(arr)/sizeof(arr[0]);
    printf("Maximum Obtainable Value is %d\n", cut_rod(arr, size));
    return 0;
}
