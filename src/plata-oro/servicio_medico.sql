/*==========================CLINICA ===================================
=======================================================================*/
declare periodo_actual date;
set periodo_actual = date_trunc(current_date(), month);

create or replace table `data-engineer-410822.oro__salud.maestra_clinica_doctores`  as 
WITH c_javier_prado as (
  SELECT
    *
  FROM `data-engineer-410822.scraping_data.clinica_javier_prado` where periodo = periodo_actual
  QUALIFY ROW_NUMBER() OVER (
    PARTITION BY nombre_completo,cmp,rne,especialidad,dia_atencion,hora_inicio,hora_fin
    ORDER BY fecha_scraping DESC) = 1
),
c_javier_prado_2 as (
  select 
    1 as id_clinica,
    "Clinica Javier Prado" as nombre_clinica,
    nombre_completo as nombre_doctor,
    cmp,
    rne,
    url_foto as url_foto_doctor,
    especialidad,
    "San Isidro" as sede,
    "San Isidro" as distrito,
    "Av. Javier Prado Este 499. San Isidro - Lima" direccion_sede,
    "(01) 2114141" telefono_clinica,
    dia_atencion,
    hora_inicio,
    hora_fin,
    url_fuente as url_agenda_cita,
    "https://cjp.pe/wp-content/uploads/2021/02/LOGO-V2-WEB_.png" as url_logo_clinica,
    CASE
    WHEN RAND() < 0.333 THEN 4
    WHEN RAND() < 0.666 THEN 4.5
    ELSE 5 end as calificacion,
    true cmp_verificado,
    cast(null as string) formacion,
    "Presencial" as tipo_atencion,
  from c_javier_prado cjp
),

c_internacional as (
  SELECT
    *
  FROM `data-engineer-410822.scraping_data.clinica_internacional` where periodo = periodo_actual
  QUALIFY ROW_NUMBER() OVER (
    PARTITION BY clinica,nombre_completo,cmp,especialidad,sede_title,sede_adress,tipo_atencion_title,dia,hora_inicio,hora_fin
    ORDER BY fecha_scraping DESC) = 1
ORDER BY fecha_scraping DESC
),
c_internacional_2 as (
  select 
    2 as id_clinica,
    clinica as nombre_clinica,
    nombre_completo as nombre_doctor,
    cmp,
    cast(null as string) rne,
    url_imagen as url_foto_doctor,
    especialidad,
    sede_title as sede,
    sede_title as distrito,
    sede_adress direccion_sede,
    "619 6100 anexo 5501" telefono_clinica,
    dia as dia_atencion,
    hora_inicio,
    hora_fin,
    "https://citasenlinea.clinicainternacional.com.pe/authentication/login/login-first-step?utm_source=google&utm_medium=paidsearch&utm_campaign=aon_ene_2025&utm_content=marcarecurrente_marca&gad_source=1&gad_campaignid=21677211110&gbraid=0AAAAAqtKBY6sVirJ6TTUhtayCDUv4F78v&gclid=CjwKCAiA24XJBhBXEiwAXElO3-mrvR3QhC5uVyMr0wf16MotKnOk0dI0R-5u_q7Y8TTwUtzA1rRndBoC3hYQAvD_BwE" as url_agenda_cita,
    "https://sa01portalpacienteprd.blob.core.windows.net/$web/assets/images/logo.svg" as url_logo_clinica,
    CASE
    WHEN RAND() < 0.333 THEN 4
    WHEN RAND() < 0.666 THEN 4.5
    ELSE 5 end as calificacion,
    true cmp_verificado,
    cast(null as string) formacion,
    tipo_atencion_title as tipo_atencion,
    from c_internacional
),


c_san_felipe as (
  SELECT
    *
  FROM `data-engineer-410822.scraping_data.clinica_san_felipe` where periodo = periodo_actual
  QUALIFY ROW_NUMBER() OVER (
      PARTITION BY nombre_medico,especialidad,cmp,rne,formacion
      ORDER BY fecha_scraping DESC) = 1
  ORDER BY fecha_scraping DESC
),
c_san_felipe_2 as (
    select 
    3 as id_clinica,
    "San Felipe" as nombre_clinica,
    nombre_medico as nombre_doctor,
    cmp,
    rne rne,
    url_foto as url_foto_doctor,
    especialidad,
    sedes as sede,
    sedes as distrito,
    sedes direccion_sede,
    "219 0000" telefono_clinica,
    cast(null as string) as dia_atencion,
    cast(null as string) as hora_inicio,
    cast(null as string) as hora_fin,
    "https://citaweb.clinicasanfelipe.com/CSF_CITAS/" as url_agenda_cita,
    "https://www.clinicasanfelipe.com/images/nuevo-logo-san-felipe-final-01.svg" as url_logo_clinica,
    CASE
    WHEN RAND() < 0.333 THEN 4
    WHEN RAND() < 0.666 THEN 4.5
    ELSE 5 end as calificacion,
    true cmp_verificado,
    formacion formacion,
    "Presencial" as tipo_atencion,
    from c_san_felipe
),

c_anglo_americana as (
  SELECT
    *
  FROM `data-engineer-410822.scraping_data.clinica_anglo_americana` where periodo = periodo_actual
  QUALIFY ROW_NUMBER() OVER (
      PARTITION BY clinica,nombre_completo,cmp,especialidad,sede_title,distrito,tipo_atencion_title,dia,hora_inicio,hora_fin
      ORDER BY fecha_scraping DESC) = 1
  ORDER BY fecha_scraping DESC
),
c_anglo_americana_2 as (
      select 
     4 as id_clinica,
    clinica as nombre_clinica,
    nombre_completo as nombre_doctor,
    cmp,
    cast(null as string) rne,
    url_imagen as url_foto_doctor,
    especialidad,
    sede_title as sede,
    distrito as distrito,
    sede_adress direccion_sede,
    "(511) 616-8910" telefono_clinica,
    dia as dia_atencion,
    hora_inicio,
    hora_fin,
    "https://citas.clinicaangloamericana.pe/login" as url_agenda_cita,
    "https://clinicaangloamericana.pe/app-de-citas/" as url_logo_clinica,
    CASE
    WHEN RAND() < 0.333 THEN 4
    WHEN RAND() < 0.666 THEN 4.5
    ELSE 5 end as calificacion,
    true cmp_verificado,
    experiencia formacion,
    "Presencial" as tipo_atencion,
    from c_anglo_americana
)
,
c_san_pablo as (
  SELECT
    *
  FROM `data-engineer-410822.scraping_data.clinica_san_pablo` where periodo = periodo_actual
QUALIFY ROW_NUMBER() OVER (
    PARTITION BY clinica,nombre_completo,cmp,especialidad,sede_title,distrito,tipo_atencion_title,dia,hora_inicio,hora_fin
    ORDER BY fecha_scraping DESC) = 1
ORDER BY fecha_scraping DESC
),
c_san_pablo_2 as (
        select 
     5 as id_clinica,
    clinica as nombre_clinica,
    nombre_completo as nombre_doctor,
    cmp,
    cast(null as string) rne,
    url_imagen as url_foto_doctor,
    especialidad,
    sede_title as sede,
    distrito as distrito,
    sede_adress direccion_sede,
    "(01) 610 3333" telefono_clinica,
    dia as dia_atencion,
    hora_inicio,
    hora_fin,
    "https://www.sanpablo.com.pe/reservar-cita/" as url_agenda_cita,
    "https://www.sanpablo.com.pe/wp-content/uploads/2024/05/LogoSPSurco.png" as url_logo_clinica,
    CASE
    WHEN RAND() < 0.333 THEN 4
    WHEN RAND() < 0.666 THEN 4.5
    ELSE 5 end as calificacion,
    true cmp_verificado,
    experiencia formacion,
    "Presencial" as tipo_atencion,
    from c_san_pablo
),
consolidado as (select * from c_san_pablo_2
union all
select * from c_javier_prado_2
union all
select * from c_anglo_americana_2
union all
select * from c_san_felipe_2
union all
select * from c_internacional_2
),
homologacion_distrito as (SELECT
  t.* EXCEPT(distrito),
  TRIM(d) AS distrito
FROM consolidado t
LEFT JOIN UNNEST(
  SPLIT(
    REPLACE(t.distrito, ' y ', ','),
    ','
  )
) AS d
ON TRUE),


 homologacion_espe AS (
  SELECT *,
    TRIM(
      REGEXP_REPLACE(
        REPLACE(REPLACE(LOWER(especialidad), ' y ', ','), ';', ','),
        r'\s+', ' '
      )
    ) AS especialidad_raw
  FROM homologacion_distrito
)

,
homologacion_espe_2 as (
  select 
    id_clinica,
    nombre_clinica,
    nombre_doctor,
    if(cmp = "",null,cmp) as cmp,
    rne,
    url_foto_doctor,
    especialidad,
    b.especialidad_homologada,
    b.id_especialidad,
    sede,
    if(distrito = "",null,distrito) as distrito,
    direccion_sede,
    telefono_clinica,
    dia_atencion,
    hora_inicio,
    hora_fin,
    url_agenda_cita,
    url_logo_clinica,
    calificacion,
    cmp_verificado,
    formacion,
    tipo_atencion,

  from homologacion_espe a 
  left join  `data-engineer-410822.plata__salud.homologacion_especialidad_id` b on a.especialidad_raw=b.especialidad_raw
)
select *  from homologacion_espe_2




--211

--select * from `data-engineer-410822.scraping_data.clinica_javier_prado`