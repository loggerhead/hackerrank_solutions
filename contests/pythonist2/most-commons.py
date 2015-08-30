commons = dict()
counter = dict()

def key(item):
    return item[1]*128 + 128-ord(item[0])

for c in raw_input():
    counter[c] = counter.get(c, 0) + 1

for k, v in counter.items():
    if len(commons) < 3:
        commons[k] = v
    else:
        min_item = min(commons.items(), key=key)
        commons.pop(min_item[0])
        max_item = max(min_item, (k, v), key=key)
        commons[max_item[0]] = max_item[1]

for item in sorted(commons.items(), key=key, reverse=True):
    print "%s %d" % item