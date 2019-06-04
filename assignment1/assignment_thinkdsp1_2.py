#!/usr/bin/env python
# coding: utf-8

# ### Assignment 1
# 
# Problem 1.2

from __future__ import print_function, division

import sys
sys.path.insert(0, '../ThinkDSP/code')#lazy way to import folder

import thinkdsp
import thinkplot

import warnings
warnings.filterwarnings('ignore')

from IPython.html.widgets import interact, fixed
from IPython.display import display
import matplotlib.pyplot as plt

# load signal
wave = thinkdsp.read_wave('473826__toiletrolltube__190524-0289-electromagnets-headphones-1.wav')

# take only a portion of the signal.  Start at 2 second mark end 6 second mark
segment = wave.segment(start=2, duration=4)
segment.make_audio()

# Actual plot
#segment.plot()
[ys,ts] = segment.get_raw()
#print("ys type: ", type(ys))
#print("ts type: ", type(ts))
#print("ts val: ", ts)
plt.plot(ys)
plt.ylabel('segmented signal')
plt.show()
