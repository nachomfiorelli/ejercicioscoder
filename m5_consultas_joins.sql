-- =====================================================================
-- M5: Consultas con JOINs para el proyecto
-- Base de datos: Ventas_Tech_DB
-- Esquema (creado en el Checkpoint de M3):
--   categorias(id_categoria, nombre_categoria, descripcion)
--   clientes(id_cliente, nombre, email, ciudad, fecha_registro)
--   productos(id_producto, nombre_producto, id_categoria, precio, stock, activo)
--   ventas(id_venta, id_cliente, id_producto, cantidad, precio_unitario, fecha_venta)
-- =====================================================================


-- ---------------------------------------------------------------------
-- Consulta 1: Vista base del proyecto (INNER JOIN)
-- Cruza ventas con clientes, productos y categorías para obtener,
-- en una sola fila, toda la información necesaria para Power BI.
-- Columna para agrupar: categoria / ciudad. Columna para filtrar: fecha.
-- ---------------------------------------------------------------------
SELECT
    v.fecha_venta AS fecha,
    v.id_cliente,
    c.nombre AS nombre_cliente,
    c.ciudad,
    p.nombre_producto AS descripcion_producto,
    cat.nombre_categoria AS categoria,
    v.cantidad,
    v.precio_unitario,
    (v.cantidad * v.precio_unitario) AS total_venta
FROM ventas v
INNER JOIN clientes c   ON v.id_cliente = c.id_cliente
INNER JOIN productos p  ON v.id_producto = p.id_producto
INNER JOIN categorias cat ON p.id_categoria = cat.id_categoria
ORDER BY v.fecha_venta;


-- ---------------------------------------------------------------------
-- Consulta 2: Clientes sin ventas (LEFT JOIN)
-- Clientes registrados que todavía no realizaron ninguna compra.
-- El LEFT JOIN conserva a todos los clientes; si un cliente no tiene
-- ventas, las columnas de "ventas" quedan en NULL, y por eso filtramos
-- con WHERE v.id_venta IS NULL para quedarnos solo con esos casos.
-- ---------------------------------------------------------------------
SELECT
    c.nombre,
    c.email,
    c.fecha_registro
FROM clientes c
LEFT JOIN ventas v ON c.id_cliente = v.id_cliente
WHERE v.id_venta IS NULL;


-- ---------------------------------------------------------------------
-- Consulta 3: Productos sin ventas (LEFT JOIN)
-- Productos del catálogo que nunca se vendieron.
-- Mismo criterio que la Consulta 2, aplicado sobre productos.
-- ---------------------------------------------------------------------
SELECT
    p.nombre_producto,
    cat.nombre_categoria AS categoria,
    p.precio
FROM productos p
INNER JOIN categorias cat ON p.id_categoria = cat.id_categoria
LEFT JOIN ventas v ON p.id_producto = v.id_producto
WHERE v.id_venta IS NULL;


-- ---------------------------------------------------------------------
-- Consulta 4: Consolidado por canal (UNION ALL)
-- No existe una columna "canal" real en el esquema, así que la creamos
-- como valor literal, separando las ventas por el criterio disponible
-- en nuestro caso: la ciudad del cliente (Buenos Aires = "CABA",
-- cualquier otra ciudad = "Interior"). Usamos UNION ALL (no UNION)
-- para no perder ventas que coincidan exactamente en todos sus valores.
-- ---------------------------------------------------------------------
SELECT
    canal,
    SUM(total) AS total_facturado,
    COUNT(*) AS cantidad_ventas
FROM (
    SELECT
        v.fecha_venta AS fecha,
        (v.cantidad * v.precio_unitario) AS total,
        'CABA' AS canal
    FROM ventas v
    INNER JOIN clientes c ON v.id_cliente = c.id_cliente
    WHERE c.ciudad = 'Buenos Aires'

    UNION ALL

    SELECT
        v.fecha_venta AS fecha,
        (v.cantidad * v.precio_unitario) AS total,
        'Interior' AS canal
    FROM ventas v
    INNER JOIN clientes c ON v.id_cliente = c.id_cliente
    WHERE c.ciudad <> 'Buenos Aires'
) AS ventas_por_canal
GROUP BY canal
ORDER BY total_facturado DESC;
