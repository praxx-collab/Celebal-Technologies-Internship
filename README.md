# Assignment - 1
# Ecommerce Data Cleaning and Exploration using Pandas

## Objective

The objective of this project is to perform basic data exploration and data cleaning operations on an ecommerce dataset using Python and Pandas.

## Steps Performed

1. Loaded the dataset into a Pandas DataFrame.
2. Explored the dataset using:

   * head()
   * shape
   * columns
   * info()
3. Identified missing values using isnull().sum().
4. Handled missing values:

   * Filled missing discount values with 0.
   * Filled missing text-based fields with suitable values such as "Unknown", "No Reviews", and "Not Available".
5. Filtered products having ratings greater than 4.0.
6. Selected relevant columns for further analysis.
7. Checked and removed duplicate records.
8. Created two derived columns named discount_amount and total_amount.
   
   *discount_amount=final_price - initial_price
   * Since the dataset did not contain a quantity column, a quantity of 1 was assumed.
   * Therefore, total_amount was set equal to final_price.
9. Saved the cleaned dataset into a new CSV file named as ecommerce_dataset_cleaned.csv

## Files Included

* Ecommerce_Data_Cleaning_Analysis.ipynb
* ecommerce_dataset_cleaned.csv
* README.md

## Tools Used

* Python
* Pandas
* Jupyter Notebook
* GitHub

