create database bdBiblioteca;
use bdBiblioteca;

create table Usuarios(
id int primary key auto_increment,
nome varchar(100),
email varchar(100),
senha_hash varchar(255),
role enum ("Bibliotecario","Adm"),
ativo tinyint(1) default 1 ,
criado_Em datetime default current_timestamp
);

CREATE TABLE Editora (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(150) NOT NULL,
  criado_em DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Genero (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(100) NOT NULL,
  criado_em DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Autor (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(150) NOT NULL,
  criado_em DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

create table Livros(
	id int primary key auto_increment,
    titulo varchar(200),
    autor int,
    editora int,
    genero int,
    ano int,
    isbn varchar(32),
    quantidade_total int,
    quantidade_disponivel int,
    criado_em datetime default current_timestamp
);

alter table Livros
add constraint fk_livros_autor
foreign key (Autor) references Autor(id),
add constraint fk_livros_editora
foreign key (Editora) references Editora(id),
add constraint fk_livros_genero
foreign key (Genero) references Genero(id); 

DELIMITER $$

Drop Procedure if exists sp_livro_criar $$
create procedure sp_livro_criar (
	in p_titulo varchar (200),
    in p_autor int,
    in p_editora int,
    in p_genero int,
    in p_ano smallint,
    in p_isbn varchar(32),
    in p_quantidade int
)
begin
insert into Livros(titulo,autor,editora,genero,ano,isbn,quantidade_total, quantidade_disponivel)
values
(p_titulo, p_autor, p_editora, p_genero, p_genero, p_ano, p_isbn, p_quantidade, p_quantidade);
end $$

drop procedure if exists sp_livro_listar $$
create procedure sp_livro_listar()
begin
select
l.id,
l.titulo,
l.autor,
a.nome as autor_nome,
l.editora,
e.nome as editora_nome,
l.genero,
g.nome as genero_nome,
l.ano,
l.isbn,
l.quantidade_total,
l.quanridade_disponivel,
l.criado_em
from Livros l
left join autor a on a.id=l.autor
left join editora e on e.id=l.editora
left join genero g on g.id=l.editora
order by l.titulo;
end$$

drop procedure if exists sp_usuario_criar $$
create procedure sp_usuario_criar(
in p_nome varchar(100),
in p_email varchar(100),
in p_senha_hash varchar(255),
in p_role varchar(20) -- precisa ser VARCHAR, nao ENUM
)
begin
insert into Usuarios(nome,email,senha_hash, role, ativo, criado_Em)
values(p_nome, p_email, p_senha_hash, p_role, 1, now());
end$$

drop procedure if exists sp_editora_criar $$
create procedure sp_editora_criar(
in p_nome varchar(150)
)
begin
insert into Editora(nome)
values(p_nome);
end$$ 

drop procedure if exists sp_autor_criar $$
create procedure sp_autor_criar(
in p_nome varchar(150)
)
begin
insert into Autor(nome)
values(p_nome);
end$$ 

drop procedure if exists sp_genero_criar $$
create procedure sp_genero_criar(
in p_nome varchar(150)
)
begin
insert into Genero(nome)
values(p_nome);
end$$ 

drop procedure if exists sp_autor_listar $$ 
create procedure sp_autor_listar() 
begin 
  select id, nome from autor order by nome; 
end$$ 
DELIMITER ;

-- Exemplo de uso (ATENÇÂO: role deve ser 'adm', não 'admin')
call sp_usuario_criar(
	'João Admin',
    'joao@biblioteca.com',
    '$2a$11$HASHADMINEXEMPLO9876543210',
    'Adm'
);

select * from Genero;
select * from Editora;
select * from Autor;



select * from Usuarios;