CREATE TABLE Lector(
	id_lector NUMERIC(4),
	codigo_lector CHAR(8),
	apellidos VARCHAR(50),
	nombres VARCHAR(50),
	tipo_lector VARCHAR(30),
	estado CHAR(1),
	
	PRIMARY KEY(id_lector)
);

CREATE TABLE Referencista(
	id_referencista NUMERIC(4),
	codigo_referencista CHAR(8),
	nombre_completo VARCHAR(100),
	
	PRIMARY KEY(id_referencista)
);

CREATE TABLE Publicacion(
	id_publicacion NUMERIC(4),
	codigo_publicacion CHAR(8),
	titulo VARCHAR(30),
	autor VARCHAR(100),
	edicion NUMERIC(2),
	tema VARCHAR(100),
	estado CHAR(1),
	tipo VARCHAR(20),
	
	PRIMARY KEY(id_publicacion)
);

CREATE TABLE Material_adicional(
	id_material NUMERIC(4),
	id_publicacion NUMERIC(4),
	tipo_contenido VARCHAR(20),
	estado CHAR(1),
	
	PRIMARY KEY(id_material),
	FOREIGN KEY(id_publicacion) REFERENCES Publicacion(id_publicacion) 
);

CREATE TABLE Ejemplar(
	id_ejemplar NUMERIC(4),
	origen VARCHAR(30),
	modalidad VARCHAR(20),
	estado CHAR(1),
	id_publicacion NUMERIC(4),
	
	PRIMARY KEY(id_ejemplar),
	FOREIGN KEY(id_publicacion) REFERENCES Publicacion(id_publicacion) 
);

CREATE TABLE Prestamo(
	id_prestamo NUMERIC(4),
	fecha_prestamo VARCHAR(10),
	fecha_devolucion VARCHAR(10),
	id_lector NUMERIC(4),
	id_referencista NUMERIC(4),
	id_ejemplar NUMERIC(4),
	
	PRIMARY KEY(id_prestamo),
	FOREIGN KEY(id_lector) REFERENCES Lector(id_lector),
	FOREIGN KEY(id_referencista) REFERENCES Referencista(id_referencista),
	FOREIGN KEY(id_ejemplar) REFERENCES Ejemplar(id_ejemplar) 
);

-- Insert 3 Referencista
INSERT INTO Referencista VALUES(1, 'codRef01', 'nombreRef1 apellidoRef01');
INSERT INTO Referencista VALUES(2, 'codRef02', 'nombreRef2 apellidoRef02');
INSERT INTO Referencista VALUES(3, 'codRef03', 'nombreRef3 apellidoRef03');

-- Insert 3 Lector
INSERT INTO Lector VALUES(1,'codLec01','apellidoLec01','nombreLec01','alumno','H');
INSERT INTO Lector VALUES(2,'codLec02','apellidoLec02','nombreLec02','docente','H');
INSERT INTO Lector VALUES(3,'codLec03','apellidoLec03','nombreLec03','invitado','H');

-- Insert 3 Publicacion
INSERT INTO Publicacion VALUES(1,'codPub01','tituloPubl01','autorPubl01',1,'temaPubl01','H','libro');
INSERT INTO Publicacion VALUES(2,'codPub02','tituloPubl02','autorPubl02',2,'temaPubl01','H','revista');
INSERT INTO Publicacion VALUES(3,'codPub03','tituloPubl03','autorPubl03',3,'temaPubl01','I','manual');

-- Insert 2 Material_adicional
INSERT INTO Material_adicional VALUES(1,1,'USB','H');
INSERT INTO Material_adicional VALUES(2,2,'CD','H');

-- Insert 6 Ejemplar
INSERT INTO Ejemplar VALUES(1,'compra','prestamo a domicilio','H',1);
INSERT INTO Ejemplar VALUES(2,'donacion','prestamo a domicilio','H',2);
INSERT INTO Ejemplar VALUES(3,'convenio','consulta en sala','H',3);
INSERT INTO Ejemplar VALUES(4,'compra','prestamo virtual','H',3);
INSERT INTO Ejemplar VALUES(5,'donacion','prestamo a domicilio','I',1);
INSERT INTO Ejemplar VALUES(6,'donacion','consulta en sala','H',2);

-- Insert 5 Prestamo
INSERT INTO Prestamo VALUES(1,'26-11-2021','30-11-2021',1,2,1);

-- Obtener publicacion
SELECT * FROM publicacion p;

-- Registrar un lector
INSERT INTO Lector VALUES(?,?,?,?,?,?);

-- Obtener publicacion material
SELECT p.id_publicacion, p.codigo_publicacion, p.titulo, p.autor, p.edicion, p.tipo, ma.id_material, ma.tipo_contenido FROM publicacion p 
INNER JOIN Material_adicional ma ON (p.id_publicacion = ma.id_publicacion);

UPDATE ejemplar e SET e.estado = 'I' WHERE id_detalle =?


-- Obtener info detalladad de Libros prestados (Ejemplares con estado 'H')
SELECT pr.id_prestamo, p.titulo, p.autor, pr.fecha_prestamo,pr.fecha_devolucion, e.origen, e.id_ejemplar, e.modalidad, l.codigo_lector, l.apellidos, l.nombres, l.tipo_lector, r.codigo_referencista, r.nombre_completo FROM prestamo pr 
INNER JOIN ejemplar e ON (pr.id_ejemplar = e.id_ejemplar)
INNER JOIN publicacion p ON (p.id_publicacion = e.id_publicacion)
INNER JOIN lector l ON (l.id_lector = pr.id_lector)
INNER JOIN referencista r ON (r.id_referencista = pr.id_referencista)
WHERE e.estado = 'H';

















