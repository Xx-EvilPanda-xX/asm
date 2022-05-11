#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <limits.h>

long ipower(long base, long exp);

void vulnerable(long arg1, long arg2, FILE* file);

void callFromStackSmash(long val)
{
  puts("called from smashed stack!\n");
  printf("value returned from asm: %lld\n\n", val);

  exit(22);
}

int main(int argc, char** argv)
{
  /*unsigned char tri_code[] = 
"\x48\x89\xe5\x48\x81\xec\xb8\x00\x00\x00\x48\x8d\x95\x48\xff\xff"
"\xff\x41\xb8\x01\x00\x00\x00\x41\xb9\x00\x00\x00\x00\xc6\x02\x7c"
"\x48\xff\xc2\xc6\x02\x40\x48\xff\xc2\x49\xff\xc1\x4d\x39\xc1\x75"
"\xf2\xc6\x02\x5c\x48\xff\xc2\xc6\x02\x0a\x48\xff\xc2\xc6\x02\x7c"
"\x48\xff\xc2\x49\xff\xc0\x41\xb9\x00\x00\x00\x00\x49\x83\xf8\x0f"
"\x7e\xd1\xc6\x02\x0a\x48\xff\xca\x48\x31\xdb\xeb\x22\xb8\x01\x00"
"\x00\x00\xbf\x01\x00\x00\x00\x48\x8d\xb5\x48\xff\xff\xff\xba\xb8"
"\x00\x00\x00\x0f\x05\xb8\x3c\x00\x00\x00\x48\x31\xff\x0f\x05\xc6"
"\x02\x60\x48\xff\xc2\x48\xff\xc3\x48\x83\xfb\x11\x7e\xf1\xc6\x02"
"\x0a\xeb\xca";*/

  //printf("Calling into the stack!\n");
  //goto *((void*) tri_code)
  if (argc != 3)
  {
    printf("Must be passed base and exp!\n\n");
    return -1;
  }
  printf("Address of function ipower: %llx\n\n", (void*) ipower);

  puts("Please enter a file path to be loaded: ");

  char fp[256];
  scanf("%256s", fp);
  FILE* file = fopen(fp, "rb");

  vulnerable(atol(argv[1]), atol(argv[2]), file);
}

void vulnerable(long arg1, long arg2, FILE* file)
{
  __asm
  (
    "push %rdi\n"
    "push %rsi\n"
  );

  char buf[16];
  fgets(buf, INT_MAX, file);
  
  puts("Ok thanks! Now I'm just gonna casually return from this function...\n");

  __asm
  (
    "pop %rsi\n"
    "pop %rdi\n"
  );
}