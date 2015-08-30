s = raw_input()
k = int(raw_input())

def unique(part):
    seen = set()
    return ''.join([c for c in part if c not in seen and seen.add(c) == None])

for part in map(unique, zip(*[iter(s)]*k)):
    print part