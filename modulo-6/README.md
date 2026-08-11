# Módulo 6 - Checkpoint: Pipeline ETL desde SQL con Power Query y M

## Descripción

En este checkpoint se construyó un pipeline ETL utilizando Power BI, Power Query y lenguaje M a partir del dataset de TechStore.

El objetivo fue importar, limpiar, transformar y documentar los datos antes de utilizarlos en el modelo analítico.

El proceso se realizó sobre cinco tablas:

- `Dim_Clientes`
- `Dim_Territorios`
- `Dim_Productos`
- `Dim_Categorias`
- `Fact_Ventas`

El archivo final de Power BI contiene las transformaciones realizadas en Power Query y el modelo de datos preparado para continuar con las siguientes etapas del proyecto.

---

## Fuente de datos

La fuente utilizada fue el archivo `Pipeline_ETL_Dataset.xlsx`.

El dataset contiene información de:

- Clientes
- Territorios
- Productos
- Categorías
- Ventas

La conexión se realizó desde Power BI Desktop mediante:

**Inicio → Obtener datos → Excel**

Luego se seleccionaron las tablas y se ingresó a **Transformar datos** para realizar el proceso ETL mediante Power Query.

---

## Tablas del modelo

### Dim_Clientes

Se realizaron las siguientes transformaciones:

- Eliminación de registros completamente vacíos.
- Promoción de la primera fila como encabezados.
- Corrección de tipos de datos.
- Eliminación del registro duplicado utilizando `id_cliente` como clave.
- Reemplazo de valores nulos en `email` por `"Sin email"`.
- Reemplazo de valores nulos en `ciudad` por `"Sin datos"`.
- Merge con `Dim_Territorios` utilizando `ciudad` y `pais`.
- Incorporación de `id_territorio` y `region`.

**Resultado final: 11 registros.**

#### Tratamiento de valores nulos

Los valores nulos de `email` fueron reemplazados por `"Sin email"` para conservar los registros y diferenciar la ausencia de información de un error.

Los valores nulos de `ciudad` fueron reemplazados por `"Sin datos"`. El cliente se conserva porque su `id_cliente` y el resto de sus atributos continúan siendo válidos.

Cuando un cliente no posee una ciudad válida, no se asigna artificialmente un territorio o región. Por este motivo, algunos registros pueden conservar valores nulos en los atributos territoriales.

---

### Dim_Territorios

La tabla contiene la información territorial utilizada para enriquecer los datos de clientes.

Transformaciones realizadas:

- Eliminación de registros completamente vacíos.
- Corrección de tipos de datos.
- Control de registros duplicados mediante `id_territorio`.
- Preparación de los campos utilizados para realizar el Merge con `Dim_Clientes`.

Campos principales:

- `id_territorio`
- `ciudad`
- `pais`
- `region`

---

### Dim_Productos

La tabla contiene la información de los productos comercializados por TechStore.

Transformaciones realizadas:

- Eliminación de registros completamente vacíos.
- Corrección de tipos de datos.
- Eliminación del producto duplicado utilizando `id_producto`.
- Resolución del valor nulo de `precio`.
- Reemplazo del valor nulo de `categoria` por `"Sin Categoría"`.

**Resultado final: 12 registros.**

#### Tratamiento de valores nulos

El valor nulo de `precio` fue resuelto porque este atributo es necesario para realizar análisis monetarios y de ingresos.

El valor nulo de `categoria` fue reemplazado por `"Sin Categoría"` para conservar el producto sin asignarlo arbitrariamente a una categoría existente.

---

### Dim_Categorias

La tabla contiene las categorías de productos utilizadas por TechStore.

Transformaciones realizadas:

- Eliminación de registros completamente vacíos.
- Corrección de tipos de datos.
- Control de registros duplicados mediante `id_categoria`.

**Resultado final: 4 registros.**

---

### Fact_Ventas

La tabla contiene las transacciones realizadas por TechStore.

Transformaciones realizadas:

- Eliminación de registros completamente vacíos.
- Promoción de encabezados.
- Corrección de tipos de datos.
- Conservación de las 50 transacciones originales.
- Merge con `Dim_Productos` utilizando `id_producto`.
- Incorporación de `nombre_producto` y `categoria`.

**Resultado final: 50 registros.**

Se utilizó un `Left Outer Join` para garantizar que todas las ventas originales fueran conservadas, incluso cuando una venta no encontrara correspondencia en la dimensión de productos.

---

## Eliminación de registros en blanco

Todas las consultas incluyen un paso específico para eliminar registros completamente vacíos antes de realizar las transformaciones principales.

La lógica utilizada en lenguaje M consiste en conservar únicamente las filas que contienen al menos un valor no nulo.

Esto permite evitar que filas completamente vacías provenientes de la fuente ingresen al modelo.

---

## Tipos de datos

Se verificaron y corrigieron los tipos de datos de las columnas.

| Tipo de información | Tipo aplicado |
|---|---|
| Identificadores | `Whole Number` |
| Fechas | `Date` |
| Importes y valores monetarios | `Decimal Number` |
| Cantidades y stock | `Whole Number` |
| Campos descriptivos | `Text` |

El tipado correcto permite realizar posteriormente análisis temporales, cálculos numéricos y relaciones entre las tablas.

---

## Merge realizados

### Dim_Clientes + Dim_Territorios

Se realizó un Merge entre `Dim_Clientes` y `Dim_Territorios`.

**Claves utilizadas:**

- `ciudad`
- `pais`

**Columnas incorporadas:**

- `id_territorio`
- `region`

Se utilizó `Left Outer Join` para conservar todos los registros de clientes.

---

### Fact_Ventas + Dim_Productos

Se realizó un Merge entre `Fact_Ventas` y `Dim_Productos`.

**Clave utilizada:**

- `id_producto`

**Columnas incorporadas:**

- `nombre_producto`
- `categoria`

Se utilizó `Left Outer Join` para conservar las 50 transacciones originales.

---

## Documentación en lenguaje M

Las transformaciones fueron documentadas directamente desde el **Editor Avanzado de Power Query**.

Se utilizaron comentarios técnicos mediante `//` para explicar las principales decisiones de transformación.

Entre los aspectos documentados se encuentran:

- Eliminación de registros vacíos.
- Corrección de tipos.
- Eliminación de duplicados.
- Tratamiento de valores nulos.
- Merge entre tablas.
- Justificación de las transformaciones realizadas.

---

## Modelo de datos

Después de cargar las consultas en Power BI se establecieron relaciones de tipo **1:N**.

### Territorios → Clientes

`Dim_Territorios[id_territorio]` → `Dim_Clientes[Dim_Territorios.id_territorio]`

### Clientes → Ventas

`Dim_Clientes[id_cliente]` → `Fact_Ventas[id_cliente]`

### Productos → Ventas

`Dim_Productos[id_producto]` → `Fact_Ventas[id_producto]`

Las relaciones utilizan cardinalidad **Uno a varios (1:*)** y dirección de filtro única.

`Dim_Categorias` queda como tabla de referencia independiente porque `Dim_Productos` no posee actualmente `id_categoria` como clave relacionada.

---

## Control final de registros

| Tabla | Registros finales |
|---|---:|
| `Dim_Clientes` | 11 |
| `Dim_Territorios` | Según fuente |
| `Dim_Productos` | 12 |
| `Dim_Categorias` | 4 |
| `Fact_Ventas` | 50 |

Todas las consultas fueron cargadas correctamente y sin errores.

---

## Evidencias

Las capturas del proceso se encuentran dentro de la carpeta `capturas/`.

Se incluyen evidencias de:

1. Conexión a la fuente.
2. Perfilado y calidad de datos.
3. Transformaciones realizadas.
4. Editor Avanzado y documentación en lenguaje M.
5. Merge entre las tablas.
6. Modelo final y relaciones.

---

## Archivo entregable

El archivo principal del checkpoint es:

`Pipeline_ETL_Gomez_Matias.pbix`

El archivo contiene el pipeline ETL construido en Power Query y el modelo de datos resultante.

---

## Resultado

El pipeline ETL permite disponer de datos limpios, tipados, transformados y documentados, dejando una base confiable para continuar con la construcción del modelo analítico y las medidas DAX en las siguientes etapas del proyecto.
