SELECT Midia.titulo, Midia.data_lancamento, A.media_aval, Midia_Franquia.nome AS franquia, Prod.nome_organizacao AS produtora
    FROM Midia
    JOIN (SELECT id_midia FROM Participacao WHERE nome_pessoa = 'Robert Downey Jr.' OR nome_pessoa = 'Ícaro Silva' AND natureza = 'ATOR') P ON (Midia.id_midia = P.id_midia)
    LEFT JOIN (SELECT id_midia, AVG(nota) AS media_aval FROM Avaliacao GROUP BY id_midia HAVING AVG(nota) > 2) A ON (Midia.id_midia = A.id_midia)
    JOIN (SELECT id_midia, nome_organizacao FROM Producao WHERE nome_organizacao = 'Marvel Studios' OR nome_organizacao = 'Storytel') Prod ON (Midia.id_midia = Prod.id_midia)
    LEFT JOIN Midia_Franquia ON (Midia.id_midia = Midia_Franquia.id_midia)
    WHERE DATE_PART('year', Midia.data_lancamento) BETWEEN 2018 AND 2020
    ORDER BY A.media_aval DESC;

SELECT Midia.titulo, Midia.data_lancamento, A.media_aval, Midia_Franquia.nome AS franquia, Producao.nome_organizacao AS produtora
    FROM Midia
    JOIN Participacao ON (Midia.id_midia = Participacao.id_midia AND Participacao.nome_pessoa IN ('Robert Downey Jr.', 'Ícaro Silva') AND Participacao.natureza = 'ATOR')
    LEFT JOIN (SELECT id_midia, AVG(nota) AS media_aval FROM Avaliacao GROUP BY id_midia HAVING AVG(nota) > 2) A ON (Midia.id_midia = A.id_midia)
    JOIN Producao ON (Midia.id_midia = Producao.id_midia AND Producao.nome_organizacao IN ('Marvel Studios', 'Storytel'))
    LEFT JOIN Midia_Franquia ON (Midia.id_midia = Midia_Franquia.id_midia)
    WHERE DATE_PART('year', Midia.data_lancamento) BETWEEN 2018 AND 2020
    ORDER BY A.media_aval DESC;

SELECT Participacao.nome_pessoa, Participacao.data_nasc_pessoa, Indicacao.indicacao, Indicacao.premiado
    FROM (SELECT id_midia FROM Midia WHERE Midia.titulo = 'Avatar') M
    JOIN Participacao ON (M.id_midia = Participacao.id_midia AND Participacao.natureza = 'ATOR')
    LEFT JOIN Indicacao ON (Participacao.id_participacao = Indicacao.id_participacao);

-- SELECT Midia.titulo, AVG(Avaliacao.nota) AS media_aval FROM Avaliacao JOIN Midia ON (Avaliacao.id_midia = Midia.id_midia) GROUP BY Midia.titulo;

SELECT Midia_franquia.nome, AVG(A.media_aval) AS media_aval_franquia, SUM(A.nro_aval) AS qtd_aval_franquia
    FROM Midia
    JOIN (SELECT id_midia, COUNT(*) AS nro_aval, AVG(nota) AS media_aval FROM Avaliacao GROUP BY id_midia) A ON (Midia.id_midia = A.id_midia)
    JOIN Midia_Franquia ON (Midia.id_midia = Midia_Franquia.id_midia)
    GROUP BY Midia_franquia.nome
    ORDER BY media_aval_franquia;

SELECT Usuario.email, Usuario.nome,
    COUNT(Mod_Cadastro) AS mod_Cadastro, SUM(Mod_Cadastro.penalidade) AS penalidade_cadastro,
    COUNT(Mod_Edicao) AS mod_edicao, SUM(Mod_Edicao.penalidade) AS penalidade_edicao,
    COUNT(Mod_Comentario) AS mod_comentario, SUM(Mod_Comentario.penalidade) AS penalidade_comentario,
    COUNT(Mod_Avaliacao) AS mod_avaliacao, SUM(Mod_Avaliacao.penalidade) AS penalidade_avaliacao
    FROM Usuario
    LEFT JOIN Mod_Cadastro ON (Usuario.email = Mod_Cadastro.email_cadastrante)
    LEFT JOIN Mod_Edicao ON (Usuario.email = Mod_Edicao.email_editor)
    LEFT JOIN (
        Mod_Comentario JOIN Comentario ON (Mod_Comentario.id_comentario = Comentario.id_comentario)
    ) ON (Usuario.email = Comentario.email)
    LEFT JOIN Mod_Avaliacao ON (Usuario.email = Mod_Avaliacao.email_avaliador)
    GROUP BY Usuario.email, Usuario.nome;
