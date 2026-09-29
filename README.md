# Wafer Yield Simulator

An interactive web-based **semiconductor wafer yield simulator** for
visualizing wafer-level die testing, pass/fail classification, yield
calculation, test sequencing, and tester-speed control.

## Overview

A semiconductor wafer contains many individual dies. Manufacturing
defects can cause some dies to fail testing. This project provides an
interactive browser-based model of that process.

``` text
Wafer Parameters
       |
       v
   Die Generation
       |
       v
   Die Testing
       |
       v
 Pass / Fail Classification
       |
       v
   Yield Calculation
       |
       v
 Interactive Visualization
```

The project is intended for educational and portfolio use in VLSI,
semiconductor manufacturing, IC testing, and yield analysis.

------------------------------------------------------------------------

## Features

### Interactive Wafer Visualization

The simulator displays individual dies across a wafer and provides
visual feedback as testing progresses.

### Die-Level Testing

Dies are processed individually and classified according to the
simulator’s test/bin data and logic.

### Yield Calculation

The observed test yield is represented by:

\[ Y = \]

where:

- `N_good` = number of passing dies
- `N_tested` = number of tested dies
- `Y` = observed yield percentage

### Automatic Test Sequence

The simulator can automatically progress through the wafer rather than
requiring every test operation to be initiated manually.

### Tester Velocity Control

The interface includes a **Tester Velocity** control with:

- Range: **0.5x to 5.0x**
- Default: **2.5x**
- Live velocity display
- Automatic-test timing scaled with velocity
- Higher velocity for faster testing
- Lower velocity for observation and debugging

Conceptually:

\[ T\_{delay} \]

where `T_delay` is the delay between test events and `V` is tester
velocity.

### Test/Classification Data

The repository includes:

``` text
wafer_test_bins.csv
```

for wafer test/bin data used by the project.

------------------------------------------------------------------------

## Repository Structure

``` text
wafer_yield_simulator/
|
|-- index.html
|-- script.js
|-- style.css
|-- wafer_test_bins.csv
|-- README.md
`-- .gitignore
```

### `index.html`

Defines the web interface and simulator page structure.

### `script.js`

Contains the simulator’s interactive behavior, test sequence,
calculations, and UI logic.

### `style.css`

Contains the visual styling and layout.

### `wafer_test_bins.csv`

Contains wafer test/bin data used by the simulator.

### `.gitignore`

Prevents unwanted local and generated files from being committed.

------------------------------------------------------------------------

## How It Works

### 1. Wafer Initialization

The application creates the wafer/die visualization.

### 2. Die Testing

The simulator processes dies according to its test sequence and data
model.

### 3. Pass/Fail Classification

Each tested die receives the corresponding simulated test result.

### 4. Yield Calculation

The number of good and tested dies is tracked.

``` text
Yield (%) = Good Dies / Tested Dies x 100
```

### 5. Automatic Testing

The automatic sequence continues through the wafer. Tester velocity
determines the timing between test events.

------------------------------------------------------------------------

## Example

If 100 dies are tested and 92 pass:

``` text
Good dies   = 92
Failed dies = 8
Tested dies = 100
```

Then:

\[ Y = = 92% \]

The observed test yield is therefore **92%**.

------------------------------------------------------------------------

## Semiconductor Yield Background

Yield is an important semiconductor manufacturing metric because
fabricated dies can fail due to random defects, systematic defects,
process variation, and other manufacturing effects.

A simple observed-yield calculation is:

\[ Y = \]

or, as a percentage:

\[ Y\_{%} = \]

Actual semiconductor yield analysis is more complex and can involve
defect density, die area, critical area, spatial defect correlation,
process variation, and different statistical yield models.

This simulator is an educational model and is not intended to provide
production semiconductor yield predictions.

------------------------------------------------------------------------

## Simple Defect-Density Model

A future analytical extension can use the simple Poisson yield
relationship:

\[ Y = e^{-D_0 A} \]

where:

- `D_0` = defect density
- `A` = die area
- `Y` = predicted yield

This provides a useful way to study the relationship between die area,
defect density, and yield.

------------------------------------------------------------------------

## Project Workflow

``` text
             +----------------------+
             |   Wafer Parameters   |
             +----------+-----------+
                        |
                        v
             +----------------------+
             |    Generate Dies     |
             +----------+-----------+
                        |
                        v
             +----------------------+
             |      Test Die        |
             +----------+-----------+
                        |
                 +------+------+
                 |             |
                 v             v
             +-------+     +-------+
             | PASS  |     | FAIL  |
             +---+---+     +---+---+
                 |             |
                 +------+------+
                        |
                        v
             +----------------------+
             |    Yield Analysis    |
             +----------+-----------+
                        |
                        v
             +----------------------+
             | Wafer Visualization  |
             +----------------------+
```

------------------------------------------------------------------------

## Running Locally

### Clone the repository

``` bash
git clone https://github.com/suresh-vlsi/wafer_yield_simulator.git
```

Enter the project:

``` bash
cd wafer_yield_simulator
```

### Option 1: Open directly

Open:

``` text
index.html
```

in a modern web browser.

### Option 2: VS Code

Open the project folder in VS Code:

``` bash
code .
```

Then open `index.html`.

A local web-server extension such as Live Server can also be used during
development.

### Option 3: Python HTTP server

If Python is installed:

``` bash
python -m http.server 8000
```

Then open:

``` text
http://localhost:8000
```

------------------------------------------------------------------------

## Technologies

| Technology | Purpose                    |
|------------|----------------------------|
| HTML5      | Web interface              |
| CSS3       | Styling and layout         |
| JavaScript | Simulation and interaction |
| CSV        | Test/bin data              |
| Git        | Version control            |
| GitHub     | Source-code hosting        |

------------------------------------------------------------------------

## Educational Objectives

This project demonstrates concepts related to:

1.  Semiconductor manufacturing
2.  Wafer and die organization
3.  IC testing
4.  Pass/fail binning
5.  Yield calculation
6.  Defect-oriented simulation
7.  Data-driven visualization
8.  Interactive JavaScript applications
9.  Engineering dashboards
10. Git/GitHub project development

------------------------------------------------------------------------

## Possible Extensions

The simulator can be expanded with more advanced semiconductor models.

### Defect Density

Allow the user to vary:

\[ D_0 = \]

and observe its effect on yield.

### Statistical Yield Models

Potential additions include:

- Poisson yield model
- Murphy yield model
- Negative-binomial yield model
- Clustered-defect models
- Monte Carlo simulation

### Advanced Analysis

Future versions could include:

- Yield versus defect-density plots
- Yield versus die-area plots
- Multiple-wafer comparison
- Yield distributions
- Mean and standard deviation
- Confidence intervals
- Defect-density sweeps
- Die-area sweeps

### Advanced Visualization

Potential additions:

- Wafer heat maps
- Defect maps
- Bin distributions
- Yield trend charts
- Process comparison dashboards

------------------------------------------------------------------------

## Limitations

This is a **simplified educational simulator**.

It does not attempt to reproduce a complete semiconductor manufacturing
line or a production-grade yield-analysis system.

Real manufacturing yield analysis can require process-specific data and
models for:

- Random defects
- Systematic defects
- Spatial correlations
- Critical-area effects
- Parametric failures
- Process variation
- Test coverage
- Manufacturing process conditions

------------------------------------------------------------------------

## Use Cases

The project can be used for:

- VLSI coursework
- Semiconductor engineering learning
- IC testing demonstrations
- Yield-analysis demonstrations
- Digital VLSI portfolios
- Academic presentations
- Semiconductor interview preparation
- Interactive engineering visualization

------------------------------------------------------------------------

## GitHub Repository

Repository:

**suresh-vlsi/wafer_yield_simulator**

https://github.com/suresh-vlsi/wafer_yield_simulator

------------------------------------------------------------------------

## Author

**Suresh Kumar**

M.Tech — Systems & Control Engineering, IIT Bombay

Areas of interest:

- VLSI Design
- RTL Design
- ASIC Verification
- Digital VLSI
- Semiconductor Manufacturing
- Hardware Design
- Formal Verification

------------------------------------------------------------------------

## License

No open-source license has been selected for the repository unless one
is explicitly added.

If the project is later intended for unrestricted reuse, an open-source
license such as MIT can be added.

------------------------------------------------------------------------

## Version

**Complete Wafer Yield Simulator**

Current documented functionality:

- Interactive wafer/die visualization
- Die-level testing
- Yield tracking
- Automatic test sequencing
- Tester velocity control
- CSV-based test/bin data
- Browser-based interface
