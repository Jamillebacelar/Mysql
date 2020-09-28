create database if not exists db_universidade;
use db_universidade;

create table if not exists tbl_aluno (
	mat integer primary key ,
	nome varchar (50) not null,
	endereco varchar(50) not null,
	cidade varchar(60) not null
);
create table if not exists tbl_disciplina (
	cod_disc varchar(3) primary key,
	nome_disc varchar(30) not null,
	carga_hor int not null
);


create table if not exists tbl_professor (
	cod_prof int primary key not null,
	nome varchar(40) not null,
	endereco varchar(50) not null,
	cidade varchar(50) not null
);


create table if not exists tbl_turma (
	cod_disc varchar(3) not null,
	cod_turma int not null,
	cod_prof int not null,
	ano varchar(4) not null,
	horario varchar(7) not null,
primary key (cod_disc, cod_turma, cod_prof, ano),
constraint fk_turma_disciplina foreign key (cod_disc) references tbl_disciplina(cod_disc),
constraint fk_turma_professor foreign key (cod_prof) references tbl_professor(cod_prof)
);


create table if not exists tbl_historico (
	mat integer,
	cod_disc varchar(3),
	cod_turma int,
	cod_prof int,
	ano varchar(4) not null,
	frequencia smallint,
	nota float,
primary key (mat, cod_disc, cod_turma, cod_prof, ano),
constraint fk_aluno_historico foreign key (mat) references tbl_aluno(mat),
constraint fk_turma_historico foreign key (cod_disc, cod_turma,cod_prof,ano) 
references tbl_turma(cod_disc, cod_turma,cod_prof,ano)
);


insert into tbl_aluno (mat, nome, endereco, cidade) values
(2015010101, 'JOSE DE ALENCAR', 'RUA DAS ALMAS', 'NATAL'),
(2015010102, 'JOÃO JOSÉ', 'AVENIDA RUY CARNEIRO', 'JOÃO PESSOA'),
(2015010103, 'MARIA JOAQUINA', 'RUA CARROSSEL', 'RECIFE'),
(2015010104, 'MARIA DAS DORES', 'RUA DAS LADEIRAS', 'FORTALEZA'),
(2015010105, 'JOSUÉ CLAUDINO DOS SANTOS', 'CENTRO', 'NATAL'),
(2015010106, 'JOSUÉLISSON CLAUDINO DOS SANTOS', 'CENTRO', 'NATAL');


insert into tbl_disciplina(cod_disc, nome_disc, carga_hor) values
('BD', 'BANCO DE DADOS', 100),
('POO', 'PROGRAMAÇÃO COM ACESSO A BANCO DE DADOS', 100),
('WEB', 'AUTORIA WEB', 50),
('ENG', 'ENGENHARIA DE SOFTWARE', 80);



alter table tbl_disciplina modify nome_disc varchar(50);

-- alterando a quantidade de caracteres

insert into tbl_professor(cod_prof, nome, endereco, cidade) values
(212131, 'NICKERSON FERREIRA', 'RUA MANAÍRA', 'JOÃO PESSOA'),
(122135, 'ADORILSON BEZERRA', 'AVENIDA SALGADO FILHO', 'NATAL'),
(192011, 'DIEGO OLIVEIRA', 'AVENIDA ROBERTO FREIRE', 'NATAL');


insert into tbl_turma(cod_disc, cod_turma, cod_prof, ano, horario) values
('BD', 1, 212131, '2015', '11H-12H'),
('BD', 2, 212131, '2015', '13H-14H'),
('POO', 1, 192011, '2015', '08H-09H'),
('WEB', 1, 192011, '2015', '07H-08H'),
('ENG', 1, 122135, '2015', '10H-11H');


insert into tbl_historico (mat, cod_disc, cod_turma, cod_prof, ano, frequencia, nota) values
(2015010103, 'BD', 1,212131,'2015', 200, 7.5),
(2015010106, 'POO', 1,192011,'2015', 270, 9),
(2015010104, 'POO', 1, 192011, '2015', 100,3);


insert into tbl_historico (mat, cod_disc, cod_turma, cod_prof, ano, frequencia, nota) values
(2015010101,'BD', 1, 212131, '2015', 100,3),
(2015010102,'BD', 2, 212131, '2015', 50, 4),
(2015010105,'POO', 1, 192011, '2015',200, 10);



-- a
select mat,nota from tbl_historico where ano='2015' and cod_disc='BD' and nota<5;


-- b
select mat, avg(nota) from tbl_historico where ano='2015' and cod_disc='POO';


-- c
select mat, avg(nota) from tbl_historico where ano='2015' and cod_disc='POO' and nota>6;


-- d
select mat, nome, cidade from tbl_aluno where cidade<>'NATAL';


select *from historico; 

select *from tbl_aluno;

 ----- selects com mais de uma tabela
select mat from historico;
select historico.mat,tbl_aluno.nome from tbl_aluno inner join historico
on historico.mat=tbl_aluno.mat;

----- nome aluno (tbl_aluno), mat (disciplian), cod_disc (historico), nome_disc (tbl_disciplina)


select historico.mat,tbl_aluno.NOME,tbl_aluno.CIDADE,historico.cod_prof,
tbl_professor.NOME,historico.cod_disc, tbl_disciplina.NOME_DISC, 
tbl_disciplina.CARGA_HOR from historico inner join tbl_aluno on historico.mat=tbl_aluno.mat
inner join tbl_professor on historico.cod_prof=tbl_professor.COD_PROF inner join
tbl_disciplina on historico.cod_disc=tbl_disciplina.cod_disc;
 
 -- quando a carga horaria for menor que 50 e organiza por nome da cidade em ordem crescente
 select historico.mat as ' matricula', tbl_aluno.NOME as ' nome aluno', tbl_aluno.CIDADE ' endereço do aluno' ,historico.cod_prof,
tbl_professor.NOME as ' nome do professor', historico.cod_disc, tbl_disciplina.NOME_DISC ' disiplina', 
tbl_disciplina.CARGA_HOR, historico.nota as 'nota',hostorico.nota + 0.5 as 'nota com 0.5 ponto', from historico 
inner join tbl_aluno on historico.mat=tbl_aluno.mat
inner join tbl_professor on historico.cod_prof=tbl_professor.COD_PROF inner join
tbl_disciplina on historico.cod_disc=tbl_disciplina.cod_disc where CARGA_HOR <=50
order by tbl_aluno.NOME;
 