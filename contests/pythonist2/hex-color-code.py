import re
import sys

_n = raw_input("")
css_code = "".join(sys.stdin.readlines())

patval = r'[\w\-_0-9]+:\s*(.*?);'
values = re.findall(patval, css_code)

pathex = r'(#([a-fA-F0-9]{3}){1,2})'
results = []
for value in values:
    result = re.findall(pathex, value) 
    if result:
        map(lambda groups: results.append(groups[0]), result)

print "\n".join(results)
