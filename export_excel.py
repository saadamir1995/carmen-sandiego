import pandas as pd
import os
import logging

# Configure logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)

def export_excel_to_csv(excel_file, output_dir):
    """
    Export all sheets from Excel file to CSV format preserving original column names.
    
    Args:
        excel_file (str): Path to Excel file
        output_dir (str): Directory to save CSV files
        
    Returns:
        bool: True if successful, False otherwise
    """
    try:
        # Validate input file exists
        if not os.path.exists(excel_file):
            logger.error(f"File not found: {excel_file}")
            return False
        
        # Create output directory if it doesn't exist
        os.makedirs(output_dir, exist_ok=True)
        
        # Load Excel file
        logger.info(f"Loading Excel file: {excel_file}")
        xls = pd.ExcelFile(excel_file)
        logger.info(f"Found {len(xls.sheet_names)} sheets: {xls.sheet_names}")
        
        # Process each sheet
        for sheet_name in xls.sheet_names:
            logger.info(f"Processing sheet: {sheet_name}")
            
            # Read sheet data
            df = pd.read_excel(xls, sheet_name=sheet_name)
            
            # Generate output filename
            csv_filename = f"{sheet_name.lower().replace(' ', '_')}.csv"
            output_path = os.path.join(output_dir, csv_filename)
            
            # Export to CSV preserving original column names
            df.to_csv(output_path, index=False)
            logger.info(f"Exported {len(df)} rows to: {output_path}")
        
        logger.info("All sheets exported successfully")
        return True
        
    except Exception as e:
        logger.error(f"Error during export: {str(e)}")
        return False

if __name__ == "__main__":
    excel_file = 'carmen_sightings_20220629061307.xlsx'
    output_dir = 'seeds/'
    
    success = export_excel_to_csv(excel_file, output_dir)
    exit(0 if success else 1)