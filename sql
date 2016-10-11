--Para los niveles de urgencia de una requi
CREATE TABLE nivel_urgencia(
cve_nivel_urgencia INT IDENTITY(1,1) PRIMARY KEY,
nombre VARCHAR(50) NOT NULL,
abreviatura VARCHAR(10) NOT NULL,
activo BIT
)
INSERT INTO nivel_urgencia VALUES('Alto', 'Alt', 'True');
INSERT INTO nivel_urgencia VALUES('Bajo', 'Baj', 'True');
INSERT INTO nivel_urgencia VALUES('Normal', 'Nal', 'True');
INSERT INTO nivel_urgencia VALUES('Urgente', 'Urg', 'True');

--la requisicion
CREATE TABLE requisicion(
cve_requisicion INT IDENTITY(1,1) PRIMARY KEY,
cve_urgencia INT FOREIGN KEY REFERENCES nivel_urgencia(cve_nivel_urgencia),
cve_solicito INT FOREIGN KEY REFERENCES persona(cve_persona),
folio INT NOT NULL, 
fecha_necesita DATE NOT NULL,
fecha_registro DATETIME,
lugar_utilizar VARCHAR(200),
observacion VARCHAR(300),
activo BIT
)
--Cuando hay un archivo en la requi
CREATE TABLE requisicion_cotizacion(
cve_requisicion_cotizacion INT IDENTITY(1,1) PRIMARY KEY,
cve_requisicion INT FOREIGN KEY REFERENCES requisicion(cve_requisicion),
cve_archivo INT FOREIGN KEY REFERENCES archivo(cve_archivo)
)

--Productos que puede comprar
CREATE TABLE tipo_compra(
cve_tipo_compra INT IDENTITY(1,1) PRIMARY KEY,
nombre VARCHAR(150) NOT NULL,
activo BIT
)
INSERT INTO tipo_compra VALUES('Papelería', 'True');
INSERT INTO tipo_compra VALUES('Insumos de laboratorio', 'True');
INSERT INTO tipo_compra VALUES('Insumos de computadora', 'True');
INSERT INTO tipo_compra VALUES('Alimentos', 'True');
INSERT INTO tipo_compra VALUES('Servicio', 'True');
INSERT INTO tipo_compra VALUES('Otro', 'True');

CREATE TABLE concepto_tipo_compra(
cve_concepto_requisicion INT IDENTITY(1,1) PRIMARY KEY,
cve_concepto INT FOREIGN KEY REFERENCES concepto_pago(cve_concepto_pago),
cve_tipo_compra INT FOREIGN KEY REFERENCES tipo_compra(cve_tipo_compra),
pieza BIT
)
--detalles de la requi
CREATE TABLE detalle_requisicion(
cve_detalle_requisicion INT IDENTITY(1,1) PRIMARY KEY,
cve_concepto INT FOREIGN KEY REFERENCES concepto_pago(cve_concepto_pago),
cantidad INT NOT NULL,
precio FLOAT NOT NULL,
activo BIT
)

--cuando la requi es urgente
CREATE TABLE requisicion_urgencia(
cve_requisicion_urgencia INT IDENTITY(1,1) PRIMARY KEY,
cve_requisicion INT FOREIGN KEY REFERENCES requisicion(cve_requisicion),
justificacion TEXT NOT NULL
)

--situacion de la requi
CREATE TABLE requisicion_situacion(
cve_requisicion_situacion INT IDENTITY(1,1) PRIMARY KEY,
cve_requisicion INT FOREIGN KEY REFERENCES requisicion(cve_requisicion),
cve_situacion INT FOREIGN KEY REFERENCES situacion_actividad(cve_situacion_actividad),
fecha DATETIME NOT NULL,
comentario TEXT NULL, --Utilizar cuando se cancele la requi y poder poner una justificación
activo BIT
)
/*INSERT INTO situacion_actividad VALUES('Enviada', 'Primer estatus de la requisición', 'True');
INSERT INTO situacion_actividad VALUES('Atendida', 'La requisición fue abierta o leída', 'True');
INSERT INTO situacion_actividad VALUES('Aceptada', 'La requisición fue aceptada', 'True');
INSERT INTO situacion_actividad VALUES('Rechazada', 'La requisición fue rechazada', 'True');*/

--son las tablas existentes
CREATE TABLE proveedor(
cve_proveedor INT IDENTITY(1,1) PRIMARY KEY,
cve_tipo_cliente INT FOREIGN KEY REFERENCES tipo_cliente(cve_tipo_cliente),
fecha_alta DATETIME NOT NULL,
activo BIT
)
--Si es persona el proveedor
CREATE TABLE proveedor_persona(
cve_proveedor_persona INT IDENTITY(1,1) PRIMARY KEY,
cve_persona INT FOREIGN KEY REFERENCES persona(cve_persona)
)
--Si el proveedor es empresa
CREATE TABLE proveedor_empresa(
cve_proveedor_persona INT IDENTITY(1,1) PRIMARY KEY,
cve_empresa INT FOREIGN KEY REFERENCES empresa(cve_empresa)
)

--requi -> proveedor
CREATE TABLE requisicion_proveedor(
cve_requisicion_proveedor INT IDENTITY(1,1),
cve_requisicion INT FOREIGN KEY REFERENCES requisicion(cve_requisicion),
cve_proveedor INT FOREIGN KEY REFERENCES proveedor(cve_proveedor),
activo BIT
)
--Insertamos en banco
/*INSERT INTO banco VALUES('Grupo Financiero Inbursa', 'INBURSA', GETDATE(), 'True');
INSERT INTO banco VALUES('Banco Santander', 'SANTAND', GETDATE(), 'True');
INSERT INTO banco VALUES('Banco del Ahorro Nacional y Servicios Financieros', 'BANSEFI', GETDATE(), 'True');
INSERT INTO banco VALUES('Grupo Financiero Bancomer', 'BANCOMER', GETDATE(), 'True');
INSERT INTO banco VALUES('Banco de México', 'Banxico', GETDATE(), 'True');
INSERT INTO banco VALUES('Banco Nacional de México', 'BANAMEX', GETDATE(), 'True');
INSERT INTO banco VALUES('Banco Azteca', 'BAAZTEC', GETDATE(), 'True');
INSERT INTO banco VALUES('Grupo Financiero HSBC', 'HSBC', GETDATE(), 'True');*/

--cuenta
CREATE TABLE cuenta(
cve_cuenta INT IDENTITY(1,1) PRIMARY KEY,
cve_banco INT FOREIGN KEY REFERENCES banco(cve_banco),
numero_cuenta VARCHAR(30),
clabe_interbancaria VARCHAR(20),
activo BIT
)

--proveedor_cuenta
CREATE TABLE proveedor_cuenta(
cve_proveedor_cuenta INT IDENTITY(1,1) PRIMARY KEY,
cve_proveedor INT FOREIGN KEY REFERENCES proveedor(cve_proveedor),
cve_cuenta INT FOREIGN KEY REFERENCES cuenta(cve_cuenta)
)

--validacion de usuario
CREATE TABLE super_usuario(
cve_super_clave INT IDENTITY(1,1) PRIMARY KEY,
cve_usuario INT FOREIGN KEY REFERENCES usuario(cve_usuario),
clave VARCHAR(300) NOT NULL,
activo BIT
)
