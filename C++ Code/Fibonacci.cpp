#include <iostream>

using namespace std;

int fibonacci(int n)
{
    int y;
    if (n <= 1)
    {
        y = 1;
    }
    else
    {
        y = fibonacci(n - 1);
        y = y + fibonacci(n - 2);
    }
    return y;
}

int main()
{
    for (int i = 1; i < 6; i++)
    {
        cout << fibonacci(i) << endl;
    }
}