def read_ints():
    return [int(x) for x in raw_input().split()]

k, m = read_ints()
lists = []

for i in xrange(k):
    lists.append([(x % m)**2 % m for x in read_ints()[1:]])

def add_list(vector1, vector2):
    sum = []
    for num in vector1:
        sum += [x + num for x in vector2]
    return sum

print max([x % m for x in reduce(add_list, lists)])