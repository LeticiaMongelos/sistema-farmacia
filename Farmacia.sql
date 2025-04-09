
-- Creación de la base de datos farmacia
CREATE DATABASE farmacia;

-- Usar la base de datos farmacia
USE farmacia;
CREATE TABLE modulo (
    id_modulo INT IDENTITY(1,1) NOT NULL,
    mod_url NVARCHAR(MAX) NOT NULL,
    mod_titulo VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_modulo)
);

CREATE TABLE role (
    id_role INT IDENTITY(1,1) NOT NULL,
    rol_descripcion VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_role)
);

CREATE TABLE permiso (
    id_modulo INT NOT NULL,
    id_role INT NOT NULL,
    PRIMARY KEY (id_modulo, id_role),
    FOREIGN KEY (id_modulo) REFERENCES modulo (id_modulo),
    FOREIGN KEY (id_role) REFERENCES role (id_role)
);

CREATE TABLE producto (
    id_producto INT IDENTITY(1,1) NOT NULL,
    pro_descripcion VARCHAR(50) NOT NULL,
    pro_cantidad INT NOT NULL,
    pro_precio INT NOT NULL,
    PRIMARY KEY (id_producto)
);

CREATE TABLE empleado (
    id_empleado INT IDENTITY(1,1) NOT NULL,
    emp_cedula VARCHAR(50) NOT NULL,
    emp_nombre VARCHAR(100) NOT NULL,
    emp_celular VARCHAR(50) NOT NULL,
    emp_usuario VARCHAR(50) NOT NULL,
    emp_clave VARCHAR(50) NOT NULL,
    emp_estado VARCHAR(20) NOT NULL,
    id_role INT NOT NULL,
    PRIMARY KEY (id_empleado),
    FOREIGN KEY (id_role) REFERENCES role (id_role),
    CHECK (emp_estado IN ('Activo', 'Vacaciones', 'Inactivo'))
);

CREATE TABLE horario (
    id_horario INT IDENTITY(1,1) NOT NULL,
    id_empleado INT NOT NULL,
    hor_dia VARCHAR(20) NOT NULL,
    hor_inicio TIME NOT NULL,
    hor_fin TIME NOT NULL,
    PRIMARY KEY (id_horario),
    FOREIGN KEY (id_empleado) REFERENCES empleado (id_empleado),
    CHECK (hor_dia IN ('Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado', 'Domingo'))
);

CREATE TABLE compra (
    id_compra INT IDENTITY(1,1) NOT NULL,
    id_empleado INT NOT NULL,
    com_factura VARCHAR(50) NOT NULL,
    com_fecha DATETIME NOT NULL,
    com_total INT NOT NULL,
    PRIMARY KEY (id_compra),
    FOREIGN KEY (id_empleado) REFERENCES empleado (id_empleado)
);

CREATE TABLE compradetalle (
    id_compradetalle INT IDENTITY(1,1) NOT NULL,
    id_compra INT NOT NULL,
    id_producto INT NOT NULL,
    comdet_cantidad INT NOT NULL,
    comdet_subtotal INT NOT NULL,
    comdet_vencimiento VARCHAR(50) NOT NULL, -- Varchar porque los medicamentos no dan dia para el vencimiento, asi que quedaria 12-2025 en lugar de 29-12-2025
    PRIMARY KEY (id_compradetalle),
    FOREIGN KEY (id_compra) REFERENCES compra (id_compra),
    FOREIGN KEY (id_producto) REFERENCES producto (id_producto)
);

CREATE TABLE cliente (
    id_cliente INT IDENTITY(1,1) NOT NULL,
    cli_cedula VARCHAR(50) NOT NULL,
    cli_nombre VARCHAR(100) NOT NULL,
    cli_nacimiento DATE NOT NULL,
    cli_celular VARCHAR(50) NOT NULL,
    cli_correo VARCHAR(50) NOT NULL,
    cli_direccion VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_cliente)
);

CREATE TABLE cita (
    id_cita INT IDENTITY(1,1) NOT NULL,
    id_cliente INT NOT NULL,
    id_empleado INT NOT NULL,
    cit_fecha TIME NOT NULL,
    cit_estado VARCHAR(20) DEFAULT 'Pendiente',
    cit_pago INT NOT NULL,
    cit_nota NVARCHAR(MAX),
    PRIMARY KEY (id_cita),
    FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente),
    FOREIGN KEY (id_empleado) REFERENCES empleado (id_empleado),
    CHECK (cit_estado IN ('Pendiente', 'Confirmada', 'Cancelada', 'Completada'))
);

CREATE TABLE venta (
    id_venta INT IDENTITY(1,1) NOT NULL,
    id_cliente INT NOT NULL,
    id_empleado INT NOT NULL,
    ven_fecha DATETIME NOT NULL,
    ven_total INT NOT NULL,
    ven_factura VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_venta),
    FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente),
    FOREIGN KEY (id_empleado) REFERENCES empleado (id_empleado)
);

CREATE TABLE ventadetalle (
    id_ventadetalle INT IDENTITY(1,1) NOT NULL,
    id_venta INT NOT NULL,
    id_producto INT NOT NULL,
    vendet_cantidad INT NOT NULL,
    vendet_subtotal INT NOT NULL,
    PRIMARY KEY (id_ventadetalle),
    FOREIGN KEY (id_venta) REFERENCES venta (id_venta),
    FOREIGN KEY (id_producto) REFERENCES producto (id_producto)
);

