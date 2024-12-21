# Athena Hartigan
# Due Date: 11/9/2024
# This code creates a database to store FDA pediatic labeling changes data. The code reads the data from the two Excel files, merges the data, and then splits the data into three tables: Application, Study, and DemographicsCount. The code then creates a SQLite database and inserts the data into the tables.
# Co-Author: Bard

# Import required libraries 
try:
  import sqlite3
except ImportError:
  print("Error: sqlite3 module not found. This is a built-in Python module. Please ensure you're using a Python environment with the correct libraries installed.")
  exit()
try:
  import os
except ImportError:
  print("Error: os module not found. This is a built-in Python module. Please ensure you're using a Python environment with the correct libraries installed.")
  exit()

try:
  import matplotlib.pyplot as plt
except ImportError:
  print("Error: matplotlib library not found. Please install it using 'pip install matplotlib'.")
  exit()

try:
  import pandas as pd
except ImportError:
  print("Error: pandas library not found. Please install it using 'pip install pandas'.")
  exit()

try:
  import requests
except ImportError:
  print("Error: requests library not found. Please install it using 'pip install requests'.")
  exit()

from io import BytesIO

try:
  from utils import *
except ImportError:
  print("Error: utils.py module not found. Please ensure it's present in the same directory.")
  exit()

try:
  import seaborn as sns
except ImportError:
  print("Error: seaborn library not found. Please install it using 'pip install seaborn'.")
  exit()

try:
  from rdkit import Chem
  from rdkit.ML.Descriptors import MoleculeDescriptors
  from rdkit.Chem import Descriptors
except ImportError:
  print("Error: rdkit library not found. Please install it using 'pip install rdkit'.")
  exit()


# URLs of the Excel files
url1 = 'https://www.fda.gov/media/175738/download?attachment'
url2 = 'https://www.fda.gov/media/175739/download?attachment'

# Download and read the first Excel file
response1 = requests.get(url1)
labeling = pd.read_excel(BytesIO(response1.content), sheet_name='Pediatric Labeling Changes', header=1, engine='openpyxl')

# Download and read the second Excel file
response2 = requests.get(url2)
study = pd.read_excel(BytesIO(response2.content), sheet_name='BPCA PREA Pediatric Studies', engine='openpyxl')
labeling.columns = labeling.columns.str.strip()
study.columns = study.columns.str.strip()

merged = labeling.merge(study, how='outer')

merged['Pediatric Labeling Date'] = pd.to_datetime(labeling['Pediatric Labeling Date'], format='%m/%d/%Y')
merged['Pediatric Labeling Approval Date'] = pd.to_datetime(study['Pediatric Labeling Approval Date'], format='%m/%d/%Y')
merged['Pediatric Labeling Date'] = merged['Pediatric Labeling Date'].astype(str)
merged['Pediatric Labeling Approval Date'] = merged['Pediatric Labeling Approval Date'].astype(str)


merged.rename(columns={
    'FDA Application Number(s)': 'FDAAppNum',
    'Pediatric Labeling Date': 'LabelDate',
    'Trade Name': 'TradeName',
    'Generic Name': 'GenericName',
    'Type of Legislation': 'LegislationType',
    'Indication': 'Indication',
    'Indication(s) Studied': 'IndicationStudied',
    'Labeling Change Summary': 'LabelSummary',
    'Therapeutic Category': 'TheraCategory',
    'Dosage Form(s)': 'DoseForm',
    'Route(s) of Administration': 'RouteAdmin',
    'Studied in Neonates': 'StudiedNeonates',
    'Indicated in Neonates': 'IndicatedNeonates',
    'Pediatric Labeling Approval Date': 'ApprovalDate',
    'Pharmacological Class': 'PharmaClass',
    'Product Labeling Link': 'LabelLink',
    'Study Number': 'StudyId',
    'Ages Studied': 'AgesStudied',
    'Study Type': 'StudyType',
    'Study Design': 'StudyDesign',
    'Patients Enrolled': 'PatientsEnrolled',
    'Patients Analyzed': 'PatientsAnalyzed',
    'Number of Centers': 'NumCenters',
    'Number of Countries': 'NumCountries',
    'Country Names': 'CountryName',
    'Notes': 'Notes',
    'Total # of Hispanic/Latino': 'Hispanic/Latino',
    'Total # of Non-Hispanic/Non-Latino': 'Non Hispanic/Non Latino',
    'Total #  of Unknown Ethnicity': 'Unknown Ethnicity',
    'Total #  of Asian': 'Asian',
    'Total #  of Black': 'Black',
    'Total #  of White': 'White',
    'Total #  of Native Hawaiian or Pacific Islander': 'Native Hawaiian/Pacific Islander',
    'Total #  of American Indian/Alaska Native': 'American Indian/Alaska Native',
    'Total #  of Other Race': 'Other Race',
    'Total #  of Unknown Race': 'Unknown Race'
}, inplace=True)

merged['StudiedNeonates'] = [True if neonate == "X" else False for neonate in merged['StudiedNeonates']]
merged['IndicatedNeonates'] = [True if neonate == "X" else False for neonate in merged['IndicatedNeonates']]


#Fixing multi-valued columns
merged = split(merged, 'FDAAppNum', '\n')
merged = split(merged, 'DoseForm', '\n')
merged = split(merged, 'RouteAdmin', '\n')
merged = split(merged, 'StudyId', '\n')
merged = split(merged, 'AgesStudied', '\n')
merged = split(merged, 'StudyType', '\n')
merged = split(merged, 'StudyDesign', '\n')
merged = split(merged, 'PatientsEnrolled', '\n')
merged = split(merged, 'PatientsAnalyzed', '\n')
merged = split(merged, 'NumCenters', '\n')
merged = split(merged, 'NumCountries', '\n')
merged = split(merged, 'Hispanic/Latino', '\n')
merged = split(merged, 'Non Hispanic/Non Latino', '\n')
merged = split(merged, 'Unknown Ethnicity', '\n')
merged = split(merged, 'Asian', '\n')
merged = split(merged, 'Black', '\n')
merged = split(merged, 'White', '\n')
merged = split(merged, 'Native Hawaiian/Pacific Islander', '\n')
merged = split(merged, 'American Indian/Alaska Native', '\n')
merged = split(merged, 'Other Race', '\n')
merged = split(merged, 'Unknown Race', '\n')
merged = split(merged, 'CountryName', '\n')
merged = split(merged, 'StudyType', ',')
merged = split(merged, 'StudyDesign', ',')
merged = split(merged, 'TradeName', ',')
merged = split(merged, 'Indication', ',')
merged = split(merged, 'TheraCategory', ',')
merged = split(merged, 'PharmaClass', ';')
merged = split(merged, 'TradeName', ';')
merged = split(merged, 'StudyType', ',')
merged = split(merged, 'CountryName', ',')
merged = split(merged, 'DoseForm', ',')
merged = merged.replace({"N/A": None, "\r": "", "\t": "     "}, regex=True)

merged = split(merged, 'GenericName', '/')


merged = merged.map(lambda x: x.strip() if isinstance(x, str) else x)
merged = merged.drop_duplicates()

#adding country code
add_country_codes(merged, 'CountryName')

#adding smiles
add_smiles_to_df(merged, 'GenericName')

merged.insert(0, 'FDAAppId', range(1, len(merged) + 1))

Application = merged[['FDAAppId', 'FDAAppNum', 'Notes', 'LabelLink', 'IndicationStudied', 'TheraCategory', 'LabelDate', 'LabelSummary']] 
Application = Application.drop_duplicates()

Ages = create_index(merged, 'AgesStudied', 'AgesId')
Ages = Ages.drop_duplicates()

Cohort = merged[['FDAAppId', 'StudyId', 'PatientsEnrolled', 'PatientsAnalyzed', 'NumCenters', 'NumCountries', 'ApprovalDate', 'AgesId']]
Cohort = Cohort.drop_duplicates()

LegislationType, Legislation_App = join(merged, 'LegislationType', 'LegislationTypeId')
Legislation_App = Legislation_App[['LegislationTypeId', 'FDAAppId']]
LegislationType = LegislationType.drop_duplicates()
Legislation_App = Legislation_App.drop_duplicates()

Ethnicity_Names = ['Hispanic/Latino', 'Non Hispanic/Non Latino', 'Unknown Ethnicity']
Race_Names = ['Asian', 'Black', 'White', 'Native Hawaiian/Pacific Islander', 'American Indian/Alaska Native', 'Other Race', 'Unknown Race']
Ethnicity_Mapping = get_mapping_of_col(merged, Ethnicity_Names, 'EthnicityName', 'EthnicityId', 'EthnicityCount')
Race_Mapping = get_mapping_of_col(merged, Race_Names, 'RaceName', 'RaceId', 'RaceCount')

Race_Name =  Race_Mapping[['RaceId', 'RaceName',]]
Race = Race_Mapping[['FDAAppId', 'StudyId', 'RaceId', 'RaceCount']]
Race_Name = Race_Name.drop_duplicates()
Race = Race.drop_duplicates()

Ethnicity_Name = Ethnicity_Mapping[['EthnicityId', 'EthnicityName']]
Ethnicity = Ethnicity_Mapping[['FDAAppId', 'StudyId', 'EthnicityId', 'EthnicityCount']]
Ethnicity_Name = Ethnicity_Name.drop_duplicates()
Ethnicity = Ethnicity.drop_duplicates()

StudyType, Cohort_Study_Type = join(merged, 'StudyType', 'StudyTypeId')
Cohort_Study_Type = Cohort_Study_Type[['FDAAppId', 'StudyId', 'StudyTypeId']]
StudyType = StudyType.drop_duplicates()
Cohort_Study_Type = Cohort_Study_Type.drop_duplicates()

StudyDesign, Cohort_Study_Design = join(merged, 'StudyDesign', 'StudyDesignId')
Cohort_Study_Design = Cohort_Study_Design[['FDAAppId', 'StudyId', 'StudyDesignId']]
StudyDesign = StudyDesign.drop_duplicates()
Cohort_Study_Design = Cohort_Study_Design.drop_duplicates()

GenericName = create_index(merged, 'GenericName', 'GenericNameId')
GenericName = GenericName.drop_duplicates()

TradeName = create_index(merged, 'TradeName', 'TradeNameId')
TradeName = TradeName.drop_duplicates()

Generic_Trade = merged[['TradeNameId', 'GenericNameId']]
Generic_Trade = Generic_Trade.drop_duplicates()

Smiles, GenericName_Smiles = join(merged, 'SmilesName', 'SmilesId')
GenericName_Smiles = GenericName_Smiles[['GenericNameId', 'SmilesId']]
Smiles = Smiles.drop_duplicates()
GenericName_Smiles = GenericName_Smiles.drop_duplicates()

Drug_App = merged[['GenericNameId', 'FDAAppId']]
Drug_App = Drug_App.drop_duplicates()

Dose, Dose_App = join(merged, 'DoseForm', 'DoseId')
Dose_App = Dose_App[['DoseId', 'FDAAppId']]
Dose = Dose.drop_duplicates()
Dose_App = Dose_App.drop_duplicates()

Route, Route_App = join(merged, 'RouteAdmin', 'RouteId')
Route_App = Route_App[['RouteId', 'FDAAppId']]
Route = Route.drop_duplicates()
Route_App = Route_App.drop_duplicates()

Country, Country_App = join(merged, 'CountryName', 'CountryId')
Country_App = Country_App[['CountryId', 'FDAAppId']]
Country = Country.drop_duplicates()
Country_App = Country_App.drop_duplicates()

Neonates, Neonate_App = join_on_two_columns(merged, 'StudiedNeonates', 'IndicatedNeonates', 'NeonateId') 
Neonate_App = Neonate_App[['NeonateId', 'FDAAppId']]
Neonates = Neonates.drop_duplicates()
Neonate_App = Neonate_App.drop_duplicates()

Indication, Indication_App = join(merged, 'Indication', 'IndicationId')
Indication_App = Indication_App[['IndicationId', 'FDAAppId']]
Indication = Indication.drop_duplicates()
Indication_App = Indication_App.drop_duplicates()

PharmaClass, Pharma_App = join(merged, 'PharmaClass', 'PharmaClassId')
Pharma_App = Pharma_App[['PharmaClassId', 'FDAAppId']]
PharmaClass = PharmaClass.drop_duplicates()
Pharma_App = Pharma_App.drop_duplicates()

tables = {
    "Application": Application, 
    "Cohort": Cohort, 
    "LegislationType": LegislationType, 
    "Legislation_App": Legislation_App,
    "Race_Name" : Race_Name,
    "Race" : Race,
    "Ethnicity_Name" : Ethnicity_Name, 
    "Ethnicity" : Ethnicity, 
    "Ages" : Ages, 
    "StudyType" : StudyType, 
    "StudyDesign" : StudyDesign, 
    "Cohort_Study_Type" : Cohort_Study_Type, 
    "Cohort_Study_Design" : Cohort_Study_Design, 
    "GenericName" : GenericName, 
    "TradeName" : TradeName, 
    "Generic_Trade" : Generic_Trade, 
    "Smiles" : Smiles, 
    "GenericName_Smiles" : GenericName_Smiles, 
    "Drug_App" : Drug_App, 
    "Dose" : Dose,
    "Dose_App" : Dose_App,
    "Route" : Route,
    "Route_App" : Route_App,
    "Country" : Country,
    "Country_App" : Country_App,
    "Neonates" : Neonates,
    "Neonate_App" : Neonate_App,
    "Indication" : Indication,
    "Indication_App" : Indication_App,
    "PharmaClass" : PharmaClass,
    "Pharma_App" : Pharma_App
}
db_file = "PediatricLabeling.db"

# Delete the database file if it exists
if os.path.exists(db_file):
    os.remove(db_file)

con = sqlite3.connect("PediatricLabeling.db")
cur = con.cursor()
sql_commands = open('schema.sql', mode = 'r').read().split(';')
for sql_command in sql_commands:
    cur.execute(sql_command)

for key, value in tables.items():
    # I had to add this in because the SMILES API stopped working (started being busy)
    if value.empty:
        continue
    value = list(value.apply(tuple, axis = 1))
    cur.executemany(f'INSERT INTO {key} VALUES({("?," * len(value[0]))[:-1]})', value)
    con.commit()  

# Retrieve SMILES strings from the database
cur.execute("SELECT SmilesId, SmilesName FROM SMILES")
smiles_data = cur.fetchall()

# List of descriptors
descriptor_names = [desc[0] for desc in Descriptors._descList]
calculator = MoleculeDescriptors.MolecularDescriptorCalculator(descriptor_names)

# Compute descriptors and insert into the database
for smiles_id, smiles in smiles_data:
    mol = Chem.MolFromSmiles(smiles)
    if mol:
        descriptors = calculator.CalcDescriptors(mol)
        for name, value in zip(descriptor_names, descriptors):
            cur.execute("INSERT INTO MolecularDescriptors (SmilesId, DescriptorName, DescriptorValue) VALUES (?, ?, ?)",
                           (smiles_id, name, value))

# Commit the changes
con.commit()
con.close()
