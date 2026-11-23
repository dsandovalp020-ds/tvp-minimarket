-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         8.4.3 - MySQL Community Server - GPL
-- SO del servidor:              Win64
-- HeidiSQL Versión:             12.8.0.6908
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para tpv_minimarket
CREATE DATABASE IF NOT EXISTS `tpv_minimarket` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `tpv_minimarket`;

-- Volcando estructura para tabla tpv_minimarket.actividad_log
CREATE TABLE IF NOT EXISTS `actividad_log` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned DEFAULT NULL,
  `accion` varchar(50) NOT NULL,
  `modulo` varchar(50) NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  `ip` varchar(45) DEFAULT NULL,
  `datos` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `actividad_log_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla tpv_minimarket.actividad_log: ~0 rows (aproximadamente)
DELETE FROM `actividad_log`;

-- Volcando estructura para tabla tpv_minimarket.backups
CREATE TABLE IF NOT EXISTS `backups` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `archivo` varchar(255) NOT NULL,
  `tamano` bigint DEFAULT '0',
  `tipo` enum('manual','automatico') DEFAULT 'manual',
  `user_id` bigint unsigned DEFAULT NULL,
  `observaciones` text,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `backups_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla tpv_minimarket.backups: ~0 rows (aproximadamente)
DELETE FROM `backups`;

-- Volcando estructura para tabla tpv_minimarket.cajas
CREATE TABLE IF NOT EXISTS `cajas` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `activo` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla tpv_minimarket.cajas: ~2 rows (aproximadamente)
DELETE FROM `cajas`;
INSERT INTO `cajas` (`id`, `nombre`, `descripcion`, `activo`, `created_at`, `updated_at`) VALUES
	(1, 'Caja Principal', 'Caja principal del minimarket', 1, '2026-05-08 12:32:35', '2026-05-08 12:32:35'),
	(2, 'Caja 2', 'Segunda caja', 1, '2026-05-08 12:32:35', '2026-05-08 12:32:35');

-- Volcando estructura para tabla tpv_minimarket.categorias
CREATE TABLE IF NOT EXISTS `categorias` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `color` varchar(20) DEFAULT '#3B82F6',
  `icono` varchar(50) DEFAULT 'cube',
  `activo` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla tpv_minimarket.categorias: ~12 rows (aproximadamente)
DELETE FROM `categorias`;
INSERT INTO `categorias` (`id`, `nombre`, `descripcion`, `color`, `icono`, `activo`, `created_at`, `updated_at`) VALUES
	(1, 'Abarrotes', 'Productos básicos secos', '#f59e0b', 'cube', 1, '2026-05-08 12:32:35', '2026-05-08 12:32:35'),
	(2, 'Bebidas', 'Bebidas alcohólicas y no alcohólicas', '#3b82f6', 'wine-bottle', 1, '2026-05-08 12:32:35', '2026-05-08 12:32:35'),
	(3, 'Lácteos', 'Leche, queso, yogurt', '#ec4899', 'cheese', 1, '2026-05-08 12:32:35', '2026-05-08 12:32:35'),
	(4, 'Panadería', 'Pan, pasteles', '#d97706', 'bread-slice', 1, '2026-05-08 12:32:35', '2026-05-08 12:32:35'),
	(5, 'Frutas y Verduras', 'Productos frescos', '#10b981', 'apple-alt', 1, '2026-05-08 12:32:35', '2026-05-08 12:32:35'),
	(6, 'Carnes', 'Carnes y embutidos', '#dc2626', 'drumstick-bite', 1, '2026-05-08 12:32:35', '2026-05-08 12:32:35'),
	(7, 'Snacks', 'Galletas, papas fritas', '#fbbf24', 'cookie', 1, '2026-05-08 12:32:35', '2026-05-08 12:32:35'),
	(8, 'Limpieza', 'Productos de limpieza', '#06b6d4', 'soap', 1, '2026-05-08 12:32:35', '2026-05-08 12:32:35'),
	(9, 'Cuidado Personal', 'Higiene personal', '#a855f7', 'tshirt', 1, '2026-05-08 12:32:35', '2026-05-08 12:32:35'),
	(10, 'Bebés', 'Productos para bebés', '#f472b6', 'baby', 1, '2026-05-08 12:32:35', '2026-05-08 12:32:35'),
	(11, 'Mascotas', 'Productos para mascotas', '#84cc16', 'paw', 1, '2026-05-08 12:32:35', '2026-05-08 12:32:35'),
	(12, 'Helados', 'Helados y postres congelados', '#06b6d4', 'ice-cream', 1, '2026-05-08 12:32:35', '2026-05-08 12:32:35');

-- Volcando estructura para tabla tpv_minimarket.clientes
CREATE TABLE IF NOT EXISTS `clientes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `codigo` varchar(30) NOT NULL,
  `tipo_documento` varchar(20) DEFAULT 'DNI',
  `documento` varchar(30) DEFAULT NULL,
  `nombres` varchar(255) NOT NULL,
  `apellidos` varchar(255) DEFAULT NULL,
  `razon_social` varchar(255) DEFAULT NULL,
  `telefono` varchar(30) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `ciudad` varchar(100) DEFAULT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `genero` varchar(20) DEFAULT NULL,
  `puntos_fidelidad` int DEFAULT '0',
  `credito_limite` decimal(12,2) DEFAULT '0.00',
  `credito_usado` decimal(12,2) DEFAULT '0.00',
  `observaciones` text,
  `activo` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `codigo` (`codigo`),
  KEY `documento` (`documento`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla tpv_minimarket.clientes: ~10 rows (aproximadamente)
DELETE FROM `clientes`;
INSERT INTO `clientes` (`id`, `codigo`, `tipo_documento`, `documento`, `nombres`, `apellidos`, `razon_social`, `telefono`, `email`, `direccion`, `ciudad`, `fecha_nacimiento`, `genero`, `puntos_fidelidad`, `credito_limite`, `credito_usado`, `observaciones`, `activo`, `created_at`, `updated_at`) VALUES
	(1, 'CL00001', 'DNI', '12345678', 'Juan Carlos', 'Pérez García', NULL, '987654321', 'juan.perez@gmail.com', 'Av. Lima 123', 'Lima', NULL, 'M', 178, 0.00, 0.00, NULL, 1, '2026-05-08 12:44:53', '2026-05-08 12:44:53'),
	(2, 'CL00002', 'DNI', '87654321', 'María Elena', 'González López', NULL, '976543210', 'maria.gonzalez@gmail.com', 'Jr. Cusco 456', 'Lima', NULL, 'F', 16, 0.00, 0.00, NULL, 1, '2026-05-08 12:44:53', '2026-05-08 12:44:53'),
	(3, 'CL00003', 'DNI', '23456789', 'Carlos Alberto', 'Ramírez Soto', NULL, '965432109', 'carlos.ramirez@hotmail.com', 'Av. Brasil 789', 'Lima', NULL, 'M', 226, 500.00, 0.00, NULL, 1, '2026-05-08 12:44:53', '2026-05-08 12:44:53'),
	(4, 'CL00004', 'DNI', '34567890', 'Ana Sofía', 'Torres Vargas', NULL, '954321098', 'ana.torres@gmail.com', 'Av. Arequipa 321', 'Lima', NULL, 'F', 95, 200.00, 0.00, NULL, 1, '2026-05-08 12:44:53', '2026-05-08 12:44:53'),
	(5, 'CL00005', 'DNI', '45678901', 'Luis Fernando', 'Mendoza Castro', NULL, '943210987', 'luis.mendoza@yahoo.com', 'Jr. Tacna 654', 'Lima', NULL, 'M', 80, 500.00, 0.00, NULL, 1, '2026-05-08 12:44:53', '2026-05-08 12:44:53'),
	(6, 'CL00006', 'DNI', '56789012', 'Patricia', 'Flores Quispe', NULL, '932109876', 'patricia.flores@gmail.com', 'Av. Javier Prado 987', 'Lima', NULL, 'F', 223, 500.00, 0.00, NULL, 1, '2026-05-08 12:44:53', '2026-05-08 12:44:53'),
	(7, 'CL00007', 'RUC', '20100200300', 'Comercial El Sol', NULL, NULL, '012345678', 'ventas@elsol.com', 'Av. Industrial 100', 'Lima', NULL, NULL, 242, 0.00, 0.00, NULL, 1, '2026-05-08 12:44:53', '2026-05-08 12:44:53'),
	(8, 'CL00008', 'DNI', '67890123', 'Roberto', 'Silva Huamán', NULL, '921098765', 'roberto.silva@gmail.com', 'Jr. Junín 234', 'Lima', NULL, 'M', 59, 1000.00, 0.00, NULL, 1, '2026-05-08 12:44:53', '2026-05-08 12:44:53'),
	(9, 'CL00009', 'DNI', '78901234', 'Carmen', 'Vega Ramos', NULL, '910987654', 'carmen.vega@hotmail.com', 'Av. La Marina 567', 'Lima', NULL, 'F', 46, 100.00, 0.00, NULL, 1, '2026-05-08 12:44:53', '2026-05-08 12:44:53'),
	(10, 'CL00010', 'DNI', '89012345', 'José Manuel', 'Díaz Aguirre', NULL, '900876543', 'jose.diaz@gmail.com', 'Jr. Puno 890', 'Lima', NULL, 'M', 152, 0.00, 0.00, NULL, 1, '2026-05-08 12:44:53', '2026-05-08 12:44:53');

-- Volcando estructura para tabla tpv_minimarket.compras
CREATE TABLE IF NOT EXISTS `compras` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `numero` varchar(30) NOT NULL,
  `numero_factura` varchar(50) DEFAULT NULL,
  `fecha_compra` datetime NOT NULL,
  `fecha_vencimiento` date DEFAULT NULL,
  `proveedor_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `subtotal` decimal(12,2) DEFAULT '0.00',
  `descuento` decimal(12,2) DEFAULT '0.00',
  `impuesto` decimal(12,2) DEFAULT '0.00',
  `total` decimal(12,2) DEFAULT '0.00',
  `forma_pago` varchar(30) DEFAULT 'efectivo',
  `estado` enum('recibida','pendiente','anulada') DEFAULT 'recibida',
  `observaciones` text,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `numero` (`numero`),
  KEY `proveedor_id` (`proveedor_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `compras_ibfk_1` FOREIGN KEY (`proveedor_id`) REFERENCES `proveedores` (`id`),
  CONSTRAINT `compras_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla tpv_minimarket.compras: ~10 rows (aproximadamente)
DELETE FROM `compras`;
INSERT INTO `compras` (`id`, `numero`, `numero_factura`, `fecha_compra`, `fecha_vencimiento`, `proveedor_id`, `user_id`, `subtotal`, `descuento`, `impuesto`, `total`, `forma_pago`, `estado`, `observaciones`, `created_at`, `updated_at`) VALUES
	(1, 'C-00000001', 'F740-06601', '2026-05-03 16:00:00', NULL, 6, 1, 749.28, 0.00, 0.00, 749.28, 'efectivo', 'recibida', NULL, '2026-05-03 21:00:00', '2026-05-03 21:00:00'),
	(2, 'C-00000002', 'F552-08360', '2026-05-07 08:00:00', NULL, 2, 1, 1679.30, 0.00, 0.00, 1679.30, 'credito', 'recibida', NULL, '2026-05-07 13:00:00', '2026-05-07 13:00:00'),
	(3, 'C-00000003', 'F377-09319', '2026-05-02 14:00:00', NULL, 4, 1, 1786.33, 0.00, 0.00, 1786.33, 'credito', 'recibida', NULL, '2026-05-02 19:00:00', '2026-05-02 19:00:00'),
	(4, 'C-00000004', 'F355-00996', '2026-04-17 11:00:00', NULL, 2, 1, 681.94, 0.00, 0.00, 681.94, 'credito', 'recibida', NULL, '2026-04-17 16:00:00', '2026-04-17 16:00:00'),
	(5, 'C-00000005', 'F155-02759', '2026-05-07 11:00:00', NULL, 5, 1, 1756.79, 0.00, 0.00, 1756.79, 'credito', 'recibida', NULL, '2026-05-07 16:00:00', '2026-05-07 16:00:00'),
	(6, 'C-00000006', 'F622-07240', '2026-04-17 17:00:00', NULL, 8, 1, 1089.34, 0.00, 0.00, 1089.34, 'efectivo', 'recibida', NULL, '2026-04-17 22:00:00', '2026-04-17 22:00:00'),
	(7, 'C-00000007', 'F691-00130', '2026-04-14 09:00:00', NULL, 8, 1, 1128.75, 0.00, 0.00, 1128.75, 'credito', 'recibida', NULL, '2026-04-14 14:00:00', '2026-04-14 14:00:00'),
	(8, 'C-00000008', 'F596-01842', '2026-04-19 15:00:00', NULL, 9, 1, 1444.10, 0.00, 0.00, 1444.10, 'efectivo', 'recibida', NULL, '2026-04-19 20:00:00', '2026-04-19 20:00:00'),
	(9, 'C-00000009', 'F707-07945', '2026-04-15 16:00:00', NULL, 3, 1, 674.31, 0.00, 0.00, 674.31, 'credito', 'recibida', NULL, '2026-04-15 21:00:00', '2026-04-15 21:00:00'),
	(10, 'C-00000010', 'F747-04942', '2026-04-26 17:00:00', NULL, 4, 1, 2595.81, 0.00, 0.00, 2595.81, 'efectivo', 'recibida', NULL, '2026-04-26 22:00:00', '2026-04-26 22:00:00');

-- Volcando estructura para tabla tpv_minimarket.compra_detalles
CREATE TABLE IF NOT EXISTS `compra_detalles` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `compra_id` bigint unsigned NOT NULL,
  `producto_id` bigint unsigned NOT NULL,
  `codigo` varchar(50) NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  `cantidad` decimal(12,3) NOT NULL,
  `precio_unitario` decimal(12,2) NOT NULL,
  `descuento` decimal(12,2) DEFAULT '0.00',
  `impuesto` decimal(12,2) DEFAULT '0.00',
  `subtotal` decimal(12,2) NOT NULL,
  `total` decimal(12,2) NOT NULL,
  `fecha_vencimiento` date DEFAULT NULL,
  `lote` varchar(50) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `compra_id` (`compra_id`),
  KEY `producto_id` (`producto_id`),
  CONSTRAINT `compra_detalles_ibfk_1` FOREIGN KEY (`compra_id`) REFERENCES `compras` (`id`) ON DELETE CASCADE,
  CONSTRAINT `compra_detalles_ibfk_2` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla tpv_minimarket.compra_detalles: ~53 rows (aproximadamente)
DELETE FROM `compra_detalles`;
INSERT INTO `compra_detalles` (`id`, `compra_id`, `producto_id`, `codigo`, `descripcion`, `cantidad`, `precio_unitario`, `descuento`, `impuesto`, `subtotal`, `total`, `fecha_vencimiento`, `lote`, `created_at`, `updated_at`) VALUES
	(1, 1, 23, 'P000023', 'Limón', 45.000, 4.20, 0.00, 0.00, 189.00, 189.00, NULL, NULL, '2026-05-03 21:00:00', '2026-05-03 21:00:00'),
	(2, 1, 30, 'P000030', 'Jabón Bolívar 250g', 25.000, 2.45, 0.00, 0.00, 61.25, 61.25, NULL, NULL, '2026-05-03 21:00:00', '2026-05-03 21:00:00'),
	(3, 1, 19, 'P000019', 'Manzana Roja', 26.000, 4.83, 0.00, 0.00, 125.58, 125.58, NULL, NULL, '2026-05-03 21:00:00', '2026-05-03 21:00:00'),
	(4, 1, 3, 'P000003', 'Azúcar Rubia 1kg', 97.000, 3.85, 0.00, 0.00, 373.45, 373.45, NULL, NULL, '2026-05-03 21:00:00', '2026-05-03 21:00:00'),
	(5, 2, 28, 'P000028', 'Detergente Ariel 850g', 36.000, 11.55, 0.00, 0.00, 415.80, 415.80, NULL, NULL, '2026-05-07 13:00:00', '2026-05-07 13:00:00'),
	(6, 2, 15, 'P000015', 'Mantequilla Gloria 200g', 70.000, 5.95, 0.00, 0.00, 416.50, 416.50, NULL, NULL, '2026-05-07 13:00:00', '2026-05-07 13:00:00'),
	(7, 2, 11, 'P000011', 'Jugo Frugos Manzana 1L', 60.000, 3.64, 0.00, 0.00, 218.40, 218.40, NULL, NULL, '2026-05-07 13:00:00', '2026-05-07 13:00:00'),
	(8, 2, 24, 'P000024', 'Lays Original 105g', 63.000, 4.55, 0.00, 0.00, 286.65, 286.65, NULL, NULL, '2026-05-07 13:00:00', '2026-05-07 13:00:00'),
	(9, 2, 9, 'P000009', 'Agua Cielo 625ml', 33.000, 1.40, 0.00, 0.00, 46.20, 46.20, NULL, NULL, '2026-05-07 13:00:00', '2026-05-07 13:00:00'),
	(10, 2, 10, 'P000010', 'Cerveza Cristal 630ml', 65.000, 4.55, 0.00, 0.00, 295.75, 295.75, NULL, NULL, '2026-05-07 13:00:00', '2026-05-07 13:00:00'),
	(11, 3, 12, 'P000012', 'Leche Gloria Entera 1L', 84.000, 3.50, 0.00, 0.00, 294.00, 294.00, NULL, NULL, '2026-05-02 19:00:00', '2026-05-02 19:00:00'),
	(12, 3, 26, 'P000026', 'Chocman Costa', 86.000, 0.84, 0.00, 0.00, 72.24, 72.24, NULL, NULL, '2026-05-02 19:00:00', '2026-05-02 19:00:00'),
	(13, 3, 28, 'P000028', 'Detergente Ariel 850g', 57.000, 11.55, 0.00, 0.00, 658.35, 658.35, NULL, NULL, '2026-05-02 19:00:00', '2026-05-02 19:00:00'),
	(14, 3, 24, 'P000024', 'Lays Original 105g', 55.000, 4.55, 0.00, 0.00, 250.25, 250.25, NULL, NULL, '2026-05-02 19:00:00', '2026-05-02 19:00:00'),
	(15, 3, 16, 'P000016', 'Pan Francés', 23.000, 0.28, 0.00, 0.00, 6.44, 6.44, NULL, NULL, '2026-05-02 19:00:00', '2026-05-02 19:00:00'),
	(16, 3, 7, 'P000007', 'Inca Kola 1.5L', 26.000, 4.55, 0.00, 0.00, 118.30, 118.30, NULL, NULL, '2026-05-02 19:00:00', '2026-05-02 19:00:00'),
	(17, 3, 10, 'P000010', 'Cerveza Cristal 630ml', 85.000, 4.55, 0.00, 0.00, 386.75, 386.75, NULL, NULL, '2026-05-02 19:00:00', '2026-05-02 19:00:00'),
	(18, 4, 12, 'P000012', 'Leche Gloria Entera 1L', 85.000, 3.50, 0.00, 0.00, 297.50, 297.50, NULL, NULL, '2026-04-17 16:00:00', '2026-04-17 16:00:00'),
	(19, 4, 20, 'P000020', 'Plátano de Seda', 29.000, 1.96, 0.00, 0.00, 56.84, 56.84, NULL, NULL, '2026-04-17 16:00:00', '2026-04-17 16:00:00'),
	(20, 4, 29, 'P000029', 'Lejía Clorox 1L', 72.000, 4.55, 0.00, 0.00, 327.60, 327.60, NULL, NULL, '2026-04-17 16:00:00', '2026-04-17 16:00:00'),
	(21, 5, 25, 'P000025', 'Doritos Nacho 110g', 51.000, 4.76, 0.00, 0.00, 242.76, 242.76, NULL, NULL, '2026-05-07 16:00:00', '2026-05-07 16:00:00'),
	(22, 5, 1, 'P000001', 'Arroz Costeño 5kg', 51.000, 20.23, 0.00, 0.00, 1031.73, 1031.73, NULL, NULL, '2026-05-07 16:00:00', '2026-05-07 16:00:00'),
	(23, 5, 26, 'P000026', 'Chocman Costa', 48.000, 0.84, 0.00, 0.00, 40.32, 40.32, NULL, NULL, '2026-05-07 16:00:00', '2026-05-07 16:00:00'),
	(24, 5, 6, 'P000006', 'Atún Real Lata 170g', 77.000, 4.34, 0.00, 0.00, 334.18, 334.18, NULL, NULL, '2026-05-07 16:00:00', '2026-05-07 16:00:00'),
	(25, 5, 30, 'P000030', 'Jabón Bolívar 250g', 44.000, 2.45, 0.00, 0.00, 107.80, 107.80, NULL, NULL, '2026-05-07 16:00:00', '2026-05-07 16:00:00'),
	(26, 6, 3, 'P000003', 'Azúcar Rubia 1kg', 82.000, 3.85, 0.00, 0.00, 315.70, 315.70, NULL, NULL, '2026-04-17 22:00:00', '2026-04-17 22:00:00'),
	(27, 6, 18, 'P000018', 'Tostadas Bimbo', 88.000, 4.06, 0.00, 0.00, 357.28, 357.28, NULL, NULL, '2026-04-17 22:00:00', '2026-04-17 22:00:00'),
	(28, 6, 5, 'P000005', 'Fideos Don Vittorio 500g', 80.000, 3.15, 0.00, 0.00, 252.00, 252.00, NULL, NULL, '2026-04-17 22:00:00', '2026-04-17 22:00:00'),
	(29, 6, 16, 'P000016', 'Pan Francés', 47.000, 0.28, 0.00, 0.00, 13.16, 13.16, NULL, NULL, '2026-04-17 22:00:00', '2026-04-17 22:00:00'),
	(30, 6, 23, 'P000023', 'Limón', 36.000, 4.20, 0.00, 0.00, 151.20, 151.20, NULL, NULL, '2026-04-17 22:00:00', '2026-04-17 22:00:00'),
	(31, 7, 20, 'P000020', 'Plátano de Seda', 78.000, 1.96, 0.00, 0.00, 152.88, 152.88, NULL, NULL, '2026-04-14 14:00:00', '2026-04-14 14:00:00'),
	(32, 7, 29, 'P000029', 'Lejía Clorox 1L', 56.000, 4.55, 0.00, 0.00, 254.80, 254.80, NULL, NULL, '2026-04-14 14:00:00', '2026-04-14 14:00:00'),
	(33, 7, 26, 'P000026', 'Chocman Costa', 45.000, 0.84, 0.00, 0.00, 37.80, 37.80, NULL, NULL, '2026-04-14 14:00:00', '2026-04-14 14:00:00'),
	(34, 7, 14, 'P000014', 'Queso Fresco 250g', 31.000, 6.30, 0.00, 0.00, 195.30, 195.30, NULL, NULL, '2026-04-14 14:00:00', '2026-04-14 14:00:00'),
	(35, 7, 27, 'P000027', 'Galletas Oreo', 40.000, 2.66, 0.00, 0.00, 106.40, 106.40, NULL, NULL, '2026-04-14 14:00:00', '2026-04-14 14:00:00'),
	(36, 7, 19, 'P000019', 'Manzana Roja', 79.000, 4.83, 0.00, 0.00, 381.57, 381.57, NULL, NULL, '2026-04-14 14:00:00', '2026-04-14 14:00:00'),
	(37, 8, 10, 'P000010', 'Cerveza Cristal 630ml', 43.000, 4.55, 0.00, 0.00, 195.65, 195.65, NULL, NULL, '2026-04-19 20:00:00', '2026-04-19 20:00:00'),
	(38, 8, 32, 'P000032', 'Pasta Dental Colgate', 49.000, 5.25, 0.00, 0.00, 257.25, 257.25, NULL, NULL, '2026-04-19 20:00:00', '2026-04-19 20:00:00'),
	(39, 8, 22, 'P000022', 'Cebolla', 21.000, 2.66, 0.00, 0.00, 55.86, 55.86, NULL, NULL, '2026-04-19 20:00:00', '2026-04-19 20:00:00'),
	(40, 8, 19, 'P000019', 'Manzana Roja', 73.000, 4.83, 0.00, 0.00, 352.59, 352.59, NULL, NULL, '2026-04-19 20:00:00', '2026-04-19 20:00:00'),
	(41, 8, 20, 'P000020', 'Plátano de Seda', 81.000, 1.96, 0.00, 0.00, 158.76, 158.76, NULL, NULL, '2026-04-19 20:00:00', '2026-04-19 20:00:00'),
	(42, 8, 29, 'P000029', 'Lejía Clorox 1L', 21.000, 4.55, 0.00, 0.00, 95.55, 95.55, NULL, NULL, '2026-04-19 20:00:00', '2026-04-19 20:00:00'),
	(43, 8, 8, 'P000008', 'Coca Cola 1.5L', 69.000, 4.76, 0.00, 0.00, 328.44, 328.44, NULL, NULL, '2026-04-19 20:00:00', '2026-04-19 20:00:00'),
	(44, 9, 22, 'P000022', 'Cebolla', 65.000, 2.66, 0.00, 0.00, 172.90, 172.90, NULL, NULL, '2026-04-15 21:00:00', '2026-04-15 21:00:00'),
	(45, 9, 19, 'P000019', 'Manzana Roja', 85.000, 4.83, 0.00, 0.00, 410.55, 410.55, NULL, NULL, '2026-04-15 21:00:00', '2026-04-15 21:00:00'),
	(46, 9, 4, 'P000004', 'Sal Yodada 1kg', 59.000, 1.54, 0.00, 0.00, 90.86, 90.86, NULL, NULL, '2026-04-15 21:00:00', '2026-04-15 21:00:00'),
	(47, 10, 17, 'P000017', 'Pan Integral', 71.000, 0.49, 0.00, 0.00, 34.79, 34.79, NULL, NULL, '2026-04-26 22:00:00', '2026-04-26 22:00:00'),
	(48, 10, 10, 'P000010', 'Cerveza Cristal 630ml', 77.000, 4.55, 0.00, 0.00, 350.35, 350.35, NULL, NULL, '2026-04-26 22:00:00', '2026-04-26 22:00:00'),
	(49, 10, 28, 'P000028', 'Detergente Ariel 850g', 72.000, 11.55, 0.00, 0.00, 831.60, 831.60, NULL, NULL, '2026-04-26 22:00:00', '2026-04-26 22:00:00'),
	(50, 10, 2, 'P000002', 'Aceite Primor 1L', 89.000, 8.75, 0.00, 0.00, 778.75, 778.75, NULL, NULL, '2026-04-26 22:00:00', '2026-04-26 22:00:00'),
	(51, 10, 20, 'P000020', 'Plátano de Seda', 65.000, 1.96, 0.00, 0.00, 127.40, 127.40, NULL, NULL, '2026-04-26 22:00:00', '2026-04-26 22:00:00'),
	(52, 10, 25, 'P000025', 'Doritos Nacho 110g', 87.000, 4.76, 0.00, 0.00, 414.12, 414.12, NULL, NULL, '2026-04-26 22:00:00', '2026-04-26 22:00:00'),
	(53, 10, 30, 'P000030', 'Jabón Bolívar 250g', 24.000, 2.45, 0.00, 0.00, 58.80, 58.80, NULL, NULL, '2026-04-26 22:00:00', '2026-04-26 22:00:00');

-- Volcando estructura para tabla tpv_minimarket.configuraciones
CREATE TABLE IF NOT EXISTS `configuraciones` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `clave` varchar(100) NOT NULL,
  `valor` text,
  `tipo` varchar(30) DEFAULT 'string',
  `grupo` varchar(50) DEFAULT 'general',
  `descripcion` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `clave` (`clave`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla tpv_minimarket.configuraciones: ~9 rows (aproximadamente)
DELETE FROM `configuraciones`;
INSERT INTO `configuraciones` (`id`, `clave`, `valor`, `tipo`, `grupo`, `descripcion`, `created_at`, `updated_at`) VALUES
	(1, 'puntos_por_moneda', '0.1', 'string', 'fidelidad', NULL, '2026-05-08 12:32:35', '2026-05-08 12:32:35'),
	(2, 'dias_aviso_vencimiento', '30', 'integer', 'inventario', NULL, '2026-05-08 12:32:35', '2026-05-08 12:32:35'),
	(3, 'stock_minimo_default', '5', 'integer', 'inventario', NULL, '2026-05-08 12:32:35', '2026-05-08 12:32:35'),
	(4, 'serie_ticket', 'T001', 'string', 'facturacion', NULL, '2026-05-08 12:32:35', '2026-05-08 12:32:35'),
	(5, 'serie_boleta', 'B001', 'string', 'facturacion', NULL, '2026-05-08 12:32:35', '2026-05-08 12:32:35'),
	(6, 'serie_factura', 'F001', 'string', 'facturacion', NULL, '2026-05-08 12:32:35', '2026-05-08 12:32:35'),
	(7, 'ancho_ticket', '80', 'integer', 'ticket', NULL, '2026-05-08 12:32:35', '2026-05-08 12:32:35'),
	(8, 'imprimir_auto', '1', 'boolean', 'ticket', NULL, '2026-05-08 12:32:35', '2026-05-08 12:32:35'),
	(9, 'mostrar_logo_ticket', '1', 'boolean', 'ticket', NULL, '2026-05-08 12:32:35', '2026-05-08 12:32:35');

-- Volcando estructura para tabla tpv_minimarket.empresas
CREATE TABLE IF NOT EXISTS `empresas` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `razon_social` varchar(255) NOT NULL,
  `nombre_comercial` varchar(255) DEFAULT NULL,
  `ruc_nit` varchar(30) DEFAULT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `ciudad` varchar(100) DEFAULT NULL,
  `telefono` varchar(30) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `sitio_web` varchar(255) DEFAULT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `moneda` varchar(10) DEFAULT 'S/',
  `codigo_moneda` varchar(5) DEFAULT 'PEN',
  `impuesto` decimal(5,2) DEFAULT '18.00',
  `impuesto_incluido` tinyint(1) DEFAULT '1',
  `mensaje_ticket` varchar(255) DEFAULT NULL,
  `terminos_condiciones` text,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla tpv_minimarket.empresas: ~0 rows (aproximadamente)
DELETE FROM `empresas`;
INSERT INTO `empresas` (`id`, `razon_social`, `nombre_comercial`, `ruc_nit`, `direccion`, `ciudad`, `telefono`, `email`, `sitio_web`, `logo`, `moneda`, `codigo_moneda`, `impuesto`, `impuesto_incluido`, `mensaje_ticket`, `terminos_condiciones`, `created_at`, `updated_at`) VALUES
	(1, 'TPV Minimarket Demo S.A.C.', 'Mi Minimarket', '20100100100', 'Av. Principal 123', 'Lima', '01-555-1234', 'contacto@minimarket.com', NULL, NULL, 'S/', 'PEN', 18.00, 1, '¡Gracias por su preferencia! Vuelva pronto.', NULL, '2026-05-08 12:32:35', '2026-05-08 12:32:35');

-- Volcando estructura para tabla tpv_minimarket.movimientos_caja
CREATE TABLE IF NOT EXISTS `movimientos_caja` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `turno_caja_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `tipo` enum('ingreso','egreso') NOT NULL,
  `concepto` varchar(255) NOT NULL,
  `monto` decimal(12,2) NOT NULL,
  `observaciones` text,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `turno_caja_id` (`turno_caja_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `movimientos_caja_ibfk_1` FOREIGN KEY (`turno_caja_id`) REFERENCES `turnos_caja` (`id`),
  CONSTRAINT `movimientos_caja_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla tpv_minimarket.movimientos_caja: ~5 rows (aproximadamente)
DELETE FROM `movimientos_caja`;
INSERT INTO `movimientos_caja` (`id`, `turno_caja_id`, `user_id`, `tipo`, `concepto`, `monto`, `observaciones`, `created_at`, `updated_at`) VALUES
	(1, 1, 1, 'ingreso', 'Reembolso de proveedor', 179.00, NULL, '2026-04-20 17:44:53', '2026-04-20 17:44:53'),
	(2, 1, 1, 'egreso', 'Comida personal', 118.00, NULL, '2026-04-30 17:44:53', '2026-04-30 17:44:53'),
	(3, 1, 1, 'egreso', 'Comida personal', 104.00, NULL, '2026-04-22 17:44:53', '2026-04-22 17:44:53'),
	(4, 1, 1, 'ingreso', 'Cobro pendiente', 51.00, NULL, '2026-04-30 17:44:53', '2026-04-30 17:44:53'),
	(5, 1, 1, 'egreso', 'Pago servicio luz', 158.00, NULL, '2026-04-21 17:44:53', '2026-04-21 17:44:53');

-- Volcando estructura para tabla tpv_minimarket.movimientos_inventario
CREATE TABLE IF NOT EXISTS `movimientos_inventario` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `producto_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `tipo` enum('entrada','salida','ajuste','merma','transferencia') NOT NULL,
  `motivo` varchar(100) NOT NULL,
  `cantidad` decimal(12,3) NOT NULL,
  `stock_anterior` decimal(12,3) NOT NULL,
  `stock_nuevo` decimal(12,3) NOT NULL,
  `referencia_tipo` varchar(50) DEFAULT NULL,
  `referencia_id` bigint unsigned DEFAULT NULL,
  `observaciones` text,
  `fecha` datetime NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `producto_id` (`producto_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `movimientos_inventario_ibfk_1` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`),
  CONSTRAINT `movimientos_inventario_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla tpv_minimarket.movimientos_inventario: ~80 rows (aproximadamente)
DELETE FROM `movimientos_inventario`;
INSERT INTO `movimientos_inventario` (`id`, `producto_id`, `user_id`, `tipo`, `motivo`, `cantidad`, `stock_anterior`, `stock_nuevo`, `referencia_tipo`, `referencia_id`, `observaciones`, `fecha`, `created_at`, `updated_at`) VALUES
	(1, 29, 2, 'salida', 'Venta T001-00000001', 3.000, 40.000, 37.000, 'venta', 1, NULL, '2026-04-09 12:29:00', '2026-05-08 12:44:53', '2026-05-08 12:44:53'),
	(2, 4, 2, 'salida', 'Venta T001-00000001', 4.000, 60.000, 56.000, 'venta', 1, NULL, '2026-04-09 12:29:00', '2026-05-08 12:44:53', '2026-05-08 12:44:53'),
	(3, 2, 2, 'salida', 'Venta T001-00000001', 4.000, 30.000, 26.000, 'venta', 1, NULL, '2026-04-09 12:29:00', '2026-05-08 12:44:53', '2026-05-08 12:44:53'),
	(4, 3, 2, 'salida', 'Venta T001-00000002', 1.000, 80.000, 79.000, 'venta', 2, NULL, '2026-04-12 09:51:00', '2026-05-08 12:44:53', '2026-05-08 12:44:53'),
	(5, 8, 2, 'salida', 'Venta T001-00000002', 3.000, 70.000, 67.000, 'venta', 2, NULL, '2026-04-12 09:51:00', '2026-05-08 12:44:53', '2026-05-08 12:44:53'),
	(6, 17, 2, 'salida', 'Venta T001-00000002', 1.000, 100.000, 99.000, 'venta', 2, NULL, '2026-04-12 09:51:00', '2026-05-08 12:44:53', '2026-05-08 12:44:53'),
	(7, 29, 2, 'salida', 'Venta T001-00000003', 1.000, 37.000, 36.000, 'venta', 3, NULL, '2026-04-15 13:26:00', '2026-05-08 12:44:53', '2026-05-08 12:44:53'),
	(8, 10, 2, 'salida', 'Venta T001-00000003', 1.000, 60.000, 59.000, 'venta', 3, NULL, '2026-04-15 13:26:00', '2026-05-08 12:44:53', '2026-05-08 12:44:53'),
	(9, 14, 2, 'salida', 'Venta T001-00000003', 4.000, 20.000, 16.000, 'venta', 3, NULL, '2026-04-15 13:26:00', '2026-05-08 12:44:53', '2026-05-08 12:44:53'),
	(10, 15, 2, 'salida', 'Venta T001-00000003', 2.000, 15.000, 13.000, 'venta', 3, NULL, '2026-04-15 13:26:00', '2026-05-08 12:44:53', '2026-05-08 12:44:53'),
	(11, 11, 2, 'salida', 'Venta T001-00000003', 2.000, 40.000, 38.000, 'venta', 3, NULL, '2026-04-15 13:26:00', '2026-05-08 12:44:53', '2026-05-08 12:44:53'),
	(12, 22, 1, 'salida', 'Venta T001-00000004', 2.000, 30.000, 28.000, 'venta', 4, NULL, '2026-04-18 13:05:00', '2026-05-08 12:44:53', '2026-05-08 12:44:53'),
	(13, 19, 1, 'salida', 'Venta T001-00000004', 4.000, 30.000, 26.000, 'venta', 4, NULL, '2026-04-18 13:05:00', '2026-05-08 12:44:53', '2026-05-08 12:44:53'),
	(14, 24, 1, 'salida', 'Venta T001-00000004', 2.000, 50.000, 48.000, 'venta', 4, NULL, '2026-04-18 13:05:00', '2026-05-08 12:44:53', '2026-05-08 12:44:53'),
	(15, 7, 1, 'salida', 'Venta T001-00000004', 3.000, 80.000, 77.000, 'venta', 4, NULL, '2026-04-18 13:05:00', '2026-05-08 12:44:53', '2026-05-08 12:44:53'),
	(16, 8, 1, 'salida', 'Venta T001-00000004', 4.000, 67.000, 63.000, 'venta', 4, NULL, '2026-04-18 13:05:00', '2026-05-08 12:44:53', '2026-05-08 12:44:53'),
	(17, 32, 1, 'salida', 'Venta T001-00000004', 1.000, 40.000, 39.000, 'venta', 4, NULL, '2026-04-18 13:05:00', '2026-05-08 12:44:53', '2026-05-08 12:44:53'),
	(18, 18, 1, 'salida', 'Venta T001-00000005', 1.000, 30.000, 29.000, 'venta', 5, NULL, '2026-04-21 10:14:00', '2026-05-08 12:44:54', '2026-05-08 12:44:54'),
	(19, 14, 1, 'salida', 'Venta T001-00000005', 4.000, 16.000, 12.000, 'venta', 5, NULL, '2026-04-21 10:14:00', '2026-05-08 12:44:54', '2026-05-08 12:44:54'),
	(20, 12, 1, 'salida', 'Venta T001-00000005', 4.000, 60.000, 56.000, 'venta', 5, NULL, '2026-04-21 10:14:00', '2026-05-08 12:44:54', '2026-05-08 12:44:54'),
	(21, 17, 1, 'salida', 'Venta T001-00000005', 4.000, 99.000, 95.000, 'venta', 5, NULL, '2026-04-21 10:14:00', '2026-05-08 12:44:54', '2026-05-08 12:44:54'),
	(22, 13, 1, 'salida', 'Venta T001-00000005', 1.000, 25.000, 24.000, 'venta', 5, NULL, '2026-04-21 10:14:00', '2026-05-08 12:44:54', '2026-05-08 12:44:54'),
	(23, 4, 1, 'salida', 'Venta T001-00000005', 3.000, 56.000, 53.000, 'venta', 5, NULL, '2026-04-21 10:14:00', '2026-05-08 12:44:54', '2026-05-08 12:44:54'),
	(24, 32, 3, 'salida', 'Venta T001-00000006', 2.000, 39.000, 37.000, 'venta', 6, NULL, '2026-04-24 18:45:00', '2026-05-08 12:44:54', '2026-05-08 12:44:54'),
	(25, 23, 3, 'salida', 'Venta T001-00000006', 4.000, 20.000, 16.000, 'venta', 6, NULL, '2026-04-24 18:45:00', '2026-05-08 12:44:54', '2026-05-08 12:44:54'),
	(26, 25, 3, 'salida', 'Venta T001-00000006', 2.000, 45.000, 43.000, 'venta', 6, NULL, '2026-04-24 18:45:00', '2026-05-08 12:44:54', '2026-05-08 12:44:54'),
	(27, 6, 3, 'salida', 'Venta T001-00000006', 3.000, 80.000, 77.000, 'venta', 6, NULL, '2026-04-24 18:45:00', '2026-05-08 12:44:54', '2026-05-08 12:44:54'),
	(28, 15, 3, 'salida', 'Venta T001-00000006', 3.000, 13.000, 10.000, 'venta', 6, NULL, '2026-04-24 18:45:00', '2026-05-08 12:44:54', '2026-05-08 12:44:54'),
	(29, 31, 3, 'salida', 'Venta T001-00000006', 1.000, 25.000, 24.000, 'venta', 6, NULL, '2026-04-24 18:45:00', '2026-05-08 12:44:54', '2026-05-08 12:44:54'),
	(30, 24, 2, 'salida', 'Venta T001-00000007', 1.000, 48.000, 47.000, 'venta', 7, NULL, '2026-04-27 16:58:00', '2026-05-08 12:44:54', '2026-05-08 12:44:54'),
	(31, 30, 2, 'salida', 'Venta T001-00000007', 1.000, 50.000, 49.000, 'venta', 7, NULL, '2026-04-27 16:58:00', '2026-05-08 12:44:54', '2026-05-08 12:44:54'),
	(32, 6, 1, 'salida', 'Venta T001-00000008', 4.000, 77.000, 73.000, 'venta', 8, NULL, '2026-04-30 19:27:00', '2026-05-08 12:44:54', '2026-05-08 12:44:54'),
	(33, 17, 1, 'salida', 'Venta T001-00000008', 3.000, 95.000, 92.000, 'venta', 8, NULL, '2026-04-30 19:27:00', '2026-05-08 12:44:54', '2026-05-08 12:44:54'),
	(34, 23, 2, 'salida', 'Venta T001-00000009', 3.000, 16.000, 13.000, 'venta', 9, NULL, '2026-05-02 21:25:00', '2026-05-08 12:44:54', '2026-05-08 12:44:54'),
	(35, 6, 2, 'salida', 'Venta T001-00000009', 3.000, 73.000, 70.000, 'venta', 9, NULL, '2026-05-02 21:25:00', '2026-05-08 12:44:54', '2026-05-08 12:44:54'),
	(36, 27, 2, 'salida', 'Venta T001-00000009', 3.000, 60.000, 57.000, 'venta', 9, NULL, '2026-05-02 21:25:00', '2026-05-08 12:44:54', '2026-05-08 12:44:54'),
	(37, 7, 2, 'salida', 'Venta T001-00000009', 2.000, 77.000, 75.000, 'venta', 9, NULL, '2026-05-02 21:25:00', '2026-05-08 12:44:54', '2026-05-08 12:44:54'),
	(38, 10, 2, 'salida', 'Venta T001-00000009', 1.000, 59.000, 58.000, 'venta', 9, NULL, '2026-05-02 21:25:00', '2026-05-08 12:44:54', '2026-05-08 12:44:54'),
	(39, 22, 3, 'salida', 'Venta T001-00000010', 1.000, 28.000, 27.000, 'venta', 10, NULL, '2026-05-03 12:19:00', '2026-05-08 12:44:54', '2026-05-08 12:44:54'),
	(40, 32, 3, 'salida', 'Venta T001-00000010', 4.000, 37.000, 33.000, 'venta', 10, NULL, '2026-05-03 12:19:00', '2026-05-08 12:44:54', '2026-05-08 12:44:54'),
	(41, 8, 3, 'salida', 'Venta T001-00000010', 4.000, 63.000, 59.000, 'venta', 10, NULL, '2026-05-03 12:19:00', '2026-05-08 12:44:54', '2026-05-08 12:44:54'),
	(42, 10, 3, 'salida', 'Venta T001-00000011', 1.000, 58.000, 57.000, 'venta', 11, NULL, '2026-05-04 14:35:00', '2026-05-08 12:44:54', '2026-05-08 12:44:54'),
	(43, 13, 3, 'salida', 'Venta T001-00000011', 1.000, 24.000, 23.000, 'venta', 11, NULL, '2026-05-04 14:35:00', '2026-05-08 12:44:54', '2026-05-08 12:44:54'),
	(44, 23, 3, 'salida', 'Venta T001-00000011', 1.000, 13.000, 12.000, 'venta', 11, NULL, '2026-05-04 14:35:00', '2026-05-08 12:44:54', '2026-05-08 12:44:54'),
	(45, 21, 3, 'salida', 'Venta T001-00000011', 1.000, 25.000, 24.000, 'venta', 11, NULL, '2026-05-04 14:35:00', '2026-05-08 12:44:54', '2026-05-08 12:44:54'),
	(46, 6, 1, 'salida', 'Venta T001-00000012', 3.000, 70.000, 67.000, 'venta', 12, NULL, '2026-05-05 17:56:00', '2026-05-08 12:44:54', '2026-05-08 12:44:54'),
	(47, 5, 1, 'salida', 'Venta T001-00000012', 4.000, 100.000, 96.000, 'venta', 12, NULL, '2026-05-05 17:56:00', '2026-05-08 12:44:54', '2026-05-08 12:44:54'),
	(48, 22, 1, 'salida', 'Venta T001-00000012', 3.000, 27.000, 24.000, 'venta', 12, NULL, '2026-05-05 17:56:00', '2026-05-08 12:44:54', '2026-05-08 12:44:54'),
	(49, 17, 1, 'salida', 'Venta T001-00000012', 2.000, 92.000, 90.000, 'venta', 12, NULL, '2026-05-05 17:56:00', '2026-05-08 12:44:54', '2026-05-08 12:44:54'),
	(50, 21, 1, 'salida', 'Venta T001-00000012', 4.000, 24.000, 20.000, 'venta', 12, NULL, '2026-05-05 17:56:00', '2026-05-08 12:44:54', '2026-05-08 12:44:54'),
	(51, 32, 1, 'salida', 'Venta T001-00000012', 2.000, 33.000, 31.000, 'venta', 12, NULL, '2026-05-05 17:56:00', '2026-05-08 12:44:54', '2026-05-08 12:44:54'),
	(52, 5, 3, 'salida', 'Venta T001-00000013', 3.000, 96.000, 93.000, 'venta', 13, NULL, '2026-05-06 15:00:00', '2026-05-08 12:44:54', '2026-05-08 12:44:54'),
	(53, 12, 3, 'salida', 'Venta T001-00000013', 1.000, 56.000, 55.000, 'venta', 13, NULL, '2026-05-06 15:00:00', '2026-05-08 12:44:54', '2026-05-08 12:44:54'),
	(54, 19, 2, 'salida', 'Venta T001-00000014', 3.000, 26.000, 23.000, 'venta', 14, NULL, '2026-05-07 17:12:00', '2026-05-08 12:44:54', '2026-05-08 12:44:54'),
	(55, 33, 2, 'salida', 'Venta T001-00000014', 4.000, 50.000, 46.000, 'venta', 14, NULL, '2026-05-07 17:12:00', '2026-05-08 12:44:54', '2026-05-08 12:44:54'),
	(56, 31, 2, 'salida', 'Venta T001-00000014', 2.000, 24.000, 22.000, 'venta', 14, NULL, '2026-05-07 17:12:00', '2026-05-08 12:44:54', '2026-05-08 12:44:54'),
	(57, 27, 2, 'salida', 'Venta T001-00000014', 4.000, 57.000, 53.000, 'venta', 14, NULL, '2026-05-07 17:12:00', '2026-05-08 12:44:54', '2026-05-08 12:44:54'),
	(58, 8, 2, 'salida', 'Venta T001-00000014', 4.000, 59.000, 55.000, 'venta', 14, NULL, '2026-05-07 17:12:00', '2026-05-08 12:44:54', '2026-05-08 12:44:54'),
	(59, 16, 2, 'salida', 'Venta T001-00000014', 4.000, 200.000, 196.000, 'venta', 14, NULL, '2026-05-07 17:12:00', '2026-05-08 12:44:54', '2026-05-08 12:44:54'),
	(60, 22, 1, 'salida', 'Venta T001-00000015', 4.000, 24.000, 20.000, 'venta', 15, NULL, '2026-05-08 13:47:00', '2026-05-08 12:44:54', '2026-05-08 12:44:54'),
	(61, 18, 1, 'salida', 'Venta T001-00000015', 4.000, 29.000, 25.000, 'venta', 15, NULL, '2026-05-08 13:47:00', '2026-05-08 12:44:54', '2026-05-08 12:44:54'),
	(62, 24, 1, 'salida', 'Venta T001-00000015', 4.000, 47.000, 43.000, 'venta', 15, NULL, '2026-05-08 13:47:00', '2026-05-08 12:44:54', '2026-05-08 12:44:54'),
	(63, 19, 1, 'salida', 'Venta T001-00000015', 3.000, 23.000, 20.000, 'venta', 15, NULL, '2026-05-08 13:47:00', '2026-05-08 12:44:54', '2026-05-08 12:44:54'),
	(64, 31, 1, 'salida', 'Venta T001-00000015', 3.000, 22.000, 19.000, 'venta', 15, NULL, '2026-05-08 13:47:00', '2026-05-08 12:44:54', '2026-05-08 12:44:54'),
	(65, 2, 1, 'salida', 'Venta T001-00000015', 2.000, 26.000, 24.000, 'venta', 15, NULL, '2026-05-08 13:47:00', '2026-05-08 12:44:54', '2026-05-08 12:44:54'),
	(66, 30, 2, 'salida', 'Venta T001-00000016', 3.000, 49.000, 46.000, 'venta', 16, NULL, '2026-05-08 16:10:00', '2026-05-08 12:44:54', '2026-05-08 12:44:54'),
	(67, 3, 2, 'salida', 'Venta T001-00000016', 2.000, 79.000, 77.000, 'venta', 16, NULL, '2026-05-08 16:10:00', '2026-05-08 12:44:54', '2026-05-08 12:44:54'),
	(68, 17, 2, 'salida', 'Venta T001-00000016', 4.000, 90.000, 86.000, 'venta', 16, NULL, '2026-05-08 16:10:00', '2026-05-08 12:44:54', '2026-05-08 12:44:54'),
	(69, 21, 2, 'salida', 'Venta T001-00000016', 2.000, 20.000, 18.000, 'venta', 16, NULL, '2026-05-08 16:10:00', '2026-05-08 12:44:54', '2026-05-08 12:44:54'),
	(70, 13, 2, 'salida', 'Venta T001-00000016', 1.000, 23.000, 22.000, 'venta', 16, NULL, '2026-05-08 16:10:00', '2026-05-08 12:44:54', '2026-05-08 12:44:54'),
	(71, 1, 3, 'salida', 'Venta T001-00000017', 3.000, 50.000, 47.000, 'venta', 17, NULL, '2026-05-08 17:32:00', '2026-05-08 12:44:54', '2026-05-08 12:44:54'),
	(72, 2, 3, 'salida', 'Venta T001-00000017', 3.000, 24.000, 21.000, 'venta', 17, NULL, '2026-05-08 17:32:00', '2026-05-08 12:44:54', '2026-05-08 12:44:54'),
	(73, 23, 3, 'salida', 'Venta T001-00000017', 3.000, 12.000, 9.000, 'venta', 17, NULL, '2026-05-08 17:32:00', '2026-05-08 12:44:54', '2026-05-08 12:44:54'),
	(74, 6, 3, 'salida', 'Venta T001-00000017', 2.000, 67.000, 65.000, 'venta', 17, NULL, '2026-05-08 17:32:00', '2026-05-08 12:44:54', '2026-05-08 12:44:54'),
	(75, 24, 3, 'salida', 'Venta T001-00000017', 1.000, 43.000, 42.000, 'venta', 17, NULL, '2026-05-08 17:32:00', '2026-05-08 12:44:54', '2026-05-08 12:44:54'),
	(76, 32, 3, 'salida', 'Venta T001-00000018', 3.000, 31.000, 28.000, 'venta', 18, NULL, '2026-05-08 20:36:00', '2026-05-08 12:44:54', '2026-05-08 12:44:54'),
	(77, 12, 3, 'salida', 'Venta T001-00000018', 3.000, 55.000, 52.000, 'venta', 18, NULL, '2026-05-08 20:36:00', '2026-05-08 12:44:54', '2026-05-08 12:44:54'),
	(78, 16, 3, 'salida', 'Venta T001-00000018', 1.000, 196.000, 195.000, 'venta', 18, NULL, '2026-05-08 20:36:00', '2026-05-08 12:44:54', '2026-05-08 12:44:54'),
	(79, 7, 3, 'salida', 'Venta T001-00000018', 2.000, 75.000, 73.000, 'venta', 18, NULL, '2026-05-08 20:36:00', '2026-05-08 12:44:54', '2026-05-08 12:44:54'),
	(80, 15, 3, 'salida', 'Venta T001-00000018', 1.000, 10.000, 9.000, 'venta', 18, NULL, '2026-05-08 20:36:00', '2026-05-08 12:44:54', '2026-05-08 12:44:54');

-- Volcando estructura para tabla tpv_minimarket.password_reset_tokens
CREATE TABLE IF NOT EXISTS `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla tpv_minimarket.password_reset_tokens: ~0 rows (aproximadamente)
DELETE FROM `password_reset_tokens`;

-- Volcando estructura para tabla tpv_minimarket.productos
CREATE TABLE IF NOT EXISTS `productos` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `codigo` varchar(50) NOT NULL,
  `codigo_barras` varchar(50) DEFAULT NULL,
  `nombre` varchar(255) NOT NULL,
  `descripcion` text,
  `categoria_id` bigint unsigned DEFAULT NULL,
  `proveedor_id` bigint unsigned DEFAULT NULL,
  `unidad_medida` varchar(20) DEFAULT 'UND',
  `precio_compra` decimal(12,2) DEFAULT '0.00',
  `precio_venta` decimal(12,2) DEFAULT '0.00',
  `precio_mayoreo` decimal(12,2) DEFAULT '0.00',
  `cantidad_mayoreo` int DEFAULT '0',
  `stock` decimal(12,3) DEFAULT '0.000',
  `stock_minimo` decimal(12,3) DEFAULT '0.000',
  `stock_maximo` decimal(12,3) DEFAULT '0.000',
  `controla_stock` tinyint(1) DEFAULT '1',
  `aplica_impuesto` tinyint(1) DEFAULT '1',
  `imagen` varchar(255) DEFAULT NULL,
  `fecha_vencimiento` date DEFAULT NULL,
  `lote` varchar(50) DEFAULT NULL,
  `ubicacion` varchar(100) DEFAULT NULL,
  `activo` tinyint(1) DEFAULT '1',
  `destacado` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `codigo` (`codigo`),
  KEY `codigo_barras` (`codigo_barras`),
  KEY `categoria_id` (`categoria_id`),
  KEY `proveedor_id` (`proveedor_id`),
  CONSTRAINT `productos_ibfk_1` FOREIGN KEY (`categoria_id`) REFERENCES `categorias` (`id`) ON DELETE SET NULL,
  CONSTRAINT `productos_ibfk_2` FOREIGN KEY (`proveedor_id`) REFERENCES `proveedores` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla tpv_minimarket.productos: ~33 rows (aproximadamente)
DELETE FROM `productos`;
INSERT INTO `productos` (`id`, `codigo`, `codigo_barras`, `nombre`, `descripcion`, `categoria_id`, `proveedor_id`, `unidad_medida`, `precio_compra`, `precio_venta`, `precio_mayoreo`, `cantidad_mayoreo`, `stock`, `stock_minimo`, `stock_maximo`, `controla_stock`, `aplica_impuesto`, `imagen`, `fecha_vencimiento`, `lote`, `ubicacion`, `activo`, `destacado`, `created_at`, `updated_at`) VALUES
	(1, 'P000001', '7501000000001', 'Arroz Costeño 5kg', NULL, 1, 1, 'KG', 22.50, 28.90, 27.46, 12, 98.000, 10.000, 100.000, 1, 1, NULL, '2026-08-06', 'L0007', NULL, 1, 1, '2026-05-08 12:32:35', '2026-05-08 12:32:35'),
	(2, 'P000002', '7501000000002', 'Aceite Primor 1L', NULL, 1, 1, 'LT', 9.80, 12.50, 11.88, 12, 110.000, 5.000, 60.000, 1, 1, NULL, NULL, NULL, NULL, 1, 1, '2026-05-08 12:32:35', '2026-05-08 12:32:35'),
	(3, 'P000003', '7501000000003', 'Azúcar Rubia 1kg', NULL, 1, 1, 'KG', 4.20, 5.50, 5.23, 12, 256.000, 15.000, 160.000, 1, 1, NULL, NULL, NULL, NULL, 1, 1, '2026-05-08 12:32:35', '2026-05-08 12:32:35'),
	(4, 'P000004', '7501000000004', 'Sal Yodada 1kg', NULL, 1, 1, 'KG', 1.50, 2.20, 2.09, 12, 112.000, 10.000, 120.000, 1, 1, NULL, '2026-06-22', 'L0006', NULL, 1, 1, '2026-05-08 12:32:35', '2026-05-08 12:32:35'),
	(5, 'P000005', '7501000000005', 'Fideos Don Vittorio 500g', NULL, 1, 1, 'PAQ', 3.20, 4.50, 4.28, 12, 173.000, 20.000, 200.000, 1, 1, NULL, '2026-11-04', 'L0008', NULL, 1, 1, '2026-05-08 12:32:35', '2026-05-08 12:32:35'),
	(6, 'P000006', '7501000000006', 'Atún Real Lata 170g', NULL, 1, 1, 'UND', 4.50, 6.20, 5.89, 12, 142.000, 15.000, 160.000, 1, 1, NULL, NULL, NULL, NULL, 1, 1, '2026-05-08 12:32:35', '2026-05-08 12:32:35'),
	(7, 'P000007', '7501000000007', 'Inca Kola 1.5L', NULL, 2, 2, 'UND', 4.50, 6.50, 6.18, 12, 99.000, 12.000, 160.000, 1, 1, NULL, NULL, NULL, NULL, 1, 1, '2026-05-08 12:32:35', '2026-05-08 12:32:35'),
	(8, 'P000008', '7501000000008', 'Coca Cola 1.5L', NULL, 2, 2, 'UND', 4.80, 6.80, 6.46, 12, 124.000, 10.000, 140.000, 1, 1, NULL, '2026-05-11', 'L0001', NULL, 1, 1, '2026-05-08 12:32:35', '2026-05-08 12:32:35'),
	(9, 'P000009', '7501000000009', 'Agua Cielo 625ml', NULL, 2, 2, 'UND', 1.20, 2.00, 1.90, 12, 153.000, 20.000, 240.000, 1, 1, NULL, NULL, NULL, NULL, 1, 1, '2026-05-08 12:32:35', '2026-05-08 12:32:35'),
	(10, 'P000010', '7501000000010', 'Cerveza Cristal 630ml', NULL, 2, 2, 'UND', 4.50, 6.50, 6.18, 12, 327.000, 12.000, 120.000, 1, 1, NULL, NULL, NULL, NULL, 1, 1, '2026-05-08 12:32:35', '2026-05-08 12:32:35'),
	(11, 'P000011', '7501000000011', 'Jugo Frugos Manzana 1L', NULL, 2, 2, 'UND', 3.80, 5.20, 4.94, 12, 98.000, 8.000, 80.000, 1, 1, NULL, NULL, NULL, NULL, 1, 1, '2026-05-08 12:32:35', '2026-05-08 12:32:35'),
	(12, 'P000012', '7501000000012', 'Leche Gloria Entera 1L', NULL, 3, 3, 'UND', 3.80, 5.00, 4.75, 12, 221.000, 10.000, 120.000, 1, 1, NULL, '2026-05-18', 'L0002', NULL, 1, 1, '2026-05-08 12:32:35', '2026-05-08 12:32:35'),
	(13, 'P000013', '7501000000013', 'Yogurt Gloria Fresa 1kg', NULL, 3, 3, 'UND', 7.50, 9.90, 9.41, 12, 22.000, 5.000, 50.000, 1, 1, NULL, NULL, NULL, NULL, 1, 0, '2026-05-08 12:32:35', '2026-05-08 12:32:35'),
	(14, 'P000014', '7501000000014', 'Queso Fresco 250g', NULL, 3, 3, 'UND', 6.50, 9.00, 8.55, 12, 43.000, 4.000, 40.000, 1, 1, NULL, NULL, NULL, NULL, 1, 0, '2026-05-08 12:32:35', '2026-05-08 12:32:35'),
	(15, 'P000015', '7501000000015', 'Mantequilla Gloria 200g', NULL, 3, 3, 'UND', 6.20, 8.50, 8.08, 12, 79.000, 3.000, 30.000, 1, 1, NULL, NULL, NULL, NULL, 1, 0, '2026-05-08 12:32:35', '2026-05-08 12:32:35'),
	(16, 'P000016', '7501000000016', 'Pan Francés', NULL, 4, 4, 'UND', 0.20, 0.40, 0.38, 12, 265.000, 30.000, 400.000, 1, 1, NULL, NULL, NULL, NULL, 1, 0, '2026-05-08 12:32:35', '2026-05-08 12:32:35'),
	(17, 'P000017', '7501000000017', 'Pan Integral', NULL, 4, 4, 'UND', 0.40, 0.70, 0.67, 12, 157.000, 20.000, 200.000, 1, 1, NULL, '2026-05-28', 'L0004', NULL, 1, 0, '2026-05-08 12:32:35', '2026-05-08 12:32:35'),
	(18, 'P000018', '7501000000018', 'Tostadas Bimbo', NULL, 4, 4, 'PAQ', 4.20, 5.80, 5.51, 12, 113.000, 8.000, 60.000, 1, 1, NULL, NULL, NULL, NULL, 1, 0, '2026-05-08 12:32:35', '2026-05-08 12:32:35'),
	(19, 'P000019', '7501000000019', 'Manzana Roja', NULL, 5, 1, 'KG', 4.50, 6.90, 6.56, 12, 283.000, 5.000, 60.000, 1, 1, NULL, NULL, NULL, NULL, 1, 0, '2026-05-08 12:32:35', '2026-05-08 12:32:35'),
	(20, 'P000020', '7501000000020', 'Plátano de Seda', NULL, 5, 1, 'KG', 1.80, 2.80, 2.66, 12, 293.000, 8.000, 80.000, 1, 1, NULL, NULL, NULL, NULL, 1, 0, '2026-05-08 12:32:35', '2026-05-08 12:32:35'),
	(21, 'P000021', '7501000000021', 'Tomate', NULL, 5, 1, 'KG', 3.50, 5.00, 4.75, 12, 18.000, 5.000, 50.000, 1, 1, NULL, NULL, NULL, NULL, 1, 0, '2026-05-08 12:32:35', '2026-05-08 12:32:35'),
	(22, 'P000022', '7501000000022', 'Cebolla', NULL, 5, 1, 'KG', 2.50, 3.80, 3.61, 12, 106.000, 6.000, 60.000, 1, 1, NULL, NULL, NULL, NULL, 1, 0, '2026-05-08 12:32:35', '2026-05-08 12:32:35'),
	(23, 'P000023', '7501000000023', 'Limón', NULL, 5, 1, 'KG', 4.20, 6.00, 5.70, 12, 90.000, 4.000, 40.000, 1, 1, NULL, '2026-05-23', 'L0003', NULL, 1, 0, '2026-05-08 12:32:35', '2026-05-08 12:32:35'),
	(24, 'P000024', '7501000000024', 'Lays Original 105g', NULL, 7, 1, 'UND', 4.50, 6.50, 6.18, 12, 160.000, 10.000, 100.000, 1, 1, NULL, NULL, NULL, NULL, 1, 0, '2026-05-08 12:32:35', '2026-05-08 12:32:35'),
	(25, 'P000025', '7501000000025', 'Doritos Nacho 110g', NULL, 7, 1, 'UND', 4.80, 6.80, 6.46, 12, 181.000, 8.000, 90.000, 1, 1, NULL, NULL, NULL, NULL, 1, 0, '2026-05-08 12:32:35', '2026-05-08 12:32:35'),
	(26, 'P000026', '7501000000026', 'Chocman Costa', NULL, 7, 1, 'UND', 0.80, 1.20, 1.14, 12, 279.000, 20.000, 200.000, 1, 1, NULL, NULL, NULL, NULL, 1, 0, '2026-05-08 12:32:35', '2026-05-08 12:32:35'),
	(27, 'P000027', '7501000000027', 'Galletas Oreo', NULL, 7, 1, 'UND', 2.50, 3.80, 3.61, 12, 93.000, 12.000, 120.000, 1, 1, NULL, NULL, NULL, NULL, 1, 0, '2026-05-08 12:32:35', '2026-05-08 12:32:35'),
	(28, 'P000028', '7501000000028', 'Detergente Ariel 850g', NULL, 8, 1, 'UND', 12.50, 16.50, 15.68, 12, 195.000, 5.000, 60.000, 1, 1, NULL, NULL, NULL, NULL, 1, 0, '2026-05-08 12:32:35', '2026-05-08 12:32:35'),
	(29, 'P000029', '7501000000029', 'Lejía Clorox 1L', NULL, 8, 1, 'LT', 4.50, 6.50, 6.18, 12, 185.000, 8.000, 80.000, 1, 1, NULL, NULL, NULL, NULL, 1, 0, '2026-05-08 12:32:35', '2026-05-08 12:32:35'),
	(30, 'P000030', '7501000000030', 'Jabón Bolívar 250g', NULL, 8, 1, 'UND', 2.20, 3.50, 3.33, 12, 139.000, 10.000, 100.000, 1, 1, NULL, NULL, NULL, NULL, 1, 0, '2026-05-08 12:32:35', '2026-05-08 12:32:35'),
	(31, 'P000031', '7501000000031', 'Shampoo H&S 200ml', NULL, 9, 1, 'UND', 14.50, 18.90, 17.96, 12, 19.000, 5.000, 50.000, 1, 1, NULL, NULL, NULL, NULL, 1, 0, '2026-05-08 12:32:35', '2026-05-08 12:32:35'),
	(32, 'P000032', '7501000000032', 'Pasta Dental Colgate', NULL, 9, 1, 'UND', 5.20, 7.50, 7.13, 12, 77.000, 8.000, 80.000, 1, 1, NULL, NULL, NULL, NULL, 1, 0, '2026-05-08 12:32:35', '2026-05-08 12:32:35'),
	(33, 'P000033', '7501000000033', 'Papel Higiénico Suave x4', NULL, 9, 1, 'PAQ', 7.50, 10.50, 9.98, 12, 46.000, 10.000, 100.000, 1, 1, NULL, '2026-06-12', 'L0005', NULL, 1, 0, '2026-05-08 12:32:35', '2026-05-08 12:32:35');

-- Volcando estructura para tabla tpv_minimarket.promociones
CREATE TABLE IF NOT EXISTS `promociones` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `descripcion` text,
  `tipo` enum('descuento_porcentaje','descuento_fijo','2x1','3x2','precio_especial') NOT NULL,
  `valor` decimal(12,2) DEFAULT '0.00',
  `producto_id` bigint unsigned DEFAULT NULL,
  `categoria_id` bigint unsigned DEFAULT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date NOT NULL,
  `cantidad_minima` int DEFAULT '1',
  `activo` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `producto_id` (`producto_id`),
  KEY `categoria_id` (`categoria_id`),
  CONSTRAINT `promociones_ibfk_1` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`) ON DELETE SET NULL,
  CONSTRAINT `promociones_ibfk_2` FOREIGN KEY (`categoria_id`) REFERENCES `categorias` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla tpv_minimarket.promociones: ~10 rows (aproximadamente)
DELETE FROM `promociones`;
INSERT INTO `promociones` (`id`, `nombre`, `descripcion`, `tipo`, `valor`, `producto_id`, `categoria_id`, `fecha_inicio`, `fecha_fin`, `cantidad_minima`, `activo`, `created_at`, `updated_at`) VALUES
	(1, 'Descuento Verano', 'Descuento del 10% en bebidas', 'descuento_porcentaje', 10.00, NULL, 2, '2026-05-03', '2026-06-02', 1, 1, '2026-05-08 12:44:54', '2026-05-08 12:44:54'),
	(2, '2x1 en Snacks', '2x1 en todos los snacks', '2x1', 0.00, NULL, 7, '2026-05-06', '2026-06-07', 1, 2, '2026-05-08 12:44:54', '2026-05-08 12:44:54'),
	(3, 'Promo Lácteos', '15% off en lácteos', 'descuento_porcentaje', 15.00, NULL, 3, '2026-05-08', '2026-05-28', 1, 1, '2026-05-08 12:44:54', '2026-05-08 12:44:54'),
	(4, 'Combo Familiar', 'Compra 3 unidades y paga 2', '3x2', 0.00, NULL, 1, '2026-05-07', '2026-05-23', 1, 1, '2026-05-08 12:44:54', '2026-05-08 12:44:54'),
	(5, 'Liquidación Limpieza', 'S/ 5 de descuento en limpieza', 'descuento_fijo', 5.00, NULL, 8, '2026-05-05', '2026-05-28', 1, 1, '2026-05-08 12:44:54', '2026-05-08 12:44:54'),
	(6, 'Frutas Frescas', '20% off frutas y verduras', 'descuento_porcentaje', 20.00, NULL, 5, '2026-05-08', '2026-05-18', 1, 1, '2026-05-08 12:44:54', '2026-05-08 12:44:54'),
	(7, 'Aceite Promocional', 'Precio especial S/ 10', 'precio_especial', 10.00, 2, NULL, '2026-04-28', '2026-06-07', 1, 1, '2026-05-08 12:44:54', '2026-05-08 12:44:54'),
	(8, 'Pan Combo', 'Descuento panadería', 'descuento_porcentaje', 12.00, NULL, 4, '2026-05-01', '2026-06-07', 1, 1, '2026-05-08 12:44:54', '2026-05-08 12:44:54'),
	(9, 'Cuidado Personal', '10% off cuidado personal', 'descuento_porcentaje', 10.00, NULL, 9, '2026-05-08', '2026-06-02', 1, 1, '2026-05-08 12:44:54', '2026-05-08 12:44:54'),
	(10, 'Mega Descuento', '25% off productos seleccionados', 'descuento_porcentaje', 25.00, NULL, NULL, '2026-05-13', '2026-07-07', 1, 1, '2026-05-08 12:44:54', '2026-05-08 12:44:54');

-- Volcando estructura para tabla tpv_minimarket.proveedores
CREATE TABLE IF NOT EXISTS `proveedores` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `codigo` varchar(30) NOT NULL,
  `razon_social` varchar(255) NOT NULL,
  `nombre_comercial` varchar(255) DEFAULT NULL,
  `ruc_nit` varchar(30) DEFAULT NULL,
  `contacto` varchar(255) DEFAULT NULL,
  `telefono` varchar(30) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `ciudad` varchar(100) DEFAULT NULL,
  `observaciones` text,
  `activo` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `codigo` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla tpv_minimarket.proveedores: ~10 rows (aproximadamente)
DELETE FROM `proveedores`;
INSERT INTO `proveedores` (`id`, `codigo`, `razon_social`, `nombre_comercial`, `ruc_nit`, `contacto`, `telefono`, `email`, `direccion`, `ciudad`, `observaciones`, `activo`, `created_at`, `updated_at`) VALUES
	(1, 'PR00001', 'Distribuidora Alimentos S.A.', NULL, '20100200300', 'Juan Pérez', '987-654-321', 'ventas@dasa.com', NULL, 'Lima', NULL, 1, '2026-05-08 12:32:35', '2026-05-08 12:32:35'),
	(2, 'PR00002', 'Bebidas y Más SAC', NULL, '20200300400', 'María Gómez', '976-543-210', 'pedidos@bebidasymas.com', NULL, 'Lima', NULL, 1, '2026-05-08 12:32:35', '2026-05-08 12:32:35'),
	(3, 'PR00003', 'Lácteos del Norte', NULL, '20300400500', 'Carlos Ruiz', '965-432-109', 'lacteos@delnorte.com', NULL, 'Trujillo', NULL, 1, '2026-05-08 12:32:35', '2026-05-08 12:32:35'),
	(4, 'PR00004', 'Panificadora La Espiga', NULL, '20400500600', 'Ana Torres', '954-321-098', 'pedidos@laespiga.com', NULL, 'Lima', NULL, 1, '2026-05-08 12:32:35', '2026-05-08 12:32:35'),
	(5, 'PR00005', 'Snacks Premium S.A.', NULL, '20500600700', 'Pedro Salinas', '987111222', 'ventas@snackspremium.com', NULL, 'Lima', NULL, 1, '2026-05-08 12:44:53', '2026-05-08 12:44:53'),
	(6, 'PR00006', 'Distribuidora Gloria SAC', NULL, '20600700800', 'Lucía Pacheco', '987333444', 'pedidos@gloria.com.pe', NULL, 'Lima', NULL, 1, '2026-05-08 12:44:53', '2026-05-08 12:44:53'),
	(7, 'PR00007', 'Importadora Limpieza Total', NULL, '20700800900', 'Miguel Castro', '987555666', 'ventas@limpiezatotal.com', NULL, 'Callao', NULL, 1, '2026-05-08 12:44:53', '2026-05-08 12:44:53'),
	(8, 'PR00008', 'Cervecería Backus', NULL, '20100100100', 'Sandra Velarde', '987777888', 'ventas@backus.pe', NULL, 'Lima', NULL, 1, '2026-05-08 12:44:53', '2026-05-08 12:44:53'),
	(9, 'PR00009', 'Procter & Gamble Perú', NULL, '20800900100', 'Diego Reyes', '987999000', 'pedidos@pg.pe', NULL, 'Lima', NULL, 1, '2026-05-08 12:44:53', '2026-05-08 12:44:53'),
	(10, 'PR00010', 'Alicorp Distribución', NULL, '20900100200', 'Karina Yupanqui', '988111222', 'ventas@alicorp.com.pe', NULL, 'Lima', NULL, 1, '2026-05-08 12:44:53', '2026-05-08 12:44:53');

-- Volcando estructura para tabla tpv_minimarket.puntos_fidelidad
CREATE TABLE IF NOT EXISTS `puntos_fidelidad` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `cliente_id` bigint unsigned NOT NULL,
  `venta_id` bigint unsigned DEFAULT NULL,
  `tipo` enum('ganado','canjeado','expirado','ajuste') NOT NULL,
  `puntos` int NOT NULL,
  `saldo_anterior` int NOT NULL,
  `saldo_nuevo` int NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cliente_id` (`cliente_id`),
  KEY `venta_id` (`venta_id`),
  CONSTRAINT `puntos_fidelidad_ibfk_1` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`id`),
  CONSTRAINT `puntos_fidelidad_ibfk_2` FOREIGN KEY (`venta_id`) REFERENCES `ventas` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla tpv_minimarket.puntos_fidelidad: ~0 rows (aproximadamente)
DELETE FROM `puntos_fidelidad`;

-- Volcando estructura para tabla tpv_minimarket.roles
CREATE TABLE IF NOT EXISTS `roles` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(80) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `permisos` json DEFAULT NULL,
  `activo` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla tpv_minimarket.roles: ~4 rows (aproximadamente)
DELETE FROM `roles`;
INSERT INTO `roles` (`id`, `nombre`, `descripcion`, `permisos`, `activo`, `created_at`, `updated_at`) VALUES
	(1, 'Administrador', 'Acceso completo al sistema', '["*"]', 1, '2026-05-08 12:32:35', '2026-05-08 12:32:35'),
	(2, 'Gerente', 'Gestión completa excepto configuración del sistema', '["productos", "ventas", "compras", "clientes", "proveedores", "caja", "reportes", "promociones"]', 1, '2026-05-08 12:32:35', '2026-05-08 12:32:35'),
	(3, 'Cajero', 'Acceso al punto de venta y caja', '["ventas", "caja", "clientes"]', 1, '2026-05-08 12:32:35', '2026-05-08 12:32:35'),
	(4, 'Almacenero', 'Gestión de inventario y compras', '["productos", "compras", "proveedores", "reportes"]', 1, '2026-05-08 12:32:35', '2026-05-08 12:32:35');

-- Volcando estructura para tabla tpv_minimarket.sessions
CREATE TABLE IF NOT EXISTS `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text,
  `payload` longtext NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `last_activity` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla tpv_minimarket.sessions: ~0 rows (aproximadamente)
DELETE FROM `sessions`;

-- Volcando estructura para tabla tpv_minimarket.turnos_caja
CREATE TABLE IF NOT EXISTS `turnos_caja` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `caja_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `fecha_apertura` datetime NOT NULL,
  `fecha_cierre` datetime DEFAULT NULL,
  `monto_apertura` decimal(12,2) DEFAULT '0.00',
  `monto_cierre` decimal(12,2) DEFAULT NULL,
  `monto_calculado` decimal(12,2) DEFAULT NULL,
  `diferencia` decimal(12,2) DEFAULT '0.00',
  `total_ventas` decimal(12,2) DEFAULT '0.00',
  `total_efectivo` decimal(12,2) DEFAULT '0.00',
  `total_tarjeta` decimal(12,2) DEFAULT '0.00',
  `total_otros` decimal(12,2) DEFAULT '0.00',
  `cantidad_ventas` int DEFAULT '0',
  `observaciones` text,
  `estado` enum('abierto','cerrado') DEFAULT 'abierto',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `caja_id` (`caja_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `turnos_caja_ibfk_1` FOREIGN KEY (`caja_id`) REFERENCES `cajas` (`id`),
  CONSTRAINT `turnos_caja_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla tpv_minimarket.turnos_caja: ~0 rows (aproximadamente)
DELETE FROM `turnos_caja`;
INSERT INTO `turnos_caja` (`id`, `caja_id`, `user_id`, `fecha_apertura`, `fecha_cierre`, `monto_apertura`, `monto_cierre`, `monto_calculado`, `diferencia`, `total_ventas`, `total_efectivo`, `total_tarjeta`, `total_otros`, `cantidad_ventas`, `observaciones`, `estado`, `created_at`, `updated_at`) VALUES
	(1, 1, 1, '2026-04-08 08:00:00', '2026-04-08 22:00:00', 100.00, 1253.00, 1253.00, 0.00, 1338.10, 1153.00, 59.40, 125.70, 18, NULL, 'cerrado', '2026-05-08 12:44:53', '2026-05-08 12:44:53'),
	(2, 1, 1, '2026-05-08 07:50:01', NULL, 0.00, NULL, NULL, 0.00, 0.00, 0.00, 0.00, 0.00, 0, NULL, 'abierto', '2026-05-08 12:50:01', '2026-05-08 12:50:01');

-- Volcando estructura para tabla tpv_minimarket.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `role_id` bigint unsigned DEFAULT NULL,
  `telefono` varchar(30) DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `activo` tinyint(1) DEFAULT '1',
  `ultimo_login` timestamp NULL DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla tpv_minimarket.users: ~3 rows (aproximadamente)
DELETE FROM `users`;
INSERT INTO `users` (`id`, `name`, `username`, `email`, `email_verified_at`, `password`, `role_id`, `telefono`, `avatar`, `activo`, `ultimo_login`, `remember_token`, `created_at`, `updated_at`) VALUES
	(1, 'Administrador del Sistema', 'admin', 'admin@tpvminimarket.com', NULL, '$2y$12$WYiZcBLR03WmsgcaDPx6o.mzOoquFbI6dZWK1VieUXICa9NwjyG7O', 1, '999-888-777', NULL, 1, '2026-05-09 12:05:39', NULL, '2026-05-08 12:32:35', '2026-05-09 12:05:39'),
	(2, 'Gerente Demo', 'gerente', 'gerente@tpvminimarket.com', NULL, '$2y$12$IUOHL4/TrxYymxd9Ca4k7uLt5HVWuowT.COW8fZHjTFdPRve9mZSu', 2, NULL, NULL, 1, NULL, NULL, '2026-05-08 12:32:35', '2026-05-08 12:32:35'),
	(3, 'Cajero Demo', 'cajero', 'cajero@tpvminimarket.com', NULL, '$2y$12$p.wjdnQIBszr2Mj9SLpVp.dDZ2Masfu5MM49d.i8AMhFIvpoiZoCO', 3, NULL, NULL, 1, NULL, NULL, '2026-05-08 12:32:35', '2026-05-08 12:32:35');

-- Volcando estructura para tabla tpv_minimarket.ventas
CREATE TABLE IF NOT EXISTS `ventas` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `numero_ticket` varchar(30) NOT NULL,
  `tipo_comprobante` varchar(30) DEFAULT 'TICKET',
  `serie` varchar(10) DEFAULT 'T001',
  `fecha_venta` datetime NOT NULL,
  `cliente_id` bigint unsigned DEFAULT NULL,
  `user_id` bigint unsigned NOT NULL,
  `turno_caja_id` bigint unsigned DEFAULT NULL,
  `subtotal` decimal(12,2) DEFAULT '0.00',
  `descuento` decimal(12,2) DEFAULT '0.00',
  `impuesto` decimal(12,2) DEFAULT '0.00',
  `total` decimal(12,2) DEFAULT '0.00',
  `monto_recibido` decimal(12,2) DEFAULT '0.00',
  `cambio` decimal(12,2) DEFAULT '0.00',
  `forma_pago` varchar(30) DEFAULT 'efectivo',
  `detalle_pago` json DEFAULT NULL,
  `estado` enum('completada','anulada','pendiente') DEFAULT 'completada',
  `observaciones` text,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `numero_ticket` (`numero_ticket`),
  KEY `cliente_id` (`cliente_id`),
  KEY `user_id` (`user_id`),
  KEY `turno_caja_id` (`turno_caja_id`),
  CONSTRAINT `ventas_ibfk_1` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`id`) ON DELETE SET NULL,
  CONSTRAINT `ventas_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `ventas_ibfk_3` FOREIGN KEY (`turno_caja_id`) REFERENCES `turnos_caja` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla tpv_minimarket.ventas: ~18 rows (aproximadamente)
DELETE FROM `ventas`;
INSERT INTO `ventas` (`id`, `numero_ticket`, `tipo_comprobante`, `serie`, `fecha_venta`, `cliente_id`, `user_id`, `turno_caja_id`, `subtotal`, `descuento`, `impuesto`, `total`, `monto_recibido`, `cambio`, `forma_pago`, `detalle_pago`, `estado`, `observaciones`, `created_at`, `updated_at`) VALUES
	(1, 'T001-00000001', 'TICKET', 'T001', '2026-04-09 12:29:00', NULL, 2, 1, 66.36, 0.00, 11.94, 78.30, 80.00, 1.70, 'efectivo', NULL, 'completada', NULL, '2026-04-09 17:29:00', '2026-04-09 17:29:00'),
	(2, 'T001-00000002', 'TICKET', 'T001', '2026-04-12 09:51:00', NULL, 2, 1, 22.54, 0.00, 4.06, 26.60, 30.00, 3.40, 'efectivo', NULL, 'completada', NULL, '2026-04-12 14:51:00', '2026-04-12 14:51:00'),
	(3, 'T001-00000003', 'TICKET', 'T001', '2026-04-15 13:26:00', 2, 2, 1, 64.75, 5.00, 11.65, 71.40, 71.40, 0.00, 'transferencia', NULL, 'completada', NULL, '2026-04-15 18:26:00', '2026-04-15 18:26:00'),
	(4, 'T001-00000004', 'TICKET', 'T001', '2026-04-18 13:05:00', NULL, 1, 1, 86.78, 0.00, 15.62, 102.40, 105.00, 2.60, 'efectivo', NULL, 'completada', NULL, '2026-04-18 18:05:00', '2026-04-18 18:05:00'),
	(5, 'T001-00000005', 'TICKET', 'T001', '2026-04-21 10:14:00', 7, 1, 1, 68.73, 0.00, 12.37, 81.10, 85.00, 3.90, 'efectivo', NULL, 'completada', NULL, '2026-04-21 15:14:00', '2026-04-21 15:14:00'),
	(6, 'T001-00000006', 'TICKET', 'T001', '2026-04-24 18:45:00', 9, 3, 1, 97.97, 0.00, 17.63, 115.60, 120.00, 4.40, 'efectivo', NULL, 'completada', NULL, '2026-04-24 23:45:00', '2026-04-24 23:45:00'),
	(7, 'T001-00000007', 'TICKET', 'T001', '2026-04-27 16:58:00', 2, 2, 1, 8.47, 0.00, 1.53, 10.00, 10.00, 0.00, 'efectivo', NULL, 'completada', NULL, '2026-04-27 21:58:00', '2026-04-27 21:58:00'),
	(8, 'T001-00000008', 'TICKET', 'T001', '2026-04-30 19:27:00', NULL, 1, 1, 22.80, 0.00, 4.10, 26.90, 26.90, 0.00, 'transferencia', NULL, 'completada', NULL, '2026-05-01 00:27:00', '2026-05-01 00:27:00'),
	(9, 'T001-00000009', 'TICKET', 'T001', '2026-05-02 21:25:00', NULL, 2, 1, 57.20, 5.00, 10.30, 62.50, 65.00, 2.50, 'efectivo', NULL, 'completada', NULL, '2026-05-03 02:25:00', '2026-05-03 02:25:00'),
	(10, 'T001-00000010', 'TICKET', 'T001', '2026-05-03 12:19:00', 1, 3, 1, 51.69, 4.00, 9.31, 57.00, 60.00, 3.00, 'efectivo', NULL, 'completada', NULL, '2026-05-03 17:19:00', '2026-05-03 17:19:00'),
	(11, 'T001-00000011', 'TICKET', 'T001', '2026-05-04 14:35:00', NULL, 3, 1, 23.22, 0.00, 4.18, 27.40, 27.40, 0.00, 'transferencia', NULL, 'completada', NULL, '2026-05-04 19:35:00', '2026-05-04 19:35:00'),
	(12, 'T001-00000012', 'TICKET', 'T001', '2026-05-05 17:56:00', NULL, 1, 1, 71.53, 0.00, 12.87, 84.40, 85.00, 0.60, 'efectivo', NULL, 'completada', NULL, '2026-05-05 22:56:00', '2026-05-05 22:56:00'),
	(13, 'T001-00000013', 'TICKET', 'T001', '2026-05-06 15:00:00', 2, 3, 1, 15.68, 0.00, 2.82, 18.50, 20.00, 1.50, 'efectivo', NULL, 'completada', NULL, '2026-05-06 20:00:00', '2026-05-06 20:00:00'),
	(14, 'T001-00000014', 'TICKET', 'T001', '2026-05-07 17:12:00', NULL, 2, 1, 122.46, 0.00, 22.04, 144.50, 145.00, 0.50, 'efectivo', NULL, 'completada', NULL, '2026-05-07 22:12:00', '2026-05-07 22:12:00'),
	(15, 'T001-00000015', 'TICKET', 'T001', '2026-05-08 13:47:00', NULL, 1, 1, 141.36, 0.00, 25.44, 166.80, 170.00, 3.20, 'efectivo', NULL, 'completada', NULL, '2026-05-08 18:47:00', '2026-05-08 18:47:00'),
	(16, 'T001-00000016', 'TICKET', 'T001', '2026-05-08 16:10:00', NULL, 2, 1, 37.46, 0.00, 6.74, 44.20, 45.00, 0.80, 'efectivo', NULL, 'completada', NULL, '2026-05-08 21:10:00', '2026-05-08 21:10:00'),
	(17, 'T001-00000017', 'TICKET', 'T001', '2026-05-08 17:32:00', 5, 3, 1, 136.53, 0.00, 24.57, 161.10, 165.00, 3.90, 'efectivo', NULL, 'completada', NULL, '2026-05-08 22:32:00', '2026-05-08 22:32:00'),
	(18, 'T001-00000018', 'TICKET', 'T001', '2026-05-08 20:36:00', NULL, 3, 1, 50.34, 0.00, 9.06, 59.40, 59.40, 0.00, 'tarjeta', NULL, 'completada', NULL, '2026-05-09 01:36:00', '2026-05-09 01:36:00');

-- Volcando estructura para tabla tpv_minimarket.venta_detalles
CREATE TABLE IF NOT EXISTS `venta_detalles` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `venta_id` bigint unsigned NOT NULL,
  `producto_id` bigint unsigned NOT NULL,
  `codigo` varchar(50) NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  `cantidad` decimal(12,3) NOT NULL,
  `precio_unitario` decimal(12,2) NOT NULL,
  `descuento` decimal(12,2) DEFAULT '0.00',
  `impuesto` decimal(12,2) DEFAULT '0.00',
  `subtotal` decimal(12,2) NOT NULL,
  `total` decimal(12,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `venta_id` (`venta_id`),
  KEY `producto_id` (`producto_id`),
  CONSTRAINT `venta_detalles_ibfk_1` FOREIGN KEY (`venta_id`) REFERENCES `ventas` (`id`) ON DELETE CASCADE,
  CONSTRAINT `venta_detalles_ibfk_2` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla tpv_minimarket.venta_detalles: ~80 rows (aproximadamente)
DELETE FROM `venta_detalles`;
INSERT INTO `venta_detalles` (`id`, `venta_id`, `producto_id`, `codigo`, `descripcion`, `cantidad`, `precio_unitario`, `descuento`, `impuesto`, `subtotal`, `total`, `created_at`, `updated_at`) VALUES
	(1, 1, 29, 'P000029', 'Lejía Clorox 1L', 3.000, 6.50, 0.00, 2.97, 16.53, 19.50, '2026-04-09 17:29:00', '2026-04-09 17:29:00'),
	(2, 1, 4, 'P000004', 'Sal Yodada 1kg', 4.000, 2.20, 0.00, 1.34, 7.46, 8.80, '2026-04-09 17:29:00', '2026-04-09 17:29:00'),
	(3, 1, 2, 'P000002', 'Aceite Primor 1L', 4.000, 12.50, 0.00, 7.63, 42.37, 50.00, '2026-04-09 17:29:00', '2026-04-09 17:29:00'),
	(4, 2, 3, 'P000003', 'Azúcar Rubia 1kg', 1.000, 5.50, 0.00, 0.84, 4.66, 5.50, '2026-04-12 14:51:00', '2026-04-12 14:51:00'),
	(5, 2, 8, 'P000008', 'Coca Cola 1.5L', 3.000, 6.80, 0.00, 3.11, 17.29, 20.40, '2026-04-12 14:51:00', '2026-04-12 14:51:00'),
	(6, 2, 17, 'P000017', 'Pan Integral', 1.000, 0.70, 0.00, 0.11, 0.59, 0.70, '2026-04-12 14:51:00', '2026-04-12 14:51:00'),
	(7, 3, 29, 'P000029', 'Lejía Clorox 1L', 1.000, 6.50, 0.00, 0.99, 5.51, 6.50, '2026-04-15 18:26:00', '2026-04-15 18:26:00'),
	(8, 3, 10, 'P000010', 'Cerveza Cristal 630ml', 1.000, 6.50, 0.00, 0.99, 5.51, 6.50, '2026-04-15 18:26:00', '2026-04-15 18:26:00'),
	(9, 3, 14, 'P000014', 'Queso Fresco 250g', 4.000, 9.00, 0.00, 5.49, 30.51, 36.00, '2026-04-15 18:26:00', '2026-04-15 18:26:00'),
	(10, 3, 15, 'P000015', 'Mantequilla Gloria 200g', 2.000, 8.50, 0.00, 2.59, 14.41, 17.00, '2026-04-15 18:26:00', '2026-04-15 18:26:00'),
	(11, 3, 11, 'P000011', 'Jugo Frugos Manzana 1L', 2.000, 5.20, 0.00, 1.59, 8.81, 10.40, '2026-04-15 18:26:00', '2026-04-15 18:26:00'),
	(12, 4, 22, 'P000022', 'Cebolla', 2.000, 3.80, 0.00, 1.16, 6.44, 7.60, '2026-04-18 18:05:00', '2026-04-18 18:05:00'),
	(13, 4, 19, 'P000019', 'Manzana Roja', 4.000, 6.90, 0.00, 4.21, 23.39, 27.60, '2026-04-18 18:05:00', '2026-04-18 18:05:00'),
	(14, 4, 24, 'P000024', 'Lays Original 105g', 2.000, 6.50, 0.00, 1.98, 11.02, 13.00, '2026-04-18 18:05:00', '2026-04-18 18:05:00'),
	(15, 4, 7, 'P000007', 'Inca Kola 1.5L', 3.000, 6.50, 0.00, 2.97, 16.53, 19.50, '2026-04-18 18:05:00', '2026-04-18 18:05:00'),
	(16, 4, 8, 'P000008', 'Coca Cola 1.5L', 4.000, 6.80, 0.00, 4.15, 23.05, 27.20, '2026-04-18 18:05:00', '2026-04-18 18:05:00'),
	(17, 4, 32, 'P000032', 'Pasta Dental Colgate', 1.000, 7.50, 0.00, 1.14, 6.36, 7.50, '2026-04-18 18:05:00', '2026-04-18 18:05:00'),
	(18, 5, 18, 'P000018', 'Tostadas Bimbo', 1.000, 5.80, 0.00, 0.88, 4.92, 5.80, '2026-04-21 15:14:00', '2026-04-21 15:14:00'),
	(19, 5, 14, 'P000014', 'Queso Fresco 250g', 4.000, 9.00, 0.00, 5.49, 30.51, 36.00, '2026-04-21 15:14:00', '2026-04-21 15:14:00'),
	(20, 5, 12, 'P000012', 'Leche Gloria Entera 1L', 4.000, 5.00, 0.00, 3.05, 16.95, 20.00, '2026-04-21 15:14:00', '2026-04-21 15:14:00'),
	(21, 5, 17, 'P000017', 'Pan Integral', 4.000, 0.70, 0.00, 0.43, 2.37, 2.80, '2026-04-21 15:14:00', '2026-04-21 15:14:00'),
	(22, 5, 13, 'P000013', 'Yogurt Gloria Fresa 1kg', 1.000, 9.90, 0.00, 1.51, 8.39, 9.90, '2026-04-21 15:14:00', '2026-04-21 15:14:00'),
	(23, 5, 4, 'P000004', 'Sal Yodada 1kg', 3.000, 2.20, 0.00, 1.01, 5.59, 6.60, '2026-04-21 15:14:00', '2026-04-21 15:14:00'),
	(24, 6, 32, 'P000032', 'Pasta Dental Colgate', 2.000, 7.50, 0.00, 2.29, 12.71, 15.00, '2026-04-24 23:45:00', '2026-04-24 23:45:00'),
	(25, 6, 23, 'P000023', 'Limón', 4.000, 6.00, 0.00, 3.66, 20.34, 24.00, '2026-04-24 23:45:00', '2026-04-24 23:45:00'),
	(26, 6, 25, 'P000025', 'Doritos Nacho 110g', 2.000, 6.80, 0.00, 2.07, 11.53, 13.60, '2026-04-24 23:45:00', '2026-04-24 23:45:00'),
	(27, 6, 6, 'P000006', 'Atún Real Lata 170g', 3.000, 6.20, 0.00, 2.84, 15.76, 18.60, '2026-04-24 23:45:00', '2026-04-24 23:45:00'),
	(28, 6, 15, 'P000015', 'Mantequilla Gloria 200g', 3.000, 8.50, 0.00, 3.89, 21.61, 25.50, '2026-04-24 23:45:00', '2026-04-24 23:45:00'),
	(29, 6, 31, 'P000031', 'Shampoo H&S 200ml', 1.000, 18.90, 0.00, 2.88, 16.02, 18.90, '2026-04-24 23:45:00', '2026-04-24 23:45:00'),
	(30, 7, 24, 'P000024', 'Lays Original 105g', 1.000, 6.50, 0.00, 0.99, 5.51, 6.50, '2026-04-27 21:58:00', '2026-04-27 21:58:00'),
	(31, 7, 30, 'P000030', 'Jabón Bolívar 250g', 1.000, 3.50, 0.00, 0.53, 2.97, 3.50, '2026-04-27 21:58:00', '2026-04-27 21:58:00'),
	(32, 8, 6, 'P000006', 'Atún Real Lata 170g', 4.000, 6.20, 0.00, 3.78, 21.02, 24.80, '2026-05-01 00:27:00', '2026-05-01 00:27:00'),
	(33, 8, 17, 'P000017', 'Pan Integral', 3.000, 0.70, 0.00, 0.32, 1.78, 2.10, '2026-05-01 00:27:00', '2026-05-01 00:27:00'),
	(34, 9, 23, 'P000023', 'Limón', 3.000, 6.00, 0.00, 2.75, 15.25, 18.00, '2026-05-03 02:25:00', '2026-05-03 02:25:00'),
	(35, 9, 6, 'P000006', 'Atún Real Lata 170g', 3.000, 6.20, 0.00, 2.84, 15.76, 18.60, '2026-05-03 02:25:00', '2026-05-03 02:25:00'),
	(36, 9, 27, 'P000027', 'Galletas Oreo', 3.000, 3.80, 0.00, 1.74, 9.66, 11.40, '2026-05-03 02:25:00', '2026-05-03 02:25:00'),
	(37, 9, 7, 'P000007', 'Inca Kola 1.5L', 2.000, 6.50, 0.00, 1.98, 11.02, 13.00, '2026-05-03 02:25:00', '2026-05-03 02:25:00'),
	(38, 9, 10, 'P000010', 'Cerveza Cristal 630ml', 1.000, 6.50, 0.00, 0.99, 5.51, 6.50, '2026-05-03 02:25:00', '2026-05-03 02:25:00'),
	(39, 10, 22, 'P000022', 'Cebolla', 1.000, 3.80, 0.00, 0.58, 3.22, 3.80, '2026-05-03 17:19:00', '2026-05-03 17:19:00'),
	(40, 10, 32, 'P000032', 'Pasta Dental Colgate', 4.000, 7.50, 0.00, 4.58, 25.42, 30.00, '2026-05-03 17:19:00', '2026-05-03 17:19:00'),
	(41, 10, 8, 'P000008', 'Coca Cola 1.5L', 4.000, 6.80, 0.00, 4.15, 23.05, 27.20, '2026-05-03 17:19:00', '2026-05-03 17:19:00'),
	(42, 11, 10, 'P000010', 'Cerveza Cristal 630ml', 1.000, 6.50, 0.00, 0.99, 5.51, 6.50, '2026-05-04 19:35:00', '2026-05-04 19:35:00'),
	(43, 11, 13, 'P000013', 'Yogurt Gloria Fresa 1kg', 1.000, 9.90, 0.00, 1.51, 8.39, 9.90, '2026-05-04 19:35:00', '2026-05-04 19:35:00'),
	(44, 11, 23, 'P000023', 'Limón', 1.000, 6.00, 0.00, 0.92, 5.08, 6.00, '2026-05-04 19:35:00', '2026-05-04 19:35:00'),
	(45, 11, 21, 'P000021', 'Tomate', 1.000, 5.00, 0.00, 0.76, 4.24, 5.00, '2026-05-04 19:35:00', '2026-05-04 19:35:00'),
	(46, 12, 6, 'P000006', 'Atún Real Lata 170g', 3.000, 6.20, 0.00, 2.84, 15.76, 18.60, '2026-05-05 22:56:00', '2026-05-05 22:56:00'),
	(47, 12, 5, 'P000005', 'Fideos Don Vittorio 500g', 4.000, 4.50, 0.00, 2.75, 15.25, 18.00, '2026-05-05 22:56:00', '2026-05-05 22:56:00'),
	(48, 12, 22, 'P000022', 'Cebolla', 3.000, 3.80, 0.00, 1.74, 9.66, 11.40, '2026-05-05 22:56:00', '2026-05-05 22:56:00'),
	(49, 12, 17, 'P000017', 'Pan Integral', 2.000, 0.70, 0.00, 0.21, 1.19, 1.40, '2026-05-05 22:56:00', '2026-05-05 22:56:00'),
	(50, 12, 21, 'P000021', 'Tomate', 4.000, 5.00, 0.00, 3.05, 16.95, 20.00, '2026-05-05 22:56:00', '2026-05-05 22:56:00'),
	(51, 12, 32, 'P000032', 'Pasta Dental Colgate', 2.000, 7.50, 0.00, 2.29, 12.71, 15.00, '2026-05-05 22:56:00', '2026-05-05 22:56:00'),
	(52, 13, 5, 'P000005', 'Fideos Don Vittorio 500g', 3.000, 4.50, 0.00, 2.06, 11.44, 13.50, '2026-05-06 20:00:00', '2026-05-06 20:00:00'),
	(53, 13, 12, 'P000012', 'Leche Gloria Entera 1L', 1.000, 5.00, 0.00, 0.76, 4.24, 5.00, '2026-05-06 20:00:00', '2026-05-06 20:00:00'),
	(54, 14, 19, 'P000019', 'Manzana Roja', 3.000, 6.90, 0.00, 3.16, 17.54, 20.70, '2026-05-07 22:12:00', '2026-05-07 22:12:00'),
	(55, 14, 33, 'P000033', 'Papel Higiénico Suave x4', 4.000, 10.50, 0.00, 6.41, 35.59, 42.00, '2026-05-07 22:12:00', '2026-05-07 22:12:00'),
	(56, 14, 31, 'P000031', 'Shampoo H&S 200ml', 2.000, 18.90, 0.00, 5.77, 32.03, 37.80, '2026-05-07 22:12:00', '2026-05-07 22:12:00'),
	(57, 14, 27, 'P000027', 'Galletas Oreo', 4.000, 3.80, 0.00, 2.32, 12.88, 15.20, '2026-05-07 22:12:00', '2026-05-07 22:12:00'),
	(58, 14, 8, 'P000008', 'Coca Cola 1.5L', 4.000, 6.80, 0.00, 4.15, 23.05, 27.20, '2026-05-07 22:12:00', '2026-05-07 22:12:00'),
	(59, 14, 16, 'P000016', 'Pan Francés', 4.000, 0.40, 0.00, 0.24, 1.36, 1.60, '2026-05-07 22:12:00', '2026-05-07 22:12:00'),
	(60, 15, 22, 'P000022', 'Cebolla', 4.000, 3.80, 0.00, 2.32, 12.88, 15.20, '2026-05-08 18:47:00', '2026-05-08 18:47:00'),
	(61, 15, 18, 'P000018', 'Tostadas Bimbo', 4.000, 5.80, 0.00, 3.54, 19.66, 23.20, '2026-05-08 18:47:00', '2026-05-08 18:47:00'),
	(62, 15, 24, 'P000024', 'Lays Original 105g', 4.000, 6.50, 0.00, 3.97, 22.03, 26.00, '2026-05-08 18:47:00', '2026-05-08 18:47:00'),
	(63, 15, 19, 'P000019', 'Manzana Roja', 3.000, 6.90, 0.00, 3.16, 17.54, 20.70, '2026-05-08 18:47:00', '2026-05-08 18:47:00'),
	(64, 15, 31, 'P000031', 'Shampoo H&S 200ml', 3.000, 18.90, 0.00, 8.65, 48.05, 56.70, '2026-05-08 18:47:00', '2026-05-08 18:47:00'),
	(65, 15, 2, 'P000002', 'Aceite Primor 1L', 2.000, 12.50, 0.00, 3.81, 21.19, 25.00, '2026-05-08 18:47:00', '2026-05-08 18:47:00'),
	(66, 16, 30, 'P000030', 'Jabón Bolívar 250g', 3.000, 3.50, 0.00, 1.60, 8.90, 10.50, '2026-05-08 21:10:00', '2026-05-08 21:10:00'),
	(67, 16, 3, 'P000003', 'Azúcar Rubia 1kg', 2.000, 5.50, 0.00, 1.68, 9.32, 11.00, '2026-05-08 21:10:00', '2026-05-08 21:10:00'),
	(68, 16, 17, 'P000017', 'Pan Integral', 4.000, 0.70, 0.00, 0.43, 2.37, 2.80, '2026-05-08 21:10:00', '2026-05-08 21:10:00'),
	(69, 16, 21, 'P000021', 'Tomate', 2.000, 5.00, 0.00, 1.53, 8.47, 10.00, '2026-05-08 21:10:00', '2026-05-08 21:10:00'),
	(70, 16, 13, 'P000013', 'Yogurt Gloria Fresa 1kg', 1.000, 9.90, 0.00, 1.51, 8.39, 9.90, '2026-05-08 21:10:00', '2026-05-08 21:10:00'),
	(71, 17, 1, 'P000001', 'Arroz Costeño 5kg', 3.000, 28.90, 0.00, 13.23, 73.47, 86.70, '2026-05-08 22:32:00', '2026-05-08 22:32:00'),
	(72, 17, 2, 'P000002', 'Aceite Primor 1L', 3.000, 12.50, 0.00, 5.72, 31.78, 37.50, '2026-05-08 22:32:00', '2026-05-08 22:32:00'),
	(73, 17, 23, 'P000023', 'Limón', 3.000, 6.00, 0.00, 2.75, 15.25, 18.00, '2026-05-08 22:32:00', '2026-05-08 22:32:00'),
	(74, 17, 6, 'P000006', 'Atún Real Lata 170g', 2.000, 6.20, 0.00, 1.89, 10.51, 12.40, '2026-05-08 22:32:00', '2026-05-08 22:32:00'),
	(75, 17, 24, 'P000024', 'Lays Original 105g', 1.000, 6.50, 0.00, 0.99, 5.51, 6.50, '2026-05-08 22:32:00', '2026-05-08 22:32:00'),
	(76, 18, 32, 'P000032', 'Pasta Dental Colgate', 3.000, 7.50, 0.00, 3.43, 19.07, 22.50, '2026-05-09 01:36:00', '2026-05-09 01:36:00'),
	(77, 18, 12, 'P000012', 'Leche Gloria Entera 1L', 3.000, 5.00, 0.00, 2.29, 12.71, 15.00, '2026-05-09 01:36:00', '2026-05-09 01:36:00'),
	(78, 18, 16, 'P000016', 'Pan Francés', 1.000, 0.40, 0.00, 0.06, 0.34, 0.40, '2026-05-09 01:36:00', '2026-05-09 01:36:00'),
	(79, 18, 7, 'P000007', 'Inca Kola 1.5L', 2.000, 6.50, 0.00, 1.98, 11.02, 13.00, '2026-05-09 01:36:00', '2026-05-09 01:36:00'),
	(80, 18, 15, 'P000015', 'Mantequilla Gloria 200g', 1.000, 8.50, 0.00, 1.30, 7.20, 8.50, '2026-05-09 01:36:00', '2026-05-09 01:36:00');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
