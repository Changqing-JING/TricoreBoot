#include <array>
#include <cstdio>
#include <cstdlib>

extern "C" {
void asmQuickSort(int list[], int left, int right);
}

std::array<int, 5> arr1 = {7, 3, 8, 9, 6};
std::array<int, 5> arr2;

static int division(int list[], int left, int right) {
  int base = list[left];
  while (left < right) {
    while (left < right && list[right] >= base) {
      right--;
    }
    list[left] = list[right];

    while (left < right && list[left] <= base) {
      left++;
    }
    list[right] = list[left];
  }

  list[left] = base;

  return left;
}

static void quickSort(int list[], int left, int right) {

  if (left < right) {

    int base = division(list, left, right);

    quickSort(list, left, base - 1);

    quickSort(list, base + 1, right);
  }
}

int main() {

  arr2 = arr1;
  quickSort(arr1.data(), 0, arr1.size() - 1);

  asmQuickSort(arr2.data(), 0, arr2.size() - 1);

  return 0;
}