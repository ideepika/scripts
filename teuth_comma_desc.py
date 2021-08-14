#!/usr/bin/env python3
import re
description = input("enter description string: ")

regex = re.compile("\ |\/|\{|\}")
filter = regex.sub(",", (description.lstrip('{').rstrip('}')))
print(filter)
