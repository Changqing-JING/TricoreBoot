#include <stdint.h>

typedef union {
  uint64_t i;
  double d;
} U;

int main() {
  U u1;
  U u2;
  U u3;
  u1.i = 0x4000000000000000;
  return u3.i;
}