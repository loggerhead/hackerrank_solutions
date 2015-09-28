#include <stdio.h>

int main()
{
    int n, m;
    int fst, num;
    int buf[202] = { 0 };

    scanf("%d", &n);
    scanf("%d", &fst);
    buf[101]++;
    for (int i = 1; i < n; i++) {
        scanf("%d", &num);
        buf[num - fst + 101]++;
    }

    scanf("%d", &m);
    for (int i = 0; i < m; i++) {
        scanf("%d", &num);
        buf[num - fst + 101]--;
    }

    for (int i = 0; i < 202; i++) {
        if (buf[i] < 0)
            printf("%d ", i + fst - 101);
    }
    printf("\n");

    return 0;
}