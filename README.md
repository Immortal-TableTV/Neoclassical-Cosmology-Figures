# Peebles Chapter 13 Cosmology Figures

This repository contains MATLAB scripts that reproduce selected figures from Chapter 13 of *Principles of Physical Cosmology* by P. J. E. Peebles. The scripts explore how different cosmological models affect observable quantities such as lookback time, angular size distance, bolometric distance modulus, galaxy counts, gravitational lensing optical depth, and growth of density fluctuations.

The project is organized around a main runner script, `mainFigures.m`, which allows all figure scripts to be executed from one place.

## Project Overview

The goal of this repository is to numerically reproduce and visualize several cosmological relationships from Peebles Chapter 13. Most scripts compare two common model families:

1. **No Curvature / Flat Models**
   [
   \Omega_k = 0, \qquad \Omega_\Lambda = 1 - \Omega_m
   ]

2. **No Dark Energy Models**
   [
   \Omega_\Lambda = 0, \qquad \Omega_k = 1 - \Omega_m
   ]

Across the figures, the scripts vary the matter density parameter (\Omega_m) and evaluate the resulting behavior as a function of redshift (z) or density parameter (\Omega).

## Repository Structure

```text
.
├── mainFigures.m
├── lookBackTime.m
├── angularSizeDistance.m
├── angularSizeDistanceVSomega.m
├── intersectingObjectsProb.m
├── angSize.m
├── bolometricDistance.m
├── countsFunction.m
├── redDiffangSize.m
├── opDepthGravLens.m
├── growthFactor.m
├── veloFactor.m
└── README.md
```

## Main Script

### `mainFigures.m`

This is the main driver script for the repository. It lets the user run all reproduced Chapter 13 figure scripts from one location.

At the top of the file, individual figure scripts can be turned on or off using Boolean flags:

```matlab
run_fig_13_1  = true;
run_fig_13_2  = true;
run_fig_13_3  = true;
...
run_fig_13_14 = true;
```

The variable

```matlab
run_all = true;
```

can be used to run every included figure script.

When the program starts, the user is prompted to choose a cosmological model:

```matlab
choice = input("Type (1) for No Curvature or Type (2) for No Dark Energy:   ");
```

The two options are:

```text
1 = No Curvature / Flat Models
2 = No Dark Energy / Lambda = 0
```

After the model is selected, `mainFigures.m` runs the selected figure scripts one by one.

## Included Figures

| Script                         | Figure | Description                                                     |
| ------------------------------ | -----: | --------------------------------------------------------------- |
| `lookBackTime.m`               |   13.1 | Lookback time as a function of redshift                         |
| `angularSizeDistance.m`        |   13.2 | Angular size distance as a function of redshift                 |
| `angularSizeDistanceVSomega.m` |   13.3 | Angular size distance as (z \rightarrow \infty) versus (\Omega) |
| `intersectingObjectsProb.m`    |   13.4 | Line-of-sight intersection probability factor                   |
| `angSize.m`                    |   13.5 | Angular size factor as a function of redshift                   |
| `bolometricDistance.m`         |   13.6 | Bolometric distance modulus as a function of redshift           |
| `countsFunction.m`             |   13.8 | Counts function as a function of redshift                       |
| `redDiffangSize.m`             |   13.9 | Ratio of redshift difference to angular size                    |
| `opDepthGravLens.m`            |  13.12 | Optical depth for gravitational lensing                         |
| `growthFactor.m`               |  13.13 | Growth factor for density fluctuations                          |
| `veloFactor.m`                 |  13.14 | Velocity factor for density fluctuations                        |

## Cosmological Quantities Used

Many of the scripts rely on the dimensionless expansion function

[
E(z) = \frac{H(z)}{H_0}
]

with

[
E(z) =
\sqrt{
\Omega_m(1+z)^3
+
\Omega_k(1+z)^2
+
\Omega_\Lambda
}.
]

The scripts also commonly use the dimensionless radial coordinate

[
\chi(z) = \int_0^z \frac{dz'}{E(z')}.
]

Curvature corrections are applied using

[
S_k(\chi) =
\begin{cases}
\chi, & \Omega_k = 0 \
\dfrac{\sinh(\sqrt{\Omega_k}\chi)}{\sqrt{\Omega_k}}, & \Omega_k > 0 \
\dfrac{\sin(\sqrt{-\Omega_k}\chi)}{\sqrt{-\Omega_k}}, & \Omega_k < 0
\end{cases}
]

so that

[
\frac{H_0 a_0 r(z)}{c} = S_k(\chi).
]

## Requirements

This project requires:

* MATLAB
* Basic MATLAB plotting functionality
* MATLAB numerical integration using `integral`

No additional toolboxes are required for the current scripts.

## How to Run

Download or clone this repository, then open the project folder in MATLAB.

Make sure all `.m` files are in the same folder. Then run:

```matlab
mainFigures
```

MATLAB will ask you to choose a cosmological model:

```text
Type (1) for No Curvature or Type (2) for No Dark Energy:
```

Enter:

```text
1
```

for flat/no-curvature models, or

```text
2
```

for no-dark-energy models.

The selected scripts will then run and generate the corresponding Chapter 13 figure reproductions.


## Running Individual Figures

Each script can also be run individually. For example:

```matlab
lookBackTime
```

or

```matlab
opDepthGravLens
```

Some scripts are designed to receive the model choice from `mainFigures.m`. If running a script individually, make sure the model choice variable is defined or uncomment the input block near the top of the file.

For example:

```matlab
choice = input("Type (1) for No Curvature or Type (2) for No Dark Energy:   ");
```

## Notes on MATLAB Auto-Save Files

Some MATLAB `.asv` auto-save files may appear while editing. These are backup files created by MATLAB and are not needed to run the project.

Recommended `.gitignore` entry:

```text
*.asv
```

## Example Workflow

A typical workflow is:

1. Open MATLAB.
2. Navigate to the repository folder.
3. Run `mainFigures.m`.
4. Select a cosmological model.
5. View the generated Chapter 13 figure reproductions.
6. Modify the figure selection flags in `mainFigures.m` if only certain plots are needed.

## Academic Context

These scripts were written as part of an independent study in general relativity and cosmology. The figures are intended to support conceptual understanding of cosmological observables, numerical integration in expanding-universe models, and the dependence of observational quantities on (\Omega_m), (\Omega_\Lambda), and curvature.

## Disclaimer

This repository is an educational reproduction of selected figures from Peebles Chapter 13. The scripts are intended for learning, visualization, and numerical experimentation rather than precision cosmological parameter estimation.
