SELECT Midia.titulo, Midia.data_lancamento, A.media_aval, Midia_Franquia.nome AS franquia, Prod.nome_organizacao AS produtora FROM Midia
    JOIN (SELECT id_midia FROM Participacao WHERE nome_pessoa = 'Robert Downey Jr.' OR nome_pessoa = 'Ícaro Silva' AND natureza = 'ATOR') P ON (Midia.id_midia = P.id_midia)
    LEFT JOIN (SELECT id_midia, AVG(nota) AS media_aval FROM Avaliacao GROUP BY id_midia HAVING AVG(nota) > 2) A ON (Midia.id_midia = A.id_midia)
    JOIN (SELECT id_midia, nome_organizacao FROM Producao WHERE nome_organizacao = 'Marvel Studios' OR nome_organizacao = 'Storytel') Prod ON (Midia.id_midia = Prod.id_midia)
    LEFT JOIN Midia_Franquia ON (Midia.id_midia = Midia_Franquia.id_midia)
    WHERE DATE_PART('year', Midia.data_lancamento) BETWEEN 2018 AND 2020 ORDER BY A.media_aval DESC;

SELECT Midia.titulo, Midia.data_lancamento, A.media_aval, Midia_Franquia.nome AS franquia, Producao.nome_organizacao AS produtora FROM Midia
    JOIN Participacao ON (Midia.id_midia = Participacao.id_midia AND Participacao.nome_pessoa IN ('Robert Downey Jr.', 'Ícaro Silva') AND Participacao.natureza = 'ATOR')
    LEFT JOIN (SELECT id_midia, AVG(nota) AS media_aval FROM Avaliacao GROUP BY id_midia HAVING AVG(nota) > 2) A ON (Midia.id_midia = A.id_midia)
    JOIN Producao ON (Midia.id_midia = Producao.id_midia AND Producao.nome_organizacao IN ('Marvel Studios', 'Storytel'))
    LEFT JOIN Midia_Franquia ON (Midia.id_midia = Midia_Franquia.id_midia)
    WHERE DATE_PART('year', Midia.data_lancamento) BETWEEN 2018 AND 2020 ORDER BY A.media_aval DESC;
