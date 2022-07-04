INSERT INTO Usuario(email, nome, senha, tipo) VALUES
    ('mod@mod.me', 'mod', 'mod', 'MODERADOR'),
    ('mod2@mod.me', 'mod2', 'mod2', 'MODERADOR'),
    ('a@b.com', 'funalo23', 'senha123', 'USUARIO'),
    ('b@c.com', 'outro_fulano42', 'senhaforte', 'USUARIO'),
    ('c@d.com', 'ciclano1', 'minhasenha', 'USUARIO');

INSERT INTO Promocao(email_usuario, data, status) VALUES
    ('b@c.com', '2022-06-18', 'EM ANDAMENTO'),
    ('c@d.com', '2022-06-22', 'EM ANDAMENTO'),
    ('b@c.com', '2022-05-10', 'INDEFERIDA');

INSERT INTO Voto(email_usuario, data, email_moderador, voto) VALUES
    ('b@c.com', '2022-06-18', 'mod@mod.me', true),
    ('c@d.com', '2022-06-22', 'mod@mod.me', false),
    ('c@d.com', '2022-06-22', 'mod2@mod.me', true),
    ('b@c.com', '2022-05-10', 'mod@mod.me', true),
    ('b@c.com', '2022-05-10', 'mod2@mod.me', false);

INSERT INTO Midia(id_midia, titulo, data_lancamento, tipo, sinopse, status, nro_capitulos, duracao, plataforma) VALUES
    (
        '58d2a1b9-ab9d-41f1-93e4-b80073bcef99',
        'Avatar',
        '2009-12-18',
        'FILME', 
        'Um militar paraplégico despachado para a lua Pandora em uma missão única fica dividido entre seguir suas ordens e proteger o mundo que ele sente ser sua casa.',
        'FINALIZADA',
        NULL,
        '2h 2m',
        NULL
    ),
    (
        '05b4c947-7856-4a4c-ae85-4a1436b2cc31',
        'Avatar: O Caminho da Água',
        '2022-12-16',
        'FILME',
        'A sequela de Avatar.',
        'EM PRODUCAO',
        NULL,
        NULL,
        NULL
    ),
    (
        'c53b10f2-e0f9-49c5-a130-a0ac594d8611',
        'Avengers: Endgame',
        '2019-04-25',
        'FILME',
        'Após os eventos devastadores de Vingadores: Guerra Infinita , o universo está em ruínas, e com a ajuda de aliados os Vingadores se reúnem para desfazer as ações de Thanos e restaurar a ordem...',
        'FINALIZADA',
        NULL,
        '2h 21m',
        NULL
    ),
    (
        '95dfbb45-1c83-44a9-9593-e0b8c85a282a',
        'Sherlock Holmes',
        '2009-12-25',
        'FILME',
        'Quando uma série de assassinatos brutais aterroriza Londres, não demora muito para o lendário detetive Sherlock Holmes e seu parceiro solucionador de crimes, o Dr. Watson, encontrar o assassino, Lord Blackwood. Um devoto das artes das trevas, Blackwood tem um esquema maior em mente e sua execução está em seus planos. O jogo está em andamento quando Blackwood parece subir da sepultura, levando Holmes e Watson para o mundo das tecnologias ocultas e estranhas.',
        'FINALIZADA',
        NULL,
        '2h 9m',
        NULL
    ),
    (
        '1ff2ed2f-d9e4-4edd-825f-10c0e0d690ef',
        'Friends',
        '1994-09-22',
        'SERIE',
        'Relata a vida pessoal de seis amigos em seus trinta anos na cidade de Manhattan.',
        'FINALIZADA',
        NULL,
        NULL,
        NULL
    ),
    (
        '07abe988-4f6f-40c6-a985-c470371ba4ee',
        'Grey''s Anatomy',
        '2005-03-27',
        'SERIE',
        'Drama centrado na vida pessoal e profissional de cinco estagiários e seus supervisores.',
        'EM EXIBICAO',
        NULL,
        NULL,
        NULL
    ),
    (
        'db5e85db-25f6-4d3b-a78c-2c64bc4812fc',
        'The Legend of Zelda: Ocarina of Time',
        '1998-11-21',
        'JOGO',
        'Journey through the land of Hyrule in the Nintendo 64''s first installment in the Zelda universe, Legend of Zelda: The Ocarina of Time',
        'FINALIZADA',
        NULL,
        NULL,
        'Nintendo 64'
    ),
    (
        '92a8e48e-20c5-4269-addb-bc050a2711e6',
        'Harry Potter e a Pedra Filosofal',
        '2020-12-03',
        'AUDIOBOOK',
        'Uma criança órfã se matricula em uma escola de magia, onde ele aprende a verdade sobre si mesmo, sua família e o terrível mal que se esconde no mundo mágico.',
        'FINALIZADA',
        17,
        '8h 50m',
        NULL
    );

INSERT INTO Genero(nome) VALUES
    ('ação'),
    ('aventura'),
    ('fantasia'),
    ('ficção científica'),
    ('drama'),
    ('drama médico'),
    ('comédia romântica'),
    ('RPG');


INSERT INTO Midia_Genero(id_midia, genero) VALUES
    ('58d2a1b9-ab9d-41f1-93e4-b80073bcef99', 'ficção científica'),
    ('05b4c947-7856-4a4c-ae85-4a1436b2cc31', 'ficção científica'),
    ('c53b10f2-e0f9-49c5-a130-a0ac594d8611', 'ação'),
    ('c53b10f2-e0f9-49c5-a130-a0ac594d8611', 'fantasia'),
    ('1ff2ed2f-d9e4-4edd-825f-10c0e0d690ef', 'comédia romântica'),
    ('07abe988-4f6f-40c6-a985-c470371ba4ee', 'drama médico'),
    ('07abe988-4f6f-40c6-a985-c470371ba4ee', 'drama'),
    ('07abe988-4f6f-40c6-a985-c470371ba4ee', 'comédia romântica'),
    ('db5e85db-25f6-4d3b-a78c-2c64bc4812fc', 'ação'),
    ('db5e85db-25f6-4d3b-a78c-2c64bc4812fc', 'aventura'),
    ('db5e85db-25f6-4d3b-a78c-2c64bc4812fc', 'fantasia'),
    ('db5e85db-25f6-4d3b-a78c-2c64bc4812fc', 'RPG'),
    ('92a8e48e-20c5-4269-addb-bc050a2711e6', 'aventura'),
    ('92a8e48e-20c5-4269-addb-bc050a2711e6', 'fantasia');

INSERT INTO Temporada(id_midia, nro_temporada, nome, sinopse) VALUES
    ('1ff2ed2f-d9e4-4edd-825f-10c0e0d690ef', 1, 'Temporada 1', 'Após abandonar Barry, seu noivo, no altar, Rachel se muda para o apartamento de Monica, sua melhor amiga da época do colégio, e começa a trabalhar como garçonete no Central Perk. Ross, então, finalmente sente que esse é o momento de se declarar para Rachel, mas, enquanto tenta achar um jeito de fazer isso, precisa lidar com a chegada do primeiro filho com a ex-esposa. Joey continua insistindo na carreira de ator e Phoebe trabalha como massagista. Já Chandler decide terminar o namoro com Janice, logo descobrindo que isso será mais difícil do que parece.'),
    ('1ff2ed2f-d9e4-4edd-825f-10c0e0d690ef', 2, 'Temporada 2', 'Quando Ross retorna aos Estados Unidos, Rachel vai até o aeroporto se declarar para ele, mas acaba encontrando uma grande e nada agradável surpresa. Monica é demitida de seu trabalho como chef no restaurante e acaba conseguindo emprego como garçonete. Enquanto isso, Joey é escalado para um papel de destaque na novela Days of Our Lives e decide se mudar do apartamento que divide com Chandler, que passa a procurar por um novo colega de quarto.'),
    ('07abe988-4f6f-40c6-a985-c470371ba4ee', 1, 'Temporada 1', 'Meredith Grey (Ellen Pompeo) começa a trabalhar no Seattle Grace Hospital e logo descobre que passou a noite com um dos seus chefes, Dr. Derek Shepherd (Patrick Dempsey). Enquanto enfrenta os desafios da vida profissional, ela se aproxima dos outros internos liderados pela residente Dra. Bailey (Chandra Wilson): Cristina Yang (Sandra Oh), Izzie Stevens (Katherine Heigl), George O''Malley (T.R. Knight) e Alex Karev (Justin Chambers).'),
    ('07abe988-4f6f-40c6-a985-c470371ba4ee', 2, 'Temporada 2', 'No agitado Seattle Grace Hospital, a relação entre pacientes e médicos se tornam cada vez mais estreita à medida que os dias se passam. É aí que a Dra. Izzie (Katherine Heigl) se apaixona por Denny Duquette (Jeffrey Dean Morgan), um paciente em estado crítico. Além disso, Addison (Kate Walsh) e Mark Sloan (Eric Dane) integram a equipe do hospital.');

INSERT INTO Episodio(id_midia, nro_temporada, nro_episodio, nome, sinopse) VALUES
    ('1ff2ed2f-d9e4-4edd-825f-10c0e0d690ef', 1, 1, 'The Pilot', 'Monica fala com os rapazes sobre Paul, o cara do vinho, e ela jura que não está saindo com ele. Ross está depressivo, porque sua ex-mulher acabou de se mudar para viver com sua amante. Então, Rachel invade o Central Perk vestida de noiva, porque acabou de deixar o noivo plantado no altar. Rachel diz a seu pai que ficará com Monica, para a surpresa da irmã de Ross.'),
    ('1ff2ed2f-d9e4-4edd-825f-10c0e0d690ef', 1, 2, 'The One with the Sonogram at the End', 'Ross descobre que sua ex-mulher, Carol, está grávida dele. Ela e Susan (sua amante) querem que Ross faça parte da vida do bebê. Monica recebe seus pais para jantar e sofre com a delicada tortura imposta por sua mãe. Rachel decide devolver a aliança a Barry (seu ex-noivo), mas quando ela chega a seu consultório, descobre que ele começou a ter um relacionamento com uma de suas madrinhas, Mindy. Ross acompanha Carol e Susan até o ginecologista e vê o ultrassom de seu bebê.'),
    ('07abe988-4f6f-40c6-a985-c470371ba4ee', 1, 1, 'A Hard Day''s Night', 'Meredith Grey acorda depois de uma noite para começar seu primeiro turno como interna de cirurgia. O primeiro turno para os novos internos cirúrgicos Meredith Grey (Ellen Pompeo), Cristina Yang (Sandra Oh), Izzie Stevens (Katherine Heigl), George O''Malley (T.R. Knight) e Alex Karev (Justin Chambers) é memorável. Enquanto trabalha, Meredith percebe que o cara de sua noite anterior é o Dr. Derek Shepherd. Derek pede a um interno que resolva o caso de um adolescente que tenha convulsões. Meredith e Christina percebem que ela tem um aneurisma que foi causado por uma queda. À luz dessa percepção, Derek escolhe Meredith para auxiliar em sua cirurgia, mesmo que Meredith tenha dito a Christina que ela podia.'),
    ('07abe988-4f6f-40c6-a985-c470371ba4ee', 1, 2, 'The First Cut Is the Deepest', 'Meredith procura por colegas de quarto para compartilhar a casa de sua mãe, mas inicialmente não quer ficar com Izzie e George. Derek e Meredith atendem a uma vítima de estupro. Ao olhar para bebês recém-nascidos no hospital, Meredith e George descobrem uma doença com um bebê recém-nascido, mas uma enfermeira tenta rejeitar suas preocupações. Izzie Stevens ajuda uma mulher chinesa cuja filha precisa de cuidados médicos. Derek e Burke discutem sobre o cargo de chefe de cirurgia.');

INSERT INTO Franquia(nome, descricao) VALUES
    ('Avatar', 'Franquia de filmes Avatar'),
    ('Vingadores', 'Franquia de filmes Vingadores'),
    ('The Legend of Zelda', 'Franquia de jogos The Legend of Zelda'),
    ('Harry Potter', 'Franquia de livros e filmes Harry Potter');

INSERT INTO Midia_Franquia(id_midia, nome) VALUES
    ('58d2a1b9-ab9d-41f1-93e4-b80073bcef99', 'Avatar'),
    ('05b4c947-7856-4a4c-ae85-4a1436b2cc31', 'Avatar'),
    ('c53b10f2-e0f9-49c5-a130-a0ac594d8611', 'Vingadores'),
    ('db5e85db-25f6-4d3b-a78c-2c64bc4812fc', 'The Legend of Zelda'),
    ('92a8e48e-20c5-4269-addb-bc050a2711e6', 'Harry Potter');

INSERT INTO Interessa(email, id_midia) VALUES
    ('a@b.com', '58d2a1b9-ab9d-41f1-93e4-b80073bcef99'),
    ('a@b.com', '92a8e48e-20c5-4269-addb-bc050a2711e6'),
    ('c@d.com', 'c53b10f2-e0f9-49c5-a130-a0ac594d8611'),
    ('c@d.com', '1ff2ed2f-d9e4-4edd-825f-10c0e0d690ef'),
    ('c@d.com', '58d2a1b9-ab9d-41f1-93e4-b80073bcef99');

INSERT INTO Pessoa(nome, data_nasc, biografia, eh_ator, eh_diretor, eh_autor) VALUES
    (
        'Robert Downey Jr.',
        '1965-04-04',
        'Robert Downey Jr. é um ator, cantor, compositor e pianista americano. Estreou como ator em 1970 aos 5 anos, no filme Pound, dirigido por seu pai, Robert Downey, Sr., e desde então tem atuado constantemente em trabalhos para televisão, cinema e ópera.',
        true,
        false,
        false
    ),
    (
        'J. K. Rowling',
        '1965-07-31',
        'J. K. Rowling é uma escritora britânica, autora da série "Harry Potter", que conquistou o público jovem e vendeu milhões de exemplares.',
        false,
        false,
        true
    ),
    (
        'James Cameron',
        '1954-08-16',
        'James Francis Cameron é um cineasta, produtor, roteirista e editor canadense. É bacharel em Física pela Universidade da Califórnia e também explorador dos fundos oceânicos, tendo sido, em 26 de março de 2012, o primeiro homem a descer sozinho num batiscafo ao fundo da Fossa das Marianas',
        false,
        true,
        true
    ),
    (
        'Ícaro Silva',
        '1987-03-19',
        'Ícaro Silva é um ator, músico, modelo e escritor brasileiro. Aos 8 anos lançou seu primeiro livro, Três Historinhas de Ícaro Silva, em seguida lançou os livros O Peixe Dourado e Aventuras de Geva. Começou a atuar aos 11 anos na novela Meu Pé de Laranja Lima em 1998 na Band.',
        true,
        false,
        true
    );

INSERT INTO Participacao(id_participacao, id_midia, nome_pessoa, data_nasc_pessoa, natureza, descricao) VALUES
    ('9387f72c-593b-48a3-be44-a33b1429a2b0', 'c53b10f2-e0f9-49c5-a130-a0ac594d8611', 'Robert Downey Jr.', '1965-04-04', 'ATOR', 'Protagonista'),
    ('402cc123-7463-4db9-a935-64877b81eeb0', '58d2a1b9-ab9d-41f1-93e4-b80073bcef99', 'James Cameron', '1954-08-16', 'DIRETOR', NULL),
    ('f6a92cf4-7a6e-4a8f-bb5b-8122860c6294', '05b4c947-7856-4a4c-ae85-4a1436b2cc31', 'James Cameron', '1954-08-16', 'DIRETOR', NULL),
    ('7f7ef2eb-5fe2-42a1-b2cc-5e0757f36c9f', '92a8e48e-20c5-4269-addb-bc050a2711e6', 'J. K. Rowling', '1965-07-31', 'AUTOR', NULL),
    ('15247e42-1257-4237-8257-acdce17945a4', '92a8e48e-20c5-4269-addb-bc050a2711e6', 'Ícaro Silva', '1987-03-19', 'ATOR', 'Narrador'),
    ('2fb7b6cb-37a9-44e8-9703-2d9e2c3cc196', '95dfbb45-1c83-44a9-9593-e0b8c85a282a', 'Robert Downey Jr.', '1965-04-04', 'ATOR', 'Protagonista');

INSERT INTO Indicacao(id_participacao, indicacao, premiado) VALUES
    ('9387f72c-593b-48a3-be44-a33b1429a2b0', 'Oscar de melhor ator em filme de ação', false),
    ('402cc123-7463-4db9-a935-64877b81eeb0', 'Oscar de melhor direção', true);

INSERT INTO Organizacao(nome, data_fundacao, descricao, eh_produtora, eh_distribuidora, eh_gravadora, eh_desenvolvedora) VALUES
    (
        'Marvel Studios',
        '1993-12-07',
        'Marvel Studios é um estúdio de cinema norte-americano parte do conglomerado The Walt Disney Company. Marvel Studios trabalha em conjunto com a Walt Disney Studios para distribuição e marketing. Tem o produtor de cinema Kevin Feige como presidente.',
        true,
        false,
        false,
        false
    ),
    (
        'Walt Disney Studios Motion Pictures',
        '1953-06-23',
        'Walt Disney Studios Motion Pictures é uma distribuidora americana de filmes, pertencente à The Walt Disney Company.',
        false,
        true,
        false,
        false
    ),
    (
        'Nintendo Entertainment Analysis & Development',
        '1983-09-30',
        'Nintendo Entertainment Analysis & Development (ou EAD; antes Research & Development Team 4) foi a principal divisão de desenvolvimento de jogos eletrônicos dentro da Nintendo.',
        false,
        false,
        false,
        true
    ),
    (
        'Storytel',
        '2005-01-01',
        'A Storytel é um dos maiores serviços de streaming de audiobooks e e-books com assinatura do mundo e oferece mais de 500.000 títulos para ouvir e ler, em escala global.',
        true,
        true,
        true,
        false
    );

INSERT INTO Producao(id_midia, nome_organizacao, data_fundacao_organizacao) VALUES
    ('c53b10f2-e0f9-49c5-a130-a0ac594d8611', 'Marvel Studios', '1993-12-07'),
    ('92a8e48e-20c5-4269-addb-bc050a2711e6', 'Storytel', '2005-01-01');

INSERT INTO Avaliacao(email, id_midia, nota, conteudo) VALUES
    ('a@b.com', '58d2a1b9-ab9d-41f1-93e4-b80073bcef99', 5, 'Filme muito legal! Ótimos efeitos especiais.'),
    ('c@d.com', 'c53b10f2-e0f9-49c5-a130-a0ac594d8611', 1, 'Horrível.'),
    ('a@b.com', 'c53b10f2-e0f9-49c5-a130-a0ac594d8611', 5, NULL),
    ('b@c.com', 'c53b10f2-e0f9-49c5-a130-a0ac594d8611', 4, NULL),
    ('a@b.com', '1ff2ed2f-d9e4-4edd-825f-10c0e0d690ef', 5, NULL);

INSERT INTO Mod_Avaliacao(email, email_avaliador, id_midia, data, acao, motivo, penalidade) VALUES
    (
        'mod@mod.me',
        'a@b.com',
        '58d2a1b9-ab9d-41f1-93e4-b80073bcef99',
        '2022-06-12',
        'CENSURADO',
        'Contém links que redirecionam a sites que promovem pirataria',
        1
    ),
    (
        'mod2@mod.me',
        'c@d.com',
        'c53b10f2-e0f9-49c5-a130-a0ac594d8611',
        '2022-06-19',
        'CENSURADO',
        'Discurso de ódio',
        3
    );

INSERT INTO Edicao(email, id_midia, data_edicao, conteudo) VALUES
    (
        'a@b.com',
        '58d2a1b9-ab9d-41f1-93e4-b80073bcef99',
        '2022-06-02',
        'Um militar paraplégico despachado para a lua Pandora em uma missão única fica dividido entre seguir suas ordens e proteger o mundo que ele sente ser sua casa.'
    ),
    (
        'c@d.com',
        'db5e85db-25f6-4d3b-a78c-2c64bc4812fc',
        '2022-05-15',
        'A história segue o protagonista Link enquanto explora um arquipélago no meio de um vasto oceano à procura de sua irmã, que foi sequestrada e está nas mãos do maligno feiticeiro Ganon. Em sua jornada ele é auxiliado por uma capitã pirata chamada Tetra e por um barco falante chamado Rei dos Leões Vermelhos'
    ),
    (
        'b@c.com',
        'db5e85db-25f6-4d3b-a78c-2c64bc4812fc',
        '2022-05-28',
        'Journey through the land of Hyrule in the Nintendo 64''s first installment in the Zelda universe, Legend of Zelda: The Ocarina of Time.'
    );

INSERT INTO Mod_Edicao(email, email_editor, id_midia, data_edicao, data, acao, motivo, penalidade) VALUES 
    (
        'mod2@mod.me',
        'a@b.com',
        '58d2a1b9-ab9d-41f1-93e4-b80073bcef99',
        '2022-06-02',
        '2022-06-08',
        'CENSURADO',
        'Contém links externos',
        0
    ),
    (
        'mod@mod.me',
        'c@d.com',
        'db5e85db-25f6-4d3b-a78c-2c64bc4812fc',
        '2022-05-15',
        '2022-05-16',
        'EXCLUIDO',
        'Informações erradas',
        0
    );

INSERT INTO Cadastro(email, id_midia, data_cadastro, aprovado) VALUES
    ('a@b.com', '58d2a1b9-ab9d-41f1-93e4-b80073bcef99', '2022-05-01', true),
    ('a@b.com', '05b4c947-7856-4a4c-ae85-4a1436b2cc31', '2022-06-08', false),
    ('b@c.com', 'c53b10f2-e0f9-49c5-a130-a0ac594d8611', '2022-06-02', true),
    ('b@c.com', '1ff2ed2f-d9e4-4edd-825f-10c0e0d690ef', '2022-05-04', true),
    ('b@c.com', '07abe988-4f6f-40c6-a985-c470371ba4ee', '2022-05-06', true),
    ('b@c.com', 'db5e85db-25f6-4d3b-a78c-2c64bc4812fc', '2022-05-03', true),
    ('b@c.com', '92a8e48e-20c5-4269-addb-bc050a2711e6', '2022-05-01', true);

INSERT INTO Mod_Cadastro(email, email_cadastrante, id_midia, data, acao, motivo, penalidade) VALUES
    (
        'mod@mod.me',
        'a@b.com',
        '58d2a1b9-ab9d-41f1-93e4-b80073bcef99',
        '2022-05-02',
        'CENSURADO',
        'Informações erradas',
        0
    ),
    (
        'mod2@mod.me',
        'b@c.com',
        '92a8e48e-20c5-4269-addb-bc050a2711e6',
        '2022-05-03',
        'CENSURADO',
        'Informações erradas',
        0
    );

INSERT INTO Comentario(id_comentario, email, id_midia, data, conteudo, id_comentario_respondido) VALUES
    (
        'f73782e2-96c7-4a51-abb2-c046b8a3e9b7',
        'c@d.com',
        '05b4c947-7856-4a4c-ae85-4a1436b2cc31',
        '2022-06-20',
        'alguém sabe qnd vai lançar?',
        NULL
    ),
    (
        'd13a1650-de5d-4a44-b3af-1f6b447c5d8c',
        'a@b.com',
        '05b4c947-7856-4a4c-ae85-4a1436b2cc31',
        '2022-06-22',
        'A previsão é lançar no fim do ano',
        'f73782e2-96c7-4a51-abb2-c046b8a3e9b7'
    ),
    (
        'bc07e6da-8c28-4bcf-9a96-e3466ab51536',
        'b@c.com',
        '07abe988-4f6f-40c6-a985-c470371ba4ee',
        '2022-06-12',
        'E essa série que nunca acaba?',
        NULL
    ),
    (
        'b694ab94-0bb6-48ce-8ddf-df2577003156',
        'b@c.com',
        '92a8e48e-20c5-4269-addb-bc050a2711e6',
        '2022-06-25',
        'Dá pra baixar de graça nesse site: http://recifedoscorsarios.sh/audiobooks/harr124adc',
        NULL
    ),
    (
        '1562191a-0fc5-4a0b-b2b9-9b8c4e992c55',
        'c@d.com',
        '92a8e48e-20c5-4269-addb-bc050a2711e6',
        '2022-06-22',
        'Ganhe dinheiro fácil: http://ww3.ganhando-dinheiro-em-casa.win',
        NULL
    );

INSERT INTO Reacao(email_reagente, id_comentario, reacao) VALUES
    ('c@d.com', 'd13a1650-de5d-4a44-b3af-1f6b447c5d8c', 's'),
    ('a@b.com', 'bc07e6da-8c28-4bcf-9a96-e3466ab51536', 'r'),
    ('c@d.com', 'bc07e6da-8c28-4bcf-9a96-e3466ab51536', 'r');

INSERT INTO Mod_Comentario(email, id_comentario, data, acao, motivo, penalidade) VALUES
    (
        'mod@mod.me',
        'b694ab94-0bb6-48ce-8ddf-df2577003156',
        '2022-06-26',
        'EXCLUIDO',
        'Promove pirataria com links externos',
        1
    ),
    (
        'mod2@mod.me',
        '1562191a-0fc5-4a0b-b2b9-9b8c4e992c55',
        '2022-06-22',
        'EXCLUIDO',
        'Spam',
        1
    );
