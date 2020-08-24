#include <iostream>
#include <cmath>
#include <vector>
#include <algorithm>

using namespace std;

int main()
{

    float y = 383;
    float a = 73;
    float b = 3;
    float m = 16;

    float power = pow(2, m);
    vector<int> tmp;
    float sum = 0;

    for (int i = 10; i > 0; i--)
    {

        y = y * a + b;
        y = fmod(y, power);

        if (find(tmp.begin(), tmp.end(), y) != tmp.end())
        {
            cout << "The iteration happens" << endl;
            break;
        }
        cout << y << endl;
        tmp.push_back(y);

        sum = sum + y;
    }

    cout << "vector size is: " << tmp.size() << endl;

    cout << "sum is equal to " << sum << endl;
}
