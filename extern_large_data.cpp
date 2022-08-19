
#include <cstdlib>
constexpr unsigned int arraySize = 1024 * 1024 * 2;

unsigned char arr_bss[arraySize];

extern unsigned char *p_arr_data;
extern unsigned int arr_data_size;

int main() {

  for (unsigned int i = 0; i < arraySize; i++) {
    arr_bss[i] = i % 256U;
  }

  for (unsigned int i = 0; i < arraySize; i++) {
    if (arr_bss[i] != i % 256U) {
      abort();
    }
  }

  for (unsigned int i = 0; i < arr_data_size; i++) {
    if (p_arr_data[i] != i % 256U) {
      abort();
    }
  }

  return 0;
}