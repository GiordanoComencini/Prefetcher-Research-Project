#!/bin/bash
#
#
#
# Traces:
#    605.mcf_s-472B
#    649.fotonik3d_s-1B
#    MNIST_NN
#
#
# Experiments:
#    nopref: --warmup_instructions=100000 --simulation_instructions=500000 --config=$(PYTHIA_HOME)/config/nopref.ini
#    bingo: --warmup_instructions=100000 --simulation_instructions=500000 --l2c_prefetcher_types=bingo --config=$(PYTHIA_HOME)/config/bingo.ini
#    pythia: --warmup_instructions=100000 --simulation_instructions=500000 --l2c_prefetcher_types=scooby --config=$(PYTHIA_HOME)/config/pythia.ini
#    spt_v2: --warmup_instructions=100000 --simulation_instructions=500000 --l2c_prefetcher_types=spt_v2 --config=$(PYTHIA_HOME)/config/spt_v2.ini
#    sfp: --warmup_instructions=100000 --simulation_instructions=500000 --l2c_prefetcher_types=sfp --config=$(PYTHIA_HOME)/config/sfp.ini
#    sp_ghb: --warmup_instructions=100000 --simulation_instructions=500000 --l2c_prefetcher_types=sp_ghb --config=$(PYTHIA_HOME)/config/sp_ghb.ini
#
#
#
#
/home/pcineverdies/Projects/RM4ES/Prefetcher-Research-Project/bin/perceptron-multi-multi-no-ship-1core --warmup_instructions=100000 --simulation_instructions=500000 --config=/home/pcineverdies/Projects/RM4ES/Prefetcher-Research-Project/config/nopref.ini  -traces /home/pcineverdies/Projects/RM4ES/Prefetcher-Research-Project/traces/605.mcf_s-472B.champsimtrace.xz > 605.mcf_s-472B_nopref.out 2>&1
/home/pcineverdies/Projects/RM4ES/Prefetcher-Research-Project/bin/perceptron-multi-multi-no-ship-1core --warmup_instructions=100000 --simulation_instructions=500000 --l2c_prefetcher_types=bingo --config=/home/pcineverdies/Projects/RM4ES/Prefetcher-Research-Project/config/bingo.ini  -traces /home/pcineverdies/Projects/RM4ES/Prefetcher-Research-Project/traces/605.mcf_s-472B.champsimtrace.xz > 605.mcf_s-472B_bingo.out 2>&1
/home/pcineverdies/Projects/RM4ES/Prefetcher-Research-Project/bin/perceptron-multi-multi-no-ship-1core --warmup_instructions=100000 --simulation_instructions=500000 --l2c_prefetcher_types=scooby --config=/home/pcineverdies/Projects/RM4ES/Prefetcher-Research-Project/config/pythia.ini  -traces /home/pcineverdies/Projects/RM4ES/Prefetcher-Research-Project/traces/605.mcf_s-472B.champsimtrace.xz > 605.mcf_s-472B_pythia.out 2>&1
/home/pcineverdies/Projects/RM4ES/Prefetcher-Research-Project/bin/perceptron-multi-multi-no-ship-1core --warmup_instructions=100000 --simulation_instructions=500000 --l2c_prefetcher_types=spt_v2 --config=/home/pcineverdies/Projects/RM4ES/Prefetcher-Research-Project/config/spt_v2.ini  -traces /home/pcineverdies/Projects/RM4ES/Prefetcher-Research-Project/traces/605.mcf_s-472B.champsimtrace.xz > 605.mcf_s-472B_spt_v2.out 2>&1
/home/pcineverdies/Projects/RM4ES/Prefetcher-Research-Project/bin/perceptron-multi-multi-no-ship-1core --warmup_instructions=100000 --simulation_instructions=500000 --l2c_prefetcher_types=sfp --config=/home/pcineverdies/Projects/RM4ES/Prefetcher-Research-Project/config/sfp.ini  -traces /home/pcineverdies/Projects/RM4ES/Prefetcher-Research-Project/traces/605.mcf_s-472B.champsimtrace.xz > 605.mcf_s-472B_sfp.out 2>&1
/home/pcineverdies/Projects/RM4ES/Prefetcher-Research-Project/bin/perceptron-multi-multi-no-ship-1core --warmup_instructions=100000 --simulation_instructions=500000 --l2c_prefetcher_types=sp_ghb --config=/home/pcineverdies/Projects/RM4ES/Prefetcher-Research-Project/config/sp_ghb.ini  -traces /home/pcineverdies/Projects/RM4ES/Prefetcher-Research-Project/traces/605.mcf_s-472B.champsimtrace.xz > 605.mcf_s-472B_sp_ghb.out 2>&1
/home/pcineverdies/Projects/RM4ES/Prefetcher-Research-Project/bin/perceptron-multi-multi-no-ship-1core --warmup_instructions=100000 --simulation_instructions=500000 --config=/home/pcineverdies/Projects/RM4ES/Prefetcher-Research-Project/config/nopref.ini  -traces /home/pcineverdies/Projects/RM4ES/Prefetcher-Research-Project/traces/649.fotonik3d_s-1B.champsimtrace.xz > 649.fotonik3d_s-1B_nopref.out 2>&1
/home/pcineverdies/Projects/RM4ES/Prefetcher-Research-Project/bin/perceptron-multi-multi-no-ship-1core --warmup_instructions=100000 --simulation_instructions=500000 --l2c_prefetcher_types=bingo --config=/home/pcineverdies/Projects/RM4ES/Prefetcher-Research-Project/config/bingo.ini  -traces /home/pcineverdies/Projects/RM4ES/Prefetcher-Research-Project/traces/649.fotonik3d_s-1B.champsimtrace.xz > 649.fotonik3d_s-1B_bingo.out 2>&1
/home/pcineverdies/Projects/RM4ES/Prefetcher-Research-Project/bin/perceptron-multi-multi-no-ship-1core --warmup_instructions=100000 --simulation_instructions=500000 --l2c_prefetcher_types=scooby --config=/home/pcineverdies/Projects/RM4ES/Prefetcher-Research-Project/config/pythia.ini  -traces /home/pcineverdies/Projects/RM4ES/Prefetcher-Research-Project/traces/649.fotonik3d_s-1B.champsimtrace.xz > 649.fotonik3d_s-1B_pythia.out 2>&1
/home/pcineverdies/Projects/RM4ES/Prefetcher-Research-Project/bin/perceptron-multi-multi-no-ship-1core --warmup_instructions=100000 --simulation_instructions=500000 --l2c_prefetcher_types=spt_v2 --config=/home/pcineverdies/Projects/RM4ES/Prefetcher-Research-Project/config/spt_v2.ini  -traces /home/pcineverdies/Projects/RM4ES/Prefetcher-Research-Project/traces/649.fotonik3d_s-1B.champsimtrace.xz > 649.fotonik3d_s-1B_spt_v2.out 2>&1
/home/pcineverdies/Projects/RM4ES/Prefetcher-Research-Project/bin/perceptron-multi-multi-no-ship-1core --warmup_instructions=100000 --simulation_instructions=500000 --l2c_prefetcher_types=sfp --config=/home/pcineverdies/Projects/RM4ES/Prefetcher-Research-Project/config/sfp.ini  -traces /home/pcineverdies/Projects/RM4ES/Prefetcher-Research-Project/traces/649.fotonik3d_s-1B.champsimtrace.xz > 649.fotonik3d_s-1B_sfp.out 2>&1
/home/pcineverdies/Projects/RM4ES/Prefetcher-Research-Project/bin/perceptron-multi-multi-no-ship-1core --warmup_instructions=100000 --simulation_instructions=500000 --l2c_prefetcher_types=sp_ghb --config=/home/pcineverdies/Projects/RM4ES/Prefetcher-Research-Project/config/sp_ghb.ini  -traces /home/pcineverdies/Projects/RM4ES/Prefetcher-Research-Project/traces/649.fotonik3d_s-1B.champsimtrace.xz > 649.fotonik3d_s-1B_sp_ghb.out 2>&1
/home/pcineverdies/Projects/RM4ES/Prefetcher-Research-Project/bin/perceptron-multi-multi-no-ship-1core --warmup_instructions=100000 --simulation_instructions=500000 --config=/home/pcineverdies/Projects/RM4ES/Prefetcher-Research-Project/config/nopref.ini  -traces /home/pcineverdies/Projects/RM4ES/Prefetcher-Research-Project/traces/MNIST_NN.champsimtrace.xz > MNIST_NN_nopref.out 2>&1
/home/pcineverdies/Projects/RM4ES/Prefetcher-Research-Project/bin/perceptron-multi-multi-no-ship-1core --warmup_instructions=100000 --simulation_instructions=500000 --l2c_prefetcher_types=bingo --config=/home/pcineverdies/Projects/RM4ES/Prefetcher-Research-Project/config/bingo.ini  -traces /home/pcineverdies/Projects/RM4ES/Prefetcher-Research-Project/traces/MNIST_NN.champsimtrace.xz > MNIST_NN_bingo.out 2>&1
/home/pcineverdies/Projects/RM4ES/Prefetcher-Research-Project/bin/perceptron-multi-multi-no-ship-1core --warmup_instructions=100000 --simulation_instructions=500000 --l2c_prefetcher_types=scooby --config=/home/pcineverdies/Projects/RM4ES/Prefetcher-Research-Project/config/pythia.ini  -traces /home/pcineverdies/Projects/RM4ES/Prefetcher-Research-Project/traces/MNIST_NN.champsimtrace.xz > MNIST_NN_pythia.out 2>&1
/home/pcineverdies/Projects/RM4ES/Prefetcher-Research-Project/bin/perceptron-multi-multi-no-ship-1core --warmup_instructions=100000 --simulation_instructions=500000 --l2c_prefetcher_types=spt_v2 --config=/home/pcineverdies/Projects/RM4ES/Prefetcher-Research-Project/config/spt_v2.ini  -traces /home/pcineverdies/Projects/RM4ES/Prefetcher-Research-Project/traces/MNIST_NN.champsimtrace.xz > MNIST_NN_spt_v2.out 2>&1
/home/pcineverdies/Projects/RM4ES/Prefetcher-Research-Project/bin/perceptron-multi-multi-no-ship-1core --warmup_instructions=100000 --simulation_instructions=500000 --l2c_prefetcher_types=sfp --config=/home/pcineverdies/Projects/RM4ES/Prefetcher-Research-Project/config/sfp.ini  -traces /home/pcineverdies/Projects/RM4ES/Prefetcher-Research-Project/traces/MNIST_NN.champsimtrace.xz > MNIST_NN_sfp.out 2>&1
/home/pcineverdies/Projects/RM4ES/Prefetcher-Research-Project/bin/perceptron-multi-multi-no-ship-1core --warmup_instructions=100000 --simulation_instructions=500000 --l2c_prefetcher_types=sp_ghb --config=/home/pcineverdies/Projects/RM4ES/Prefetcher-Research-Project/config/sp_ghb.ini  -traces /home/pcineverdies/Projects/RM4ES/Prefetcher-Research-Project/traces/MNIST_NN.champsimtrace.xz > MNIST_NN_sp_ghb.out 2>&1
