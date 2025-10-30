                -- integrantes: Guzman Ayelen, Quiroga Maira, Pari Jennifer, Luna Natasha


CREATE DATABASE IF NOT EXISTS Servicio;                               -- Creacion de la base de datos llamada "Servicio" 

/* 
	Tabla de las entidades
*/

DROP DATABASE Usuario;

DROP TABLE IF EXISTS Usuario;                                         -- eliminamos tabla, si existe una llamada "usuario"
CREATE TABLE Usuario (                                                -- creamos tabla "usuario"
	id_usuario INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,              -- columna id_usuario, tipo entero,no puede ser null porque es primary key
    direccion VARCHAR(20) NOT NULL,                                   -- columna direccion
    telefono VARCHAR(20) NOT NULL,                                    -- columna telefono (llamada tel en el diagrama)
    CONSTRAINT pk_id_usuario PRIMARY KEY (id_usuario)                 -- restriccion si o si para clave primaria
);



DROP TABLE IF EXISTS Empresa;                                                     -- eliminamos la tabla empresa si esta existe
CREATE TABLE Empresa (                                                            -- creamos la tabla "Empresa"
	nro_cuit INTEGER NOT NULL,  -- columna nro_cuit
    id_usuario INTEGER UNSIGNED NOT NULL,     
    capacidad INTEGER NOT NULL,                                                   -- columna capacidad 
    CONSTRAINT cantidadCap CHECK(capacidad <= 50000 AND capacidad >= 0),          -- restriccion en columna capacidad
    CONSTRAINT pk_nro_cuit PRIMARY KEY (nro_cuit),                                 -- restriccion de clave primaria
    CONSTRAINT fk_empresa_idusuario FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)  
);



DROP TABLE IF EXISTS Persona;                                                            -- si esa tabla ya existe, la elimina
CREATE TABLE Persona (                                                                   -- crea tabla "persona"
	dni INTEGER NOT NULL,                                                                -- columna dni (llamada dniPer en el diagrama)
    id_usuario INTEGER UNSIGNED NOT NULL,                                               -- columna usuario
    telefono VARCHAR(20) NOT NULL,                                                       -- columna telefono     
    CONSTRAINT  CHECK(dni < 1000000000 AND dni >= 0),                                    -- restriccion en  columna dni
    CONSTRAINT pk_dni PRIMARY KEY (dni),                                                 -- restriccion de clave primaria
    CONSTRAINT fk_persona_idusuario FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)      -- restriccion de clave foranea a tabla "usuario" 
    ON DELETE CASCADE                                                                    -- si elimina el valor en la tabla padre, tmb lo hará en la tabla del hijo
    ON UPDATE CASCADE                                                                    -- si cambia el valor  en la tabla padre se actualiza en la tabla del hijo
);



DROP TABLE IF EXISTS Empleado;                                                 -- verifica si esa tabla existe para eliminarla
CREATE TABLE Empleado (                                                        -- crea la tabla "Empleado"
	dniEmpleado INTEGER NOT NULL UNIQUE,                                       -- crea la columna dniEmpleado  (dniEmp en el diagrama)
    nombre VARCHAR(20) NOT NULL,                                               -- crea la columna nombre
    apellido VARCHAR(20) NOT NULL,                                             -- crea la columna apellido
    sueldo INTEGER,                                                             -- crea la columna sueldo
    CONSTRAINT fk_dni FOREIGN KEY (dniEmpleado) REFERENCES Persona(dni)         -- restriccion de clave foranea a persona
    ON DELETE CASCADE                                                            -- si elimina el valor del padre, tmb lo hará en el hijo
    ON UPDATE CASCADE                                                           -- si modifica el valor del padre, tmb lo hará en el hijo
);



DROP TABLE IF EXISTS Motivo;                       
CREATE TABLE Motivo (                                                              -- crea tabla "Motivo"
	codigoMot INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,                            -- columna codigoMot  (cod_mot en el diagrama)
    descripcion VARCHAR(30),                                                       -- columna descripcion (descrip en el diagrama)
    CONSTRAINT pk_codigo_Mot PRIMARY KEY (codigoMot)                               --  restriccion clave primaria
);



DROP TABLE IF EXISTS reclamo;                                                             -- verifica si existe un atabla con ese nombre, la elimina
CREATE TABLE reclamo (                                                                     -- crea la tabla "Reclamo"
	id_usuario 	INTEGER UNSIGNED,        													
	nro_reclamo INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,                                 -- columna (nroRec en el diagrama)
    codigoMot INTEGER UNSIGNED NOT NULL,                                                  -- columna  (cod_mot en el diagrama)
    fecha_reclamo DATE,                                                                   -- columna  con el formato (dia-mes-año)
    hora_reclamo TIME,                                                                    -- con el formato (horas:minutos:segundos)
    fecha_solucion DATE,                                                                  -- (fecha_reso en el diagrama)
    CONSTRAINT pk_nro_reclamo PRIMARY KEY (nro_reclamo),                                  -- restriccion de clave primaria
    CONSTRAINT fk_codigoMot_reclamo FOREIGN KEY (codigoMot) REFERENCES Motivo(codigoMot),           -- restriccion de clave foranea a tabla motivo
    CONSTRAINT fk_idusuario_reclamo FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario) 
    ON DELETE CASCADE
);



DROP TABLE IF EXISTS Material;                                                          
CREATE TABLE Material (                                                         -- crea tabla "material"
	codigoMat INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,                         -- columna codigoMat (codMat en el diagrama)
    descripcion VARCHAR(30),                                                    -- columna descripcion (descri en el diagrama)
    CONSTRAINT pk_codigoMat PRIMARY KEY (codigoMat)                             -- restriccion de clave primaria
);



DROP TABLE IF EXISTS Llamados;                                                                       -- si existe esa tabla la elimina
CREATE TABLE Llamados (                                                                              -- crea tabla ""llamado" entidad debil
	nro_llamado INTEGER UNSIGNED,                                                                    -- columna nro_llamado 
    nro_reclamo INTEGER UNSIGNED,                                                                    -- (nroRec en el diagrama)
    fecha_reclamo DATE,
    hora_reclamo TIME,                                                                               -- (hora_llamado en el diagrama)
    CONSTRAINT pk_nro_llamadoReclamo_llamado PRIMARY KEY (nro_llamado, nro_reclamo),                 -- restriccion clave primaria
    CONSTRAINT fk_nroReclamo_llamados FOREIGN KEY (nro_reclamo) REFERENCES Reclamo (nro_reclamo)     -- restriccion de clave foranea a tabla reclamo
    ON DELETE CASCADE
);



/* 
	Tabla de la relacion entre reclamo y material ("usó" en el diagrama)
*/


DROP TABLE IF EXISTS UsoMaterial;            
CREATE TABLE UsoMaterial (                                                                                  -- crea tabla "usoMaterial"
    nro_reclamo INTEGER UNSIGNED NOT NULL,                                                                  -- (nroRec en el diagrama)
    codigoMat INTEGER UNSIGNED NOT NULL,                                                                    -- (codMat en el diagrama)
    cantMat INTEGER,
    CONSTRAINT cantidad CHECK(cantMat <= 999),                                                           -- restriccion que la cantMat sea menor o igual a 999
    CONSTRAINT fk_nro_reclamo_uso FOREIGN KEY (nro_reclamo) REFERENCES Reclamo(nro_reclamo) ON DELETE CASCADE,                -- restriccion de clave primaria
    CONSTRAINT fk_codigoMat_uso FOREIGN KEY (codigoMat) REFERENCES Material(codigoMat)                          -- restriccion de clave foranea a tabla material
    ON DELETE CASCADE
);

DROP TABLE IF EXISTS Mantiene;
CREATE TABLE Mantiene (
	dniEmpleado INTEGER NOT NULL,
	nro_reclamo INTEGER UNSIGNED NOT NULL,
    CONSTRAINT pk_mantiene PRIMARY KEY (dniEmpleado, nro_reclamo),
    CONSTRAINT fk_Mantiene_dni FOREIGN KEY (dniEmpleado) REFERENCES Empleado(dniEmpleado),
    CONSTRAINT fk_Mantiene_reclamo FOREIGN KEY (nro_reclamo) REFERENCES Reclamo(nro_reclamo)
    ON DELETE CASCADE
);


-- TRIGGER (Se activa automaticamente despues de haber eliminado una fila de la tabla reclamo

DROP TABLE IF EXISTS Reclamos_borrados;                                      
CREATE TABLE Reclamos_borrados (                                                                -- creamos tabla "reclamos_borrados" que usará el trigger y guardará toda la informacion
	nro_reclamo INTEGER UNSIGNED NOT NULL,
	codigoMot integer, 
    fecha_reclamo DATE,
    hora_reclamo TIME,
    fecha_solucion DATE,
    id_usuario INTEGER UNSIGNED NOT NULL,
    usuario_eliminador VARCHAR(100),
	fecha_eliminacion DATETIME,
    CONSTRAINT fk_id_usuario_reclamo FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)                  -- restriccion de clave primaria
	ON DELETE CASCADE
);




DROP TRIGGER IF EXISTS trigger_baja_reclamos;
delimiter $$
CREATE TRIGGER trigger_baja_reclamos                                                          -- creamos el disparador          
	AFTER DELETE ON reclamo                                                                            -- se ejecuta despues de borrar una fila en la tabla reclamo
    FOR EACH ROW                                                                                                 -- el trigger se ejecutará cada vesz que se borre una fila
    BEGIN                                                                                                                  -- que se ejecutará?
     INSERT INTO Reclamos_borrados                                                                                                 -- inserta un nuevo registro en la tabla reclamos_borrados con todos los datos detallados
    VALUES(OLD.nro_reclamo, OLD.codigoMot, OLD.fecha_reclamo, OLD.hora_reclamo, OLD.fecha_solucion, OLD.id_usuario, CURRENT_USER(), NOW() );      -- OLD= lo que se borró. current_user = quien lo eliminó, NOW() = fecha y hora
	END;
$$
delimiter ;
