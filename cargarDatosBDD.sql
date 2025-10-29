-- integrantes: Maira Quiroga, Ayelen Guzman, Natasha Luna, Jennifer Pari


USE Servicio;

INSERT INTO Usuario (direccion, telefono) 
VALUES
('San Martín 123', '3584123456'),
('Av. Italia 456', '3584987654'),
('Belgrano 789', '3584765432');

INSERT INTO Usuario (direccion, telefono) 
VALUES
('Santa Fe', 3586543612),
('Alvear', 3567786243);

INSERT INTO Usuario (direccion, telefono) 
VALUES
('Suiza', 3586543700);

INSERT INTO Empresa (nro_cuit, id_usuario, capacidad) 
VALUES
(307112341, 1, 20000),
(307176545, 2, 45000),
(307198761, 3, 10000);

INSERT INTO Empresa (nro_cuit, id_usuario, capacidad) 
VALUES
(305902999, 4, 6000);

INSERT INTO Persona (dni, id_usuario, telefono) 
VALUES
(40111222, 1, '3584000001'),
(38999888, 2, '3584000002'),
(42777111, 3, '3584000003');

INSERT INTO Persona (dni, id_usuario, telefono) 
VALUES
(4460646, 5, '358506183');

INSERT INTO Persona (dni, id_usuario, telefono) 
VALUES
(570000, 6, '35854646');

INSERT INTO Empleado (dniEmpleado, nombre, apellido, sueldo) 
VALUES
(40111222, 'Juan', 'Pérez', 350000),
(38999888, 'Lucía', 'Gómez', 400000),
(42777111, 'Carlos', 'Díaz', 380000);

INSERT INTO Motivo ( descripcion) 
VALUES
( 'Corte de suministro'),
('Baja tensión'),
( 'Pérdida de gas'),
( 'Falla en medidor');

INSERT INTO Material (descripcion) 
VALUES
('Cable trifásico'),
('Tubo de gas 1/2"'),
('Medidor digital'),
('Transformador 25kVA');

INSERT INTO reclamo ( id_usuario, nro_reclamo, codigoMot, fecha_reclamo, hora_reclamo, fecha_solucion) 
VALUES
(1, 1, 3,  '2025-10-10', '09:15:00', '2025-10-11'),
(2, 2, 3, '2025-10-12', '14:40:00', NULL),
(3, 3, 4, '2025-10-15', '17:05:00', '2025-10-16');

INSERT INTO reclamo ( id_usuario, nro_reclamo, codigoMot, fecha_reclamo, hora_reclamo, fecha_solucion) 
VALUES
(4, 4, 3, '2025-10-28', '21:51:00', '2026-10-30'),
(5, 5, 3, '2029-10-29', '20:51:00', '2030-10-30');

INSERT INTO reclamo ( id_usuario, nro_reclamo, codigoMot, fecha_reclamo, hora_reclamo, fecha_solucion) 
VALUES
(6, 6, 2, '2025-10-30', '16:51:00', '2026-10-01'),
(6, 7, 3, '2025-10-5', '20:00:00', '2027-10-01');


INSERT INTO llamados (nro_llamado, nro_reclamo, fecha_reclamo, hora_reclamo) 
VALUES
(1, 1, '2025-10-10', '09:00:00'),
(2, 2, '2025-10-12', '14:30:00'),
(3, 3, '2025-10-15', '16:50:00'),
(4, 3, '2025-11-15', '20:50:00'),
(4, 2, '2025-12-25', '24:00:00');

INSERT INTO llamados (nro_llamado, nro_reclamo, fecha_reclamo, hora_reclamo) 
VALUES
(5, 4, '2025-10-28', '21:51:00'),
(5, 5, '2029-10-29', '20:51:00');


INSERT INTO UsoMaterial (nro_reclamo, codigoMat, cantMat)
 VALUES
(1, 1, 10),
(1, 3, 1),
(2, 2, 4),
(3, 4, 1);

INSERT INTO Mantiene (dniEmpleado, nro_reclamo)
VALUES
(40111222, 1), 
(40111222, 2),  
(38999888, 3),  
(42777111, 4),  
(40111222, 5), 
(40111222, 6),  
(38999888, 6),  
(42777111, 1); 


-- PRUEBAS BASICAS

SELECT * 
FROM Usuario;

SELECT * 
FROM Empresa;

SELECT * 
FROM Persona;

SELECT * 
FROM Reclamo;

SELECT * 
FROM Material;

SELECT * 
FROM Motivo;

SELECT *
FROM llamados;

SELECT * 
FROM usomaterial;

/*
	Consultas consigna 6
*/
  -- Esta consulta devuelve los reclamos utilizo materiales incluido los que no 
SELECT r.nro_reclamo, m.codigoMat, m.descripcion, u.cantMat
FROM Reclamo r 
LEFT JOIN UsoMaterial u
	ON r.nro_reclamo = u.nro_reclamo
LEFT JOIN Material m
	ON u.codigoMat = m.codigoMat
ORDER BY r.nro_reclamo ASC;

-- Esta consulta devuelve los usuarios que hicieron mas de un reclamo
SELECT count(r.nro_reclamo) AS Cantidad_de_reclamos, u.id_usuario 
FROM Usuario u
JOIN Reclamo r
	ON u.id_usuario = r.id_usuario
GROUP BY u.id_usuario
HAVING count(r.nro_reclamo) > 1;

-- Esta consulta devuelve los reclamos que tienen mas de un empleado de mantenimiento
SELECT count(m.dniEmpleado) AS Cantidad_de_empleados, m.nro_reclamo
FROM Mantiene m
GROUP BY m.nro_reclamo
HAVING count(m.dniEmpleado) > 1;





-- ejemplo de prueba del trigger


INSERT INTO reclamo ( id_usuario, nro_reclamo, codigoMot, fecha_reclamo, hora_reclamo, fecha_solucion)  -- cargamos uno en la tabla reclamo para despues eliminarlo
VALUES ( 2, 8, 3,  '2024-10-01', '09:00:00', '2024-10-05');

DELETE 
FROM reclamo 
WHERE nro_reclamo = 8;       -- que me elimine de la tabla reclamo el nro de reclamo = 5
  
  SELECT *                     -- verificamos que realmente quedó registrado en la tabla reclamos_borrados
FROM reclamos_borrados;
  
