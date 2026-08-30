# 📊 Módulo 8 — Modelo de datos y medidas DAX

## Pre-entrega: Modelo de datos con relaciones activas y tabla de medidas Core en DAX

Este módulo corresponde al **Checkpoint 2** del proyecto RetailPro.

El objetivo es transformar el modelo preparado durante el pipeline ETL en un **modelo analítico funcional**, incorporando relaciones entre tablas, una dimensión calendario y un conjunto de medidas DAX reutilizables para el análisis de ventas.

---

## 📁 Entregable

**Archivo Power BI:**

`Gomez_Matias_Checkpoint2.pbix`

El archivo contiene el modelo de datos, las relaciones, la dimensión calendario, las medidas DAX y la página de validación solicitada en la actividad.

---

## 🏗️ Modelo de datos

Se implementó un modelo con estructura dimensional, utilizando `Fact_Ventas` como tabla de hechos y distintas dimensiones para analizar las transacciones.

### Tablas principales

| Tabla             | Tipo      | Función                            |
| ----------------- | --------- | ---------------------------------- |
| `Fact_Ventas`     | Hechos    | Registra las ventas y sus métricas |
| `Dim_Clientes`    | Dimensión | Información de clientes            |
| `Dim_Productos`   | Dimensión | Información de productos           |
| `Dim_Categorias`  | Dimensión | Clasificación de productos         |
| `Dim_Fechas`      | Dimensión | Análisis temporal                  |
| `Dim_Territorios` | Dimensión | Información territorial            |

---

## 🔗 Relaciones

Las relaciones principales del modelo fueron configuradas con cardinalidad **1:N**, dirección de filtro **única** y relaciones **activas**.

```text
Dim_Categorias
      │
      │ 1:N
      ▼
Dim_Productos
      │
      │ 1:N
      ▼
Fact_Ventas
 ▲         ▲
 │         │
1:N       1:N
 │         │
 │         │
Dim_Clientes   Dim_Fechas
```

### Relaciones implementadas

* `Dim_Clientes[id_cliente]` → `Fact_Ventas[id_cliente]`
* `Dim_Productos[id_producto]` → `Fact_Ventas[id_producto]`
* `Dim_Categorias[id_categoria]` → `Dim_Productos[id_categoria]`
* `Dim_Fechas[Date]` → `Fact_Ventas[fecha_venta]`

Todas las relaciones se mantienen con filtro unidireccional desde las dimensiones hacia las tablas relacionadas.

---

## 📅 Dimensión calendario

Se creó `Dim_Fechas` mediante DAX utilizando el rango de fechas disponible en `Fact_Ventas`.

```DAX
Dim_Fechas =
CALENDAR(
    MIN(Fact_Ventas[fecha_venta]),
    MAX(Fact_Ventas[fecha_venta])
)
```

La dimensión contiene las siguientes columnas:

* `Date`
* `Año`
* `Mes Número`
* `Mes Nombre`
* `Trimestre`
* `Semana`

Además:

* `Mes Nombre` se ordena mediante `Mes Número`.
* `Dim_Fechas` fue marcada como tabla de fechas utilizando `Date`.
* La dimensión está relacionada con `Fact_Ventas` mediante la fecha de venta.

Esto permite utilizar correctamente las funciones de inteligencia temporal de DAX.

---

## 📐 Tabla de medidas

Se creó la tabla `_Medidas` como contenedor exclusivo para las medidas DAX del modelo.

La tabla contiene:

```text
_Medidas
├── Total Ventas
├── Ventas Online
├── Ventas YTD
├── Ventas LY
└── % Crecimiento Anual
```

La centralización de las medidas permite mantener una estructura organizada y facilita su reutilización en los diferentes reportes del proyecto.

---

## 🧮 Medidas DAX

### Total Ventas

Calcula el importe total de ventas.

```DAX
Total Ventas =
SUM(Fact_Ventas[total_venta])
```

### Ventas Online

Utiliza `CALCULATE` para filtrar las ventas realizadas mediante el canal Online.

```DAX
Ventas Online =
CALCULATE(
    [Total Ventas],
    Fact_Ventas[canal] = "Online"
)
```

### Ventas YTD

Calcula las ventas acumuladas desde el comienzo del año hasta el período seleccionado.

```DAX
Ventas YTD =
TOTALYTD(
    [Total Ventas],
    Dim_Fechas[Date]
)
```

### Ventas LY

Obtiene las ventas correspondientes al mismo período del año anterior.

```DAX
Ventas LY =
CALCULATE(
    [Total Ventas],
    SAMEPERIODLASTYEAR(Dim_Fechas[Date])
)
```

### % Crecimiento Anual

Calcula la variación porcentual entre las ventas actuales y las ventas del período comparable del año anterior.

Se utilizan `VAR` para almacenar los resultados intermedios y `DIVIDE` para realizar la división de forma segura.

```DAX
% Crecimiento Anual =
VAR VentasActual = [Total Ventas]
VAR VentasAnterior = [Ventas LY]
RETURN
    DIVIDE(
        VentasActual - VentasAnterior,
        VentasAnterior
    )
```

La medida está configurada con formato de porcentaje.

---

## 🔎 Validación

Se creó una página denominada **`Validacion`** para comprobar el funcionamiento del modelo y de las medidas.

La matriz utiliza:

### Filas

`Dim_Fechas[Mes Nombre]`

### Columnas

`Dim_Fechas[Año]`

### Valores

* `Total Ventas`
* `Ventas YTD`
* `Ventas LY`
* `% Crecimiento Anual`

---

## ✅ Controles realizados

La validación permite comprobar:

* Que `Ventas YTD` acumule progresivamente las ventas dentro de cada año.
* Que el valor de enero de `Ventas YTD` coincida con `Total Ventas` de enero.
* Que `Ventas LY` muestre el período equivalente del año anterior.
* Que no existan valores de año anterior cuando no hay un período comparable disponible.
* Que `% Crecimiento Anual` calcule correctamente la variación entre períodos.

### Resultado validado

Se verificó que `Ventas YTD` acumula las ventas progresivamente dentro de cada año. Por ejemplo, el valor correspondiente a febrero incorpora las ventas de enero y febrero, confirmando el correcto funcionamiento de la relación entre `Dim_Fechas` y `Fact_Ventas` y de la medida de inteligencia temporal.

---

## 🛠️ Herramientas utilizadas

* **Microsoft Power BI**
* **DAX**
* **Power Query**
* **SQL Server**
* **GitHub**

---

## 🎯 Objetivo del checkpoint

Este modelo constituye la base analítica para las siguientes etapas del proyecto integrador de RetailPro.

A partir de las relaciones, la dimensión calendario y las medidas desarrolladas será posible construir indicadores, visualizaciones y análisis orientados a responder preguntas de negocio en los módulos posteriores.

---

## 👤 Autor

**Matias Gomez Galeano**

**Curso:** Data Analytics — Coderhouse
