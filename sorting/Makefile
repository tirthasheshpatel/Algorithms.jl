CC          := g++
LINKER      := $(CC)
CFLAGS      := -O3 -m64 -mavx2 -std=c99 -march=native -fopenmp -D_POSIX_C_SOURCE=200809L
FFLAGS      := $(CFLAGS)

NREPEATS    := 3
NFIRST      := 50
NLAST_SMALL := 500
NLAST       := 1500
NINC        := 50

LDFLAGS     := -lpthread -m64 -lm -fopenmp

# Benchmarking Julia's sorting algorithms
julia_merge_sort:
	julia driver.jl merge    $(NREPEATS) $(NFIRST) $(NLAST) $(NINC) "outputs/julia_merge_sort.csv"

julia_quick_sort:
	julia driver.jl quick    $(NREPEATS) $(NFIRST) $(NLAST) $(NINC) "outputs/julia_quick_sort.csv"

julia_counting_sort:
	julia driver.jl counting $(NREPEATS) $(NFIRST) $(NLAST) $(NINC) "outputs/julia_counting_sort.csv"

julia_inbuilt_sort:
	julia driver.jl inbuilt  $(NREPEATS) $(NFIRST) $(NLAST) $(NINC) "outputs/julia_inbuilt_sort.csv"

plot:
	python plotter.py outputs

all:
	make julia_merge_sort
	make julia_quick_sort
	make julia_counting_sort
	make julia_inbuilt_sort
	make plot
