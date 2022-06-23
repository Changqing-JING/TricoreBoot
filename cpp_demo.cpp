#include <filesystem>
#include <fstream>
#include <iostream>
#include <string>
#include <vector>

void printTextFile(const char *filename) {
  std::vector<char> buffer;

  FILE *f = fopen(filename, "rb");

  if (f) {
    fseek(f, 0, SEEK_END);
    long length = ftell(f);
    fseek(f, 0, SEEK_SET);
    buffer.resize(length);

    fread(buffer.data(), 1, length, f);

    fclose(f);
  }

  std::cout << buffer.data();
}

int main() {
  const char *path = __FILE__;

  std::filesystem::path currentFilePath(__FILE__);
  std::filesystem::path projectRoot = currentFilePath.parent_path();

  std::cout << "workspace folder is " << projectRoot.string() << std::endl;

  printTextFile(path);
  return 0;
}