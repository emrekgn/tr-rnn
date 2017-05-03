#!/usr/bin/env python
# -*- coding: utf-8 -*-

from ebooklib import epub
from HTMLParser import HTMLParser
import re
import sys


class HTMLStripper(HTMLParser):
    def __init__(self):
        self.reset()
        self.fed = []

    def handle_data(self, d):
        self.fed.append(d)

    def get_data(self):
        return ''.join(self.fed)


def main():
    f = open(sys.argv[2], 'a+')
    book = epub.read_epub(sys.argv[1])
    stripper = HTMLStripper()
    for chapter in book.get_items_of_type(9):
        stripper.feed(chapter.content)
    # Remove redundant new lines
    f.write(re.sub(r'(\\r|\\n\\n|\\n\\n\\n)+', '', stripper.get_data()))
    f.close()

if __name__ == '__main__':
    main()
