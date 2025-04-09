
-- Creación de la base de datos farmacia
CREATE DATABASE farmacia;

-- Usar la base de datos farmacia
USE farmacia;


-- Creación de la tabla laboratorio
CREATE TABLE laboratorio (
    id_laboratorio INTEGER PRIMARY KEY,
    lab_descripcion VARCHAR(255),
    lab_telefono VARCHAR(50),
    lab_direccion VARCHAR(255)
);

-- Creación de la tabla producto
CREATE TABLE producto (
    id_producto INTEGER PRIMARY KEY,
    pro_descripcion VARCHAR(255),
    pro_precio INTEGER,
    pro_cantidad INTEGER,
    pro_vencimiento TIMESTAMP,
    id_laboratorio INTEGER,
    FOREIGN KEY (id_laboratorio) REFERENCES laboratorio(id_laboratorio)
);

-- Creación de la tabla role
CREATE TABLE role (
    id_role INTEGER PRIMARY KEY,
    role_descripcion VARCHAR(255)
);

-- Creación de la tabla modulo
CREATE TABLE modulo (
    id_modulo INTEGER PRIMARY KEY,
    mod_descripcion VARCHAR(255)
);

-- Creación de la tabla permiso
CREATE TABLE permiso (
    id_modulo INTEGER,
    id_role INTEGER,
    PRIMARY KEY (id_modulo, id_role),
    FOREIGN KEY (id_modulo) REFERENCES modulo(id_modulo),
    FOREIGN KEY (id_role) REFERENCES role(id_role)
);

-- Creación de la tabla persona
CREATE TABLE persona (
    id_persona INTEGER PRIMARY KEY,
    per_nombre VARCHAR(255),
    per_cedula VARCHAR(20),
    per_correo VARCHAR(100),
    per_nic VARCHAR(50),
    per_telefono VARCHAR(50),
    per_usuario VARCHAR(50),
    per_clave VARCHAR(100),
    id_role INTEGER,
    FOREIGN KEY (id_role) REFERENCES role(id_role)
);

-- Creación de la tabla proveedor
CREATE TABLE proveedor (
    id_proveedor INTEGER PRIMARY KEY,
    pro_descripcion VARCHAR(255)
);

-- Creación de la tabla compra
CREATE TABLE compra (
    id_compra INTEGER PRIMARY KEY,
    com_total INTEGER,
    com_fecha TIME,
    com_factura VARCHAR(50),
    id_persona INTEGER,
    id_proveedor INTEGER,
    FOREIGN KEY (id_persona) REFERENCES persona(id_persona),
    FOREIGN KEY (id_proveedor) REFERENCES proveedor(id_proveedor)
);

-- Creación de la tabla compra_detalle
CREATE TABLE compra_detalle (
    id_compra_detalle INTEGER PRIMARY KEY,
    comdet_cantidad INTEGER,
    comdet_subtotal INTEGER,
    id_producto INTEGER,
    id_compra INTEGER,
    FOREIGN KEY (id_producto) REFERENCES producto(id_producto),
    FOREIGN KEY (id_compra) REFERENCES compra(id_compra)
);

-- Creación de la tabla venta
CREATE TABLE venta (
    id_venta INTEGER PRIMARY KEY,
    ven_total INTEGER,
    ven_fecha TIME,
    ven_factura VARCHAR(50),
    id_persona INTEGER,
    FOREIGN KEY (id_persona) REFERENCES persona(id_persona)
);

-- Creación de la tabla venta_detalle
CREATE TABLE venta_detalle (
    id_venta_detalle INTEGER PRIMARY KEY,
    vendet_cantidad INTEGER,
    vendet_subtotal INTEGER,
    id_producto INTEGER,
    id_venta INTEGER,
    FOREIGN KEY (id_producto) REFERENCES producto(id_producto),
    FOREIGN KEY (id_venta) REFERENCES venta(id_venta)
);