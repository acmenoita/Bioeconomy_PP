USE bioeconomy_resin;

#Produção total de resina por região e relação com área florestal
SELECT fa.region, 
       fa.hectares AS florest_areas,
       rp.Production_Kg AS resin_production_kg,
       rp.Production_Euros AS resin_production_euros,
       rp.Production_Kg / af.hectares AS production_hectare
FROM florest_areas fa
INNER JOIN resin_production rp ON fa.ID_region = rp.ID_region;

#Eficiência da produção de resina por trabalhador
SELECT wf.region,
       rp.Production_T / wf.Workers AS efficiency_kg_per_worker
FROM workforce wf
INNER JOIN resin_production rp ON wf.ID_region = rp.ID_region
ORDER BY efficiency_kg_per_worker DESC;

#Custos de extração e produção por região
SELECT region,
       Extraction_Cost AS extraction_cost,
       Production_Cost AS production_cost
FROM extraction_cost;

#CO2 evitado por regiao 
SELECT ei.region,
       ei.CO2_Avoided AS co2_evitado,
       rp.Production_Kg,
       ei.CO2_Avoided / rp.Production_kg AS co2_avoided_per_Kg
FROM environmental_impact ei
INNER JOIN resin_production rp ON ei.ID_region = rp.ID_region;

#Relaçao entre o numero de trabalhadores com a producao de resina
SELECT wf.region,
       wf.Workers,
       rp.Production_Kg,
       rp.Production_Kg / wf.Workers AS production_per_worker
FROM workforce wf
INNER JOIN resin_production rp ON wf.ID_region = rp.ID_region;

#Relaçao custo-beenficio da producao de resina
SELECT ec.region,
       rp.Production_Euros / (ec.Extraction_Cost + ec.Production_Cost) AS cost_benefit_ratio
FROM extraction_costs ec
INNER JOIN resin_production rp ON ec.ID_region = rp.ID_region
ORDER BY cost_benefit_ratio DESC;

#Comparaçao do euros e de kg
SELECT region,
       Production_Kg,
       Production_Euros,
       Production_Euros / Production_Kg AS value_per_kg
FROM resin_production
ORDER BY value_per_kg DESC;

#Relaçao entre a area florestal e a eficiencia da produçao
SELECT fa.region,
       fa.hectares,
       rp.Production_Kg,
       rp.Production_Kg / fa.hectares AS efficiency_per_hectare
FROM florest_areas fa
INNER JOIN resin_production rp ON fa.ID_region = rp.ID_region
ORDER BY efficiency_per_hectare DESC;

Potencial de expansao (considerando a area florestal e a efeciencia atual)
SELECT fa.region,
       fa.hectares,
       rp.Production_Kg,
       rp.Production_Kg / fa.hectares AS current_efficiency,
       fa.hectares * (SELECT MAX(Production_Kg / hectares) FROM resin_production JOIN florest_areas ON resin_production.ID_region = florest_areas.ID_region) AS potential_output
FROM florest_areas fa
INNER JOIN resin_production rp ON fa.ID_region = rp.ID_region
ORDER BY potential_output - rp.Production_Kg DESC;

#Relaçao entre o imapcto ambiental e a escala de produçao
SELECT ei.region,
       ei.CO2_Avoided,
       rp.Production_Kg,
       ei.CO2_Avoided / rp.Production_Kg AS co2_avoided_per_Kg
FROM environmental_impact ei
INNER JOIN resin_production rp ON ei.ID_region = rp.ID_region
ORDER BY co2_avoided_per_Kg DESC;
