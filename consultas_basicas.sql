-- ══════════════════════════════════════════
-- TechStore — Consultas Básicas SELECT
-- Autor: Ignacio Martínez
-- Fecha: 09/09/2026
-- ══════════════════════════════════════════

-- Consulta 1: Exploración general de la tabla sales
-- SELECT * es útil en esta etapa exploratoria, cuando todavía no conocés
-- la estructura completa de la tabla y necesitás ver todas las columnas
-- disponibles para decidir cuáles te sirven. No debería usarse en
-- producción (dashboards, reportes automáticos, aplicaciones) porque
-- trae columnas de más, es más lento y se rompe silenciosamente si la
-- tabla cambia de estructura (ver README.md para el detalle).
SELECT *
FROM sales;


-- Consulta 2: Selección de columnas específicas para finanzas
-- Finanzas solo necesita saber quién compró, qué producto y cuánto gastó.
SELECT
    customer_id,
    product_id,
    total_amount
FROM sales;


-- Consulta 3: Selección con alias en español para stakeholders
-- Renombramos las columnas técnicas en inglés a nombres en español que
-- cualquier persona del equipo de finanzas puede leer sin explicación.
SELECT
    order_date AS fecha_pedido,
    product_name AS nombre_producto,
    quantity AS cantidad_unidades
FROM sales;
