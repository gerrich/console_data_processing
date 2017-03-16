#include <cstdio>
#include <vector>

template <typename action_t>
void process_line(FILE* fin, action_t &action) {
  const size_t sz = 1024 * 1024;
  std::vector<char> buff(sz);
  
  while(true) { 
    char *data = fgets(&buff[0], sz, fin);
    if (!data) break;
    size_t len = strlen(data);
    if (len > 0 && data[len - 1]=='\n') data[len - 1] = '\0';
    action(data);
  }
}

struct agg_t {
    int stat;

    agg_t(): stat(0) {}
    void operator()(const char* data) {
        int value = 0;
        if (sscanf(data, "%d", &value)) {
          stat += value;
        }
    }
    void commit() {}
};

int main() {
  agg_t agg;
  process_line(stdin, agg);
  printf("%d\n", agg.stat);
  return 0;
}
