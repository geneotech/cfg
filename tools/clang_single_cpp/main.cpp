// DONT BUILD THIS WITH F7 !!!!!!
// The script is supposed to run from shell
#include <iostream>
#include <variant>

struct A {

};

struct B {

};

int main() {
	B b;
	A a;

	a = b;
	b = a;

		std::cout<<1<<std::endl;
	std::variant<int, double> variant_test;
	variant_test = 0;
	return std::get<int>(variant_test);
}
