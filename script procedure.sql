use bdBiblioteca;
Delimiter $$

drop procedure if exists sp_livro_obter $$
create procedure sp_livro_obter (IN p_id int)
begin
	select id, titulo, autor, editora, genero, ano, isbn,quantidade_total, quantidade_disponivel, criado_em
    from livros where id = p_id;
    end;

drop procedure if exists sp_livro_atualizar $$
create procedure sp_livro_atualizar(
 in p_id  int, in p_titulo varchar(200), in p_autor int, in p_editora int,
 in p_genero int, in p_ano smallint, in p_isbn varchar(32), in p_novo_total int)
 begin
  declare v_disp int; declare v_total int;
  select quantidade_disponivel, quantidade_total into v_disp, v_total
  from livros where id = p_id for update;
  
  update livros	
	set titulo = p_titulo, autor = p_autor, editora = p_editora, genero = p_genero,
    ano = p_ano, isbn = p_isbn,
    quantidade_total = p_novo_total,
    quantidade_disponivel = GREATEST(0, LEAST(p_novo_total, v_disp + (p_novo_total - v_total)))
    where id = p_id;
    end;
    
    drop procedure if exists sp_livro_excluir $$
    create procedure sp_livro_excluir (in p_id int)
    begin
		delete from livros where id = p_id;
	end;
        
   drop procedure if exists sp_usuario_obter_por_email $$
   create procedure sp_usuario_obter_por_email (in p_email varchar(100))
   begin
   select id, nome, email, senha_hash, role, ativo
   from usuarios
   where email = p_email
   limit 1;
   end;
	DELIMITER ;