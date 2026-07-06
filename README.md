# Peebles Chapter 13 Figure Reproductions

MATLAB reproductions of selected figures from Chapter 13, **“Neoclassical Cosmological Tests,”** of P. J. E. Peebles' *Principles of Physical Cosmology*.  

This repository was made as part of my summer cosmology work at Kansas State University. The goal is not just to copy the plots, but to rebuild the calculations behind them: lookback time, distance-redshift relations, angular-size tests, number counts, gravitational lensing optical depth, and linear growth factors in different cosmological models.

## Project Overview

Chapter 13 studies how cosmological models can be tested using observable quantities as functions of redshift. The scripts in this repository numerically evaluate those relationships and plot the corresponding figure curves for different values of the matter density parameter,

\Omega_m = 0.05,\ 0.1,\ 0.2,\ \frac{1}{3},\ 0.5,\ 1,\ 2.

Most scripts compare two model families:

1. **Flat / negligible-curvature models**

\Omega_k = 0
\Omega_\Lambda = 1 - \Omega_m

2. **No-dark-energy models**

\Omega_k = 1 - \Omega_m
\Omega_\Lambda = 0

The common expansion function used throughout is

E(z) = \frac{H(z)}{H_0} = \sqrt{\Omega_m(1+z)^3 + \Omega_k(1+z)^2 + \Omega_\Lambda}.

The transverse comoving distance is computed through the dimensionless radial coordinate

\chi(z) = \int_0^z \frac{dz'}{E(z')},

with curvature handled using

\[
S_k(\chi)=
\begin{cases}
  \chi, & \Omega_k = 0,\\
  \sinh(\sqrt{\Omega_k}\chi)/\sqrt{\Omega_k}, & \Omega_k > 0,\\
  \sin(\sqrt{-\Omega_k}\chi)/\sqrt{-\Omega_k}, & \Omega_k < 0.
\end{cases}
\]

In the code, this gives the dimensionless distance

\frac{H_0 a_0 r(z)}{c} = S_k(\chi).

## Repository Contents

| File | Figure | Description |
|---|---:|---|
| `lookBackTime.m` | 13.1 | Lookback time as a function of redshift, using \(H_0(t_0 - t_z)\). |
| `angularSizeDistance.m` | 13.2 | Dimensionless angular-size distance factor, \(H_0a_0r(z)/c\), as a function of redshift. |
| `angularSizeDistanceVSomega.m` | 13.3 | Limiting angular-size distance as \(z \to \infty\), plotted against \(\Omega_m\). |
| `intersectingObjectsProb.m` | 13.4 | Dimensionless line-of-sight probability factor for intersecting objects. |
| `angSize.m` | 13.5 | Angular-size factor \(F_\theta = (1+z)/(H_0a_0r/c)\). |
| `bolometricDistance.m` | 13.6 | Bolometric distance modulus, \(m-M+5\log h\), as a function of redshift. |
| `countsFunction.m` | 13.8 | Count function \(F_n(z) = [H_0a_0r(z)]^2/(1+z)^2\). |
| `redDiffangSize.m` | 13.9 | Ratio of redshift difference to angular size, \((1/z)S_z/S_\theta\). |
| `opDepthGravLens.m` | 13.12 | Optical depth factor for gravitational lensing, \(F_{gl}\). |
| `growthFactor.m` | 13.13 | Linear density perturbation growth factor \(D(0)\). |
| `veloFactor.m` | 13.14 | Velocity growth factor \(f = d\log D/d\log a\) at \(z=0\). |
| `warmupKSU.m` | — | Simple MATLAB warm-up function used while getting started. |

## Requirements

These scripts were written for MATLAB and use standard built-in functions, including:

- `integral`
- `sqrt`
- `sinh`
- `sin`
- `log10`
- `plot`
- `lines`

No external MATLAB toolboxes are required for the core calculations.

## How to Run

Clone the repository:

```bash
git clone https://github.com/your-username/your-repository-name.git
cd your-repository-name
```

Open MATLAB in the repository folder and run any script by name. For example:

```matlab
lookBackTime
```

or

```matlab
opDepthGravLens
```

For many of the scripts, MATLAB will prompt:

```text
Type (1) for No Curvature or Type (2) for No Dark Energy:
```

Enter:

- `1` for the flat/negligible-curvature model, where \(\Omega_k = 0\)
- `2` for the no-dark-energy model, where \(\Omega_\Lambda = 0\)

Each script then generates the corresponding plot.

## Main Physics Quantities

### Lookback Time

The dimensionless lookback time is

H_0(t_0 - t_z) = \int_0^z \frac{dz'}{(1+z')E(z')}.

This tells how long ago light was emitted from an object at redshift \(z\), in units of the Hubble time.

### Distance-Redshift Relation

Most observational tests depend on the distance factor

\frac{H_0a_0r(z)}{c}.

This is computed by integrating \(1/E(z)\) and then applying the curvature correction \(S_k(\chi)\).

### Angular-Size Factor

The angular-size factor is

F_\theta(z) = \frac{1+z}{H_0a_0r(z)/c}

It is related to the angular diameter distance through

d_A = \frac{a_0r(z)}{1+z}.

### Bolometric Distance Modulus

The bolometric distance relation is written as

m - M + 5\log h =
42.38 + 5\log_{10} [ (1+z)\frac{H_0a_0r(z)}{c} ]

### Count Function

The count function used here is

F_n(z)n= \frac{[H_0a_0r(z)]^2}{(1+z)^2}.

### Redshift Difference to Angular Size

For objects moving with the general expansion,

\frac{1}{z}\frac{S_z}{S_\theta} = \frac{H_0a_0r(z)E(z)}{z}

### Gravitational Lensing Optical Depth

The gravitational lensing optical depth factor is

F_{gl} = 16\pi^3 \int_0^{z_s} \frac{dz_l}{E(z_l)} ( \frac{y_{ol}y_{ls}}{y_{os}} )^2

Here \(z_s\) is the source redshift, \(z_l\) is the lens redshift, and the \(y\)-terms are dimensionless angular-diameter-distance combinations.

### Linear Growth Factor

The growth factor evaluated at \(z=0\) is

D(0)= \frac{5\Omega_m}{2}E(0) \int_0^\infty \frac{1+z}{E(z)^3}\,dz

### Velocity Growth Factor

The velocity factor at \(z=0\) is

f(0) =
-1-\frac{\Omega_m}{2}+\Omega_\Lambda + \frac{5\Omega_m}{2D(0)}.

## Notes on Numerical Implementation

The code is intentionally written in a readable, educational style. Most scripts define the cosmological model, build the function \(E(z)\), numerically evaluate the required integral, and then plot the result.

Some implementation choices:

- Small nonzero redshift values are used in places where \(z=0\) would cause division by zero or undefined logarithms.
- `integral(..., 0, Inf)` is used for limiting expressions evaluated as \(z \to \infty\).
- The scripts keep the calculations dimensionless whenever possible.
- A reference value of \(H_0 = 70\ \text{km s}^{-1}\text{Mpc}^{-1}\) is used when converting to physical units.

## Suggested Repository Structure
```
├── README.md
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
└── warmupKSU.m
```

Optional cleanup before pushing to GitHub:

```bash
rm *.asv
```

## Academic Context

This repository is a computational companion to my independent study of relativistic cosmology. The figures are based on the Chapter 13 cosmological tests in Peebles' *Principles of Physical Cosmology* (1993). The purpose is to connect the equations in the text to numerical calculations and to build intuition for how different values of \(\Omega_m\), \(\Omega_\Lambda\), and \(\Omega_k\) change observable cosmological relationships.

## Disclaimer

These scripts are educational reproductions of textbook figures. They are not intended to replace professional cosmological codes such as CAMB, CLASS, or Astropy-based cosmology tools. Numerical choices, plotting ranges, and normalizations are selected to match the textbook-style figures and to make the underlying physics transparent.
