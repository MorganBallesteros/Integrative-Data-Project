# Integrative-Data-Project

# Political Manifesto Analysis Project

## Overview

This project analyzes political manifestos to identify linguistic indicators associated with **justifications of harm and political violence**. The workflow extracts text from manifesto PDFs, counts predefined linguistic markers, computes prevalence rates, and produces structured datasets used in the thesis analysis.

The project was designed to be fully reproducible. A user should be able to open the project, render the thesis document, and reproduce the analysis outputs.

The analysis integrates:

* **Dictionary-based text analysis** of harm-related rhetoric
* **Automated Integrative Complexity (AutoIC)** scoring
* **Statistical analysis and visualization in R**

The final output is a thesis-style report examining how linguistic markers and cognitive complexity differ across categories of political manifestos.

---

# Reproducing the Analysis

## Step 1: Open the Project

Open the **project root folder** (the folder containing the `Thesis/` directory) in RStudio.

All file paths are written relative to this root using the `here` package.

---

## Step 2: Install Required Packages

If needed, install required packages:

```r
install.packages(c(
  "dplyr",
  "tidyr",
  "stringr",
  "readr",
  "ggplot2",
  "forcats",
  "purrr",
  "here",
  "papaja",
  "tinylabels",
  "pdftools"
))
```

---

## Step 3: Run the Scoring Pipeline

The scoring pipeline converts raw PDFs into structured datasets.

Run:

```r
source("Thesis/run_scoring_pipeline.R")
```

This script:

1. Reads the marker dictionary
2. Extracts text from manifesto PDFs
3. Segments documents into paragraphs
4. Counts marker occurrences
5. Computes prevalence rates
6. Produces several processed datasets

Generated files appear in:

```
Thesis/data/processed/
```

Outputs include:

| File                                  | Description                      |
| ------------------------------------- | -------------------------------- |
| manifesto_scores_markers.csv          | Marker-level prevalence          |
| manifesto_scores_groups.csv           | Marker group prevalence          |
| manifesto_scores_categories.csv       | Category-level prevalence        |
| role_model_glorification_segments.csv | Segment-level derived indicator  |
| role_model_glorification_docs.csv     | Document-level derived indicator |

---

## Step 4: Render the Thesis

Once the processed data exist, render the thesis:

```r
rmarkdown::render("Thesis/Thesis.Rmd")
```

or click **Knit** in RStudio.

The rendered document will appear as:

```
Thesis/Thesis.pdf
```

---

# Core Scripts

## `manifesto_helpers.R`

Contains helper functions used throughout the project.

Functions include:

* `normalize_text()`
  Cleans extracted text by removing formatting artifacts and normalizing whitespace.

* `build_marker_regex()`
  Safely constructs regex patterns for marker counting.

These functions isolate text-cleaning logic so the scoring pipeline remains readable.

---

## `score_manifestos.R`

This file defines the primary analysis function:

```
score_manifestos()
```

Key features:

* Accepts either:

  * raw text data frames, or
  * PDF files
* Extracts and cleans text
* Segments text (document or paragraph level)
* Counts marker occurrences
* Computes prevalence per 1,000 words
* Produces tidy outputs for analysis

The function returns:

* a tidy long-format dataset
* optional wide-format output
* document summaries
* records of missing or problematic documents

---

## `run_scoring_pipeline.R`

This script runs the complete workflow:

1. Loads the marker dictionary
2. Locates manifesto PDFs
3. Runs the scoring function
4. Annotates markers with metadata
5. Generates derived indicators
6. Writes processed datasets

This script is intended to be run **once per project build**.

---

# Marker Dictionary

The marker dictionary defines the lexical indicators used in the analysis.

File:

```
Thesis/data/markers/marker_dictionary.csv
```

Required columns:

| Column          | Meaning                        |
| --------------- | ------------------------------ |
| marker          | lexical phrase counted in text |
| marker_group    | intermediate grouping          |
| marker_category | broader conceptual grouping    |

These categories allow markers to be aggregated into higher-level indicators.

---

# Derived Indicators

The project constructs an additional indicator:

**Role Model Glorification**

This variable identifies segments where both:

* references to violent actors/events and
* language portraying actors as role models

occur within the same paragraph.

Two outputs are produced:

* **Segment-level indicator**
* **Document-level summary**

This demonstrates how linguistic features can be combined to capture more complex rhetorical patterns.

---

# Analytical Methods

The thesis examines several linguistic indicators:

* dyadic harm framing
* justifications for violence
* martyrdom narratives
* expressions of political hopelessness

Prevalence rates are compared across manifesto categories using:

* descriptive statistics
* regression analyses

The project also incorporates **automated integrative complexity** as a cognitive measure of political reasoning.

---

# Reproducibility Notes

The project is designed to be reproducible under the following conditions:

* Raw manifesto PDFs must be present in

```
Thesis/data/raw/pdfs/
```

* The marker dictionary must exist at

```
Thesis/data/markers/marker_dictionary.csv
```

* All paths are relative and handled using the `here` package.

---

# Author

Morgan Ballesteros
University of Chicago
MAPSS – Psychology

Research focus:

* moral cognition
* political violence
* integrative complexity
* computational text analysis
