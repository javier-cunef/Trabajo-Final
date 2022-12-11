REM   Script: MODELO FISICO DE DATOS 2
REM   HEHEHEHE
DJPFNÒFENFÒ

CREATE TABLE suministrador 
( 
  nombre VARCHAR(20) NOT NULL, 
  país VARCHAR(20) NOT NULL, 
  PRIMARY KEY (nombre) 
);

CREATE TABLE Empresa_transporte 
( 
  NIF VARCHAR(20) NOT NULL, 
  Nombre VARCHAR(20) NOT NULL, 
  Codigo_Autorización_ VARCHAR(10) NOT NULL, 
  Fecha_Validez DATE NOT NULL, 
  Correo_emergencias VARCHAR(25) NOT NULL, 
  telefono VARCHAR(15) NOT NULL, 
  PRIMARY KEY (NIF) 
);

CREATE TABLE productores 
( 
  Codigo_Autorización VARCHAR(15) NOT NULL, 
  Denominación VARCHAR(20) NOT NULL, 
  Dirección_ VARCHAR(30) NOT NULL, 
  Teléfono VARCHAR(15) NOT NULL, 
  Fecha_Validez DATE NOT NULL, 
  Fecha_Fin_Validez DATE NOT NULL, 
  Tipo_Compañia VARCHAR(25) NOT NULL, 
  Correo_e VARCHAR(30) NOT NULL, 
  PRIMARY KEY (Codigo_Autorización) 
);

CREATE TABLE estaciones_primarias 
( 
  nombre VARCHAR(20) NOT NULL, 
  Codigo_Autorización VARCHAR(10) NOT NULL, 
  PRIMARY KEY (nombre), 
  FOREIGN KEY (Codigo_Autorización) REFERENCES productores(Codigo_Autorización) 
);

CREATE TABLE red_distribucion 
( 
  NºRed INT NOT NULL, 
  nombre VARCHAR(20) NOT NULL, 
  PRIMARY KEY (NºRed), 
  FOREIGN KEY (nombre) REFERENCES estaciones_primarias(nombre) 
);

CREATE TABLE líneas 
( 
  Longitud INT NOT NULL, 
  Nº_Secuencial INT NOT NULL, 
  NºRed INT NOT NULL, 
  PRIMARY KEY (Nº_Secuencial), 
  FOREIGN KEY (NºRed) REFERENCES red_distribucion(NºRed) 
);

CREATE TABLE Subestación 
( 
  ID_subestacion VARCHAR(10) NOT NULL, 
  Nº_Secuencial INT NOT NULL, 
  PRIMARY KEY (ID_subestacion), 
  FOREIGN KEY (Nº_Secuencial) REFERENCES líneas(Nº_Secuencial) 
);

CREATE TABLE provincias 
( 
  Código_Provincia INT NOT NULL, 
  nombre VARCHAR(20) NOT NULL, 
  PRIMARY KEY (Código_Provincia) 
);

CREATE TABLE responsable 
( 
  DNI VARCHAR(9) NOT NULL, 
  Nombre VARCHAR(25) NOT NULL, 
  Correo VARCHAR(30) NOT NULL, 
  Correo_Urgencias VARCHAR(30) NOT NULL, 
  Ubi_Oficina VARCHAR(20) NOT NULL, 
  Antigüedad VARCHAR(10) NOT NULL, 
  Teléfono_Urgencias VARCHAR(12) NOT NULL, 
  Teléfono VARCHAR(12) NOT NULL, 
  Fecha_Nombramiento DATE NOT NULL, 
  PRIMARY KEY (DNI) 
);

CREATE TABLE suministro 
( 
  Codigo_suministro VARCHAR(15) NOT NULL, 
  nombre VARCHAR(20) NOT NULL, 
  NIF VARCHAR(10) NOT NULL, 
  PRIMARY KEY (Codigo_suministro), 
  FOREIGN KEY (nombre) REFERENCES suministrador(nombre), 
  FOREIGN KEY (NIF) REFERENCES Empresa_transporte(NIF) 
);

CREATE TABLE central 
( 
  Latitud VARCHAR(20) NOT NULL, 
  Longitud VARCHAR(20) NOT NULL, 
  denominación VARCHAR(15) NOT NULL, 
  producción_anual FLOAT NOT NULL, 
  producción_mensual FLOAT NOT NULL, 
  producción_diaria FLOAT NOT NULL, 
  ID_central VARCHAR(10) NOT NULL, 
  whatsapp VARCHAR(20) NOT NULL, 
  twitter INT NOT NULL, 
  correo_electronico INT NOT NULL, 
  direccion_postal INT NOT NULL, 
  Codigo_Autorización VARCHAR(5) NOT NULL, 
  DNI VARCHAR(9) NOT NULL, 
  PRIMARY KEY (ID_central), 
  FOREIGN KEY (Codigo_Autorización) REFERENCES productores(Codigo_Autorización), 
  FOREIGN KEY (DNI) REFERENCES responsable(DNI) 
);

CREATE TABLE termica 
( 
  Ciclo_Combinado VARCHAR(2) NOT NULL, 
  M3_Gas_Consumido FLOAT NOT NULL, 
  Tiempo_Anual_Inyección_Red_Eléctrica FLOAT NOT NULL, 
  Tiempo_Mensual_Inyección_Red_Electrica_ FLOAT NOT NULL, 
  Volumen_Anual_Acum_CO2_Emitido FLOAT NOT NULL, 
  ID_central VARCHAR(5) NOT NULL, 
  PRIMARY KEY (ID_central), 
  FOREIGN KEY (ID_central) REFERENCES central(ID_central) 
);

CREATE TABLE eolica 
( 
  Nº_Aerogeneradores INT NOT NULL, 
  Ubicación_ VARCHAR(20) NOT NULL, 
  Velocidad_R FLOAT NOT NULL, 
  Producción_Media FLOAT NOT NULL, 
  T_Acumulada_Mensual FLOAT NOT NULL, 
  T_Acumulada_Diario FLOAT NOT NULL, 
  ID_central VARCHAR(10) NOT NULL, 
  PRIMARY KEY (ID_central), 
  FOREIGN KEY (ID_central) REFERENCES central(ID_central) 
);

CREATE TABLE hidro 
( 
  volumen_max FLOAT NOT NULL, 
  num_turbinas INT NOT NULL, 
  volumen_agua_almacenada FLOAT NOT NULL, 
  ID_central VARCHAR(10) NOT NULL, 
  PRIMARY KEY (ID_central), 
  FOREIGN KEY (ID_central) REFERENCES central(ID_central) 
);

CREATE TABLE solar 
( 
  Superficie_Paneles_Instalados FLOAT NOT NULL, 
  Media_Horas_Radiacion_Solar FLOAT NOT NULL, 
  Tipo_Radiación VARCHAR(13) NOT NULL, 
  ID_central VARCHAR(10) NOT NULL, 
  PRIMARY KEY (ID_central), 
  FOREIGN KEY (ID_central) REFERENCES central(ID_central) 
);

CREATE TABLE Nuclear 
( 
  Volumen_de_Mineral_Nuclear FLOAT NOT NULL, 
  Nº_Reactores INT NOT NULL, 
  Volumen_de_Residuos FLOAT NOT NULL, 
  ID_central VARCHAR(10) NOT NULL, 
  PRIMARY KEY (ID_central), 
  FOREIGN KEY (ID_central) REFERENCES central(ID_central) 
);

CREATE TABLE Entrega 
( 
  NIF VARCHAR(10) NOT NULL, 
  ID_central VARCHAR(10) NOT NULL, 
  PRIMARY KEY (NIF), 
  FOREIGN KEY (ID_central) REFERENCES Nuclear(ID_central) 
);

CREATE TABLE Zona_servicio 
( 
  ID_zona_servicio VARCHAR(10) NOT NULL, 
  Categoria_ VARCHAR(20) NOT NULL, 
  consumo_medio_ FLOAT NOT NULL, 
  nºconsumidores INT NOT NULL, 
  Código_Provincia INT NOT NULL,  
  PRIMARY KEY (ID_zona_servicio), 
  FOREIGN KEY (Código_Provincia) REFERENCES provincias(Código_Provincia) 
);

CREATE TABLE alertas 
( 
  Código_Alerta VARCHAR(10) NOT NULL, 
  Tipo VARCHAR(1) NOT NULL, 
  Código_Central VARCHAR(10) NOT NULL, 
  latitud VARCHAR(20) NOT NULL, 
  longitud VARCHAR(20) NOT NULL, 
  Fecha_Activación DATE NOT NULL, 
  Fecha_Desactivación DATE NOT NULL, 
  Intervención VARCHAR(10) NOT NULL, 
  ID_central VARCHAR(10) NOT NULL, 
  PRIMARY KEY (Código_Alerta), 
  FOREIGN KEY (ID_central) REFERENCES central(ID_central) 
);

CREATE TABLE distribuye 
( 
  ID_subestacion VARCHAR(10) NOT NULL, 
  ID_zona_servicio VARCHAR(10) NOT NULL, 
  PRIMARY KEY (ID_subestacion, ID_zona_servicio), 
  FOREIGN KEY (ID_subestacion) REFERENCES Subestación(ID_subestacion), 
  FOREIGN KEY (ID_zona_servicio) REFERENCES Zona_servicio(ID_zona_servicio) 
);

CREATE TABLE realiza 
( 
  Codigo_suministro VARCHAR(10) NOT NULL, 
  NIF VARCHAR(10) NOT NULL, 
  PRIMARY KEY (Codigo_suministro, NIF), 
  FOREIGN KEY (Codigo_suministro) REFERENCES suministro(Codigo_suministro), 
  FOREIGN KEY (NIF) REFERENCES Entrega(NIF) 
);

CREATE TABLE suministrador 
( 
  nombre VARCHAR(20) NOT NULL, 
  país VARCHAR(20) NOT NULL, 
  PRIMARY KEY (nombre) 
);

CREATE TABLE Empresa_transporte 
( 
  NIF VARCHAR(20) NOT NULL, 
  Nombre VARCHAR(20) NOT NULL, 
  Codigo_Autorización_ VARCHAR(10) NOT NULL, 
  Fecha_Validez DATE NOT NULL, 
  Correo_emergencias VARCHAR(25) NOT NULL, 
  telefono VARCHAR(15) NOT NULL, 
  PRIMARY KEY (NIF) 
);

CREATE TABLE productores 
( 
  Codigo_Autorización VARCHAR(15) NOT NULL, 
  Denominación VARCHAR(20) NOT NULL, 
  Dirección_ VARCHAR(30) NOT NULL, 
  Teléfono VARCHAR(15) NOT NULL, 
  Fecha_Validez DATE NOT NULL, 
  Fecha_Fin_Validez DATE NOT NULL, 
  Tipo_Compañia VARCHAR(25) NOT NULL, 
  Correo_e VARCHAR(30) NOT NULL, 
  PRIMARY KEY (Codigo_Autorización) 
);

CREATE TABLE estaciones_primarias 
( 
  nombre VARCHAR(20) NOT NULL, 
  Codigo_Autorización VARCHAR(10) NOT NULL, 
  PRIMARY KEY (nombre), 
  FOREIGN KEY (Codigo_Autorización) REFERENCES productores(Codigo_Autorización) 
);

CREATE TABLE red_distribucion 
( 
  NºRed INT NOT NULL, 
  nombre VARCHAR(20) NOT NULL, 
  PRIMARY KEY (NºRed), 
  FOREIGN KEY (nombre) REFERENCES estaciones_primarias(nombre) 
);

CREATE TABLE líneas 
( 
  Longitud INT NOT NULL, 
  Nº_Secuencial INT NOT NULL, 
  NºRed INT NOT NULL, 
  PRIMARY KEY (Nº_Secuencial), 
  FOREIGN KEY (NºRed) REFERENCES red_distribucion(NºRed) 
);

CREATE TABLE Subestación 
( 
  ID_subestacion VARCHAR(10) NOT NULL, 
  Nº_Secuencial INT NOT NULL, 
  PRIMARY KEY (ID_subestacion), 
  FOREIGN KEY (Nº_Secuencial) REFERENCES líneas(Nº_Secuencial) 
);

CREATE TABLE provincias 
( 
  Código_Provincia INT NOT NULL, 
  nombre VARCHAR(20) NOT NULL, 
  PRIMARY KEY (Código_Provincia) 
);

CREATE TABLE responsable 
( 
  DNI VARCHAR(9) NOT NULL, 
  Nombre VARCHAR(25) NOT NULL, 
  Correo VARCHAR(30) NOT NULL, 
  Correo_Urgencias VARCHAR(30) NOT NULL, 
  Ubi_Oficina VARCHAR(20) NOT NULL, 
  Antigüedad VARCHAR(10) NOT NULL, 
  Teléfono_Urgencias VARCHAR(12) NOT NULL, 
  Teléfono VARCHAR(12) NOT NULL, 
  Fecha_Nombramiento DATE NOT NULL, 
  PRIMARY KEY (DNI) 
);

CREATE TABLE suministro 
( 
  Codigo_suministro VARCHAR(15) NOT NULL, 
  nombre VARCHAR(20) NOT NULL, 
  NIF VARCHAR(10) NOT NULL, 
  PRIMARY KEY (Codigo_suministro), 
  FOREIGN KEY (nombre) REFERENCES suministrador(nombre), 
  FOREIGN KEY (NIF) REFERENCES Empresa_transporte(NIF) 
);

CREATE TABLE central 
( 
  Latitud VARCHAR(20) NOT NULL, 
  Longitud VARCHAR(20) NOT NULL, 
  denominación VARCHAR(15) NOT NULL, 
  producción_anual FLOAT NOT NULL, 
  producción_mensual FLOAT NOT NULL, 
  producción_diaria FLOAT NOT NULL, 
  ID_central VARCHAR(10) NOT NULL, 
  whatsapp VARCHAR(20) NOT NULL, 
  twitter INT NOT NULL, 
  correo_electronico INT NOT NULL, 
  direccion_postal INT NOT NULL, 
  Codigo_Autorización VARCHAR(5) NOT NULL, 
  DNI VARCHAR(9) NOT NULL, 
  PRIMARY KEY (ID_central), 
  FOREIGN KEY (Codigo_Autorización) REFERENCES productores(Codigo_Autorización), 
  FOREIGN KEY (DNI) REFERENCES responsable(DNI) 
);

CREATE TABLE termica 
( 
  Ciclo_Combinado VARCHAR(2) NOT NULL, 
  M3_Gas_Consumido FLOAT NOT NULL, 
  Tiempo_Anual_Inyección_Red_Eléctrica FLOAT NOT NULL, 
  Tiempo_Mensual_Inyección_Red_Electrica_ FLOAT NOT NULL, 
  Volumen_Anual_Acum_CO2_Emitido FLOAT NOT NULL, 
  ID_central VARCHAR(5) NOT NULL, 
  PRIMARY KEY (ID_central), 
  FOREIGN KEY (ID_central) REFERENCES central(ID_central) 
);

CREATE TABLE eolica 
( 
  Nº_Aerogeneradores INT NOT NULL, 
  Ubicación_ VARCHAR(20) NOT NULL, 
  Velocidad_R FLOAT NOT NULL, 
  Producción_Media FLOAT NOT NULL, 
  T_Acumulada_Mensual FLOAT NOT NULL, 
  T_Acumulada_Diario FLOAT NOT NULL, 
  ID_central VARCHAR(10) NOT NULL, 
  PRIMARY KEY (ID_central), 
  FOREIGN KEY (ID_central) REFERENCES central(ID_central) 
);

CREATE TABLE hidro 
( 
  volumen_max FLOAT NOT NULL, 
  num_turbinas INT NOT NULL, 
  volumen_agua_almacenada FLOAT NOT NULL, 
  ID_central VARCHAR(10) NOT NULL, 
  PRIMARY KEY (ID_central), 
  FOREIGN KEY (ID_central) REFERENCES central(ID_central) 
);

CREATE TABLE solar 
( 
  Superficie_Paneles_Instalados FLOAT NOT NULL, 
  Media_Horas_Radiacion_Solar FLOAT NOT NULL, 
  Tipo_Radiación VARCHAR(13) NOT NULL, 
  ID_central VARCHAR(10) NOT NULL, 
  PRIMARY KEY (ID_central), 
  FOREIGN KEY (ID_central) REFERENCES central(ID_central) 
);

CREATE TABLE Nuclear 
( 
  Volumen_de_Mineral_Nuclear FLOAT NOT NULL, 
  Nº_Reactores INT NOT NULL, 
  Volumen_de_Residuos FLOAT NOT NULL, 
  ID_central VARCHAR(10) NOT NULL, 
  PRIMARY KEY (ID_central), 
  FOREIGN KEY (ID_central) REFERENCES central(ID_central) 
);

CREATE TABLE Entrega 
( 
  NIF VARCHAR(10) NOT NULL, 
  ID_central VARCHAR(10) NOT NULL, 
  PRIMARY KEY (NIF), 
  FOREIGN KEY (ID_central) REFERENCES Nuclear(ID_central) 
);

CREATE TABLE Zona_servicio 
( 
  ID_zona_servicio VARCHAR(10) NOT NULL, 
  Categoria_ VARCHAR(20) NOT NULL, 
  consumo_medio_ FLOAT NOT NULL, 
  nºconsumidores INT NOT NULL, 
  Código_Provincia INT NOT NULL,  
  PRIMARY KEY (ID_zona_servicio), 
  FOREIGN KEY (Código_Provincia) REFERENCES provincias(Código_Provincia) 
);

CREATE TABLE alertas 
( 
  Código_Alerta VARCHAR(10) NOT NULL, 
  Tipo VARCHAR(1) NOT NULL, 
  Código_Central VARCHAR(10) NOT NULL, 
  latitud VARCHAR(20) NOT NULL, 
  longitud VARCHAR(20) NOT NULL, 
  Fecha_Activación DATE NOT NULL, 
  Fecha_Desactivación DATE NOT NULL, 
  Intervención VARCHAR(10) NOT NULL, 
  ID_central VARCHAR(10) NOT NULL, 
  PRIMARY KEY (Código_Alerta), 
  FOREIGN KEY (ID_central) REFERENCES central(ID_central) 
);

CREATE TABLE distribuye 
( 
  ID_subestacion VARCHAR(10) NOT NULL, 
  ID_zona_servicio VARCHAR(10) NOT NULL, 
  PRIMARY KEY (ID_subestacion, ID_zona_servicio), 
  FOREIGN KEY (ID_subestacion) REFERENCES Subestación(ID_subestacion), 
  FOREIGN KEY (ID_zona_servicio) REFERENCES Zona_servicio(ID_zona_servicio) 
);

CREATE TABLE realiza 
( 
  Codigo_suministro VARCHAR(10) NOT NULL, 
  NIF VARCHAR(10) NOT NULL, 
  PRIMARY KEY (Codigo_suministro, NIF), 
  FOREIGN KEY (Codigo_suministro) REFERENCES suministro(Codigo_suministro), 
  FOREIGN KEY (NIF) REFERENCES Entrega(NIF) 
);

insert into suministrador(nombre, país) values('Pedro', 'España');

insert into suministrador(nombre, país) values('BEnito', 'Puerto Rico');

insert into suministrador(nombre, país) values('Carlos', 'Portugal');

insert into Empresa_transporte(NIF,Nombre,Codigo_Autorización_, Fecha_Validez, Correo_emergencias,telefono) values('44318L', 'Ladrillo S.A', 'P234','2/January/2023', 'ladrillo@upa.com', '78982143');

insert into Empresa_transporte(NIF,Nombre,Codigo_Autorización_,Fecha_Validez, Correo_emergencias,telefono) values('23178R', 'DHL S.A', 'L987','30/May/2025', 'DHL@hotmail.com', '666838222');

insert into Empresa_transporte(NIF,Nombre,Codigo_Autorización_,Fecha_Validez, Correo_emergencias,telefono) values('88927B', 'UPS S.A', 'D077','15/August/2024', 'ups@gmail.com', '619623725');

insert into productores(Codigo_Autorización,Denominación,Dirección_,Teléfono,Fecha_Validez,Fecha_Fin_Validez,Tipo_Compañia,Correo_e) values('QJ3422','agua tour SA','C/Fernandez de los rios 108','656373829','10/March/2018','10/March/2022','Compañia electrica','ATour@gmail.com');

insert into productores(Codigo_Autorización,Denominación,Dirección_,Teléfono,Fecha_Validez,Fecha_Fin_Validez,Tipo_Compañia,Correo_e) values('TR00233','NN2Q SA','C/Juan Florez','656453781','30/January/2010','1/January/2020','cooperativa','N2@gmail.com');

insert into productores(Codigo_Autorización,Denominación,Dirección_,Teléfono,Fecha_Validez,Fecha_Fin_Validez,Tipo_Compañia,Correo_e) values('RR00012','Iberdrola','C/Pedro Tavares','677895982','1/December/2018','1/December/2028','compañia electrica','iberdrola@gmail.com');

insert into estaciones_primarias(nombre,Codigo_Autorización) values('Anton de Aquino', 'QJ3422');

insert into estaciones_primarias(nombre,Codigo_Autorización) values('Cristiano Ronaldo', 'TR00233');

insert into estaciones_primarias(nombre,Codigo_Autorización) values('Diolkos de Milan', 'RR00012');

insert into red_distribucion(NºRed,nombre) values(606,'Anton de Aquino');

insert into red_distribucion(NºRed,nombre) values(366,'Cristiano Ronaldo');

insert into red_distribucion(NºRed,nombre) values(419,'Diolkos de Milan');

insert into líneas(Longitud,Nº_Secuencial,NºRed) values(42648, 345, 606);

insert into líneas(Longitud,Nº_Secuencial,NºRed) values(82648, 346, 366 );

insert into líneas(Longitud,Nº_Secuencial,NºRed) values(47741, 347, 419);

insert into Subestación(ID_subestacion,Nº_Secuencial) values('P083', 345);

insert into Subestación(ID_subestacion,Nº_Secuencial) values('Q350', 346);

insert into Subestación(ID_subestacion,Nº_Secuencial) values('R612', 347);

insert into provincias(Código_Provincia,nombre) values(0234,'A Coruña');

insert into provincias(Código_Provincia,nombre) values(0216,'Santander');

insert into provincias(Código_Provincia,nombre) values(0081,'Bilbao');

insert into responsable(DNI,Nombre,Correo,Correo_Urgencias,Ubi_Oficina,Antigüedad,Teléfono_Urgencias,Teléfono,Fecha_Nombramiento) values('54151626N','José María SAntabarbara','jsMaría@gmail.com','j.emp@gmail.com','C/Sao sao 23',13,'619452123','612333452','5/December/2011');

insert into responsable(DNI,Nombre,Correo,Correo_Urgencias,Ubi_Oficina,Antigüedad,Teléfono_Urgencias,Teléfono,Fecha_Nombramiento) values('68762345P','Arturo MArinez','ArturoMAr@gmail.com','arturo.EFp@gmail.com','C/Verde 420',6,'612351637','623456791','22/February/2015');

insert into responsable(DNI,Nombre,Correo,Correo_Urgencias,Ubi_Oficina,Antigüedad,Teléfono_Urgencias,Teléfono,Fecha_Nombramiento) values('65923401T','Sergio Aldama','s.aldama@gmail.com','s.ald.W@gmail.com','C/rio 81',16,'677892365','611223344','1/January/2006');

insert into responsable(DNI,Nombre,Correo,Correo_Urgencias,Ubi_Oficina,Antigüedad,Teléfono_Urgencias,Teléfono,Fecha_Nombramiento) values('57892523N','Antón Barrul','a.barrul@gmail.com','a.Bar@gmail.com','C/macas 66',10,'612121212','611111111','1/January/2012');

insert into responsable(DNI,Nombre,Correo,Correo_Urgencias,Ubi_Oficina,Antigüedad,Teléfono_Urgencias,Teléfono,Fecha_Nombramiento) values('89134581P','Myke Towers','m.towers@gmail.com','m.Tow@gmail.com','C/hannspree 10',5,'677234512','622222222','1/January/2016');

insert into suministro(Codigo_suministro,nombre,NIF) values ('ND-04','Pedro','44318L');

insert into suministro(Codigo_suministro,nombre,NIF) values ('ND-43','BEnito','23178R');

insert into suministro(Codigo_suministro,nombre,NIF) values ('ND-76','Carlos','88927B');

insert into central(Latitud,Longitud,denominación,producción_anual,producción_mensual,producción_diaria,ID_central,whatsapp,twitter,correo_electronico,direccion_postal,Codigo_Autorización,DNI) values('28','-35','Xilodou', 36581.8, 302.3, 10.7,'N0398','632874561','@xilodou.c',xilodou.c@gmail.com','C/Cervantes 23','QJ3422','54151626N');

insert into central(Latitud,Longitud,denominación,producción_anual,producción_mensual,producción_diaria,ID_central,whatsapp,twitter,correo_electronico,direccion_postal,Codigo_Autorización,DNI) values('54','12','Ríos largos', 45918.4, 3826.5, 125.8,'M0035','612321437','@Ríoslargos','ríosLargos@gmail.com','C/Scotti 512','TR00233','68762345P');

insert into central(Latitud,Longitud,denominación,producción_anual,producción_mensual,producción_diaria,ID_central,whatsapp,twitter,correo_electronico,direccion_postal,Codigo_Autorización,DNI) values('18','03','Iguazu fall', 28527.4, 2377.2, 78.1,'T4302','677891234','@IguazuFall','iguazuF@gmail.com','C/Niagara 1','RR00012','65923401T');

insert into central(Latitud,Longitud,denominación,producción_anual,producción_mensual,producción_diaria,ID_central,whatsapp,twitter,correo_electronico,direccion_postal,Codigo_Autorización,DNI) values('-08','88','MagrebLive', 36000, 3000, 100,'W0222','677891123','@MagrebL','MagrebL@gmail.com','C/Mahmov 70','TR00233','57892523N');

insert into central(Latitud,Longitud,denominación,producción_anual,producción_mensual,producción_diaria,ID_central,whatsapp,twitter,correo_electronico,direccion_postal,Codigo_Autorización,DNI) values('54','-89','Coristanco Free', 72000, 6000, 200,'P8330','688992345','@CotistancoF','coristancoF@gmail.com','C/Zagueira 23','RR00012','89134581P');

insert into termica(Ciclo_Combinado,M3_Gas_Consumido,Tiempo_Anual_Inyección_Red_Eléctrica,Tiempo_Mensual_Inyección_Red_Electrica_,Volumen_Anual_Acum_CO2_Emitido,ID_central), values('53',1004.27,108.76,11.31,2605.46,'M0035');

insert into eolica(NºAerogeneradores,Ubicación,Velocidad_R,Producción_Media,T_Acumulada_Mensual,T_Acumulada_Diario,ID_central) values(39,'Peru',28.3,308.8,350.2,10.6,'N0398');

insert into hidro(volumen_max,num_turbinas,volumen_agua_almacenada,ID_central) values(249999.99,12,108367.43,'T4302');

insert into solar(Superficie_Paneles_Instalados,Media_Horas_Radiacion_Solar,Tipo_Radiación,ID_central) values(2570.8,10.2,'X',W0222);

insert into Nuclear(Volumen_de_Mineral_Nuclear,Nº_Reactores,Volumen_de_Residuos,ID_central) values(23000,4,1100,'P8330');

inisert into Entrega(NIF,ID_central) values('6722319','P8330'); 


inisert into Entrega(NIF,ID_central) values('6829424','P8330'); 


insert into Zona_servicio(ID_zona_servicio,Categoria_,consumo_medio_,nºconsumidores,Código_Provincia) values('H-23','Sub',230.00,19,0234);

insert into Zona_servicio(ID_zona_servicio,Categoria_,consumo_medio_,nºconsumidores,Código_Provincia) values('H-24','Sub',112.2,27,0216);

insert into Zona_servicio(ID_zona_servicio,Categoria_,consumo_medio_,nºconsumidores,Código_Provincia) values('H-25','Sub',192.2,25,0081);

insert into alertas(Código_Alerta,Tipo,Código_Central,latitud,longitud,Fecha_Activación,Fecha_Desactivación,Intervención, ID_central ) values('AL-00001','H','PR-005','41.5206081','-5.9718162','2022/September/2018','2022/07/14-13:56:49','IN-0002','M0035');

insert into alertas(Código_Alerta,Tipo,Código_Central,latitud,longitud,Fecha_Activación,Fecha_Desactivación,Intervención, ID_central ) values('AL-00002','N','PR-006','41.5206082','-5.9718163','2022/November/2015','2022/08/15-13:56:57','IN-0003','M0035');

insert into alertas(Código_Alerta,Tipo,Código_Central,latitud,longitud,Fecha_Activación,Fecha_Desactivación,Intervención, ID_central ) values('AL-0003','E','PR-007','41.5206083','-5.9718164','2022/October/2020','2022/07/15-13:56:55','IN-0004','P8330');

insert into distribuye(ID_subestacion,ID_zona_servicio ,NIF) values('NN32','N-511',0234 );

insert into distribuye(ID_subestacion,ID_zona_servicio ,NIF) values('KL89','N-032', 0216);

insert into distribuye(ID_subestacion,ID_zona_servicio ,NIF) values('GR03','N-709', 0081);

insert into realiza(Codigo_suministro ,NIF) values('4HJH','6722319' );

insert into realiza(Codigo_suministro ,NIF) values('8KLM','6829424' );

CREATE TABLE suministrador 
( 
  nombre VARCHAR(20) NOT NULL, 
  país VARCHAR(20) NOT NULL, 
  PRIMARY KEY (nombre) 
);

CREATE TABLE Empresa_transporte 
( 
  NIF VARCHAR(20) NOT NULL, 
  Nombre VARCHAR(20) NOT NULL, 
  Codigo_Autorización_ VARCHAR(10) NOT NULL, 
  Fecha_Validez DATE NOT NULL, 
  Correo_emergencias VARCHAR(25) NOT NULL, 
  telefono VARCHAR(15) NOT NULL, 
  PRIMARY KEY (NIF) 
);

CREATE TABLE productores 
( 
  Codigo_Autorización VARCHAR(15) NOT NULL, 
  Denominación VARCHAR(20) NOT NULL, 
  Dirección_ VARCHAR(30) NOT NULL, 
  Teléfono VARCHAR(15) NOT NULL, 
  Fecha_Validez DATE NOT NULL, 
  Fecha_Fin_Validez DATE NOT NULL, 
  Tipo_Compañia VARCHAR(25) NOT NULL, 
  Correo_e VARCHAR(30) NOT NULL, 
  PRIMARY KEY (Codigo_Autorización) 
);

CREATE TABLE estaciones_primarias 
( 
  nombre VARCHAR(20) NOT NULL, 
  Codigo_Autorización VARCHAR(10) NOT NULL, 
  PRIMARY KEY (nombre), 
  FOREIGN KEY (Codigo_Autorización) REFERENCES productores(Codigo_Autorización) 
);

CREATE TABLE red_distribucion 
( 
  NºRed INT NOT NULL, 
  nombre VARCHAR(20) NOT NULL, 
  PRIMARY KEY (NºRed), 
  FOREIGN KEY (nombre) REFERENCES estaciones_primarias(nombre) 
);

CREATE TABLE líneas 
( 
  Longitud INT NOT NULL, 
  Nº_Secuencial INT NOT NULL, 
  NºRed INT NOT NULL, 
  PRIMARY KEY (Nº_Secuencial), 
  FOREIGN KEY (NºRed) REFERENCES red_distribucion(NºRed) 
);

CREATE TABLE Subestación 
( 
  ID_subestacion VARCHAR(10) NOT NULL, 
  Nº_Secuencial INT NOT NULL, 
  PRIMARY KEY (ID_subestacion), 
  FOREIGN KEY (Nº_Secuencial) REFERENCES líneas(Nº_Secuencial) 
);

CREATE TABLE provincias 
( 
  Código_Provincia INT NOT NULL, 
  nombre VARCHAR(20) NOT NULL, 
  PRIMARY KEY (Código_Provincia) 
);

CREATE TABLE responsable 
( 
  DNI VARCHAR(9) NOT NULL, 
  Nombre VARCHAR(25) NOT NULL, 
  Correo VARCHAR(30) NOT NULL, 
  Correo_Urgencias VARCHAR(30) NOT NULL, 
  Ubi_Oficina VARCHAR(20) NOT NULL, 
  Antigüedad VARCHAR(10) NOT NULL, 
  Teléfono_Urgencias VARCHAR(12) NOT NULL, 
  Teléfono VARCHAR(12) NOT NULL, 
  Fecha_Nombramiento DATE NOT NULL, 
  PRIMARY KEY (DNI) 
);

CREATE TABLE suministro 
( 
  Codigo_suministro VARCHAR(15) NOT NULL, 
  nombre VARCHAR(20) NOT NULL, 
  NIF VARCHAR(10) NOT NULL, 
  PRIMARY KEY (Codigo_suministro), 
  FOREIGN KEY (nombre) REFERENCES suministrador(nombre), 
  FOREIGN KEY (NIF) REFERENCES Empresa_transporte(NIF) 
);

CREATE TABLE central 
( 
  Latitud VARCHAR(20) NOT NULL, 
  Longitud VARCHAR(20) NOT NULL, 
  denominación VARCHAR(15) NOT NULL, 
  producción_anual FLOAT NOT NULL, 
  producción_mensual FLOAT NOT NULL, 
  producción_diaria FLOAT NOT NULL, 
  ID_central VARCHAR(10) NOT NULL, 
  whatsapp VARCHAR(20) NOT NULL, 
  twitter INT NOT NULL, 
  correo_electronico INT NOT NULL, 
  direccion_postal INT NOT NULL, 
  Codigo_Autorización VARCHAR(5) NOT NULL, 
  DNI VARCHAR(9) NOT NULL, 
  PRIMARY KEY (ID_central), 
  FOREIGN KEY (Codigo_Autorización) REFERENCES productores(Codigo_Autorización), 
  FOREIGN KEY (DNI) REFERENCES responsable(DNI) 
);

CREATE TABLE termica 
( 
  Ciclo_Combinado VARCHAR(2) NOT NULL, 
  M3_Gas_Consumido FLOAT NOT NULL, 
  Tiempo_Anual_Inyección_Red_Eléctrica FLOAT NOT NULL, 
  Tiempo_Mensual_Inyección_Red_Electrica_ FLOAT NOT NULL, 
  Volumen_Anual_Acum_CO2_Emitido FLOAT NOT NULL, 
  ID_central VARCHAR(5) NOT NULL, 
  PRIMARY KEY (ID_central), 
  FOREIGN KEY (ID_central) REFERENCES central(ID_central) 
);

CREATE TABLE eolica 
( 
  Nº_Aerogeneradores INT NOT NULL, 
  Ubicación_ VARCHAR(20) NOT NULL, 
  Velocidad_R FLOAT NOT NULL, 
  Producción_Media FLOAT NOT NULL, 
  T_Acumulada_Mensual FLOAT NOT NULL, 
  T_Acumulada_Diario FLOAT NOT NULL, 
  ID_central VARCHAR(10) NOT NULL, 
  PRIMARY KEY (ID_central), 
  FOREIGN KEY (ID_central) REFERENCES central(ID_central) 
);

CREATE TABLE hidro 
( 
  volumen_max FLOAT NOT NULL, 
  num_turbinas INT NOT NULL, 
  volumen_agua_almacenada FLOAT NOT NULL, 
  ID_central VARCHAR(10) NOT NULL, 
  PRIMARY KEY (ID_central), 
  FOREIGN KEY (ID_central) REFERENCES central(ID_central) 
);

CREATE TABLE solar 
( 
  Superficie_Paneles_Instalados FLOAT NOT NULL, 
  Media_Horas_Radiacion_Solar FLOAT NOT NULL, 
  Tipo_Radiación VARCHAR(13) NOT NULL, 
  ID_central VARCHAR(10) NOT NULL, 
  PRIMARY KEY (ID_central), 
  FOREIGN KEY (ID_central) REFERENCES central(ID_central) 
);

CREATE TABLE Nuclear 
( 
  Volumen_de_Mineral_Nuclear FLOAT NOT NULL, 
  Nº_Reactores INT NOT NULL, 
  Volumen_de_Residuos FLOAT NOT NULL, 
  ID_central VARCHAR(10) NOT NULL, 
  PRIMARY KEY (ID_central), 
  FOREIGN KEY (ID_central) REFERENCES central(ID_central) 
);

CREATE TABLE Entrega 
( 
  NIF VARCHAR(10) NOT NULL, 
  ID_central VARCHAR(10) NOT NULL, 
  PRIMARY KEY (NIF), 
  FOREIGN KEY (ID_central) REFERENCES Nuclear(ID_central) 
);

CREATE TABLE Zona_servicio 
( 
  ID_zona_servicio VARCHAR(10) NOT NULL, 
  Categoria_ VARCHAR(20) NOT NULL, 
  consumo_medio_ FLOAT NOT NULL, 
  nºconsumidores INT NOT NULL, 
  Código_Provincia INT NOT NULL,  
  PRIMARY KEY (ID_zona_servicio), 
  FOREIGN KEY (Código_Provincia) REFERENCES provincias(Código_Provincia) 
);

CREATE TABLE alertas 
( 
  Código_Alerta VARCHAR(10) NOT NULL, 
  Tipo VARCHAR(1) NOT NULL, 
  Código_Central VARCHAR(10) NOT NULL, 
  latitud VARCHAR(20) NOT NULL, 
  longitud VARCHAR(20) NOT NULL, 
  Fecha_Activación DATE NOT NULL, 
  Fecha_Desactivación DATE NOT NULL, 
  Intervención VARCHAR(10) NOT NULL, 
  ID_central VARCHAR(10) NOT NULL, 
  PRIMARY KEY (Código_Alerta), 
  FOREIGN KEY (ID_central) REFERENCES central(ID_central) 
);

CREATE TABLE distribuye 
( 
  ID_subestacion VARCHAR(10) NOT NULL, 
  ID_zona_servicio VARCHAR(10) NOT NULL, 
  PRIMARY KEY (ID_subestacion, ID_zona_servicio), 
  FOREIGN KEY (ID_subestacion) REFERENCES Subestación(ID_subestacion), 
  FOREIGN KEY (ID_zona_servicio) REFERENCES Zona_servicio(ID_zona_servicio) 
);

CREATE TABLE realiza 
( 
  Codigo_suministro VARCHAR(10) NOT NULL, 
  NIF VARCHAR(10) NOT NULL, 
  PRIMARY KEY (Codigo_suministro, NIF), 
  FOREIGN KEY (Codigo_suministro) REFERENCES suministro(Codigo_suministro), 
  FOREIGN KEY (NIF) REFERENCES Entrega(NIF) 
);

insert into suministrador(nombre, país) values('Pedro', 'España');

insert into suministrador(nombre, país) values('BEnito', 'Puerto Rico');

insert into suministrador(nombre, país) values('Carlos', 'Portugal');

insert into Empresa_transporte(NIF,Nombre,Codigo_Autorización_, Fecha_Validez, Correo_emergencias,telefono) values('44318L', 'Ladrillo S.A', 'P234','2/January/2023', 'ladrillo@upa.com', '78982143');

insert into Empresa_transporte(NIF,Nombre,Codigo_Autorización_,Fecha_Validez, Correo_emergencias,telefono) values('23178R', 'DHL S.A', 'L987','30/May/2025', 'DHL@hotmail.com', '666838222');

insert into Empresa_transporte(NIF,Nombre,Codigo_Autorización_,Fecha_Validez, Correo_emergencias,telefono) values('88927B', 'UPS S.A', 'D077','15/August/2024', 'ups@gmail.com', '619623725');

insert into productores(Codigo_Autorización,Denominación,Dirección_,Teléfono,Fecha_Validez,Fecha_Fin_Validez,Tipo_Compañia,Correo_e) values('QJ3422','agua tour SA','C/Fernandez de los rios 108','656373829','10/March/2018','10/March/2022','Compañia electrica','ATour@gmail.com');

insert into productores(Codigo_Autorización,Denominación,Dirección_,Teléfono,Fecha_Validez,Fecha_Fin_Validez,Tipo_Compañia,Correo_e) values('TR00233','NN2Q SA','C/Juan Florez','656453781','30/January/2010','1/January/2020','cooperativa','N2@gmail.com');

insert into productores(Codigo_Autorización,Denominación,Dirección_,Teléfono,Fecha_Validez,Fecha_Fin_Validez,Tipo_Compañia,Correo_e) values('RR00012','Iberdrola','C/Pedro Tavares','677895982','1/December/2018','1/December/2028','compañia electrica','iberdrola@gmail.com');

insert into estaciones_primarias(nombre,Codigo_Autorización) values('Anton de Aquino', 'QJ3422');

insert into estaciones_primarias(nombre,Codigo_Autorización) values('Cristiano Ronaldo', 'TR00233');

insert into estaciones_primarias(nombre,Codigo_Autorización) values('Diolkos de Milan', 'RR00012');

insert into red_distribucion(NºRed,nombre) values(606,'Anton de Aquino');

insert into red_distribucion(NºRed,nombre) values(366,'Cristiano Ronaldo');

insert into red_distribucion(NºRed,nombre) values(419,'Diolkos de Milan');

insert into líneas(Longitud,Nº_Secuencial,NºRed) values(42648, 345, 606);

insert into líneas(Longitud,Nº_Secuencial,NºRed) values(82648, 346, 366 );

insert into líneas(Longitud,Nº_Secuencial,NºRed) values(47741, 347, 419);

insert into Subestación(ID_subestacion,Nº_Secuencial) values('P083', 345);

insert into Subestación(ID_subestacion,Nº_Secuencial) values('Q350', 346);

insert into Subestación(ID_subestacion,Nº_Secuencial) values('R612', 347);

insert into provincias(Código_Provincia,nombre) values(0234,'A Coruña');

insert into provincias(Código_Provincia,nombre) values(0216,'Santander');

insert into provincias(Código_Provincia,nombre) values(0081,'Bilbao');

insert into responsable(DNI,Nombre,Correo,Correo_Urgencias,Ubi_Oficina,Antigüedad,Teléfono_Urgencias,Teléfono,Fecha_Nombramiento) values('54151626N','José María SAntabarbara','jsMaría@gmail.com','j.emp@gmail.com','C/Sao sao 23',13,'619452123','612333452','5/December/2011');

insert into responsable(DNI,Nombre,Correo,Correo_Urgencias,Ubi_Oficina,Antigüedad,Teléfono_Urgencias,Teléfono,Fecha_Nombramiento) values('68762345P','Arturo MArinez','ArturoMAr@gmail.com','arturo.EFp@gmail.com','C/Verde 420',6,'612351637','623456791','22/February/2015');

insert into responsable(DNI,Nombre,Correo,Correo_Urgencias,Ubi_Oficina,Antigüedad,Teléfono_Urgencias,Teléfono,Fecha_Nombramiento) values('65923401T','Sergio Aldama','s.aldama@gmail.com','s.ald.W@gmail.com','C/rio 81',16,'677892365','611223344','1/January/2006');

insert into responsable(DNI,Nombre,Correo,Correo_Urgencias,Ubi_Oficina,Antigüedad,Teléfono_Urgencias,Teléfono,Fecha_Nombramiento) values('57892523N','Antón Barrul','a.barrul@gmail.com','a.Bar@gmail.com','C/macas 66',10,'612121212','611111111','1/January/2012');

insert into responsable(DNI,Nombre,Correo,Correo_Urgencias,Ubi_Oficina,Antigüedad,Teléfono_Urgencias,Teléfono,Fecha_Nombramiento) values('89134581P','Myke Towers','m.towers@gmail.com','m.Tow@gmail.com','C/hannspree 10',5,'677234512','622222222','1/January/2016');

insert into suministro(Codigo_suministro,nombre,NIF) values ('ND-04','Pedro','44318L');

insert into suministro(Codigo_suministro,nombre,NIF) values ('ND-43','BEnito','23178R');

insert into suministro(Codigo_suministro,nombre,NIF) values ('ND-76','Carlos','88927B');

insert into central(Latitud,Longitud,denominación,producción_anual,producción_mensual,producción_diaria,ID_central,whatsapp,twitter,correo_electronico,direccion_postal,Codigo_Autorización,DNI) values('28','-35','Xilodou', 36581.8, 302.3, 10.7,'N0398','632874561','@xilodou.c',xilodou.c@gmail.com','C/Cervantes 23','QJ3422','54151626N');

insert into central(Latitud,Longitud,denominación,producción_anual,producción_mensual,producción_diaria,ID_central,whatsapp,twitter,correo_electronico,direccion_postal,Codigo_Autorización,DNI) values('54','12','Ríos largos', 45918.4, 3826.5, 125.8,'M0035','612321437','@Ríoslargos','ríosLargos@gmail.com','C/Scotti 512','TR00233','68762345P');

insert into central(Latitud,Longitud,denominación,producción_anual,producción_mensual,producción_diaria,ID_central,whatsapp,twitter,correo_electronico,direccion_postal,Codigo_Autorización,DNI) values('18','03','Iguazu fall', 28527.4, 2377.2, 78.1,'T4302','677891234','@IguazuFall','iguazuF@gmail.com','C/Niagara 1','RR00012','65923401T');

insert into central(Latitud,Longitud,denominación,producción_anual,producción_mensual,producción_diaria,ID_central,whatsapp,twitter,correo_electronico,direccion_postal,Codigo_Autorización,DNI) values('-08','88','MagrebLive', 36000, 3000, 100,'W0222','677891123','@MagrebL','MagrebL@gmail.com','C/Mahmov 70','TR00233','57892523N');

insert into central(Latitud,Longitud,denominación,producción_anual,producción_mensual,producción_diaria,ID_central,whatsapp,twitter,correo_electronico,direccion_postal,Codigo_Autorización,DNI) values('54','-89','Coristanco Free', 72000, 6000, 200,'P8330','688992345','@CotistancoF','coristancoF@gmail.com','C/Zagueira 23','RR00012','89134581P');

insert into termica(Ciclo_Combinado,M3_Gas_Consumido,Tiempo_Anual_Inyección_Red_Eléctrica,Tiempo_Mensual_Inyección_Red_Electrica_,Volumen_Anual_Acum_CO2_Emitido,ID_central), values('53',1004.27,108.76,11.31,2605.46,'M0035');

insert into eolica(NºAerogeneradores,Ubicación,Velocidad_R,Producción_Media,T_Acumulada_Mensual,T_Acumulada_Diario,ID_central) values(39,'Peru',28.3,308.8,350.2,10.6,'N0398');

insert into hidro(volumen_max,num_turbinas,volumen_agua_almacenada,ID_central) values(249999.99,12,108367.43,'T4302');

insert into solar(Superficie_Paneles_Instalados,Media_Horas_Radiacion_Solar,Tipo_Radiación,ID_central) values(2570.8,10.2,'X',W0222);

insert into Nuclear(Volumen_de_Mineral_Nuclear,Nº_Reactores,Volumen_de_Residuos,ID_central) values(23000,4,1100,'P8330');

inisert into Entrega(NIF,ID_central) values('6722319','P8330'); 


inisert into Entrega(NIF,ID_central) values('6829424','P8330'); 


insert into Zona_servicio(ID_zona_servicio,Categoria_,consumo_medio_,nºconsumidores,Código_Provincia) values('H-23','Sub',230.00,19,0234);

insert into Zona_servicio(ID_zona_servicio,Categoria_,consumo_medio_,nºconsumidores,Código_Provincia) values('H-24','Sub',112.2,27,0216);

insert into Zona_servicio(ID_zona_servicio,Categoria_,consumo_medio_,nºconsumidores,Código_Provincia) values('H-25','Sub',192.2,25,0081);

insert into alertas(Código_Alerta,Tipo,Código_Central,latitud,longitud,Fecha_Activación,Fecha_Desactivación,Intervención, ID_central ) values('AL-00001','H','PR-005','41.5206081','-5.9718162','2022/September/2018','2022/07/14-13:56:49','IN-0002','M0035');

insert into alertas(Código_Alerta,Tipo,Código_Central,latitud,longitud,Fecha_Activación,Fecha_Desactivación,Intervención, ID_central ) values('AL-00002','N','PR-006','41.5206082','-5.9718163','2022/November/2015','2022/08/15-13:56:57','IN-0003','M0035');

insert into alertas(Código_Alerta,Tipo,Código_Central,latitud,longitud,Fecha_Activación,Fecha_Desactivación,Intervención, ID_central ) values('AL-0003','E','PR-007','41.5206083','-5.9718164','2022/October/2020','2022/07/15-13:56:55','IN-0004','P8330');

insert into distribuye(ID_subestacion,ID_zona_servicio ,NIF) values('NN32','N-511',0234 );

insert into distribuye(ID_subestacion,ID_zona_servicio ,NIF) values('KL89','N-032', 0216);

insert into distribuye(ID_subestacion,ID_zona_servicio ,NIF) values('GR03','N-709', 0081);

insert into realiza(Codigo_suministro ,NIF) values('4HJH','6722319' );

insert into realiza(Codigo_suministro ,NIF) values('8KLM','6829424' );

1- 


select productor.Denominación  
from productores --selecciona la tabla qu es la principal  
inner join central  
on productores.Codigo_Autorización = central.Codigo_Autorización   -- unir tablas para acceder a todos los datos, en este caso se le añade la de central a productor 
where nombre like '%S.A%' --patron de caracteres .&xx%  los % sirven como un contentga xx 
AND Codigo_Autorización IS NOT NULL 
having count(productor.Denominación)>1;   -- un productor genera para mas de 1 central 
GROUP BY Denominación;

2- 


select * 
from eolica  
where eolica.produccion_media>(select avg(eolica.produccion_media) from eolica 
 
 
 
3- 
select central.denominacion, max(produccion_media) from eolica 
inner join central on eolica.ID_central =central.ID_central  
group by central.denominacion;

4- 


select alertas.tipo 
from alertas 
inner join central 
on alertas.ID_central=Central.ID_central 
where tipo like '%N%' 
and ID_central IS NOT NULL 
groupb by tipo;

5- 


set @estacion := 'Estacion1'


select * from central c 
inner join productor p 
on c.Codigo_Autorización = p.Codigo_Autorización 
inner join reparto r 
on p.Codigo_Reparto = r.Codigo_Reparto 
inner join Estación_primaria es 
on r.Nombre = es.nombre 
where es.Nombre = @estacion;

6- 


set @zona := 'FGHY45097'


set @provincia := 'Badajoz'


select zs.consumo_medio from central c 
inner join productor p 
on c.Codigo_Autorización = p.Codigo_Autorización 
inner join reparto r 
on p.Codigo_Reparto = r.Codigo_Reparto 
inner join Estación_primaria es 
on r.Nombre = es.nombre 
inner join red_distribución rd 
on rd.Nombre = es.Nombre 
inner join lineas l 
on l.Nº_Red = rd.Nº_Red 
inner join subestación sb 
on sb.Nº_Secuencial = l.Nº_Secuencial 
inner join distribuye d 
on sb.ID_Subestación = d.ID_Subestación 
inner join zona_de_servicio zs 
on zs.Id_Zona_Servicio = d.Id_Zona_Servicio 
inner join provincias pr 
on pr.Id_Zona_Servicio = zs.Id_Zona_Servicio 
where zs.Id_Zona_Servicio = @zona 
and pr.Nombre = @provincia;

