#!/usr/bin/env python
# coding: utf-8

# ### Assignment 1
# 
# Problem 3.3
from __future__ import print_function, division

import sys
sys.path.insert(0, '../ThinkDSP/code')#lazy way to import folder

import thinkdsp
import thinkplot

import warnings
warnings.filterwarnings('ignore')

from IPython.html.widgets import interact, fixed
from IPython.display import display

# Sweep 
signal = SawtoothChirp(start=2500, end=3000)

# Wave Duration

wave = signal.make_wave(duration=1, framerate=20000)
wave.make_audio()

# Plot 
wave.make_spectrum().plot()