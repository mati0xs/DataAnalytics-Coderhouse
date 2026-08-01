/*
===============================================================
Curso: Data Analytics - Coderhouse
Pre-entrega Módulo 5

Archivo: m5_consultas_joins.sql

Descripción:
Consultas utilizando JOIN para enriquecer el análisis de la base
de datos Ventas_Tech_DB.

Motor utilizado:
Microsoft SQL Server

Nota:
Las consultas fueron desarrolladas sobre la estructura de la base
Ventas_Tech_DB creada y aprobada en el Módulo 3.

La versión de esta base no incluye la tabla "territorios"
ni las columnas "segmento" y "canal" mencionadas en la consigna,
por lo que las consultas fueron adaptadas a la estructura
disponible, manteniendo el objetivo del ejercicio.
===============================================================
*/

USE Ventas_Tech_DB;

-- ============================================================
-- Consulta 1
-- Vista base del proyecto (INNER JOIN)
-- ============================================================

SELECT
    v.fecha_venta,
    c.nombre AS nombre_cliente,
    c.email,
    c.ciudad,
    p.nombre_producto,
    cat.nombre_categoria,
    v.cantidad,
    v.precio_unitario,
    (v.cantidad * v.precio_unitario) AS total_venta
FROM ventas AS v
INNER JOIN clientes AS c
    ON v.id_cliente = c.id_cliente
INNER JOIN productos AS p
    ON v.id_producto = p.id_producto
INNER JOIN categorias AS cat
    ON p.id_categoria = cat.id_categoria
ORDER BY v.fecha_venta;

-- ============================================================
-- Consulta 2
-- Clientes sin ventas (LEFT JOIN)
-- ============================================================

SELECT
    c.nombre,
    c.email,
    c.fecha_registro
FROM clientes AS c
LEFT JOIN ventas AS v
    ON c.id_cliente = v.id_cliente
WHERE v.id_cliente IS NULL;

-- ============================================================
-- Consulta 3
-- Productos sin ventas (LEFT JOIN)
-- ============================================================

SELECT
    p.nombre_producto,
    cat.nombre_categoria,
    p.precio
FROM productos AS p
LEFT JOIN ventas AS v
    ON p.id_producto = v.id_producto
INNER JOIN categorias AS cat
    ON p.id_categoria = cat.id_categoria
WHERE v.id_producto IS NULL;

-- ============================================================
-- Consulta 4
-- Consolidado utilizando UNION ALL
-- ============================================================

SELECT
    canal,
    SUM(total_venta) AS total_facturado
FROM (
    SELECT
        'Online' AS canal,
        (cantidad * precio_unitario) AS total_venta
    FROM ventas
    WHERE id_venta <= 5

    UNION ALL

    SELECT
        'Presencial' AS canal,
        (cantidad * precio_unitario) AS total_venta
    FROM ventas
    WHERE id_venta > 5
) AS ventas_por_canal
GROUP BY canal
ORDER BY canal;

-- ============================================================
-- Hallazgos
-- ============================================================

-- 1. El INNER JOIN consolida información de ventas, clientes,
--    productos y categorías en una única consulta, facilitando
--    su utilización posterior en Power BI.

-- 2. Todos los clientes registrados realizaron al menos una
--    compra y todos los productos del catálogo poseen ventas,
--    por lo que las consultas con LEFT JOIN no devuelven registros.

-- 3. La base de datos no incluye la columna "canal". Para
--    demostrar el uso de UNION ALL se realizó una división
--    lógica de los registros únicamente con fines didácticos.
