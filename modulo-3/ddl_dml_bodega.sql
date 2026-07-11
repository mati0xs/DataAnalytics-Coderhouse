-- ══════════════════════════════════════════
-- BodegaTech — Script de Inventario
-- Autor: Matias Gomez Galeano
-- Fecha: 11/07/2026
-- ══════════════════════════════════════════

-- ── SECCIÓN DDL ──────────────────────────
CREATE DATABASE BodegaTech;
USE BodegaTech;

-- DROP TABLE
DROP TABLE IF EXISTS inventario;

-- CREATE TABLE
CREATE TABLE inventario (

-- ID del producto, es un identificador unico autoincremental
id_producto INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
-- Nombre del producto, es una variable texto
nombre_producto VARCHAR(100) NOT NULL,
categoria VARCHAR(50) NOT NULL,
-- Precio unitario, es el precio de venta en USD que usa decimales
precio_unitario DECIMAL(10,2) NOT NULL,
stock_actual INT NOT NULL,
stock_minimo INT NOT NULL,
fecha_ingreso DATE NOT NULL,
-- activo indica con 1 si el producto es continuado y 0 si esta descontinuado
activo BIT
);

SELECT * FROM inventario

-- ── SECCIÓN DML ──────────────────────────

-- INSERT INTO
INSERT INTO inventario (nombre_producto, categoria, precio_unitario, stock_actual, stock_minimo, fecha_ingreso, activo)
VALUES 
('Laptop Pro 15', 'Computacion', 1200.00, 15, 3, '2024-01-10', 1),
('Mouse Inalambrico', 'Accesorios', 28.00, 80, 10, '2024-01-10', 1),
('Monitor 4K 27"', 'Computacion', 450.00, 12, 2, '2024-01-15', 1),
('Teclado Mecanico', 'Accesorios', 95.00, 40, 5, '2024-01-15', 1),
('Laptop Basic 14', 'Computacion', 650.00, 20, 3, '2024-02-01', 1),
('Auriculares BT Pro', 'Audio', 120.00, 35, 5, '2024-02-01', 1),
('Hub USB-C 7 Puertos', 'Accesorios', 45.00, 60, 10, '2024-02-10', 1),
('Webcam HD 1080p', 'Accesorios', 85.00, 25, 5, '2024-02-10', 1),
('SSD Externo 1TB', 'Almacenamiento', 130.00, 18, 3, '2024-03-01', 1),
('Parlante Bluetooth', 'Audio', 60.00, 45, 8, '2024-03-01', 1);

SELECT * FROM inventario;

-- UPDATE ventas del día
-- Venta de 3 laptops
UPDATE inventario
SET stock_actual = stock_actual - 3
WHERE id_producto = 1;

-- Venta de 12 mouse
UPDATE inventario
SET stock_actual = stock_actual - 12
WHERE id_producto = 2;

-- Venta de 5 auriculares
UPDATE inventario
SET stock_actual = stock_actual - 5
WHERE id_producto = 6;

-- UPDATE producto descontinuado
UPDATE inventario
SET activo = 0
WHERE id_producto = 8;

-- SELECT validaciones
SELECT * FROM inventario;
