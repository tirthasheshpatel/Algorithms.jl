CC          := gcc
LINKER      := $(CC)
CFLAGS      := -O3 -m64 -mavx2 -std=c99 -march=native -fopenmp -D_POSIX_C_SOURCE=200809L
FFLAGS      := $(CFLAGS)

NREPEATS    := 3
NFIRST      := 5000
NLAST_SMALL := 10000
NLAST       := 1500000
NINC        := 50000

LDFLAGS     := -lpthread -m64 -lm -fopenmp

UTIL_OBJS   := cutil/FLA_Clock.o cutil/RandomMatrix.o
SRC_OBJS    := csrc/counting.o csrc/quick.o driver.o

jl_sorts:
	make julia_merge_sort
	make julia_quick_sort
	make julia_counting_sort
	make julia_inbuilt_sort
	make plot

c_sorts:
	make c_quick_sort
	make c_counting_sort
	make clean

# Build the driver for benchmarking c algorithms.
driver.x: $(UTIL_OBJS) $(SRC_OBJS)
	$(LINKER) $(UTIL_OBJS) $(SRC_OBJS) -o driver.x $(LDFLAGS)

# Build all the sorting algos for c
c_quick_sort: driver.x
	./driver.x quick $(NREPEATS) $(NFIRST) $(NLAST) $(NINC) > outputs/c_quick_sort.csv

c_counting_sort: driver.x
	./driver.x counting $(NREPEATS) $(NFIRST) $(NLAST) $(NINC) > outputs/c_counting_sort.csv

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

clean:
	rm -f *.x *.o cutil/*.o csrc/*.o
