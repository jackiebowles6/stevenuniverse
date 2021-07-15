# -*- coding: utf-8 -*-
"""
Created on Tue Jun  1 09:06:26 2021

@author: JMaddox
"""

random = ['e', 'h', 'f', 'h', 'j', 'b', 'j', 'b', 'a', 'c']

random.sort()
print(random)

random.sort(reverse=True)
print(random)

unique = set(random)
print (sorted(unique))
