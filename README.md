# RetailPro: análisis de ventas con SQL y Power BI

Proyecto del curso de análisis de datos. RetailPro es una distribuidora de tecnología. El objetivo del proyecto es responder preguntas de negocio sobre ventas, clientes y productos, desde la base de datos hasta el dashboard ejecutivo.

## Herramientas

- **SQL Server** y **SQL Server Management Studio (SSMS)**: base de datos y consultas.
- **Power BI**: modelo de datos, medidas DAX y dashboard. Los archivos `.pbix` no están en este repositorio.
- **GitHub**: control de versiones y entrega de los scripts.

## Base de datos `Ventas_Tech_DB`

| Tabla | Columnas |
|---|---|
| `categorias` | `id_categoria`, `nombre_categoria`, `descripcion` |
| `clientes` | `id_cliente`, `nombre`, `email`, `ciudad`, `fecha_registro` |
| `productos` | `id_producto`, `nombre_producto`, `id_categoria`, `precio`, `stock`, `activo` |
| `ventas` | `id_venta`, `id_cliente`, `id_producto`, `cantidad`, `precio_unitario`, `fecha_venta` |

## Estructura del repositorio

```
.
├── README.md
├── ventas_tech_db.sql           # Crea el esquema y carga los datos de ejemplo
├── consultas_basicas.sql        # Ejercicio previo (tabla sales de TechStore), fuera del flujo RetailPro
└── RetailPro/
    ├── m4_consultas_negocio.sql # Consultas de agregación y hallazgos
    └── m5_consultas_joins.sql   # Consultas con JOIN
```

## Cómo ejecutar los scripts

1. Abrí SSMS y conectate a tu instancia de SQL Server.
2. Creá la base ejecutando `CREATE DATABASE Ventas_Tech_DB;`. El script no la crea: esa línea está comentada.
3. Elegí `Ventas_Tech_DB` en el desplegable de bases de datos y ejecutá `ventas_tech_db.sql`. El script borra las tablas con esos nombres y las vuelve a crear con los datos de ejemplo, así que no hay que ejecutarlo en otra base.
4. Abrí `RetailPro/m4_consultas_negocio.sql` y `RetailPro/m5_consultas_joins.sql`. Seleccioná **una consulta por vez** y presioná **F5**. Si ejecutás el archivo completo, los resultados de todas las consultas aparecen juntos.

> Los scripts usan sintaxis de SQL Server. Para otro motor, por ejemplo PostgreSQL, hay que adaptar `MONTH(fecha_venta)` a `EXTRACT(MONTH FROM fecha_venta)` y `TOP 5` a `LIMIT 5`.

## Qué contiene cada script

| Script | Contenido |
|---|---|
| `m4_consultas_negocio.sql` | Resumen ejecutivo mensual, top 5 de productos por facturación, clientes recurrentes y clasificación de meses contra el promedio, más 3 hallazgos de negocio. |
| `m5_consultas_joins.sql` | Vista base con `INNER JOIN` de 4 tablas, clientes sin ventas, productos sin ventas y consolidado por zona (CABA / Interior) con `UNION ALL`. |

## Limitaciones de los datos

Los datos de ejemplo de `ventas` corresponden a un único mes (marzo de 2024). Por eso las consultas de comparación entre meses, como la clasificación contra el promedio mensual, no permiten distinguir meses mejores o peores.

## Autor

Ignacio Martínez
