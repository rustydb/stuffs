//Problem 2C
//Calculate the winning team given the chance of winning for one team

#include <iostream>
#include <cmath>
#include <cstdlib>

using namespace std;

double team_a, steam_a, totteam_a, steam_b, totteam_b, ran_num;
int i, j, seed, series;

int main(){

    cout << "Input the chance Team A wins: ";
    cin >> team_a;
    if (team_a > 1.0 || team_a < 0.0) {
        cout << "Please enter a valid number.";
        cout << "\n";
    } else {
        cout << "Enter an integer seed: ";
        cin >> seed;
        cout << "Enter the number of series: ";
        cin >> series;
        srand(seed);
    }
    totteam_a = 0;
    totteam_b = 0;
    for (i = 1; i <= series; i++) {
        steam_a = 0;
        steam_b = 0;
        for (j = 1; j <= 3; j++) {
            ran_num = static_cast<double>(rand())/RAND_MAX;
            if (ran_num <= team_a) {
                steam_a = steam_a + 1;
            } else {
                steam_b  = steam_b + 1;
            }
        }
        if (steam_a > steam_b){
            totteam_a = totteam_a + 1;
        } else {
            totteam_b = totteam_b + 1;
        }
    }
    cout << "Team A won " << totteam_a << " of " << series << " three-game series." << "\n";
    return 0;
}

