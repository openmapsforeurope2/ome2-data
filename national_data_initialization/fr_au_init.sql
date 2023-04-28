-- Création de la table locale au.arrondissement_municipal (copie de la table BDUni avec sélection d'attributs)
DROP TABLE IF EXISTS au.arrondissement_municipal;
CREATE TABLE IF NOT EXISTS au.arrondissement_municipal
(
    cleabs character varying(24) COLLATE pg_catalog."default" NOT NULL,
    code_insee character varying(5) COLLATE pg_catalog."default",
    code_insee_de_la_commune_de_rattach character varying(5) COLLATE pg_catalog."default",
    nom_officiel character varying COLLATE pg_catalog."default",
    date_d_apparition date,
    lien_vers_chef_lieu character varying(24) COLLATE pg_catalog."default",
    liens_vers_autorite_administrative character varying COLLATE pg_catalog."default",    
    gcms_territoire character varying COLLATE pg_catalog."default" NOT NULL,
    geometrie_ge geometry(MultiPolygon),
    CONSTRAINT arrondissement_municipal_pkey PRIMARY KEY (cleabs)
)
TABLESPACE pg_default;

-- Création de la table locale au.commune (copie de la table BDUni avec sélection d'attributs)
CREATE TABLE IF NOT EXISTS au.commune
(
    cleabs character varying(24) COLLATE pg_catalog."default" NOT NULL,
    code_insee character varying(5) COLLATE pg_catalog."default",
    code_insee_de_l_arrondissement character varying(5) COLLATE pg_catalog."default",
    code_insee_du_departement character varying(5) COLLATE pg_catalog."default",
    code_insee_de_la_region character varying(5) COLLATE pg_catalog."default",  
    nom_officiel character varying COLLATE pg_catalog."default",
    gcms_territoire character varying COLLATE pg_catalog."default" NOT NULL,
    geometrie_ge geometry(MultiPolygon),
    CONSTRAINT commune_pkey PRIMARY KEY (cleabs)
)
TABLESPACE pg_default;

-- Création des champs nécessaires sur au.arrondissement_municipal 
ALTER TABLE au.arrondissement_municipal 
ADD COLUMN code_insee_de_la_region character varying(5), 
ADD COLUMN code_insee_du_departement character varying(5), 
ADD COLUMN code_insee_de_l_arrondissement character varying(5);

-- Mise à jour des champs par jointure attributaire
UPDATE au.arrondissement_municipal
SET code_insee_de_la_region = au.commune.code_insee_de_la_region,
code_insee_du_departement = au.commune.code_insee_du_departement,
code_insee_de_l_arrondissement = au.commune.code_insee_de_l_arrondissement
FROM au.commune
WHERE au.arrondissement_municipal.code_insee_de_la_commune_de_rattach = au.commune.code_insee;
