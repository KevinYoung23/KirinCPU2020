#include <iostream>
#include <cmath>

using namespace std;

int main()
{
    const int x0 = 23;
    const int a = 1;
    const int b = 0;
    const int m = 16;
    const int y0 = x0;
    int sum = 0;
    for (int m = 16; m > 0; m--)
    {
        int y = (y0 * a + b) * (pow(2, m));
        cout << y << endl;
        sum = sum + y;
    }
    cout << "sum is equal to " << sum << endl;
}