# 'Y' is a vowel and consonant, but the answer put 'Y' as a consonant
vowels = 'AEIOU'
kevin = 0
stuart = 0

s = raw_input()
l = len(s)

for i in xrange(l):
    if s[i] in vowels:
        kevin += l - i
    else:
        stuart += l - i

if kevin > stuart:
    print 'Kevin ' + str(kevin)
elif kevin == stuart:
    print 'Draw'
else:
    print 'Stuart ' + str(stuart)