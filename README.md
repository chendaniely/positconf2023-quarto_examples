# positconf2023-quarto_examples

A set of Quarto document examples going from only using code chunks to a polished report.

## Setup

### Python

Using Python 3.11.5

### Virtual environment setup

```shell
python -m venv venv
source venv/bin/activate
```

### Install packages

```shell
pip install pandas jupyter folium plotnine
```

## How to navigate this repository

If you are using the `venv` virtual environment,
make sure to activate it before running any of the scripts.

```shell
source venv/bin/activate
```

### Prep data

There are 2 scripts that will
get the original data from the DC bike share API,
process it,
and save out the relevant `.csv` files that will be used for the report.

```shell
Rscript 01-get_data.R
python 02-process_data_example.y
```

The final data set that will be used in the Quarto report examples will join
bike share station location along with the number of available bikes at that particular location
for a particular date + time.

The bike data only represents information collected when the `Rscript 01-get_data.R` was run to pull the data.

### Quarto document examples

The example documents for quarto will all begin with the `example-` file prefix.

#### Example 01: Bare Quarto document with code chunks

A quarto document that only utilizes `{python}` engine code chunks.

#### Example 02: Headings and markdown prose text

A quarto document that utilizes headings and markdown prose text.

#### Example 03: Tweaking output with YAML settings

A quarto document that utilizes YAML settings to tweak the output.
