import pandas as pd
import os

excel_file = 'carmen_sightings_20220629061307.xlsx'
output_dir = 'seeds/'

# Confirm the Excel file exists
if not os.path.exists(excel_file):
    print(f"❌ File not found: {excel_file}")
    exit()

# Load the Excel file
print(f"📂 Opening Excel file: {excel_file}")
xls = pd.ExcelFile(excel_file)
print(f"📄 Found sheets: {xls.sheet_names}")

# Export each sheet
for sheet in xls.sheet_names:
    print(f"🔄 Exporting sheet: {sheet}")
    df = pd.read_excel(xls, sheet_name=sheet)
    csv_filename = sheet.lower().replace(' ', '_') + '.csv'
    output_path = os.path.join(output_dir, csv_filename)
    df.to_csv(output_path, index=False)
    print(f"✅ Exported: {output_path}")
