-- Tabla: especialidad
drop table especialidad
create table if not exists  especialidad (
  especialidad_id int primary key generated always as identity,
  nombre text unique
);

-- Tabla: medicamento
create table if not exists medicamento (
  medicamento_id int primary key generated always as identity,
  nombre text unique,
  precio_base numeric,
  presentacion text,
  url_imagen text,
  url_compra text
);

-- Tabla: clinica
create table if not exists clinica (
  clinica_id int primary key generated always as identity,
  nombre text,
  ruc text unique,
  url_logo text,
  descripcion text
);

-- Tabla: sede
create table if not exists sede (
  sede_id int primary key generated always as identity,
  clinica_id int references clinica (clinica_id),
  nombre_sede text,
  direccion_completa text,
  distrito text,
  telefono text
);

-- Tabla: medico
drop table medico
create table if not exists medico (
  medico_id int primary key generated always as identity,
  nombre_completo text,
  cmp_numero text unique,
  validado_cmp boolean,
  rne text,
  descripcion text,
  educacion text,
  anios_experiencia int,
  url_imagen text,
  calificacion INT DEFAULT 5 CHECK (calificacion BETWEEN 1 AND 5)
);

ALTER TABLE medico
ADD COLUMN calificacion INT DEFAULT 5 CHECK (calificacion BETWEEN 1 AND 5);



-- Relación: médico - especialidad (N:N)
create table if not exists medico_especialidad (
  medico_id int references medico (medico_id),
  especialidad_id int references especialidad (especialidad_id),
  primary key (medico_id, especialidad_id)
);

-- Relación: medicamento - especialidad (N:N)
create table if not exists medicamento_especialidad (
  medicamento_id int references medicamento (medicamento_id),
  especialidad_id int references especialidad (especialidad_id),
  primary key (medicamento_id, especialidad_id)
);

-- Tabla final: servicio (antes medico_clinica_sede)
create table if not exists servicio (
  id_servicio bigint primary key generated always as identity,
  medico_id bigint references medico (medico_id),
  clinica_id bigint references clinica (clinica_id),--
  sede_id bigint references sede (sede_id),
  hora_inicio time,
  hora_fin time,
  dia text,
  modalidad text
);
 