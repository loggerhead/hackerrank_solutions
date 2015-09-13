#include <stdio.h>
#include <string.h>

char *num2word(int num)
{
    static char *words[] = { "",
        "one", "two", "three", "four", "five",
        "six", "seven", "eight", "nine", "ten",
        "eleven", "twelve", "thirteen", "fourteen", "fifteen",
        "sixteen", "seventeen", "eighteen", "nineteen", "twenty"
    };
    static char buffer[1024] = {0};

    if (num <= 20)
        return words[num];
    else {
        sprintf(buffer, "%s %s", words[20], words[num-20]);
        return buffer;
    }
}

int main()
{

    int h, m;
    char *toOrPast = "past";
    scanf("%d%d", &h, &m);

    if (m > 30) {
        m = 60 - m;
        toOrPast = "to";
        h++;
    }

    if (m == 0)
        printf("%s o' clock\n", num2word(h));
    else if (m == 1)
        printf("one minute %s %s\n", toOrPast, num2word(h));
    else if (m == 15)
        printf("quarter %s %s\n", toOrPast, num2word(h));
    else if (m < 30)
        printf("%s minutes %s %s\n", num2word(m), toOrPast, num2word(h));
    else if (m == 30)
        printf("half past %s\n", num2word(h));

    return 0;
}