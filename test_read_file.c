/// @file test_read_file.c
#include <stdio.h>

char buffer[100];

int main() {
  const char *path = __FILE__;
  FILE *f = fopen(path, "rb");

  if (f) {
    fseek(f, 0, SEEK_END);
    long length = ftell(f);
    fseek(f, 0, SEEK_SET);

    length = length < ((int)sizeof(buffer)) ? length : sizeof(buffer);

    long res = fread(buffer, 1, length, f);

    fclose(f);

    printf("file content %d byte is:\n", (int)res);
    for (int i = 0; i < res; i++) {
      printf("%x", buffer[i]);
    }
    printf("\n");

    printf("string conetent is: %s\n", buffer);
  }
  return 0;
}