#!/usr/bin/env python3

import re

data = input("paste to convert redmine fmt")

re.sub("```", "<pre>", data)
