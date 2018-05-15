#include <atomic>
#include <mutex>
#include <iostream>
#include <chrono>
#include <thread>
#include <vector>
#include <numeric>
 
int main()
{
#define NNN 10000

#if 1
			std::vector<int> bbb;
			bbb.resize(NNN);
			std::atomic<int> i = 0;
			//int i = 0;

			auto do_work = [&]() {
				while (true) {
					const auto n = i.fetch_add(1, std::memory_order_relaxed);
					//const auto n = i++;

					if (n < NNN) {
						bbb[n] = n;
					}
					else {
						break;
					}
				}
			};

			auto pr = [&]() {
				std::cout << (std::accumulate(bbb.begin(), bbb.end(), 0));
			};
#elif 0

			std::vector<int> bbb;
			bbb.resize(NNN);

			auto q = moodycamel::ConcurrentQueue<int>(NNN);

			{
				for (int i = 0; i < NNN; ++i) {
					q.enqueue(i);
				}
			}

			auto do_work = [&]() {
				int co;

				while (q.try_dequeue(co)) {
					bbb[co] = 1;
				}
			};

			auto pr = [&]() {
				LOG_NVPS(std::accumulate(bbb.begin(), bbb.end(), 0));
			};
#else
			long long data = 0;

			auto add = [&]() {
				++data;
			};

			auto pr = [&]() {
				LOG_NVPS(data);
			};
#endif

			std::thread th1(do_work);
			std::thread th2(do_work);
			std::thread th3(do_work);
			std::thread th4(do_work);
			std::thread th5(do_work);

			th1.join();
			th2.join();
			th3.join();
			th4.join();
			th5.join();

			pr();
}
