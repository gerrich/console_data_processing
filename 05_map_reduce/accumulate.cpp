#include <numeric>
#include <iterator>
#include <iostream>
#include <functional>

int main() {
    std::istream_iterator<int> int_begin(std::cin), int_end;
    int result = std::accumulate(int_begin, int_end, 0, std::plus<int>());
    std::cout << result << std::endl;
    return 0;
};
