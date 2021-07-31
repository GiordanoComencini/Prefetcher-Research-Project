<p align="center">
  <a href="https://github.com/CMU-SAFARI/Pythia">
    <img src="logo.png" alt="Logo" width="354" height="100">
  </a>
  <h3 align="center">A Customizable Hardware Prefetching Framework Using Online Reinforcement Learning
  </h3>
</p>

<p align="center">
    <a href="https://github.com/CMU-SAFARI/Pythia/blob/master/LICENSE">
        <img alt="GitHub" src="https://img.shields.io/badge/License-MIT-yellow.svg">
    </a>
    <a href="https://github.com/CMU-SAFARI/Pythia/releases">
        <img alt="GitHub release" src="https://img.shields.io/github/release/CMU-SAFARI/Pythia">
    </a>
    <a href="https://doi.org/10.5281/zenodo.5149410"><img src="https://zenodo.org/badge/DOI/10.5281/zenodo.5149410.svg" alt="DOI"></a>
</p>

<details open="open">
  <summary>Table of Contents</summary>
  <ol>
    <li><a href="#what-is-pythia">What is Pythia?</a></li>
    <li><a href="#about-the-framework">About the Framework</a></li>
    <li><a href="#prerequisites">Prerequisites</a></li>
    <li><a href="#installation">Installation</a></li>
    <li><a href="#preparing-traces">Preparing Traces</a></li>
    <ul>
      <li><a href="#more-traces">More Traces</a></li>
    </ul>
    <li><a href="#experimental-workflow">Experimental Workflow</a></li>
      <ul>
        <li><a href="#launching-experiments">Launching Experiments</a></li>
        <li><a href="#rolling-up-statistics">Rolling up Statistics</a></li>
      </ul>
    </li>
    <li><a href="#hdl-implementation">HDL Implementation</a></li>
    <li><a href="#citation">Citation</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgements">Acknowledgements</a></li>
  </ol>
</details>

## What is Pythia?

> Pythia is a hardware-realizable, light-weight data prefetcher that uses reinforcement learning to generate accurate, timely, and system-aware prefetch requests. 

Pythia formulates hardware prefetching as a reinforcement learning task. For every demand request, Pythia observes multiple different types of program context information to take a prefetch decision. For every prefetch decision, Pythia receives a numerical reward that evaluates prefetch quality under the current memory bandwidth utilization. Pythia uses this reward to reinforce the correlation between program context information and prefetch decision to generate highly accurate, timely, and system-aware prefetch requests in the future.

## About The Framework

Pythia is implemented in [ChampSim simulator](https://github.com/ChampSim/ChampSim). We have significantly modified the prefetcher integration pipeline in ChampSim to add support to a wide range of prior prefetching proposals mentioned below:

* Stride [Fu+, MICRO'92]
* Streamer [Chen and Baer, IEEE TC'95]
* SMS [Somogyi+, ISCA'06]
* AMPM [Ishii+, ICS'09]
* Sandbox [Pugsley+, HPCA'14]
* BOP [Michaud, HPCA'16]
* SPP [Kim+, MICRO'16]
* Bingo [Bakshalipour+, HPCA'19]
* SPP+PPF [Bhatia+, ISCA'19]
* DSPatch [Bera+, MICRO'19]
* MLOP [Shakerinava+, DPC-3'19]
* IPCP [Pakalapati+, ISCA'20]

Most of the  prefetchers (e.g., SPP [1], Bingo [2], IPCP [3]) reuse codes from [2nd]() and [3rd]() data prefetching championships (DPC). Others (e.g., AMPM [4], SMS [5]) are implemented from scratch and shows similar relative performance reported by previous works.

## Prerequisites

The infrastructure has been tested with the following system configuration:
  * G++ v6.3.0 20170516
  * Perl v5.24.1
  * [Megatools 1.9.98](https://megatools.megous.com) (required to download traces)

## Installation

0. Install necessary prequisites
    ```bash
    sudo apt install perl megatools
    ```
1. Clone the GitHub repo
   
   ```bash
   git clone https://github.com/CMU-SAFARI/Pythia.git
   ```
2. Clone the bloomfilter library inside Pythia home directory
   
   ```bash
   cd Pythia
   git clone https://github.com/mavam/libbf.git libbf
   ```
3. Build bloomfilter library. This should create the static `libbf.a` library inside `build` directory
   
    ```bash
    cd libbf
    mkdir build && cd build
    cmake ../
    make clean && make
    ```
4. Build Pythia for single/multi core using build script. This should create the executable inside `bin` directory.
   
   ```bash
   # ./build_champsim.sh <l1_pref> <l2_pref> <llc_pref> <ncores>
   ./build_champsim.sh multi multi no 1
   ```
   Please use `build_champsim_highcore.sh` to build ChampSim for more than four cores.

5. Set appropriate environment variables before doing any experiment as follows:

    ```bash
    source setvars.sh
    ```

## Preparing Traces
1. Use the `download_traces.pl` perl script to download necessary ChampSim traces used in our paper. 

    ```bash
    mkdir $PYTHIA_HOME/traces/
    cd $PYTHIA_HOME/scripts/
    perl download_traces.pl --csv artifact_traces.csv --dir ../traces/
    ```
> Note: the total size of all traces would be **~52 GB**.

2. Once all traces are downloaded, please replace the dummy path in `experiments/MICRO21_1C.tlist` and `experiments/MICRO21_4C.tlist` with the full path of your trace directory.

### More Traces
1. We are also releasing a new set of ChampSim traces from [PARSEC 2.1](https://parsec.cs.princeton.edu) and [Ligra](https://github.com/jshun/ligra). The trace drop-points are measured using [Intel Pinplay](https://software.intel.com/content/www/us/en/develop/articles/program-recordreplay-toolkit.html) and the traces are captured by the ChampSim PIN tool. The traces can be found in the following links:
      * PARSEC-2.1: https://mega.nz/folder/hp1wCRBI#TlHy4GKlEHW-Eyk4AfwBZA
      * Ligra: https://mega.nz/folder/p1tklDKA#Kz6Z-gs7J1Yl5qcrzpPIPg 
   
2. Our simulation infrastructure is completely compatible with all prior ChampSim traces used in CRC-2 and DPC-3. One can also convert the CVP-2 traces (courtesy of Qualcomm Datacenter Technologies) to ChampSim format using [the following converter](https://github.com/ChampSim/ChampSim/tree/master/cvp_tracer). The traces can be found in the follwing websites:
     * CRC-2 traces: http://bit.ly/2t2nkUj
     * DPC-3 traces: http://hpca23.cse.tamu.edu/champsim-traces/speccpu/
     * CVP-2 traces: https://www.microarch.org/cvp1/cvp2/rules.html

## Experimental Workflow
Our experimental workflow consists of two stages: (1) launching experiments, and (2) rolling up statistics from experiment outputs.

### Launching Experiments
1. To create necessary experiment commands in bulk, we will use `scripts/create_jobfile.pl`
2. `create_jobfile.pl` requires three necessary arguments:
      * `exe`: the full path of the executable to run
      * `tlist`: contains trace definitions
      * `exp`: contains knobs of the experiements to run
3. Create experiments as follows. Please make sure the paths used in tlist and exp files are appropriately changed.
   
      ```bash
      cd $PYTHIA_HOME/experiments/
      perl ../scripts/create_jobfile.pl --exe $PYTHIA_HOME/bin/perceptron-multi-multi-no-ship-1core --tlist MICRO21_1C.tlist --exp MICRO21_1C.exp --local 1 > jobfile.sh
      ```

4. Go to a run directory (or create one) inside `experiements` to launch runs in the following way:
      ```bash
      cd experiments_1C
      source ../jobfile.sh
      ```

5. If you have [slurm](https://slurm.schedmd.com) support to launch multiple jobs in a compute cluster, please provide `--local 0` to `create_jobfile.pl`

### Rolling-up Statistics
1. To rollup stats in bulk, we will use `scripts/rollup.pl`
2. `rollup.pl` requires three necessary arguments:
      * `tlist`
      * `exp`
      * `mfile`: specifies stat names and reduction method to rollup
3. Rollup statistics as follows. Please make sure the paths used in tlist and exp files are appropriately changed.
   
      ```bash
      cd experiements_1C/
      perl ../../scripts/rollup.pl --tlist ../MICRO21_1C.tlist --exp ../MICRO21_1C.exp --mfile ../rollup_1C_base_config.mfile > rollup.csv
      ```

4. Export the `rollup.csv` file in you favourite data processor (Python Pandas, Excel, Numbers, etc.) to gain insights.

## HDL Implementation
We also implement Pythia in [Chisel HDL](https://www.chisel-lang.org) to faithfully measure the area and power cost. The implementation, along with the reports from umcL65 library, can be found the following GitHub repo. Please note that the area and power projections in the sample report is different than what is reported in the paper due to different technology.

<p align="center">
<a href="https://github.com/CMU-SAFARI/Pythia-HDL">Pythia-HDL</a>
    <a href="https://github.com/CMU-SAFARI/Pythia-HDL">
        <img alt="Build" src="https://github.com/CMU-SAFARI/Pythia-HDL/actions/workflows/test.yml/badge.svg">
    </a>
</p>


## Citation
If you use this framework, please cite the following paper:
```
@inproceedings{bera2021,
  author = {Bera, Rahul and Kanellopoulos, Konstantinos and Nori, Anant V. and Shahroodi, Taha and Subramoney, Sreenivas and Mutlu, Onur},
  title = {{Pythia: A Customizable Hardware Prefetching Framework Using Online Reinforcement Learning}},
  booktitle = {Proceedings of the 54th Annual IEEE/ACM International Symposium on Microarchitecture},
  year = {2021}
}
```

## License

Distributed under the MIT License. See `LICENSE` for more information.

## Contact

Rahul Bera - write2bera@gmail.com

## Acknowledgements
We acklowledge support from SAFARI Research Group's industrial partners.