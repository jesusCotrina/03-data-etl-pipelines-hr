select count(distinct cmp) from `data-engineer-410822.oro__salud.maestra_clinica_doctores_2`


select nombre_clinica,count(distinct cmp) cnt_doctores from `data-engineer-410822.oro__salud.maestra_clinica_doctores_2` group by 1 order by 2 desc


select especialidad_homologada,count(distinct cmp) cnt_doctores from `data-engineer-410822.oro__salud.maestra_clinica_doctores_2` group by 1 order by 2 desc


select distrito,count(distinct cmp)cnt_doctores  from `data-engineer-410822.oro__salud.maestra_clinica_doctores_2`  where distrito is not null group by 1 order by 2 desc