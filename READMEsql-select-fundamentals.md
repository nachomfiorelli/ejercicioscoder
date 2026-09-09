sql-select-fundamentals

Consultas SQL básicas sobre la tabla sales de TechStore, escritas para el equipo de finanzas.

¿Por qué es mala práctica usar SELECT * en producción?
Rendimiento: SELECT * trae todas las columnas de la tabla, incluso las que la consulta no necesita. Con tablas grandes o con columnas pesadas (texto largo, JSON, blobs), esto significa transferir y procesar mucha más información de la necesaria, lo que hace la consulta más lenta y consume más memoria y ancho de banda — tanto en la base de datos como en la aplicación que la consume.
Mantenibilidad: si alguien agrega, elimina o renombra una columna en la tabla sales, cualquier reporte o aplicación que use SELECT * cambia su comportamiento sin aviso. Un reporte que "misteriosamente" trae una columna nueva, o una aplicación que se rompe porque esperaba una columna que ya no existe, son errores silenciosos y difíciles de rastrear. Declarar explícitamente las columnas que se necesitan (como en la Consulta 2) hace que el código sea predecible y fácil de mantener.
Seguridad (bonus): SELECT * puede exponer columnas sensibles (por ejemplo, datos de contacto o precios de costo) a consumidores del reporte que no deberían verlas, simplemente porque se agregaron a la tabla más adelante y nadie las excluyó explícitamente.
¿Por qué son importantes los alias para un stakeholder no técnico?

Los nombres de columnas en una base de datos están pensados para quien la diseña, no para quien consume el reporte. total_amount es un nombre técnico en inglés que asume que quien lo lee sabe que se refiere al monto total de una venta. Una persona del equipo de finanzas que abre ese reporte no tiene por qué saber inglés técnico ni el diccionario de datos del sistema.

Con un alias, SELECT total_amount AS monto_total FROM sales devuelve una columna llamada monto_total: cualquier persona de finanzas entiende inmediatamente qué representa esa cifra sin necesitar contexto adicional ni preguntarle al equipo de datos. Es la diferencia entre entregar un dato y entregar información lista para usar. En la Consulta 3 del archivo consultas_basicas.sql aplicamos el mismo criterio con order_date AS fecha_pedido, product_name AS nombre_producto y quantity AS cantidad_unidades.
