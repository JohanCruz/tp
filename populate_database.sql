INSERT INTO city (id, name) VALUES (1, 'Bogotá'), (2, 'Medellín'), (3, 'Bucaramanga')
INSERT INTO gender (id, name) VALUES (1, 'Masculino'), (2, 'Femenino'), (3, 'Otros')
INSERT INTO position (id, name) VALUES (1, 'Asesor'), (2, 'Otros'), (3, 'Director')

INSERT INTO employee (id, name, id_position, document, id_city, id_gender, birthday) VALUES (121, 'Juan',
1, 89, 1, 1, '1998-05-07'), (127, 'Lina', 2, 66, 2, 2, '1988-01-11'),(511, 'Johan', 3, 86076, 1, 1, 
'1983-04-17')

/* concurso */ 
INSERT INTO contest (id, name, description, date) VALUES (1, Canto, 'Puede cantar 
cualquier genero de música y acompñar con algún instrumento', '2022-12-31'),(2, 'Baile',
 'Puede bailar cualquier genero de música puede traer pareja externa', '2022-12-31'), 
(3, 'Ilustración', 'Puede ilstrar al gusto y usar cualquier formato', '2022-12-31');