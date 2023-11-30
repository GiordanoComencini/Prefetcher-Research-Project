#!/bin/bash
#
#
#
# Traces:
#    605.mcf_s-472B
#    649.fotonik3d_s-1B
#
#
# Experiments:
#    nopref: --warmup_instructions=1000000 --simulation_instructions=5000000 --config=$(PYTHIA_HOME)/config/nopref.ini
#    bingo: --warmup_instructions=1000000 --simulation_instructions=5000000 --l2c_prefetcher_types=bingo --config=$(PYTHIA_HOME)/config/bingo.ini
#    pythia: --warmup_instructions=1000000 --simulation_instructions=5000000 --l2c_prefetcher_types=scooby --config=$(PYTHIA_HOME)/config/pythia.ini
#    spt_v2: --warmup_instructions=1000000 --simulation_instructions=5000000 --l2c_prefetcher_types=spt_v2 --config=$(PYTHIA_HOME)/config/spt_v2.ini
#
#
#
#
/home/gio/Pythia/bin/perceptron-multi-multi-no-ship-1core --warmup_instructions=1000000 --simulation_instructions=5000000 --config=/home/gio/Pythia/config/nopref.ini  -traces /home/gio/Pythia/traces/605.mcf_s-472B.champsimtrace.xz > 605.mcf_s-472B_nopref.out 2>&1
/home/gio/Pythia/bin/perceptron-multi-multi-no-ship-1core --warmup_instructions=1000000 --simulation_instructions=5000000 --l2c_prefetcher_types=bingo --config=/home/gio/Pythia/config/bingo.ini  -traces /home/gio/Pythia/traces/605.mcf_s-472B.champsimtrace.xz > 605.mcf_s-472B_bingo.out 2>&1
/home/gio/Pythia/bin/perceptron-multi-multi-no-ship-1core --warmup_instructions=1000000 --simulation_instructions=5000000 --l2c_prefetcher_types=scooby --config=/home/gio/Pythia/config/pythia.ini  -traces /home/gio/Pythia/traces/605.mcf_s-472B.champsimtrace.xz > 605.mcf_s-472B_pythia.out 2>&1
/home/gio/Pythia/bin/perceptron-multi-multi-no-ship-1core --warmup_instructions=1000000 --simulation_instructions=5000000 --l2c_prefetcher_types=spt_v2 --config=/home/gio/Pythia/config/spt_v2.ini  -traces /home/gio/Pythia/traces/605.mcf_s-472B.champsimtrace.xz > 605.mcf_s-472B_spt_v2.out 2>&1
/home/gio/Pythia/bin/perceptron-multi-multi-no-ship-1core --warmup_instructions=1000000 --simulation_instructions=5000000 --config=/home/gio/Pythia/config/nopref.ini  -traces /home/gio/Pythia/traces/649.fotonik3d_s-1B.champsimtrace.xz > 649.fotonik3d_s-1B_nopref.out 2>&1
/home/gio/Pythia/bin/perceptron-multi-multi-no-ship-1core --warmup_instructions=1000000 --simulation_instructions=5000000 --l2c_prefetcher_types=bingo --config=/home/gio/Pythia/config/bingo.ini  -traces /home/gio/Pythia/traces/649.fotonik3d_s-1B.champsimtrace.xz > 649.fotonik3d_s-1B_bingo.out 2>&1
/home/gio/Pythia/bin/perceptron-multi-multi-no-ship-1core --warmup_instructions=1000000 --simulation_instructions=5000000 --l2c_prefetcher_types=scooby --config=/home/gio/Pythia/config/pythia.ini  -traces /home/gio/Pythia/traces/649.fotonik3d_s-1B.champsimtrace.xz > 649.fotonik3d_s-1B_pythia.out 2>&1
/home/gio/Pythia/bin/perceptron-multi-multi-no-ship-1core --warmup_instructions=1000000 --simulation_instructions=5000000 --l2c_prefetcher_types=spt_v2 --config=/home/gio/Pythia/config/spt_v2.ini  -traces /home/gio/Pythia/traces/649.fotonik3d_s-1B.champsimtrace.xz > 649.fotonik3d_s-1B_spt_v2.out 2>&1
