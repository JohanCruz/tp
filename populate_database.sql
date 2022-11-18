INSERT INTO city (id, name) VALUES (1, 'Bogotá'), (2, 'Medellín'), (3, 'Bucaramanga')
INSERT INTO gender (id, name) VALUES (1, 'Masculino'), (2, 'Femenino'), (3, 'Otros')
INSERT INTO position (id, name) VALUES (1, 'Asesor'), (2, 'Otros'), (3, 'Director')

INSERT INTO employee (id, name, id_position, document, id_city, id_gender, birthday) VALUES (121, 'Juan',
1, 89, 1, 1, '1998-05-07'), (127, 'Lina', 1, 66, 2, 2, '1988-01-11'),(511, 'Johan', 1, 86076, 1, 1, 
'1983-04-17')

/* concurso */ 
INSERT INTO contest (id, name, description, date) VALUES (1, Canto, 'Puede cantar 
cualquier genero de música y acompñar con algún instrumento', '2022-12-31'),(2, 'Baile',
 'Puede bailar cualquier genero de música puede traer pareja externa', '2022-12-31'), 
(3, 'Ilustración', 'Puede ilstrar al gusto y usar cualquier formato', '2022-12-31')

/* los 3 empleados quedan concursando en canto */
INSERT INTO competitor (id, id_employee, id_contest, times, enabled ) VALUES (
1, 1, 1, 1, 1), (2, 2, 1, 1, 1), (3, 3, 1, 1, 1);

INSERT INTO winner (id_contest, id_competitor, score) VALUES ( 1, 1, 1), (1, 2, 2), (1, 3, 3);

/*


/* procedimiento almacenado para consultar los participantes */

/*
SELECT competitor.id as id, employee.name as employee_name,  employee.id as employee_id, 
contest.name as contest_name, city.name as employee_city, position.name as employee_position, 
CASE competitor.enabled WHEN 1 THEN 'Si' WHEN 0 THEN  'NO' END as competitor_enabled, 
competitor.times as times
FROM competitor
INNER JOIN employee ON competitor.id_employee = employee.id
INNER JOIN contest ON competitor.id_contest = contest.id
INNER JOIN city ON employee.id_city = city.id
INNER JOIN position ON employee.id_position = position.id
*/
#DROP PROCEDURE IF EXISTS getCompetitors
/*DELIMITER //

CREATE PROCEDURE getCompetitors()
BEGIN
    SELECT competitor.id as id, employee.name as employee_name,  employee.id as employee_id, contest.name as contest_name, city.name as employee_city, position.name as employee_position, CASE competitor.enabled WHEN 1 THEN 'Si' WHEN 0 THEN  'NO' END as competitor_enabled, competitor.times as times
	FROM competitor
	INNER JOIN employee ON competitor.id_employee = employee.id
	INNER JOIN contest ON competitor.id_contest = contest.id
	INNER JOIN city ON employee.id_city = city.id
	INNER JOIN position ON employee.id_position = position.id;
END //

DELIMITER ;

*/