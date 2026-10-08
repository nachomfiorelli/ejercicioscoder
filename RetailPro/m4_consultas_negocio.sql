sql
-- m4_consultas_negocio.sql
-- Base: Ventas_Tech_DB | Tabla: ventas

-- Consulta 1: Resumen ejecutivo mensual
SELECT
    MONTH(fecha_venta)                       AS mes,
    SUM(cantidad * precio_unitario)          AS total_facturado,
    COUNT(*)                                 AS cantidad_pedidos,
    AVG(cantidad * precio_unitario)          AS ticket_promedio
FROM ventas
GROUP BY MONTH(fecha_venta)
ORDER BY mes;

-- Consulta 2: Top 5 productos por facturación
SELECT TOP 5
    id_producto,
    SUM(cantidad)                            AS unidades_vendidas,
    SUM(cantidad * precio_unitario)          AS total_generado
FROM ventas
GROUP BY id_producto
ORDER BY total_generado DESC;

-- Consulta 3: Clientes recurrentes (más de un pedido)
SELECT
    id_cliente,
    COUNT(*)                                 AS cantidad_pedidos,
    SUM(cantidad * precio_unitario)          AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1
ORDER BY total_gastado DESC;

-- Consulta 4: Meses por encima / por debajo del promedio mensual
WITH mensual AS (
    SELECT
        MONTH(fecha_venta)                   AS mes,
        SUM(cantidad * precio_unitario)      AS total_facturado
    FROM ventas
    GROUP BY MONTH(fecha_venta)
)
SELECT
    mes,
    total_facturado,
    CASE
        WHEN total_facturado > (SELECT AVG(total_facturado) FROM mensual)
            THEN 'Por encima'
        WHEN total_facturado < (SELECT AVG(total_facturado) FROM mensual)
            THEN 'Por debajo'
        ELSE 'En el promedio'
    END                                      AS posicion_vs_promedio
FROM mensual
ORDER BY mes;

-- HALLAZGOS
-- 1. El producto 1 concentra la mayor parte de la facturación: $3.600 de
--    $6.444 (55,9%). Junto con el producto 3 suma el 76,8% del total.
-- 2. Los 5 clientes de la base son recurrentes (2 pedidos cada uno). El
--    cliente 1 es el que más gasta: $2.640, el 41% de la facturación.
-- 3. Todas las ventas son de marzo de 2024 (10 pedidos, $6.444, ticket
--    promedio de $644,40), por lo que no se pueden comparar meses entre sí:
--    la Consulta 4 marca ese único mes como "En el promedio".
