ALTER TABLE hy.troncon_hydrographique ADD COLUMN lien_vers_cours_d_eau_principal varchar(80);

ALTER TABLE hy.troncon_hydrographique ADD COLUMN lien1 varchar(25); 
UPDATE hy.troncon_hydrographique SET lien1 = substring(liens_vers_cours_d_eau,1,24);
ALTER TABLE hy.troncon_hydrographique ADD COLUMN lien2 varchar(25); 
UPDATE hy.troncon_hydrographique SET lien2 = substring(liens_vers_cours_d_eau,26,24);
ALTER TABLE hy.troncon_hydrographique ADD COLUMN lien3 varchar(25); 
UPDATE hy.troncon_hydrographique SET lien3 = substring(liens_vers_cours_d_eau,51,24);

ALTER TABLE hy.troncon_hydrographique ADD COLUMN length1 real; 
UPDATE hy.troncon_hydrographique 
SET length1 = ST_length(hy.cours_d_eau.geometrie_ge)
FROM hy.cours_d_eau
WHERE hy.troncon_hydrographique.lien1 = hy.cours_d_eau.cleabs ;

ALTER TABLE hy.troncon_hydrographique ADD COLUMN length2 real; 
UPDATE hy.troncon_hydrographique 
SET length2 = ST_length(hy.cours_d_eau.geometrie_ge)
FROM hy.cours_d_eau
WHERE hy.troncon_hydrographique.lien2 = hy.cours_d_eau.cleabs ;

ALTER TABLE hy.troncon_hydrographique ADD COLUMN length3 real; 
UPDATE hy.troncon_hydrographique 
SET length3 = ST_length(hy.cours_d_eau.geometrie_ge)
FROM hy.cours_d_eau
WHERE hy.troncon_hydrographique.lien3 = hy.cours_d_eau.cleabs ;

UPDATE hy.troncon_hydrographique
SET lien_vers_cours_d_eau_principal =
CASE
  WHEN length1 is not null AND (length1 >= length2 OR length2 is null ) and (length1 >= length3 OR length3 is null) THEN lien1
  WHEN length2 is not null AND length2 >= length1 AND (length2 >= length3 OR length3 is null) THEN lien2
  WHEN length3 is not null AND length3 >= length1 AND length3 >= length2 THEN lien3
  ELSE 'void'
END;

ALTER TABLE hy.troncon_hydrographique ADD COLUMN cpx_influence_de_la_maree boolean;
ALTER TABLE hy.troncon_hydrographique ADD COLUMN cpx_code_hydrographique character varying(80);
UPDATE hy.troncon_hydrographique
SET cpx_influence_de_la_maree = hy.cours_d_eau.influence_de_la_maree, cpx_code_hydrographique = hy.cours_d_eau.code_hydrographique
FROM hy.cours_d_eau
WHERE hy.troncon_hydrographique.lien_vers_cours_d_eau_principal = hy.cours_d_eau.cleabs ;

ALTER TABLE hy.troncon_hydrographique DROP COLUMN lien1;
ALTER TABLE hy.troncon_hydrographique DROP COLUMN lien2;
ALTER TABLE hy.troncon_hydrographique DROP COLUMN lien3;
ALTER TABLE hy.troncon_hydrographique DROP COLUMN length1;
ALTER TABLE hy.troncon_hydrographique DROP COLUMN length2;
ALTER TABLE hy.troncon_hydrographique DROP COLUMN length3;