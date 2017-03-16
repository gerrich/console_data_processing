#include <cstdio>
#include <vector>

int main() {
    const size_t sz = 1024 * 1024;
    std::vector<char> buff(sz);

    while(true) {
        size_t count = fread(&buff[0], 1, sz, stdin);
        if (count == 0) break;
        fwrite(&buff[0], 1, count, stdout);
    }
    return 0;
}
