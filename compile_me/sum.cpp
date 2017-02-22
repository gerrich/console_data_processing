#include <cstdio>
#include <inttypes.h>

int main() {
  int64_t sum = 0;
  int64_t value = 0 ;
  while(scanf("%" SCNd64, &value) == 1) {
    sum += value;
  }
  printf("%" PRId64"\n", sum);
  return 0;
}
