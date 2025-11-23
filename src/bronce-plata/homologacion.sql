CREATE OR REPLACE TABLE `data-engineer-410822.oro__salud.cuidafarma_medicamentos` AS
WITH especialidad AS (
  SELECT DISTINCT id_especialidad,
  especialidad_homologada des_especialidad
  FROM `data-engineer-410822.plata__salud.homologacion_especialidad_id`
)
SELECT
a.*,
c.id_especialidad,
c.des_especialidad
FROM `data-engineer-410822.scraping_data.cuida_farma_medicamentos` a
LEFT JOIN `data-engineer-410822.scraping_data.medicamento_especialidad` b
ON a.categoria = b.string_field_0 AND a.sub_ctegoria = b.string_field_1
LEFT JOIN especialidad c
ON b.string_field_2 = c.des_especialidad