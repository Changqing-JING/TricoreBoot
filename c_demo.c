

int main() {
  // Declare a variable to hold the address
  unsigned int address = 0xd00086a6;

  // Inline assembly to load the address into a14 and perform ld.a %a14, [%a14]
  asm volatile("mov.aa %%a12, %%a14 \n"
               "mov.a %%a14, %0 \n\t"
               "ld.a %%a14, [%%a14] \n"
               "mov.aa %%a14, %%a12 \n"
               :              // No output operands
               : "d"(address) // Input operand

  );

  return 0;
}