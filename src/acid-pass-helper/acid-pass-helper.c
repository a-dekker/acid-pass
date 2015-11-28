#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main(void) {
    if (setuid(0) != 0) {
        perror("Setuid failed, no suid-bit set?");
        return 1;
    }
    setuid(0);
    system("/usr/share/harbour-acid-pass/helper/acid-passhelper.sh");
    return 0;
}
