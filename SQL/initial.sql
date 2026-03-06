CREATE SCHEMA manufactura;


CREATE TABLE manufactura.cliente (
    id_cliente SERIAL PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    sector VARCHAR(100),
    rfc VARCHAR(20)
);

CREATE TABLE manufactura.departamento (
    id_departamento SERIAL PRIMARY KEY,
    nombre VARCHAR(100)
);

CREATE TABLE manufactura.orden_produccion (
    id_orden SERIAL PRIMARY KEY,
    id_cliente INT,
    descripcion VARCHAR(200),
    fecha_inicio TIMESTAMP,
    fecha_fin TIMESTAMP,
    estatus_legal_contrato VARCHAR(50),

    FOREIGN KEY (id_cliente)
    REFERENCES manufactura.cliente(id_cliente)
);



CREATE TABLE manufactura.centro_costo (
    id_centro_costo SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    presupuesto_mensual NUMERIC
);

CREATE TABLE manufactura.maquina (
    id_maquina SERIAL PRIMARY KEY,
    nombre VARCHAR(150),
    tipo VARCHAR(50),
    costo_hora NUMERIC(10,2),
    id_centro_costo INT,

    FOREIGN KEY (id_centro_costo)
    REFERENCES manufactura.centro_costo(id_centro_costo)
);

CREATE TABLE manufactura.operador (
    id_operador SERIAL PRIMARY KEY,
    nombre VARCHAR(150),
    id_departamento INT,
    salario_hora NUMERIC(10,2),
    certificacion_seguridad BOOLEAN,

    FOREIGN KEY (id_departamento)
    REFERENCES manufactura.departamento(id_departamento)
);

CREATE TABLE manufactura.material (
    id_material SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    costo_unidad NUMERIC(10,2),
    unidad_medida VARCHAR(20)
);

CREATE TABLE manufactura.herramienta (
    id_herramienta SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    vida_util_horas NUMERIC,
    costo_unitario NUMERIC
);

CREATE TABLE manufactura.registro_proceso (
    id_registro SERIAL PRIMARY KEY,

    id_orden INT,
    id_maquina INT,
    id_operador INT,

    tiempo_operacion_horas NUMERIC,
    energia_kwh NUMERIC,
    costo_kwh NUMERIC,

    sensor_vibracion NUMERIC,
    sensor_temperatura NUMERIC,

    FOREIGN KEY (id_orden)
    REFERENCES manufactura.orden_produccion(id_orden),

    FOREIGN KEY (id_maquina)
    REFERENCES manufactura.maquina(id_maquina),

    FOREIGN KEY (id_operador)
    REFERENCES manufactura.operador(id_operador)
);

CREATE TABLE manufactura.consumo_recursos (
    id_consumo SERIAL PRIMARY KEY,

    id_registro INT,
    id_material INT,
    id_herramienta INT,

    cantidad_usada NUMERIC,

    FOREIGN KEY (id_registro)
    REFERENCES manufactura.registro_proceso(id_registro),

    FOREIGN KEY (id_material)
    REFERENCES manufactura.material(id_material),

    FOREIGN KEY (id_herramienta)
    REFERENCES manufactura.herramienta(id_herramienta)
);

CREATE TABLE manufactura.incidencia_seguridad (
    id_incidencia SERIAL PRIMARY KEY,
    id_registro INT,
    descripcion TEXT,
    severidad VARCHAR(50),
    impacto_legal VARCHAR(100),

    FOREIGN KEY (id_registro)
    REFERENCES manufactura.registro_proceso(id_registro)
);

CREATE TABLE manufactura.tiempo_muerto (
    id_tiempo SERIAL PRIMARY KEY,
    id_registro INT,
    causa VARCHAR(100),
    tiempo_min NUMERIC,

    FOREIGN KEY (id_registro)
    REFERENCES manufactura.registro_proceso(id_registro)
);

CREATE TABLE manufactura.desperdicio_calidad (
    id_desperdicio SERIAL PRIMARY KEY,
    id_registro INT,
    peso NUMERIC,
    costo_merma NUMERIC,

    FOREIGN KEY (id_registro)
    REFERENCES manufactura.registro_proceso(id_registro)
);




INSERT INTO manufactura.cliente (nombre, sector, rfc) VALUES
('AeroParts Mexico','Aeroespacial','AEM120394KJ1'),
('HydroEnergy Systems','Hidroeléctrico','HES90345PL2'),
('AutoMotion Group','Automotriz','AMG23945DJ2'),
('MedTech Precision','Médico','MTP90394LL2'),
('MetalWorks Industries','Metal Mecánica','MWI45903PL1'),
('Defense Manufacturing','Defensa','DMF20394JK2'),
('GreenTech Components','Energía','GTC23904PP1');

INSERT INTO manufactura.departamento (nombre) VALUES
('Produccion'),
('Mantenimiento'),
('Calidad'),
('Ingenieria');


INSERT INTO manufactura.centro_costo (nombre, presupuesto_mensual) VALUES
('CNC Alta Precision', 200000),
('Manufactura General', 150000),
('Laboratorio Calidad', 80000);


INSERT INTO manufactura.maquina (nombre, tipo, costo_hora, id_centro_costo) VALUES
('DMG MORI CMX 1100','CNC 3 Ejes',850,1),
('HAAS VF2','CNC 3 Ejes',700,1),
('Mazak Variaxis','CNC 5 Ejes',1200,1),
('Okuma GENOS','CNC 4 Ejes',950,1),
('Hermle C400','CNC 5 Ejes',1300,1);


INSERT INTO manufactura.orden_produccion
(id_cliente,descripcion,fecha_inicio,fecha_fin,estatus_legal_contrato)
VALUES
(1,'Carcasa turbina CNC','2025-01-10','2025-01-15','Contrato activo'),
(2,'Rotor bomba hidráulica','2025-01-11','2025-01-18','Contrato activo'),
(3,'Soporte transmisión','2025-01-12','2025-01-20','Contrato activo'),
(4,'Implante médico titanio','2025-01-15','2025-01-22','Contrato activo'),
(5,'Brida industrial','2025-01-18','2025-01-25','Contrato activo'),
(6,'Componente defensa','2025-01-20','2025-01-27','Contrato confidencial'),
(7,'Base generador eólico','2025-01-22','2025-01-30','Contrato activo'),
(1,'Eje turbina','2025-02-01','2025-02-05','Contrato activo'),
(3,'Soporte motor','2025-02-03','2025-02-08','Contrato activo'),
(2,'Impulsor hidráulico','2025-02-05','2025-02-10','Contrato activo');


INSERT INTO manufactura.registro_proceso
(id_orden,id_maquina,id_operador,tiempo_operacion_horas,energia_kwh,costo_kwh,sensor_vibracion,sensor_temperatura)
VALUES
(1,3,1,5.5,48,2.5,0.02,65),
(1,3,2,4.1,39,2.5,0.03,68),
(2,2,3,3.5,28,2.5,0.02,60),
(3,4,1,4.3,35,2.5,0.04,62),
(4,5,2,6.2,55,2.5,0.02,70),
(5,1,3,3.8,30,2.5,0.03,59),
(6,3,4,5.9,50,2.5,0.02,66),
(7,2,1,4.7,37,2.5,0.03,63),
(8,5,2,6.5,58,2.5,0.02,72),
(9,4,3,4.4,33,2.5,0.04,64);


CREATE VIEW manufactura.vista_costos_produccion AS
SELECT

rp.id_registro,
c.nombre AS cliente,
m.nombre AS maquina,
o.nombre AS operador,

rp.tiempo_operacion_horas,
rp.energia_kwh,

rp.energia_kwh * rp.costo_kwh AS costo_energia,
rp.tiempo_operacion_horas * m.costo_hora AS costo_maquina,
rp.tiempo_operacion_horas * o.salario_hora AS costo_mano_obra

FROM manufactura.registro_proceso rp

JOIN manufactura.orden_produccion op
ON rp.id_orden = op.id_orden

JOIN manufactura.cliente c
ON op.id_cliente = c.id_cliente

JOIN manufactura.maquina m
ON rp.id_maquina = m.id_maquina

JOIN manufactura.operador o
ON rp.id_operador = o.id_operador;

