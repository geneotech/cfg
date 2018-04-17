#include <iostream>
#include <tuple>
#include <optional>

template <class F>
void f(std::optional<F> t) {
	if (t) {
		t.value()(2);
	}
}

auto nullopt_lambda() {
	auto o = std::make_optional([](auto&&...){});
	o.reset();
	return o;
}

int main() {
	f(std::make_optional([](int){}));
	f(nullopt_lambda());

	std::cout << "NAJS" << std::endl;
	return 0;
}
