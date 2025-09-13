# Microbiome Cancer Data Analysis - Master's Project

A comprehensive statistical analysis comparing logistic regression approaches for cancer prediction using microbiome data. This project evaluates different preprocessing methods for compositional microbiome data in the context of binary classification.

## Project Overview

This research investigates the effectiveness of different logistic regression approaches for classifying cancer vs. healthy tissue samples using microbiome compositional data. The study compares raw count data against ALR (Additive Log-Ratio) transformed data, both combined with LASSO regularization for feature selection and classification.

### Key Objectives
- Compare raw counts vs. ALR transformation for microbiome data preprocessing
- Evaluate LASSO regularization for high-dimensional microbiome feature selection
- Assess classification performance using ROC analysis and cross-validation
- Identify optimal approaches for microbiome-based cancer prediction

### Key Findings
- **ALR Transformation**: Achieved AUC of 0.92 with 61 selected features
- **Raw Counts**: Achieved AUC of 0.91 with 59 selected features
- **Feature Selection**: No overlap between methods, suggesting different aspects of microbial community structure
- **Performance**: Both methods demonstrated strong predictive capability with slight advantage for ALR approach

## Dataset

The analysis uses microbiome count data from operational taxonomic units (OTUs) comparing:
- **Tumor samples**: Cancerous tissue microbiome profiles
- **Healthy samples**: Normal tissue microbiome profiles
- **Data structure**: High-dimensional compositional data with paired samples from same subjects
- **Challenge**: Compositional constraint requiring specialized statistical approaches

## Methodology

### Statistical Approaches Compared

#### 1. Raw Counts + LASSO
- Direct application of LASSO logistic regression to raw OTU count data
- Stratified cross-validation with upsampling for class balance
- Lambda selection via cross-validation optimization

#### 2. ALR Transformation + LASSO
- Compositional data preprocessing using Additive Log-Ratio transformation
- Addresses compositional constraint inherent in microbiome data
- LASSO regularization applied to transformed log-ratios
- Preserves relative abundance relationships

### Key Features
- **Regularization**: LASSO (L1) penalty for automatic feature selection
- **Cross-validation**: 5-fold stratified CV for robust performance estimation
- **Class balancing**: Upsampling to address potential class imbalance
- **Performance metrics**: AUC, sensitivity, specificity, balanced accuracy

## Repository Structure

```
Microbiome_Cancer_Data_Research/
├── data/
│   ├── task.txt                    # Sample metadata and labels
│   ├── otutable.txt               # Raw OTU count matrix
│   ├── count_data_clean.csv       # Processed count data
│   └── alr_data_clean.csv         # ALR transformed data
├── STAT798 Cancer.qmd             # Main analysis notebook (Quarto)
├── STAT798 Cancer.html            # Rendered HTML report
├── [Generated files...]           # R data files and outputs
└── README.md                      # This documentation
```

## Requirements

### Software
- **R** (version 4.0 or higher)
- **RStudio** (recommended for Quarto rendering)
- **Quarto** (for document rendering)

### R Packages
```r
# Core analysis packages
library(compositions)    # Compositional data analysis
library(glmnet)         # LASSO regularization
library(caret)          # Machine learning framework
library(pROC)           # ROC analysis

# Visualization and data manipulation
library(ggplot2)        # Plotting
library(dplyr)          # Data manipulation
library(reshape2)       # Data reshaping
library(gridExtra)      # Multiple plots
library(grid)           # Grid graphics
```

## Setup and Usage

### Quick Start

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/Microbiome_Cancer_Data_Research.git
   cd Microbiome_Cancer_Data_Research
   ```

2. **Open in RStudio**
   - Open the `STAT798 Cancer.qmd` file
   - Ensure all required packages are installed

3. **Run the analysis**
   - Execute code chunks sequentially or render the entire document
   - Results will include model comparisons, ROC curves, and performance metrics

### Detailed Analysis Workflow

1. **Data Loading and Preprocessing**
   - Load OTU count matrix and sample metadata
   - Data cleaning and quality control
   - Train/test split with subject-level stratification

2. **Method 1: Raw Counts Analysis**
   - Direct LASSO logistic regression on count data
   - Cross-validation for lambda selection
   - Performance evaluation and feature extraction

3. **Method 2: ALR Transformation Analysis**
   - Compositional data conversion with pseudocount addition
   - ALR transformation using reference taxon
   - LASSO regression on transformed log-ratios

4. **Comparative Analysis**
   - Side-by-side performance comparison
   - ROC curve analysis
   - Feature selection comparison
   - Visualization of results

## Results Summary

### Performance Comparison
| Method | AUC | Sensitivity | Specificity | Features Selected |
|--------|-----|-------------|-------------|-------------------|
| Raw Counts + LASSO | 0.91 | High | High | 59 |
| ALR + LASSO | 0.92 | High | High | 61 |

### Key Insights
- **Slight ALR advantage**: ALR transformation provided marginally better AUC and sensitivity
- **Complementary feature selection**: No overlap in selected features suggests methods capture different biological signals
- **Robust performance**: Both approaches achieved strong predictive performance
- **Compositional awareness**: ALR transformation better respects the compositional nature of microbiome data

## Technical Considerations

### Compositional Data Challenges
- **Sum constraint**: Microbiome data represents relative abundances summing to 1
- **Spurious correlations**: Raw analysis may introduce artificial relationships
- **Reference dependence**: ALR transformation requires reference taxon selection

### Statistical Methodology
- **High dimensionality**: Number of features (OTUs) exceeds sample size
- **Regularization necessity**: LASSO essential for feature selection and overfitting prevention
- **Cross-validation**: Critical for unbiased performance estimation

## Files Description

- **`STAT798 Cancer.qmd`**: Complete analysis workflow in Quarto format
- **`data/task.txt`**: Sample metadata with tumor/healthy labels
- **`data/otutable.txt`**: Raw OTU abundance matrix
- **Generated CSVs**: Processed datasets for reproducibility
- **HTML output**: Rendered report with all results and visualizations

## Academic Context

This project represents advanced coursework in biostatistics (STAT798 - Master's Project), demonstrating:
- **Compositional data analysis** expertise
- **High-dimensional statistics** application
- **Machine learning** for biological data
- **Reproducible research** practices using Quarto

## Methodological Significance

### Contributions
- Systematic comparison of preprocessing approaches for microbiome cancer prediction
- Demonstration of ALR transformation benefits for compositional data
- Practical application of LASSO regularization in high-dimensional biological contexts
- Reproducible workflow for microbiome classification analysis

### Clinical Relevance
- Microbiome-based biomarkers for cancer detection
- Non-invasive diagnostic potential
- Understanding of microbial community structure in disease

## Future Directions

- **Alternative transformations**: CLR (Centered Log-Ratio) and ILR (Isometric Log-Ratio) comparisons
- **Ensemble methods**: Combining multiple transformation approaches
- **Feature interpretation**: Biological significance of selected microbial taxa
- **Validation studies**: Independent dataset testing for generalizability

## Dependencies and Reproducibility

The analysis is designed for full reproducibility with:
- **Version control**: All code and data processing steps documented
- **Package management**: Explicit library loading and version dependencies
- **Seed setting**: Reproducible random sampling and cross-validation
- **Clear documentation**: Step-by-step methodology explanation

## Contact

**Author**: Aaron Pongsugree  
**Project**: STAT798 - Master's Project  
**Institution**: George Mason University  
**Program**: M.S. Biostatistics

## Data Availability

This project uses simulated/processed microbiome data. For access to original datasets or analysis replication, please refer to the academic institution's data sharing policies.

## Citation

If using this methodology or code, please cite this work appropriately according to academic standards for computational biology and biostatistics research.

---

*This project demonstrates advanced statistical methods for microbiome data analysis, combining compositional data theory with modern machine learning approaches for cancer prediction. The comprehensive comparison provides valuable insights for researchers working with high-dimensional biological data.*
