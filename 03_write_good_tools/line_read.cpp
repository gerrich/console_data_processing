#include <cstdio>
#include <vector>

int main() {
  const size_t sz = 1024 * 1024;
  std::vector<char> buff(sz);
 
  while(true) { 
    char *data = fgets(&buff[0], sz, stdin);
    if (!data) break;
    printf("str: [%s]\n", data);
  }
  return 0;
}
