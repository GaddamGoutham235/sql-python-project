# sql-python-project

### Data cleaning in SQL. Below are steps involved.

- Created a backup of laptop dataset
- Removed rows with null values
- Removing duplicate rows ensures that each record in your table is unique, which is important for accurate analysis.
- Columns with extra data has been removed using REPLACE function
- Used 'CASE' clause to group Opsys to different Operating system
- SUBSTRING_INDEX,TRIM,REPLACE, Regular Expressions are used 
- Alter is used to create new columns and drop unnecessary columns
- Rows are updated using UPDATE clause after making changes in rows


  ### EDA in SQL. Below are steps involved

  - Head: View the first few rows of the dataset . With the help of ORDER BY and LIMIT to get the top rows.
  - Tail: View the last few rows of the dataset . With the help of ORDER BY,DESC and LIMIT to get the last rows.
  - Sample: Take a random sample from the dataset. used RANDOM() to get random sample
  - Summary statistics for numerical columns such as COUNT,MIN,MAX,AVG,STD
  - Exported the table into CSV file format and uploaded the file into google collab.
  - Created visualizations to communicate insights.
  - 
 These steps provide a structured approach to performing EDA on your laptop dataset, covering data loading, cleaning, univariate and bivariate analysis, and visualization of insights.

