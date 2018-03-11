#include <iostream>
#include <fstream>
#include <sstream>
#include <variant>
#include <utility>
#include <memory>
#include <vector>
#include <optional>

struct A{
	A() { std::cout << "A()\n"; } 
	A(const A&) { std::cout << "A(const A&)\n"; }

	A(A&&) { std::cout << "Move ctor\n"; } 
	A& operator=(A&&) { std::cout << "Move assign\n"; } 
};

template <class T>
void fff(T&) {
	static_assert(std::is_same_v<T, const A>);
}

int main() {

	std::cout << sizeof(unsigned long) << std::endl;
	return 0;
}
