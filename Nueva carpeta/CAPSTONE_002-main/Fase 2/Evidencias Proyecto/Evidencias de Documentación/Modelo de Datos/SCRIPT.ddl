-- Generado por Oracle SQL Developer Data Modeler 20.3.0.283.0710
--   en:        2024-10-11 00:11:21 CLST
--   sitio:      Oracle Database 11g
--   tipo:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE ciudad (
    idciudad         NUMBER(1) NOT NULL,
    descrip          VARCHAR2(50) NOT NULL,
    region_idregion  NUMBER(2) NOT NULL
);

ALTER TABLE ciudad ADD CONSTRAINT ciudad_pk PRIMARY KEY ( idciudad );

CREATE TABLE comuna (
    idcom            NUMBER(3) NOT NULL,
    descrip          VARCHAR2(50) NOT NULL,
    ciudad_idciudad  NUMBER(1) NOT NULL
);

ALTER TABLE comuna ADD CONSTRAINT comuna_pk PRIMARY KEY ( idcom );

CREATE TABLE estudiante (
    rut_estudiante         CHAR(9) NOT NULL,
    primernom              VARCHAR2(100) NOT NULL,
    segundnom              VARCHAR2(100) NOT NULL,
    tercernom              VARCHAR2(100),
    apellido_p_            VARCHAR2(100) NOT NULL,
    apellido_m_            VARCHAR2(100) NOT NULL,
    correo_inst            VARCHAR2(100) NOT NULL,
    universidad            VARCHAR2(100) NOT NULL,
    contraseña             CHAR(10) NOT NULL,
    universidad_nomuni     VARCHAR2(50) NOT NULL,
    tipousuario_idusuario  CHAR(10) NOT NULL
);

CREATE UNIQUE INDEX estudiante__idx ON
    estudiante (
        tipousuario_idusuario
    ASC );

ALTER TABLE estudiante ADD CONSTRAINT estudiante_pk PRIMARY KEY ( rut_estudiante );

CREATE TABLE ficha_clinica (
    id_ficha               NUMBER(500) NOT NULL,
    antecedentes           VARCHAR2(500) NOT NULL,
    alergias               VARCHAR2(500) NOT NULL,
    paciente_rut_paciente  CHAR(9) NOT NULL,
    cirugias               VARCHAR2(500) NOT NULL
);

CREATE UNIQUE INDEX ficha_clinica__idx ON
    ficha_clinica (
        paciente_rut_paciente
    ASC );

ALTER TABLE ficha_clinica ADD CONSTRAINT ficha_clinica_pk PRIMARY KEY ( id_ficha );

CREATE TABLE historialmedico (
    idhistorial            CHAR(10) NOT NULL,
    fecha                  DATE NOT NULL,
    horainicio             DATE NOT NULL,
    horafinal              DATE NOT NULL,
    diagnostico            VARCHAR2(500) NOT NULL,
    paciente_rut_paciente  CHAR(9) NOT NULL
);

CREATE UNIQUE INDEX historialmedico__idx ON
    historialmedico (
        paciente_rut_paciente
    ASC );

ALTER TABLE historialmedico ADD CONSTRAINT historialmedico_pk PRIMARY KEY ( idhistorial );

CREATE TABLE horarios (
    idhorario              CHAR(10) NOT NULL,
    horainicial            DATE NOT NULL,
    fecha                  DATE NOT NULL,
    paciente_rut_paciente  CHAR(9) NOT NULL
);

ALTER TABLE horarios ADD CONSTRAINT horarios_pk PRIMARY KEY ( idhorario );

CREATE TABLE paciente (
    rut_paciente                 CHAR(9) NOT NULL,
    primernom                    VARCHAR2(100) NOT NULL,
    segundnom                    VARCHAR2(100) NOT NULL,
    tercernom                    VARCHAR2(100),
    apellido_p_                  VARCHAR2(100) NOT NULL,
    apellido_m_                  VARCHAR2(100) NOT NULL,
    telefono                     NUMBER(9) NOT NULL,
    genero                       VARCHAR2(15) NOT NULL,
    contraseña                   CHAR(10) NOT NULL,
    estudiante_rut_estudiante    CHAR(9) NOT NULL,
    ficha_clinica_id_ficha       NUMBER(500) NOT NULL,
    historialmedico_idhistorial  CHAR(10) NOT NULL,
    tipousuario_idusuario        CHAR(10) NOT NULL
);

CREATE UNIQUE INDEX paciente__idx ON
    paciente (
        historialmedico_idhistorial
    ASC );

CREATE UNIQUE INDEX paciente__idxv1 ON
    paciente (
        tipousuario_idusuario
    ASC );

CREATE UNIQUE INDEX paciente__idxv2 ON
    paciente (
        ficha_clinica_id_ficha
    ASC );

ALTER TABLE paciente ADD CONSTRAINT paciente_pk PRIMARY KEY ( rut_paciente );

CREATE TABLE receta (
    idreceta      CHAR(10) NOT NULL,
    medicamentos  VARCHAR2(500) NOT NULL,
    dosis         VARCHAR2(500) NOT NULL,
    frecuencia    VARCHAR2(500) NOT NULL
);

ALTER TABLE receta ADD CONSTRAINT receta_pk PRIMARY KEY ( idreceta );

CREATE TABLE region (
    idregion  NUMBER(2) NOT NULL,
    descrip   VARCHAR2(50) NOT NULL
);

ALTER TABLE region ADD CONSTRAINT region_pk PRIMARY KEY ( idregion );

CREATE TABLE relation_14 (
    paciente_rut_paciente  CHAR(9) NOT NULL,
    receta_idreceta        CHAR(10) NOT NULL
);

ALTER TABLE relation_14 ADD CONSTRAINT relation_14_pk PRIMARY KEY ( paciente_rut_paciente,
                                                                    receta_idreceta );

CREATE TABLE relation_2 (
    tratamiento_id_trata       NUMBER(2) NOT NULL,
    estudiante_rut_estudiante  CHAR(9) NOT NULL
);

ALTER TABLE relation_2 ADD CONSTRAINT relation_2_pk PRIMARY KEY ( tratamiento_id_trata,
                                                                  estudiante_rut_estudiante );

CREATE TABLE tipousuario (
    idusuario                  CHAR(10) NOT NULL,
    tipousuario                VARCHAR2(50) NOT NULL,
    estudiante_rut_estudiante  CHAR(9) NOT NULL,
    paciente_rut_paciente      CHAR(9) NOT NULL
);

ALTER TABLE tipousuario
    ADD CHECK ( tipousuario IN ( 'Estudiante', 'Paciente' ) );

CREATE UNIQUE INDEX tipousuario__idx ON
    tipousuario (
        estudiante_rut_estudiante
    ASC );

CREATE UNIQUE INDEX tipousuario__idxv1 ON
    tipousuario (
        paciente_rut_paciente
    ASC );

ALTER TABLE tipousuario ADD CONSTRAINT tipousuario_pk PRIMARY KEY ( idusuario );

CREATE TABLE tratamiento (
    id_trata     NUMBER(2) NOT NULL,
    tipo_trat_   VARCHAR2(50) NOT NULL,
    descripcion  VARCHAR2(100) NOT NULL
);

ALTER TABLE tratamiento ADD CONSTRAINT tratamiento_pk PRIMARY KEY ( id_trata );

CREATE TABLE universidad (
    nomuni        VARCHAR2(50) NOT NULL,
    direcuni      VARCHAR2(50) NOT NULL,
    comuna_idcom  NUMBER(3) NOT NULL
);

ALTER TABLE universidad ADD CONSTRAINT universidad_pk PRIMARY KEY ( nomuni );

ALTER TABLE ciudad
    ADD CONSTRAINT ciudad_region_fk FOREIGN KEY ( region_idregion )
        REFERENCES region ( idregion );

ALTER TABLE comuna
    ADD CONSTRAINT comuna_ciudad_fk FOREIGN KEY ( ciudad_idciudad )
        REFERENCES ciudad ( idciudad );

ALTER TABLE estudiante
    ADD CONSTRAINT estudiante_tipousuario_fk FOREIGN KEY ( tipousuario_idusuario )
        REFERENCES tipousuario ( idusuario );

ALTER TABLE estudiante
    ADD CONSTRAINT estudiante_universidad_fk FOREIGN KEY ( universidad_nomuni )
        REFERENCES universidad ( nomuni );

ALTER TABLE ficha_clinica
    ADD CONSTRAINT ficha_clinica_paciente_fk FOREIGN KEY ( paciente_rut_paciente )
        REFERENCES paciente ( rut_paciente );

ALTER TABLE historialmedico
    ADD CONSTRAINT historialmedico_paciente_fk FOREIGN KEY ( paciente_rut_paciente )
        REFERENCES paciente ( rut_paciente );

ALTER TABLE horarios
    ADD CONSTRAINT horarios_paciente_fk FOREIGN KEY ( paciente_rut_paciente )
        REFERENCES paciente ( rut_paciente );

ALTER TABLE paciente
    ADD CONSTRAINT paciente_estudiante_fk FOREIGN KEY ( estudiante_rut_estudiante )
        REFERENCES estudiante ( rut_estudiante );

ALTER TABLE paciente
    ADD CONSTRAINT paciente_ficha_clinica_fk FOREIGN KEY ( ficha_clinica_id_ficha )
        REFERENCES ficha_clinica ( id_ficha );

ALTER TABLE paciente
    ADD CONSTRAINT paciente_historialmedico_fk FOREIGN KEY ( historialmedico_idhistorial )
        REFERENCES historialmedico ( idhistorial );

ALTER TABLE paciente
    ADD CONSTRAINT paciente_tipousuario_fk FOREIGN KEY ( tipousuario_idusuario )
        REFERENCES tipousuario ( idusuario );

ALTER TABLE relation_14
    ADD CONSTRAINT relation_14_paciente_fk FOREIGN KEY ( paciente_rut_paciente )
        REFERENCES paciente ( rut_paciente );

ALTER TABLE relation_14
    ADD CONSTRAINT relation_14_receta_fk FOREIGN KEY ( receta_idreceta )
        REFERENCES receta ( idreceta );

ALTER TABLE relation_2
    ADD CONSTRAINT relation_2_estudiante_fk FOREIGN KEY ( estudiante_rut_estudiante )
        REFERENCES estudiante ( rut_estudiante );

ALTER TABLE relation_2
    ADD CONSTRAINT relation_2_tratamiento_fk FOREIGN KEY ( tratamiento_id_trata )
        REFERENCES tratamiento ( id_trata );

ALTER TABLE tipousuario
    ADD CONSTRAINT tipousuario_estudiante_fk FOREIGN KEY ( estudiante_rut_estudiante )
        REFERENCES estudiante ( rut_estudiante );

ALTER TABLE tipousuario
    ADD CONSTRAINT tipousuario_paciente_fk FOREIGN KEY ( paciente_rut_paciente )
        REFERENCES paciente ( rut_paciente );

ALTER TABLE universidad
    ADD CONSTRAINT universidad_comuna_fk FOREIGN KEY ( comuna_idcom )
        REFERENCES comuna ( idcom );



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            14
-- CREATE INDEX                             8
-- ALTER TABLE                             33
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
