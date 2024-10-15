create database grupo_fernanda
use grupo_fernanda

select *
from `ocorrencia_tipo.csv` otc ;

ALTER TABLE `ocorrencia_tipo.csv` drop COLUMN id_tipo_ocorrencia;

CREATE TABLE tipo_ocorrencia (
    ocorrencia_tipo VARCHAR(255),
    ocorrencia_tipo_categoria VARCHAR(255),
    taxonomia_tipo_icao VARCHAR(255),
    PRIMARY KEY (ocorrencia_tipo, ocorrencia_tipo_categoria, taxonomia_tipo_icao)
);
INSERT INTO tipo_ocorrencia (ocorrencia_tipo, ocorrencia_tipo_categoria, taxonomia_tipo_icao)
SELECT DISTINCT ocorrencia_tipo, ocorrencia_tipo_categoria, taxonomia_tipo_icao
FROM `ocorrencia_tipo.csv` ;

ALTER TABLE `ocorrencia_tipo.csv` drop COLUMN id_tipo_ocorrencia;

ALTER TABLE `ocorrencia_tipo.csv` ADD COLUMN id_tipo_ocorrencia INT;

select *
from tipo_ocorrencia to2 ;

ALTER TABLE tipo_ocorrencia DROP PRIMARY KEY;


UPDATE `ocorrencia_tipo.csv` o
JOIN tipo_ocorrencia t
ON o.ocorrencia_tipo = t.ocorrencia_tipo
AND o.ocorrencia_tipo_categoria = t.ocorrencia_tipo_categoria
AND o.taxonomia_tipo_icao = t.taxonomia_tipo_icao
SET o.id_tipo_ocorrencia = t.id_tipo_ocorrencia;


ALTER TABLE `ocorrencia_tipo.csv` 
DROP COLUMN ocorrencia_tipo,
DROP COLUMN ocorrencia_tipo_categoria,
DROP COLUMN taxonomia_tipo_icao;


