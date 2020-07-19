#include <sstream>
#include <iostream>

long long modulity(long long n, long long d) {
        long long moduli_cnt = 0;

        while (d) {
                auto res = n % d;

                if (!res)
                        break;

                d = res;
                ++moduli_cnt;
        };

        return moduli_cnt;
}

long long
gcd_length(long long u, long long v)
{
        unsigned long long l = 0;
        while (v != 0) {
                long long r = u % v;
                u = v;
                v = r;
                ++l;
        }
        return l;
}

long long gcd(long long u, long long v) {
        while (v != 0) {
                long long r = u % v;
                u = v;
                v = r;
        }
        return u;
}

#include <cmath>
double gcdd(double u, double v) {
        while (v != 0) {
                double r = fmod(u, v);
                u = v;
                v = r;
        }
        return u;
}

using namespace std;
#include <vector>
#include <fstream>

int main() {
	std::vector<int> results;

	for (int i = 1; i < 40000; ++i) {
		const auto result = modulity(i, 11);
		results.push_back(result  == 1 ? 1 : 0);
	}

	std::ofstream gen_file("out.txt");

	for (auto r : results) {
		gen_file << r << " ";
	}

	return 0;
}
