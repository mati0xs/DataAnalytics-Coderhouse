/*
===============================================================
Curso: SQL - Coderhouse
Pre-entrega Módulo 4

Archivo: m4_consultas_negocio.sql

Descripción:
Consultas SQL orientadas a responder preguntas de negocio
sobre la base de datos Ventas_Tech_DB.

Motor utilizado:
Microsoft SQL Server
===============================================================
*/

USE Ventas_Tech_DB;

-- ============================================================
-- Consulta 1
-- Resumen ejecutivo mensual
-- Muestra el total facturado, la cantidad de pedidos
-- y el ticket promedio agrupados por mes.
-- ============================================================

SELECT

    MONTH(fecha_venta) AS mes_venta,

    SUM(cantidad * precio_unitario) AS total_facturado,

    COUNT(*) AS cantidad_pedidos,

    AVG(cantidad * precio_unitario) AS ticket_promedio

FROM ventas

GROUP BY MONTH(fecha_venta)

ORDER BY mes_venta;

-- ============================================================
-- Consulta 2
-- Ranking de productos
-- Top 5 productos según el total facturado.
-- ============================================================

SELECT TOP 5

    id_producto,

    SUM(cantidad) AS unidades_vendidas,

    SUM(cantidad * precio_unitario) AS total_facturado

FROM ventas

GROUP BY id_producto

ORDER BY total_facturado DESC;

-- ============================================================
-- Consulta 3
-- Clientes recurrentes
-- Muestra los clientes que realizaron más de un pedido,
-- indicando la cantidad de pedidos y el total gastado.
-- ============================================================

SELECT

    id_cliente,

    COUNT(*) AS cantidad_pedidos,

    SUM(cantidad * precio_unitario) AS total_gastado

FROM ventas

GROUP BY id_cliente

HAVING COUNT(*) > 1

ORDER BY total_gastado DESC;

-- ============================================================
-- Consulta 4
-- Comparación de la facturación mensual respecto
-- al promedio general de todos los meses.
-- ============================================================

WITH ventas_mensuales AS (

    SELECT

        MONTH(fecha_venta) AS mes_venta,

        SUM(cantidad * precio_unitario) AS total_facturado

    FROM ventas

    GROUP BY MONTH(fecha_venta)

)

SELECT

    mes_venta,

    total_facturado,

    CASE

        WHEN total_facturado >
            (
                SELECT AVG(total_facturado)
                FROM ventas_mensuales
            )
            THEN 'Por encima'

        WHEN total_facturado =
            (
                SELECT AVG(total_facturado)
                FROM ventas_mensuales
            )
            THEN 'Igual al promedio'

        ELSE 'Por debajo'

    END AS comparacion_promedio

FROM ventas_mensuales

ORDER BY mes_venta;

-- ============================================================
-- Hallazgos obtenidos
-- ============================================================

-- 1. El producto con ID 1 fue el producto con mayor facturación
--    del período analizado, generando ingresos por $3.600
--    a partir de la venta de 3 unidades.

-- 2. Todos los clientes registrados realizaron al menos dos pedidos,
--    evidenciando un comportamiento de compra recurrente.
--    El cliente con ID 1 fue quien alcanzó el mayor gasto total,
--    con una facturación acumulada de $2.640.

-- 3. Todas las ventas registradas corresponden al mes de marzo,
--    alcanzando una facturación total de $6.444.
--    En consecuencia, dicho mes coincide con el promedio mensual
--    del período analizado.