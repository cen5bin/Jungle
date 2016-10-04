# coding=utf-8

import os
import path


projectRoot = str(path.Path(__file__).parentDir().parentDir())
pytoolRoot = str(path.Path(projectRoot).append('script').append('pytool'))
baseRoot = str(path.Path(projectRoot).append('script').append('base'))
print baseRoot
