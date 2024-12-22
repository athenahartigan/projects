try:
  import pandas as pd
except ImportError:
  print("Error: pandas library not found. Please install it using 'pip install pandas'.")
  exit()

try:
  import pycountry
except ImportError:
  print("Error: pycountry library not found. Please install it using 'pip install pycountry'.")
  exit()

try:
  import pubchempy as pcp
except ImportError:
  print("Error: pubchempy library not found. Please install it using 'pip install pubchempy'.")
  exit()



def split(df, col, delimiter):
    # Split the column and expand the results
    expanded_df = df[col].str.split(delimiter, expand=True).stack().reset_index(level=1, drop=True).to_frame(name=col)
    
    # Reset the index of the expanded DataFrame
    expanded_df = expanded_df.reset_index(drop=True)
    
    # Drop the original column from the DataFrame
    df = df.drop(columns=[col]).reset_index(drop=True)
    
    # Concatenate the original DataFrame with the expanded DataFrame
    df = pd.concat([df, expanded_df], axis=1)
    
    return df

def get_mapping_of_col(df, columns, col_name, col_id, count_col):
    new_df = pd.DataFrame()
    for idx, col in enumerate(columns):
        copy = df.copy()
        copy[col_name] = col
        copy[col_id] = idx
        copy[count_col] = copy[col]
        new_df = pd.concat([new_df, copy], ignore_index=True)
    return new_df

def create_index_on_two_columns(splitted_df, col_name1, col_name2, id_name):
    unique = splitted_df[[col_name1, col_name2]].drop_duplicates()
    unique.dropna(inplace=True)
    unique[id_name] = range(len(unique))
    splitted_df[id_name] = splitted_df.merge(unique, on=[col_name1, col_name2], how="left")[id_name]
    return unique[[id_name, col_name1, col_name2]]

import pandas as pd

def create_index(splitted_df, col_name, id_name):
    unique = splitted_df[[col_name]].drop_duplicates()
    unique.dropna(inplace=True)
    dictionary = {value: idx for idx, value in enumerate(unique[col_name])}
    table = pd.DataFrame(list(dictionary.items()), columns=[col_name, id_name])
    splitted_df[id_name] = splitted_df[col_name].map(dictionary)
    return table[[id_name, col_name]]

def join(splitted_df, col_name, id_name):
    table = create_index(splitted_df, col_name, id_name)

    dictionary = dict(zip(table[col_name], table[id_name]))
    splitted_df[id_name] = splitted_df[col_name].map(dictionary)
    return table[[id_name, col_name]], splitted_df

def join_on_two_columns(splitted_df, col_name1, col_name2, id_name):
    table = create_index_on_two_columns(splitted_df, col_name1, col_name2, id_name)

    dictionary = dict(zip(zip(table[col_name1], table[col_name2]), table[id_name]))
    splitted_df[id_name] = splitted_df[col_name1].map(dictionary)
    return table[[id_name, col_name1, col_name2]], splitted_df

# adds a column of country codes
def add_country_codes(df, country_column):
    def convert_country_to_iso(country_name):
        try:
            country = pycountry.countries.get(name=country_name)
            return country.alpha_2
        except Exception as e:
            return None 

    df['CountryId'] = df[country_column].apply(convert_country_to_iso)
    return df

# adds a column of isomeric SMILES  
def add_smiles_to_df(df, col):
    cache = {}
    def get_isomeric_smiles(generic_name):
        try:
            if generic_name in cache:
                return cache[generic_name]
            else:
                compounds = pcp.get_compounds(generic_name, 'name')
                if compounds:
                    cache[generic_name] = "\n".join([comp.isomeric_smiles for comp in compounds])
                    return cache[generic_name]
                else:
                    return None
        except Exception as e:
            return None

    df['SmilesName'] = df[col].apply(get_isomeric_smiles)
    return df