-- Création de la table locale au.commune (copie de la table BDUni avec sélection d'attributs)
DROP TABLE IF EXISTS au.commune;
CREATE TABLE IF NOT EXISTS au.commune
(
    cleabs character varying(24) COLLATE pg_catalog."default" NOT NULL,
    code_insee character varying(5) COLLATE pg_catalog."default",
    code_insee_de_l_arrondissement character varying(5) COLLATE pg_catalog."default",
    code_insee_du_departement character varying(5) COLLATE pg_catalog."default",
    code_insee_de_la_region character varying(5) COLLATE pg_catalog."default",  
    nom_officiel character varying COLLATE pg_catalog."default",
    gcms_territoire character varying COLLATE pg_catalog."default" NOT NULL,
    codes_siren_des_epci character varying(32) COLLATE pg_catalog."default",
    geometrie_ge geometry(MultiPolygon),
    CONSTRAINT commune_pkey PRIMARY KEY (cleabs)
)
TABLESPACE pg_default;

-- Création de la table locale au.etat (copie de la table BDUni avec sélection d'attributs)
DROP TABLE IF EXISTS au.etat;
CREATE TABLE IF NOT EXISTS au.etat
(
    cleabs character varying(24) COLLATE pg_catalog."default" NOT NULL,
    code_insee character varying(5) COLLATE pg_catalog."default",
    nom_officiel character varying COLLATE pg_catalog."default",
    gcms_territoire character varying COLLATE pg_catalog."default",
    geometrie_ge geometry(MultiPolygon),
    CONSTRAINT etat_pkey PRIMARY KEY (cleabs)
)
TABLESPACE pg_default;

-- Création de la table locale au.region (copie de la table BDUni avec sélection d'attributs)
DROP TABLE IF EXISTS au.region;
CREATE TABLE IF NOT EXISTS au.region
(
    cleabs character varying(24) COLLATE pg_catalog."default" NOT NULL,
    code_insee character varying(5) COLLATE pg_catalog."default",
    nom_officiel character varying COLLATE pg_catalog."default",
    gcms_territoire character varying COLLATE pg_catalog."default" NOT NULL,
    geometrie_ge geometry(MultiPolygon),
    CONSTRAINT region_pkey PRIMARY KEY (cleabs)
)
TABLESPACE pg_default;

-- Création de la table locale au.departement (copie de la table BDUni avec sélection d'attributs)
DROP TABLE IF EXISTS au.departement;
CREATE TABLE IF NOT EXISTS au.departement
(
    cleabs character varying(24) COLLATE pg_catalog."default" NOT NULL,
    code_insee character varying(5) COLLATE pg_catalog."default",
    code_insee_de_la_region character varying(5) COLLATE pg_catalog."default",  
    nom_officiel character varying COLLATE pg_catalog."default",
    gcms_territoire character varying COLLATE pg_catalog."default" NOT NULL,
    geometrie_ge geometry(MultiPolygon),
    CONSTRAINT departement_pkey PRIMARY KEY (cleabs)
)
TABLESPACE pg_default;

-- Création de la table locale au.arrondissement (copie de la table BDUni avec sélection d'attributs)
DROP TABLE IF EXISTS au.arrondissement;
CREATE TABLE IF NOT EXISTS au.arrondissement
(
    cleabs character varying(24) COLLATE pg_catalog."default" NOT NULL,
    code_insee_de_l_arrondissement character varying(5) COLLATE pg_catalog."default",
    code_insee_du_departement character varying(5) COLLATE pg_catalog."default",
    code_insee_de_la_region character varying(5) COLLATE pg_catalog."default",  
    nom_officiel character varying COLLATE pg_catalog."default",
    gcms_territoire character varying COLLATE pg_catalog."default" NOT NULL,
    geometrie_ge geometry(MultiPolygon),
    CONSTRAINT arrondissement_pkey PRIMARY KEY (cleabs)
)
TABLESPACE pg_default;

-- Création de la table locale au.epci (copie de la table BDUni avec sélection d'attributs)
DROP TABLE IF EXISTS au.epci;
CREATE TABLE IF NOT EXISTS au.epci
(
    cleabs character varying(24) COLLATE pg_catalog."default" NOT NULL,
    code_siren character varying(9) COLLATE pg_catalog."default",
    nature character varying(50) COLLATE pg_catalog."default",
    nom_officiel character varying COLLATE pg_catalog."default",
    gcms_territoire character varying COLLATE pg_catalog."default" NOT NULL,
    geometrie_ge geometry(MultiPolygon),
    CONSTRAINT epci_pkey PRIMARY KEY (cleabs)
)
TABLESPACE pg_default;


-- A LANCER EN SUIVANT LA DOC

ALTER TABLE au.commune ADD COLUMN codes_siren_des_epci_trunc character varying(32);
UPDATE au.commune SET codes_siren_des_epci_trunc = SUBSTRING(codes_siren_des_epci, 0, 10);

ALTER TABLE au.commune ADD COLUMN code_epci_ebm character varying(32);
UPDATE au.commune
SET code_epci_ebm = au.ebm_nam_2024_fr.code_epci
FROM au.ebm_nam_2024_fr
WHERE SUBSTRING(au.commune.codes_siren_des_epci_trunc,0,10) = SUBSTRING(au.ebm_nam_2024_fr.siren_epci,0,10);

UPDATE au.commune SET code_epci_ebm = '0Z1' WHERE codes_siren_des_epci_trunc = '249730052';
UPDATE au.commune SET code_epci_ebm = '410' WHERE codes_siren_des_epci_trunc = '200054781';


ALTER TABLE au.epci ADD COLUMN code_epci_ebm character varying(32);
UPDATE au.epci
SET code_epci_ebm = au.ebm_nam_2024_fr.code_epci
FROM au.ebm_nam_2024_fr
WHERE au.epci.code_siren = au.ebm_nam_2024_fr.siren_epci;



