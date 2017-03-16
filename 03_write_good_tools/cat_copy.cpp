#include <iostream>
#include <iterator>
#include <algorithm>

int main() {
    std::ios::sync_with_stdio(false);

    std::istreambuf_iterator<char> in_begin(std::cin), in_end;
    std::ostreambuf_iterator<char> out_begin(std::cout);
    std::copy(in_begin, in_end, out_begin);
    return 0;
}
