#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

const char PASSHELPER[] = "/usr/share/harbour-acid-pass/helper/acid-passhelper.sh";

int main(void) {
    if (setuid(0) != 0) {
        perror("Setuid failed, no suid-bit set?");
        return 1;
    }
    execlp(PASSHELPER, PASSHELPER, (char*)NULL);
    perror(PASSHELPER);
    return 0;
}
