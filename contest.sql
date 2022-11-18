-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 18-11-2022 a las 16:19:58
-- Versión del servidor: 10.4.25-MariaDB
-- Versión de PHP: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `contest`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `getCompetitors` ()   BEGIN
    SELECT competitor.id as id, employee.name as employee_name,  employee.id as employee_id, contest.name as contest_name, city.name as employee_city, position.name as employee_position, CASE competitor.enabled WHEN 1 THEN 'Si' WHEN 0 THEN  'NO' END as competitor_enabled, competitor.times as times
	FROM competitor
	INNER JOIN employee ON competitor.id_employee = employee.id
	INNER JOIN contest ON competitor.id_contest = contest.id
	INNER JOIN city ON employee.id_city = city.id
	INNER JOIN position ON employee.id_position = position.id;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `city`
--

CREATE TABLE `city` (
  `id` int(10) NOT NULL,
  `name` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `city`
--

INSERT INTO `city` (`id`, `name`) VALUES
(1, 'Bogotá'),
(2, 'Medellín'),
(3, 'Bucaramanga');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `competitor`
--

CREATE TABLE `competitor` (
  `id` int(10) NOT NULL,
  `id_employee` int(10) NOT NULL,
  `id_contest` int(10) NOT NULL,
  `times` int(11) NOT NULL,
  `date_created` timestamp NOT NULL DEFAULT current_timestamp(),
  `enabled` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `competitor`
--

INSERT INTO `competitor` (`id`, `id_employee`, `id_contest`, `times`, `date_created`, `enabled`) VALUES
(1, 511, 1, 1, '2022-11-18 01:27:01', 0),
(6, 511, 2, 2, '2022-11-18 05:21:28', 0),
(8, 511, 3, 2, '2022-11-18 06:57:39', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `contest`
--

CREATE TABLE `contest` (
  `id` int(10) NOT NULL,
  `name` varchar(15) NOT NULL,
  `description` text NOT NULL,
  `date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `contest`
--

INSERT INTO `contest` (`id`, `name`, `description`, `date`) VALUES
(1, 'Canto', 'Puede cantar cualquier genero de música y acompñar con algún instrumento', '2022-12-31'),
(2, 'Baile', 'Puede bailar cualquier genero de música puede traer pareja externa', '2022-12-31'),
(3, 'Ilustración', 'Puede ilstrar al gusto y usar cualquier formato', '2022-12-31');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `employee`
--

CREATE TABLE `employee` (
  `id` int(10) NOT NULL,
  `name` varchar(30) NOT NULL,
  `id_position` int(10) NOT NULL,
  `document` int(12) NOT NULL,
  `id_city` int(10) NOT NULL,
  `id_gender` int(10) NOT NULL,
  `birthday` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `employee`
--

INSERT INTO `employee` (`id`, `name`, `id_position`, `document`, `id_city`, `id_gender`, `birthday`) VALUES
(121, 'Juan', 1, 89, 3, 1, '1998-05-07'),
(127, 'Lina', 2, 66, 2, 2, '1988-01-11'),
(511, 'Johan', 1, 86076, 1, 1, '1983-04-17');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `gender`
--

CREATE TABLE `gender` (
  `id` int(10) NOT NULL,
  `name` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `gender`
--

INSERT INTO `gender` (`id`, `name`) VALUES
(1, 'Masculino'),
(2, 'Femenino'),
(3, 'Otro');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `position`
--

CREATE TABLE `position` (
  `id` int(10) NOT NULL,
  `name` varchar(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `position`
--

INSERT INTO `position` (`id`, `name`) VALUES
(1, 'Asesor'),
(2, 'Otros'),
(3, 'Director');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `winner`
--

CREATE TABLE `winner` (
  `id_contest` int(10) NOT NULL,
  `score` int(10) NOT NULL,
  `id_competitor` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `city`
--
ALTER TABLE `city`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `competitor`
--
ALTER TABLE `competitor`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_employee` (`id_employee`,`id_contest`),
  ADD KEY `comp1` (`id_contest`);

--
-- Indices de la tabla `contest`
--
ALTER TABLE `contest`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `document` (`document`),
  ADD KEY `id_city` (`id_city`,`id_gender`),
  ADD KEY `empl2` (`id_gender`),
  ADD KEY `id_position` (`id_position`);

--
-- Indices de la tabla `gender`
--
ALTER TABLE `gender`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `position`
--
ALTER TABLE `position`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `winner`
--
ALTER TABLE `winner`
  ADD PRIMARY KEY (`score`),
  ADD KEY `id_contest` (`id_contest`,`id_competitor`),
  ADD KEY `score` (`score`),
  ADD KEY `w1` (`id_competitor`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `city`
--
ALTER TABLE `city`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `competitor`
--
ALTER TABLE `competitor`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `contest`
--
ALTER TABLE `contest`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `gender`
--
ALTER TABLE `gender`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `position`
--
ALTER TABLE `position`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `competitor`
--
ALTER TABLE `competitor`
  ADD CONSTRAINT `comp1` FOREIGN KEY (`id_contest`) REFERENCES `contest` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `comp2` FOREIGN KEY (`id_employee`) REFERENCES `employee` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `employee`
--
ALTER TABLE `employee`
  ADD CONSTRAINT `empl1` FOREIGN KEY (`id_city`) REFERENCES `city` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `empl2` FOREIGN KEY (`id_gender`) REFERENCES `gender` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `empl3` FOREIGN KEY (`id_position`) REFERENCES `position` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `winner`
--
ALTER TABLE `winner`
  ADD CONSTRAINT `w1` FOREIGN KEY (`id_competitor`) REFERENCES `competitor` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `w2` FOREIGN KEY (`id_contest`) REFERENCES `contest` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
