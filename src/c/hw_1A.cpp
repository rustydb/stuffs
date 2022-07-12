#include <iostream>
#include <algorithm>

using namespace std;

int main () {
    int r, g, b;
    cout << "Enter the red component: ";
    cin >> r;
    cout << "Enter the green component: ";
    cin >> g;
    cout << "Enter the blue component: ";
    cin >> b;
    cout << "In descending order: ";
    int num[3] = {r, g, b};
    sort(num, num + 3);
    reverse(num, num + 3);
    cout << "In descending order: ";
    int i;
    for (i = 0; i < 3; i++) {
        if (num[i] == r) {
            cout << "red ";
        } else if (num[i] == g) {
            cout << "green ";
        } else if (num[i] == b) {
            cout << "blue ";
        }
    }
    cout << endl;
    return 0;
}
