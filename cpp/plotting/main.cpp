#include <random>
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

int main() {
#if 0
	std::default_random_engine generator;

	auto mkdist = [](int l, int r) {
		return std::uniform_int_distribution<int>(l, r);
	};

	auto dice = [&](int l, int r) {
		return mkdist(l, r)(generator);
	};

	for (int i = 2; i < 1000; ++i) {
		int total = 0;
		int trials = 0;

		for (int j = i; j > 1; ) {
			int d = dice(0, j - 1);
			total += d;
			j = d;
			++trials;
		}

		std::cout << i << "," << trials << std::endl;
	}

	for (int i = 2; i < 10000; ++i) {
		int worst = -1;
		float total = 0.f;

		for (int j = 1; j < i; ++j) {
			const int result = modulity(i, j);
			total += result;

			/* if (worst < 0) { */
			/* 	worst = result; */
			/* } */
			/* else { */
				worst = std::max(result, worst);
			/* } */
		}

		total /= (i - 1);

		std::cout << i << "," << total << std::endl;
	}
#endif

	auto pt = [](auto x, auto y) {
		std::cout << x << "," << y << std::endl;
	};

	//int pp = 11461;

	/* for (int i = 1; i < pp; ++i) { */
	/* 	pt(i, modulity(pp, i)); */
	/* } */

	pt(0, 0);
	pt(1, 1);
	pt(1, 0);
	pt(0, 0);
	pt(0.2, 0.5);

	return 0;
}
