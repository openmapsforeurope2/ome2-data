-- troncon_hydrographique : recuperation des champs cpx_influence_de_la_maree et cpx_code_hydrographique issus de cours_d_eau
ALTER TABLE troncon_hydrographique ADD COLUMN lien_vers_cours_d_eau_principal varchar(80);

ALTER TABLE troncon_hydrographique ADD COLUMN lien1 varchar(25); 
UPDATE troncon_hydrographique SET lien1 = substring(liens_vers_cours_d_eau,1,24);
ALTER TABLE troncon_hydrographique ADD COLUMN lien2 varchar(25); 
UPDATE troncon_hydrographique SET lien2 = substring(liens_vers_cours_d_eau,26,24);
ALTER TABLE troncon_hydrographique ADD COLUMN lien3 varchar(25); 
UPDATE troncon_hydrographique SET lien3 = substring(liens_vers_cours_d_eau,51,24);

ALTER TABLE troncon_hydrographique ADD COLUMN length1 real; 
UPDATE troncon_hydrographique 
SET length1 = ST_length(cours_d_eau.geometrie_ge)
FROM cours_d_eau
WHERE troncon_hydrographique.lien1 = cours_d_eau.cleabs ;

ALTER TABLE troncon_hydrographique ADD COLUMN length2 real; 
UPDATE troncon_hydrographique 
SET length2 = ST_length(cours_d_eau.geometrie_ge)
FROM cours_d_eau
WHERE troncon_hydrographique.lien2 = cours_d_eau.cleabs ;

ALTER TABLE troncon_hydrographique ADD COLUMN length3 real; 
UPDATE troncon_hydrographique 
SET length3 = ST_length(cours_d_eau.geometrie_ge)
FROM cours_d_eau
WHERE troncon_hydrographique.lien3 = cours_d_eau.cleabs ;

UPDATE troncon_hydrographique
SET lien_vers_cours_d_eau_principal =
CASE
  WHEN length1 is not null AND (length1 >= length2 OR length2 is null ) and (length1 >= length3 OR length3 is null) THEN lien1
  WHEN length2 is not null AND length2 >= length1 AND (length2 >= length3 OR length3 is null) THEN lien2
  WHEN length3 is not null AND length3 >= length1 AND length3 >= length2 THEN lien3
  ELSE 'void'
END;

ALTER TABLE troncon_hydrographique ADD COLUMN cpx_influence_de_la_maree boolean;
ALTER TABLE troncon_hydrographique ADD COLUMN cpx_code_hydrographique character varying(80);
UPDATE troncon_hydrographique
SET cpx_influence_de_la_maree = cours_d_eau.influence_de_la_maree, cpx_code_hydrographique = cours_d_eau.code_hydrographique
FROM cours_d_eau
WHERE troncon_hydrographique.lien_vers_cours_d_eau_principal = cours_d_eau.cleabs ;

ALTER TABLE troncon_hydrographique DROP COLUMN lien1;
ALTER TABLE troncon_hydrographique DROP COLUMN lien2;
ALTER TABLE troncon_hydrographique DROP COLUMN lien3;
ALTER TABLE troncon_hydrographique DROP COLUMN length1;
ALTER TABLE troncon_hydrographique DROP COLUMN length2;
ALTER TABLE troncon_hydrographique DROP COLUMN length3;


-- surface_hydrographique : recuperation des champs cpx_influence_de_la_maree et cpx_code_hydrographique issus de cours_d_eau
ALTER TABLE surface_hydrographique ADD COLUMN lien_vers_cours_d_eau_principal varchar(80);

ALTER TABLE surface_hydrographique ADD COLUMN lien1 varchar(25); 
UPDATE surface_hydrographique SET lien1 = substring(liens_vers_cours_d_eau,1,24);
ALTER TABLE surface_hydrographique ADD COLUMN lien2 varchar(25); 
UPDATE surface_hydrographique SET lien2 = substring(liens_vers_cours_d_eau,26,24);
ALTER TABLE surface_hydrographique ADD COLUMN lien3 varchar(25); 
UPDATE surface_hydrographique SET lien3 = substring(liens_vers_cours_d_eau,51,24);

ALTER TABLE surface_hydrographique ADD COLUMN length1 real; 
UPDATE surface_hydrographique 
SET length1 = ST_length(cours_d_eau.geometrie_ge)
FROM cours_d_eau
WHERE surface_hydrographique.lien1 = cours_d_eau.cleabs ;

ALTER TABLE surface_hydrographique ADD COLUMN length2 real; 
UPDATE surface_hydrographique 
SET length2 = ST_length(cours_d_eau.geometrie_ge)
FROM cours_d_eau
WHERE surface_hydrographique.lien2 = cours_d_eau.cleabs ;

ALTER TABLE surface_hydrographique ADD COLUMN length3 real; 
UPDATE surface_hydrographique 
SET length3 = ST_length(cours_d_eau.geometrie_ge)
FROM cours_d_eau
WHERE surface_hydrographique.lien3 = cours_d_eau.cleabs ;

UPDATE surface_hydrographique
SET lien_vers_cours_d_eau_principal =
CASE
  WHEN length1 is not null AND (length1 >= length2 OR length2 is null ) and (length1 >= length3 OR length3 is null) THEN lien1
  WHEN length2 is not null AND length2 >= length1 AND (length2 >= length3 OR length3 is null) THEN lien2
  WHEN length3 is not null AND length3 >= length1 AND length3 >= length2 THEN lien3
  ELSE 'void'
END;

ALTER TABLE surface_hydrographique ADD COLUMN cpx_influence_de_la_maree boolean;
ALTER TABLE surface_hydrographique ADD COLUMN cpx_code_hydrographique character varying(80);
UPDATE surface_hydrographique
SET cpx_influence_de_la_maree = cours_d_eau.influence_de_la_maree, cpx_code_hydrographique = cours_d_eau.code_hydrographique
FROM cours_d_eau
WHERE surface_hydrographique.lien_vers_cours_d_eau_principal = cours_d_eau.cleabs ;

ALTER TABLE surface_hydrographique DROP COLUMN lien1;
ALTER TABLE surface_hydrographique DROP COLUMN lien2;
ALTER TABLE surface_hydrographique DROP COLUMN lien3;
ALTER TABLE surface_hydrographique DROP COLUMN length1;
ALTER TABLE surface_hydrographique DROP COLUMN length2;
ALTER TABLE surface_hydrographique DROP COLUMN length3;


-- surface_hydrographique : recuperation des champs cpx_influence_de_la_maree et cpx_code_hydrographique issus de cours_d_eau
ALTER TABLE surface_hydrographique ADD COLUMN lien_vers_pde_principal varchar(80);

ALTER TABLE surface_hydrographique ADD COLUMN lien1 varchar(25); 
UPDATE surface_hydrographique SET lien1 = substring(liens_vers_plan_d_eau,1,24);
ALTER TABLE surface_hydrographique ADD COLUMN lien2 varchar(25); 
UPDATE surface_hydrographique SET lien2 = substring(liens_vers_plan_d_eau,26,24);
ALTER TABLE surface_hydrographique ADD COLUMN lien3 varchar(25); 
UPDATE surface_hydrographique SET lien3 = substring(liens_vers_plan_d_eau,51,24);

ALTER TABLE surface_hydrographique ADD COLUMN area1 real; 
UPDATE surface_hydrographique 
SET area1 = ST_area(plan_d_eau.geometrie_ge)
FROM plan_d_eau
WHERE surface_hydrographique.lien1 = plan_d_eau.cleabs ;

ALTER TABLE surface_hydrographique ADD COLUMN area2 real; 
UPDATE surface_hydrographique 
SET area2 = ST_area(plan_d_eau.geometrie_ge)
FROM plan_d_eau
WHERE surface_hydrographique.lien2 = plan_d_eau.cleabs ;

ALTER TABLE surface_hydrographique ADD COLUMN area3 real; 
UPDATE surface_hydrographique 
SET area3 = ST_area(plan_d_eau.geometrie_ge)
FROM plan_d_eau
WHERE surface_hydrographique.lien3 = plan_d_eau.cleabs ;

UPDATE surface_hydrographique
SET lien_vers_pde_principal =
CASE
  WHEN area1 is not null AND (area1 >= area2 OR area2 is null ) and (area1 >= area3 OR area3 is null) THEN lien1
  WHEN area2 is not null AND area2 >= area1 AND (area2 >= area3 OR area3 is null) THEN lien2
  WHEN area3 is not null AND area3 >= area1 AND area3 >= area2 THEN lien3
  ELSE 'void'
END;

ALTER TABLE surface_hydrographique ADD COLUMN cpx_pde_influence_de_la_maree boolean;
ALTER TABLE surface_hydrographique ADD COLUMN cpx_pde_code_hydrographique character varying(80);
UPDATE surface_hydrographique
SET cpx_pde_influence_de_la_maree = plan_d_eau.influence_de_la_maree, cpx_pde_code_hydrographique = plan_d_eau.code_hydrographique
FROM plan_d_eau
WHERE surface_hydrographique.lien_vers_pde_principal = plan_d_eau.cleabs ;

ALTER TABLE surface_hydrographique DROP COLUMN lien1;
ALTER TABLE surface_hydrographique DROP COLUMN lien2;
ALTER TABLE surface_hydrographique DROP COLUMN lien3;
ALTER TABLE surface_hydrographique DROP COLUMN area1;
ALTER TABLE surface_hydrographique DROP COLUMN area2;
ALTER TABLE surface_hydrographique DROP COLUMN area3;