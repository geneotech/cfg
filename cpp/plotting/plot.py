#!/usr/bin/env python
import matplotlib.pyplot as plt
import numpy as np

x, y = np.loadtxt('points.txt', delimiter=',', unpack=True)
plt.plot(x,y, label='Data', linewidth=0.5)

plt.xlabel('x')
plt.ylabel('y')
plt.title('Graph')
plt.legend()
plt.show()
