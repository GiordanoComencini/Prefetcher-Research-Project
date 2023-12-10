#!/bin/bash
#
#
#
# Traces:
#    638.imagick_s-10316B.champsimtrace
#
#
# Experiments:
#    nopref: --warmup_instructions=1000000 --simulation_instructions=5000000 --config=$(PYTHIA_HOME)/config/nopref.ini
#    bingo: --warmup_instructions=1000000 --simulation_instructions=5000000 --l2c_prefetcher_types=bingo --config=$(PYTHIA_HOME)/config/bingo.ini
#    pythia: --warmup_instructions=1000000 --simulation_instructions=5000000 --l2c_prefetcher_types=scooby --config=$(PYTHIA_HOME)/config/pythia.ini
#    spt_v2: --warmup_instructions=1000000 --simulation_instructions=5000000 --l2c_prefetcher_types=spt_v2 --config=$(PYTHIA_HOME)/config/spt_v2.ini
#    sp_ghb: --warmup_instructions=1000000 --simulation_instructions=5000000 --l2c_prefetcher_types=sp_ghb --config=$(PYTHIA_HOME)/config/sp_ghb.ini
#    sfp: --warmup_instructions=1000000 --simulation_instructions=5000000 --l2c_prefetcher_types=sfp --config=$(PYTHIA_HOME)/config/sfp.ini
#    sp_ghb: --warmup_instructions=1000000 --simulation_instructions=5000000 --l2c_prefetcher_types=sp_ghb --config=$(PYTHIA_HOME)/config/sp_ghb.ini
#
#
#
#
/home/gio/Prefetcher-Research-Project/bin/perceptron-multi-multi-no-ship-1core --warmup_instructions=1000000 --simulation_instructions=5000000 --config=/home/gio/Prefetcher-Research-Project/config/nopref.ini  -traces /home/gio/Prefetcher-Research-Project/traces/638.imagick_s-10316B.champsimtrace.xz > 638.imagick_s-10316B.champsimtrace_nopref.out 2>&1
/home/gio/Prefetcher-Research-Project/bin/perceptron-multi-multi-no-ship-1core --warmup_instructions=1000000 --simulation_instructions=5000000 --l2c_prefetcher_types=bingo --config=/home/gio/Prefetcher-Research-Project/config/bingo.ini  -traces /home/gio/Prefetcher-Research-Project/traces/638.imagick_s-10316B.champsimtrace.xz > 638.imagick_s-10316B.champsimtrace_bingo.out 2>&1
/home/gio/Prefetcher-Research-Project/bin/perceptron-multi-multi-no-ship-1core --warmup_instructions=1000000 --simulation_instructions=5000000 --l2c_prefetcher_types=scooby --config=/home/gio/Prefetcher-Research-Project/config/pythia.ini  -traces /home/gio/Prefetcher-Research-Project/traces/638.imagick_s-10316B.champsimtrace.xz > 638.imagick_s-10316B.champsimtrace_pythia.out 2>&1
/home/gio/Prefetcher-Research-Project/bin/perceptron-multi-multi-no-ship-1core --warmup_instructions=1000000 --simulation_instructions=5000000 --l2c_prefetcher_types=spt_v2 --config=/home/gio/Prefetcher-Research-Project/config/spt_v2.ini  -traces /home/gio/Prefetcher-Research-Project/traces/638.imagick_s-10316B.champsimtrace.xz > 638.imagick_s-10316B.champsimtrace_spt_v2.out 2>&1
/home/gio/Prefetcher-Research-Project/bin/perceptron-multi-multi-no-ship-1core --warmup_instructions=1000000 --simulation_instructions=5000000 --l2c_prefetcher_types=sp_ghb --config=/home/gio/Prefetcher-Research-Project/config/sp_ghb.ini  -traces /home/gio/Prefetcher-Research-Project/traces/638.imagick_s-10316B.champsimtrace.xz > 638.imagick_s-10316B.champsimtrace_sp_ghb.out 2>&1
/home/gio/Prefetcher-Research-Project/bin/perceptron-multi-multi-no-ship-1core --warmup_instructions=1000000 --simulation_instructions=5000000 --l2c_prefetcher_types=sfp --config=/home/gio/Prefetcher-Research-Project/config/sfp.ini  -traces /home/gio/Prefetcher-Research-Project/traces/638.imagick_s-10316B.champsimtrace.xz > 638.imagick_s-10316B.champsimtrace_sfp.out 2>&1
/home/gio/Prefetcher-Research-Project/bin/perceptron-multi-multi-no-ship-1core --warmup_instructions=1000000 --simulation_instructions=5000000 --l2c_prefetcher_types=sp_ghb --config=/home/gio/Prefetcher-Research-Project/config/sp_ghb.ini  -traces /home/gio/Prefetcher-Research-Project/traces/638.imagick_s-10316B.champsimtrace.xz > 638.imagick_s-10316B.champsimtrace_sp_ghb.out 2>&1
