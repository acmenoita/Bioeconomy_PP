import pandas as pd
import numpy as np

#Carregar o conjunto de dados necessarios
forest_areas = pd.read_csv(r"C:\Users\anaca\DMSPROJECT\bioeconomy_resin\processed_data\forest_areas.csv")
extraction_costs = pd.read_csv(r"C:\Users\anaca\DMSPROJECT\bioeconomy_resin\processed_data\extraction_costs.csv")
environmental_impact = pd.read_csv(r"C:\Users\anaca\DMSPROJECT\bioeconomy_resin\processed_data\environmental_impact.csv")
workforce = pd.read_csv(r"C:\Users\anaca\DMSPROJECT\bioeconomy_resin\processed_data\workforce.csv")
resin_production = pd.read_csv(r"C:\Users\anaca\DMSPROJECT\bioeconomy_resin\processed_data\resin_production.csv")

#Limpeza e transformaçao dos dados
#Remover as linhas com valores em falta
forest_areas = forest_areas.dropna()
extraction_costs = extraction_costs.dropna()
environmental_impact = environmental_impact.dropna()
workforce = workforce.dropna()
resin_production = resin_production.dropna()


#Converter a produçao de toneladas para Kg
resin_production["Production(Kg)"] = resin_production["Production(T)"] * 1000

# Garantir que o nome das regioes estao em todos os conjuntos de dados
def standardize_region_name(name):
    return name.strip().lower().replace(" ","_")

datasets = [forest_areas, extraction_costs, environmental_impact, workforce, resin_production]
for dataset in datasets:
    dataset['region'] = dataset['region'].apply(standardize_region_name)

# Guardar os conjuntos de dados ja limpos
forest_areas.to_csv(r"C:\Users\anaca\DMSPROJECT\bioeconomy_resin\processed_data\forest_areas.csv", index=False)
extraction_costs.to_csv(r"C:\Users\anaca\DMSPROJECT\bioeconomy_resin\processed_data\extraction_costs.csv", index=False)
environmental_impact.to_csv(r"C:\Users\anaca\DMSPROJECT\bioeconomy_resin\processed_data\environmental_impact.csv", index=False)
workforce.to_csv(r"C:\Users\anaca\DMSPROJECT\bioeconomy_resin\processed_data\workforce.csv", index=False)
resin_production.to_csv(r"C:\Users\anaca\DMSPROJECT\bioeconomy_resin\processed_data\resin_production.csv", index=False)

