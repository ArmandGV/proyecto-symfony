CREATE DATABASE IF NOT EXISTS symfony_master;
USE symfony_master;

CREATE TABLE IF NOT EXISTS users (
id          int(255) auto_increment NOT NULL,
role        varchar(50),
name        varchar(100) not null,
surname     varchar(200),
email       varchar(255) not null,
password    varchar(255) not null,
created_at  datetime,
CONSTRAINT pk_user PRIMARY KEY(id),
CONSTRAINT uq_email UNIQUE(email)
)ENGINE=InnoDB; 

INSERT INTO users VALUES(NULL, 'ROLE_USER', 'armando', 'gonzalez', 'armand@hotmail.com', 'password', CURTIME());
INSERT INTO users VALUES(NULL, 'ROLE_USER', 'juan', 'lopez', 'juan@hotmail.com', 'password', CURTIME());
INSERT INTO users VALUES(NULL, 'ROLE_USER', 'pedro', 'martinez', 'pedro@hotmail.com', 'password', CURTIME());

CREATE TABLE IF NOT EXISTS tasks(
id          int(255) AUTO_INCREMENT NOT NULL,
user_id     int(255) not null,
title       varchar(255),
content     text,
priority    varchar(255),
hours       int(100),
created_at  datetime,
CONSTRAINT pk_task PRIMARY KEY(id),
CONSTRAINT fk_task_user FOREIGN KEY(user_id) REFERENCES users(id)
)ENGINE=InnoDB;

INSERT INTO tasks VALUES(NULL,1, 'Tarea 1', 'Contenido de prueba 1', 'high', 40, CURTIME());
INSERT INTO tasks VALUES(NULL,1, 'Tarea 2', 'Contenido de prueba 2', 'low', 20, CURTIME());
INSERT INTO tasks VALUES(NULL,2, 'Tarea 3', 'Contenido de prueba 3', 'medium', 10, CURTIME());
INSERT INTO tasks VALUES(NULL,2, 'Tarea 4', 'Contenido de prueba 4', 'high', 50, CURTIME());
INSERT INTO tasks VALUES(NULL,3, 'Tarea 5', 'Contenido de prueba 5', 'low', 30, CURTIME());

