# RetailPro - Data Analytics

## Descripción

Este repositorio contiene el desarrollo del proyecto integrador de **Data Analytics de Coderhouse**, basado en el caso práctico de una empresa ficticia de retail tecnológico llamada **TechStore**.

El proyecto aborda distintas etapas del proceso de análisis de datos, desde el diseño y creación de una base de datos SQL hasta la limpieza, transformación y modelado de los datos en Power BI.

---

## Objetivo

Construir una solución de análisis de datos que permita transformar datos operativos en información útil para la toma de decisiones.

El proyecto incluye:

- Diseño de bases de datos.
- Creación y carga de tablas mediante SQL.
- Consultas SQL de negocio.
- Limpieza y transformación de datos.
- Procesos ETL mediante Power Query.
- Modelado de datos en Power BI.
- Desarrollo de métricas y visualizaciones.
- Documentación técnica del proceso.

---

## Tecnologías utilizadas

- SQL Server
- SQL
- Power BI Desktop
- Power Query
- Lenguaje M
- DAX
- Excel
- GitHub

---

## Estructura del repositorio

RetailPro/

├── modulo-1/

├── modulo-2/

├── modulo-3/

│   ├── ddl_dml_bodega.sql

│   ├── modulo3_unidad2_diseno.sql

│   └── README.md

├── modulo-4/

│   ├── m4_consultas_negocio.sql

│   └── README.md

├── modulo-5/

│   ├── ...

│   └── README.md

├── modulo-6/

│   ├── Pipeline_ETL_Gomez_Matias.pbix

│   ├── README.md

│   └── capturas/

└── README.md

---

# Módulos realizados

## Módulo 3 - Diseño y construcción de la base de datos

En este módulo se trabajó sobre el diseño y creación de la base de datos `Ventas_Tech_DB`.

Se desarrollaron:

- Tablas.
- Claves primarias.
- Claves foráneas.
- Restricciones.
- Inserción de datos.
- Diseño de la estructura relacional.

También se realizaron ejercicios de DDL, DML y diseño de tablas.

**Resultado:** base de datos `Ventas_Tech_DB` creada y cargada correctamente.

---

## Módulo 4 - Consultas SQL de negocio

En este módulo se desarrollaron consultas SQL para obtener métricas relevantes del negocio a partir de `Ventas_Tech_DB`.

Se trabajó con:

- `SELECT`
- `JOIN`
- `GROUP BY`
- Funciones de agregación.
- Métricas de ventas.
- Facturación.
- Análisis de clientes.
- Comparaciones de resultados.

El objetivo fue utilizar SQL para extraer información útil para el análisis comercial.

---

## Módulo 5 - Combinación y limpieza de datos con SQL

En este módulo se trabajó con consultas más avanzadas para combinar información y detectar registros faltantes.

Se aplicaron:

- `INNER JOIN`
- `LEFT JOIN`
- `UNION ALL`
- `GROUP BY`
- Manejo de valores `NULL`.
- Identificación de clientes y productos sin ventas.

También se documentaron las consultas y decisiones realizadas.

---

## Módulo 6 - Pipeline ETL con Power Query y M

En este checkpoint se construyó un pipeline ETL utilizando Power BI, Power Query y lenguaje M.

Se trabajó con cinco tablas:

- `Dim_Clientes`
- `Dim_Territorios`
- `Dim_Productos`
- `Dim_Categorias`
- `Fact_Ventas`

Las principales transformaciones incluyeron:

- Eliminación de registros completamente vacíos.
- Eliminación de duplicados.
- Tratamiento de valores nulos.
- Corrección de tipos de datos.
- Estandarización de nombres.
- Merge entre clientes y territorios.
- Merge entre ventas y productos.
- Documentación mediante comentarios en lenguaje M.
- Creación de relaciones 1:N en el modelo de Power BI.

El archivo final de Power BI es:

`Pipeline_ETL_Gomez_Matias.pbix`

La documentación específica y las evidencias del checkpoint se encuentran en `modulo-6/README.md`.

---

# Flujo general del proyecto

Datos operativos

↓

Diseño de base de datos

↓

SQL - DDL / DML

↓

Consultas de negocio

↓

Combinación y limpieza de datos

↓

Power Query / Lenguaje M

↓

Modelo de datos en Power BI

↓

Medidas DAX

↓

Dashboard y análisis

Cada módulo agrega una nueva etapa al proceso de construcción de la solución analítica.

---

# Estado del proyecto

| Etapa | Estado |
|---|---|
| Diseño de base de datos | Completado |
| Creación de `Ventas_Tech_DB` | Completado |
| Consultas SQL de negocio | Completado |
| Combinación y limpieza con SQL | Completado |
| Pipeline ETL con Power Query | Completado |
| Modelo base en Power BI | Completado |
| Medidas DAX | Próximamente |
| Dashboard final | Próximamente |

---

# Próximas etapas

El siguiente paso del proyecto será continuar con el modelo analítico en Power BI, incorporando:

- Modelo estrella.
- Tabla calendario.
- Relaciones y dimensiones.
- Medidas DAX.
- Indicadores clave de negocio.
- Visualizaciones.
- Dashboard final.

---

## Autor

**Matias Gomez**

Proyecto realizado como parte de la formación en **Data Analytics - Coderhouse**.
