# SaMMEA for HRES: Surrogated-assisted Multimodal Multi-objective Optimization for Hybrid Renewable Energy System

MATLAB implementation of the surrogate-assisted multimodal multi-objective optimization method for hybrid renewable energy system (HRES) sizing, from the paper:

> T. Zhang, W. Li, and R. Wang, "Surrogated-assisted multimodal multi-objective optimization for hybrid renewable energy system," *Complex & Intelligent Systems*, vol. 9, no. 4, pp. 4075–4087, 2023.
> DOI: [10.1007/s40747-022-00943-y](https://doi.org/10.1007/s40747-022-00943-y)

The author final manuscript is included ([2023-CAIS-Surrogated-assisted multimodal multi-objective optimization for hybrid renewable energy system.pdf](2023-CAIS-Surrogated-assisted multimodal multi-objective optimization for hybrid renewable energy system.pdf)).

## Overview

Hybrid renewable energy system sizing is a typical multimodal multi-objective problem: several structurally different configurations can reach (near-)equivalent Pareto-optimal trade-offs between cost and reliability. This project couples a surrogate model with a multimodal multi-objective evolutionary algorithm (MOSES/MOEASES) to locate multiple equivalent system designs in one run, with the following competitor algorithms included for comparison: IBEA, MOEA/D, NSGA-II, SPEA2.

## Repository Structure

```
SaMMEAforHRES/
├── RunMe_main.m        % entry script
├── MOSES/              % the proposed algorithm (MOEASES)
├── IBEA/  MOEAD/  nsga2/  SPEA2/   % competitor algorithms
├── PublicFunc/         % objectives, initialization, metrics, HRES data
│   └── wind_pv_temp.txt  % wind/PV/temperature data of the case study
├── GeneratePF.m, drawpf.m, find_knee.m, plotdat.m   % analysis & plotting
└── 2023-CAIS-*.pdf     % author manuscript
```

## Quick Start

Open MATLAB in this folder and run:

```matlab
RunMe_main
```

## Citation

```bibtex
@article{Zhang2023SaMMEA,
  author  = {Zhang, Tao and Li, Wenhua and Wang, Rui},
  title   = {Surrogated-assisted multimodal multi-objective optimization for hybrid renewable energy system},
  journal = {Complex \& Intelligent Systems},
  volume  = {9},
  number  = {4},
  pages   = {4075--4087},
  year    = {2023},
  doi     = {10.1007/s40747-022-00943-y}
}
```

## Contact

- Wenhua Li (`liwenhua1030@aliyun.com`)
