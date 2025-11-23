 create or replace table `data-engineer-410822.plata__salud.homologacion_especialidad_id` as
with tbl as (SELECT distinct especialidad_homologada,   FROM `data-engineer-410822.plata__salud.homologacion_especialidad`),
tbl_id as (
  select especialidad_homologada,ROW_NUMBER() OVER ( ORDER BY especialidad_homologada) id from tbl 
)
select a.*,id id_especialidad from `data-engineer-410822.plata__salud.homologacion_especialidad` a left join tbl_id b on a.especialidad_homologada=b.especialidad_homologada 

select distinct id_especialidad from `data-engineer-410822.plata__salud.homologacion_especialidad_id`
