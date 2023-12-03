# How to generate a trace

1. Clone [this]([https://github.com/uchuhimo/]) repository in `~`.
2. Go to the correct folder to build PIN: `cd ~/pin-3.11-97998-g7ecce2dac-gcc-linux/source/tools`
3. Build PIN: `make`
4. Export PIN root: `export PIN_ROOT=~/pin-3.11-97998-g7ecce2dac-gcc-linux`
5. Go to the folder of the tracer: `cd $PYTHIA_HOME/tracer`
6. Build the tracer: `./make_tracer.sh`
7. If exists, remove the old trace from the `traces` folder `rm ../traces/trace_name.champsimtrace.xz`
8. Make the trace of your program: `$PIN_ROOT/pin -t obj-intel64/champsim_tracer.so -o ../traces/trace_name.champsimtrace -- <your program here>`. Among the available options there is:

```
-o
Specify the output file for your trace.
The default is default_trace.champsim

-s <number>
Specify the number of instructions to skip in the program before tracing begins.
The default value is 0.

-t <number>
The number of instructions to trace, after -s instructions have been skipped.
The default value is 1,000,000.
```

9.  Compress the trace `xz -z ../traces/trace_name.champsimtrace`
10. Add the trace to a `tlist` file in `$PYTHIA_HOME/experiments`