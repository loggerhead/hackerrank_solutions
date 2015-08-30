import sys
from HTMLParser import HTMLParser

_n = raw_input()
html_code = sys.stdin.read()

class MyHTMLParser(HTMLParser):
    def handle_starttag(self, tag, attrs):
        print tag
        for attr in attrs:
            print "-> %s > %s" % attr

MyHTMLParser().feed(html_code)