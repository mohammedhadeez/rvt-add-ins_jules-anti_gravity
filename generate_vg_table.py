import pandas as pd
from openpyxl import Workbook
from openpyxl.utils.dataframe import dataframe_to_rows

input_file = 'BuiltInCategoriesRevit2024.xlsx'
output_file = 'Revit2024_VisibilityGraphics_ModelCategories.xlsx'

# Load data
print(f"Reading {input_file}...")
df = pd.read_excel(input_file)

# Filter
# Drop NaN names
df = df.dropna(subset=['English_USA (ENU)'])

# Filter out <...>
df = df[~df['English_USA (ENU)'].str.startswith('<')]

# Filter out specific internal categories
# "Filter out 'Internal Object Styles' and purely system-level entries"
df = df[df['English_USA (ENU)'] != "Internal Object Styles"]

# Filter out internal load/structural categories that appear internal
internal_load_keywords = [
    'Internal Area Load', 'Internal Line Load', 'Internal Point Load',
    'Internal Area Loads', 'Internal Line Loads', 'Internal Point Loads',
    'Structural Internal Loads'
]
for keyword in internal_load_keywords:
    df = df[~df['English_USA (ENU)'].str.contains(keyword)]

# Reset index to ensure alignment when creating the output dataframe
df = df.reset_index(drop=True)

# Prepare output columns
# A: Visibility (TRUE)
# B: Category (Name)
# C: Projection/Surface - Lines ("")
# D: Projection/Surface - Patterns ("")
# E: Transparency ("0")
# F: Cut - Lines ("")
# G: Cut - Patterns ("")
# H: Halftone ("FALSE")
# I: Detail Level ("By View")
# Hidden: ID

output_df = pd.DataFrame()
output_df['Visibility'] = ['TRUE'] * len(df)
output_df['Category'] = df['English_USA (ENU)']
output_df['Projection/Surface - Lines'] = [''] * len(df)
output_df['Projection/Surface - Patterns'] = [''] * len(df)
output_df['Transparency'] = [0] * len(df)
output_df['Cut - Lines'] = [''] * len(df)
output_df['Cut - Patterns'] = [''] * len(df)
output_df['Halftone'] = ['FALSE'] * len(df)
output_df['Detail Level'] = ['By View'] * len(df)
output_df['ID'] = df['ID']

# Sort by Category
output_df = output_df.sort_values(by='Category')

# Write to Excel
wb = Workbook()
ws = wb.active
ws.title = "Model Categories"

print("Writing to Excel...")
for r in dataframe_to_rows(output_df, index=False, header=True):
    ws.append(r)

# Formatting
# Hide ID column (Column J is the 10th column)
ws.column_dimensions['J'].hidden = True

# Set column widths
ws.column_dimensions['A'].width = 10
ws.column_dimensions['B'].width = 50
ws.column_dimensions['C'].width = 25
ws.column_dimensions['D'].width = 25
ws.column_dimensions['E'].width = 15
ws.column_dimensions['F'].width = 20
ws.column_dimensions['G'].width = 20
ws.column_dimensions['H'].width = 10
ws.column_dimensions['I'].width = 15

wb.save(output_file)
print(f"Generated {output_file} with {len(output_df)} rows.")
