import sys
from os import listdir
from os.path import isfile, join, split
from pprint import pprint

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
np.random.seed(420)


def color_gen(n):
    colors = np.random.rand(n, 3)
    while n != 0:
        yield colors[n-1]
        n -= 1


if __name__ == '__main__':
    print(f"Plotting results in the directory {sys.argv[1]}...")
    color = color_gen(100)
    files = [join(sys.argv[1], f) for f in listdir(sys.argv[1]) if isfile(join(sys.argv[1], f))]
    pprint(files)
    for f in files:
        results = pd.read_csv(f).values
        _, name = split(f)
        c = next(color)
        plt.scatter(results[:, 0], results[:, 1], label=f"{' '.join(name.split('_'))}", color=c)
        plt.plot(   results[:, 0], results[:, 1], label=f"{' '.join(name.split('_'))}", color=c)
    plt.legend()
    plt.xlabel("Size of the array.")
    plt.ylabel("Time (ns)")
    plt.savefig("sort_benchmarks.png")
