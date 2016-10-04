# coding=utf-8

import os

class Path:
    def __init__(self, filename):
        self.filename = filename

    def dirname(self):
        return os.path.split(self.filename)[0]

    def parentDir(self):
        return Path(os.path.realpath(os.path.join(self.dirname(), '..')))

    def append(self, name):
        return Path(os.path.realpath(os.path.join(self.filename, name)))

    def __str__(self):
        return os.path.realpath(self.filename)




if __name__ == '__main__':
    pp = Path('asd/baaaa')
    print pp.dirname()
    print pp.parentDir()
