#include <iostream>
#include <cmath>
#include <vector>
#include <algorithm>

using namespace std;

int multiplication(int x, int y)
{
    int sum = x;
    for (int n = 1; n < y; n++)
    {
        sum = sum + x;
    }
    return sum;
}

int power(int x, int y)
{
    int result = x;
    for (int k = 1; k < y; k++)
    {
        result = multiplication(result, x);
    }
    return result;
}

int mod(int x, int y)
{
    int tmp = x - y;
    while (tmp >= y)
    {
        tmp = tmp - y;
        //cout << "The difference is: " << diff << endl;
    }
    if (tmp < y & tmp < 0)
    {
        return x;
    }
    if (tmp < y)
    {
        return tmp;
    }
}

int main()
{

    const int x0 = 0;
    const int a = 73;
    const int b = 3;
    //const int m = 16;
    float y = x0;
    const float pow = power(2, 16);
    //cout << "The power is: " << pow << endl;

    vector<int> tmp;
    int sum = 0;
    for (int i = 10; i > 0; i--)
    {
        y = multiplication(y, a) + b;
        //cout << "tmp result * : " << y << endl;
        y = mod(y, pow);
        //cout << "tmp result mod : " << y << endl;

        if (find(tmp.begin(), tmp.end(), y) != tmp.end())
        {
            cout << "The repetition happens" << endl;
            break;
        }
        cout << y << endl;
        tmp.push_back(y);

        sum = sum + y;
    }

    cout << "vector size is: " << tmp.size() << endl;

    cout << "sum is equal to " << sum << endl;
}