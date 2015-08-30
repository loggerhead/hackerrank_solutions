N, M = map(int,raw_input().split())

def print_lines(n, m, reverse=False):
    print '\n'.join([(m-(6*i-3))/2 * '-' + (2*i-1) * '.|.' + (m-(6*i-3))/2 * '-' for i in xrange(1, n+1)][::-1 if reverse else 1])

print_lines((N-1)/2, M)
print (M-7)/2 * '-' + 'WELCOME' + (M-7)/2 * '-'
print_lines((N-1)/2, M, reverse=True)