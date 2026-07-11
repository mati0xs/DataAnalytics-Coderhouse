-- ==========================================
-- Módulo 2 - Unidad 1
-- Diseño de tablas
-- ==========================================
CREATE DATABASE Practica;
USE Practica;

-- Tabla de clientes
CREATE TABLE clientes (

    -- Identificador único del cliente.
    -- Se utiliza INT porque almacena números enteros y es una clave primaria con identificador unico.
    id_cliente INT NOT NULL IDENTITY (1,1) PRIMARY KEY,

    -- Nombre del cliente.
    -- VARCHAR(100) permite almacenar texto de longitud variable hasta un máximo de 100 caracteres.
    nombre VARCHAR(100) NOT NULL,

    -- Biografía o notas del cliente.
    -- TEXT se utiliza para almacenar textos largos sin un límite pequeño de caracteres.
    perfil_bio TEXT NOT NULL,

    -- Fecha de registro del cliente.
    -- DATE almacena únicamente la fecha (sin hora).
    fecha_registro DATE NOT NULL

);

-- Tabla de productos
CREATE TABLE productos (

    -- Identificador único del producto.
    id_producto INT NOT NULL IDENTITY (1,1) PRIMARY KEY,

    -- Descripción del producto.
    -- VARCHAR(255) permite almacenar descripciones relativamente largas.
    descripcion VARCHAR(255) NOT NULL,

    -- Precio del producto.
    -- DECIMAL(10,2) es el tipo recomendado para dinero, ya que evita errores de precisión que puede generar FLOAT.
    precio DECIMAL(10,2) NOT NULL,

    -- Indica si el producto está activo.
    -- BIT almacena TRUE o FALSE y es la opción más apropiada
    esta_activo BIT

);
