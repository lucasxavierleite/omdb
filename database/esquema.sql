CREATE TABLE Usuario (
  email VARCHAR(255),
  nome VARCHAR(20) NOT NULL UNIQUE,
  -- usernames com no máximo 20 caracteres
  senha VARCHAR(255) NOT NULL,
  -- Verificar qual hash sera usado
  tipo CHAR(9) DEFAULT 'USUARIO' CHECK (UPPER(tipo) IN ('USUARIO', 'MODERADOR')),
  CONSTRAINT PK_Usuario PRIMARY KEY (email)
);

CREATE TABLE Promocao (
  email_usuario VARCHAR(255),
  data TIMESTAMP,
  status CHAR(12) DEFAULT 'EM ANDAMENTO' CHECK (
    UPPER(status) IN ('EM ANDAMENTO', 'INDEFERIDA', 'APROVADA')
  ),
  CONSTRAINT PK_Promocao PRIMARY KEY (email_usuario, data),
  CONSTRAINT FK_Promocao_Usuario FOREIGN KEY (email_usuario) REFERENCES Usuario(email) ON DELETE CASCADE ON UPDATE CASCADE
  -- Nao faz sentido promoçao ser bloqueante para exclusao ou alteracao de usuario. Tambem nao faz sentido exitir promoçao para um usuario que nao existe ou que foi alterado. Por esses motivos CASCADE foi utilizado
);

CREATE TABLE Voto (
  email_usuario VARCHAR(255),
  data TIMESTAMP,
  email_moderador VARCHAR(255),
  voto BOOLEAN NOT NULL,
  CONSTRAINT PK_Voto PRIMARY KEY (email_usuario, data, email_moderador),
  CONSTRAINT FK_Voto_Promocao FOREIGN KEY (email_usuario, data) REFERENCES Promocao(email_usuario, data) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT FK_Voto_Moderador FOREIGN KEY (email_moderador) REFERENCES Usuario(email) ON DELETE RESTRICT ON UPDATE CASCADE
  -- Como eh necessario manter historico de votos, pois são acoes de grande seriedade, nao deve-se permitir a exclusao da promoçao que ja possui votos ou do moderador que votou. Por esses motivos RESTRICT foi utilizado
);

CREATE TABLE Midia (
  id_midia UUID DEFAULT gen_random_uuid(),
  titulo VARCHAR(255) NOT NULL,
  data_lancamento DATE NOT NULL,
  -- Usar INTERVAL YEAR gastaria mais espaço e teria o mesmo efeito
  tipo CHAR(9) DEFAULT 'GENERICA' CHECK (
    UPPER(tipo) IN (
      'GENERICA',
      'AUDIOBOOK',
      'JOGO',
      'FILME',
      'SERIE'
    )
  ),
  sinopse TEXT,
  status CHAR(11) NOT NULL,
  nro_capitulos INTEGER,
  duracao INTERVAL SECOND,
  plataforma VARCHAR(255),
  CONSTRAINT PK_Midia PRIMARY KEY (id_midia),
  CONSTRAINT UQ_Midia UNIQUE (titulo, data_lancamento),
  CONSTRAINT CK_Midia_Status CHECK (
    (
      UPPER(status) IN ('EM PRODUCAO', 'FINALIZADA', 'CANCELADA')
    )
    OR (
      UPPER(tipo) = 'SERIE'
      AND UPPER(status) = 'EM EXIBICAO'
    )
  )
  -- CONSTRAINT CK_Midia_Duracao CHECK (duracao IS NULL OR UPPER(tipo) IN ('AUDIOBOOK', 'FILME')),
  -- CONSTRAINT CK_Midia_Plataforma CHECK (plataforma IS NULL OR UPPER(tipo) == 'JOGO'),
  -- CONSTRAINT CK_Midia_Nro_Cap CHECK (nro_capitulos IS NULL OR UPPER(tipo) == 'AUDIOBOOK'),
  -- Caso fosse especializacao com totalidade, tais CHEK's fariam sentido
);

CREATE TABLE Genero (
  nome VARCHAR(50),
  CONSTRAINT PK_Genero PRIMARY KEY (nome)
);

CREATE TABLE Midia_Genero (
  id_midia UUID,
  genero VARCHAR(50),
  CONSTRAINT PK_Midia_Genero PRIMARY KEY (id_midia, genero),
  CONSTRAINT FK_Midia_Genero_Midia FOREIGN KEY (id_midia) REFERENCES Midia(id_midia) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT FK_Midia_Genero_Genero FOREIGN KEY (genero) REFERENCES Genero(nome) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Temporada (
  id_midia UUID,
  nro_temporada INTEGER,
  nome VARCHAR(255),
  sinopse TEXT,
  CONSTRAINT PK_Temporada PRIMARY KEY (id_midia, nro_temporada),
  CONSTRAINT FK_Temporada_Midia FOREIGN KEY (id_midia) REFERENCES Midia(id_midia) ON DELETE CASCADE ON UPDATE CASCADE
  -- Não faz sentido existir temporada para midia que nao existe ou que foi alterada. Por esses motivos CASCADE foi utilizado
);

CREATE TABLE Episodio (
  id_midia UUID,
  nro_temporada INTEGER,
  nro_episodio INTEGER,
  nome VARCHAR(255),
  sinopse TEXT,
  CONSTRAINT PK_Episodio PRIMARY KEY (id_midia, nro_temporada, nro_episodio),
  CONSTRAINT FK_Episodio_Midia FOREIGN KEY (id_midia) REFERENCES Midia(id_midia) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT FK_Episodio_Temporada FOREIGN KEY (id_midia, nro_temporada) REFERENCES Temporada(id_midia, nro_temporada) ON DELETE CASCADE ON UPDATE CASCADE
  -- Não faz sentido existir episodio para midia ou temporada que nao existe ou que foi alterada. Por esses motivos CASCADE foi utilizado
);

CREATE TABLE Franquia (
  nome VARCHAR(255),
  descricao TEXT,
  CONSTRAINT PK_Franquia PRIMARY KEY (nome)
);

CREATE TABLE Midia_Franquia (
  id_midia UUID,
  nome VARCHAR(255),
  CONSTRAINT PK_Midia_Franquia PRIMARY KEY (id_midia, nome),
  CONSTRAINT FK_Midia_Franquia_Midia FOREIGN KEY (id_midia) REFERENCES Midia(id_midia) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT FK_Midia_Franquia_Franquia FOREIGN KEY (nome) REFERENCES Franquia(nome) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Interessa (
  email VARCHAR(255),
  id_midia UUID,
  CONSTRAINT PK_Interessa PRIMARY KEY (email, id_midia),
  CONSTRAINT FK_Interessa_Usuario FOREIGN KEY (email) REFERENCES Usuario(email) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT FK_Interessa_Midia FOREIGN KEY (id_midia) REFERENCES Midia(id_midia) ON DELETE CASCADE ON UPDATE CASCADE
  -- Nao faz sentido existir interesse para midia que nao existe ou que foi alterada. Por esses motivos CASCADE foi utilizado
  -- Não faz sentido existir interesse de usuario que nao existe ou que foi alterado. Por esses motivos CASCADE foi utilizado
);

CREATE TABLE Pessoa (
  nome VARCHAR(255),
  data_nasc DATE,
  biografia TEXT,
  eh_ator BOOLEAN,
  eh_diretor BOOLEAN,
  eh_autor BOOLEAN,
  CONSTRAINT PK_Pessoa PRIMARY KEY (nome, data_nasc),
  CONSTRAINT CK_Pessoa_PartTotal CHECK (
    eh_ator = TRUE
    OR eh_diretor = TRUE
    OR eh_autor = TRUE
  )
);

CREATE TABLE Participacao (
  id_participacao UUID DEFAULT gen_random_uuid(),
  id_midia UUID NOT NULL,
  nome_pessoa VARCHAR(255) NOT NULL,
  data_nasc_pessoa DATE NOT NULL,
  natureza CHAR(7) NOT NULL CHECK (
    UPPER(natureza) IN ('ATOR', 'DIRETOR', 'AUTOR')
  ),
  descricao TEXT,
  CONSTRAINT PK_Participacao PRIMARY KEY (id_participacao),
  CONSTRAINT UQ_Participacao UNIQUE (id_midia, nome_pessoa, data_nasc_pessoa, natureza),
  CONSTRAINT FK_Participacao_Midia FOREIGN KEY (id_midia) REFERENCES Midia(id_midia) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT FK_Participacao_Pessoa FOREIGN KEY (nome_pessoa, data_nasc_pessoa) REFERENCES Pessoa(nome, data_nasc) ON DELETE CASCADE ON UPDATE CASCADE
  -- Não faz sentido existir participacao para midia que nao existe ou que foi alterada. Por esses motivos CASCADE foi utilizado
  -- Não faz sentido existir participacao de pessoa que nao existe ou que foi alterado. Por esses motivos CASCADE foi utilizado
);

CREATE TABLE Indicacao (
  id_participacao UUID,
  indicacao VARCHAR(255),
  premiado BOOLEAN DEFAULT FALSE,
  CONSTRAINT PK_Indicacao PRIMARY KEY (id_participacao, indicacao),
  CONSTRAINT FK_Indicacao_Participacao FOREIGN KEY (id_participacao) REFERENCES Participacao(id_participacao) ON DELETE CASCADE ON UPDATE CASCADE
  -- Não faz sentido existir indicacao para participacao que nao existe ou que foi alterada. Por esses motivos CASCADE foi utilizado
);

CREATE table Organizacao (
  nome VARCHAR(255),
  data_fundacao DATE,
  descricao TEXT,
  eh_produtora BOOLEAN,
  eh_distribuidora BOOLEAN,
  eh_gravadora BOOLEAN,
  eh_desenvolvedora BOOLEAN,
  CONSTRAINT PK_Organizacao PRIMARY KEY (nome, data_fundacao),
  CONSTRAINT CK_Organizacao_PartTotal CHECK (
    eh_produtora = TRUE
    OR eh_distribuidora = TRUE
    OR eh_gravadora = TRUE
    OR eh_desenvolvedora = TRUE
  )
);

CREATE TABLE Producao (
  id_midia UUID,
  nome_organizacao VARCHAR(255),
  data_fundacao_organizacao DATE,
  CONSTRAINT PK_Producao PRIMARY KEY (
    id_midia,
    nome_organizacao,
    data_fundacao_organizacao
  ),
  CONSTRAINT FK_Producao_Midia FOREIGN KEY (id_midia) REFERENCES Midia(id_midia) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT FK_Producao_Organizacao FOREIGN KEY (nome_organizacao, data_fundacao_organizacao) REFERENCES Organizacao(nome, data_fundacao) ON DELETE CASCADE ON UPDATE CASCADE
  -- Não faz sentido existir producao para midia que nao existe ou que foi alterada. Por esses motivos CASCADE foi utilizado
  -- Não faz sentido existir producao de organizacao que nao existe ou que foi alterada. Por esses motivos CASCADE foi utilizado
);

Create TABLE Avaliacao (
  email VARCHAR(255),
  id_midia UUID,
  nota INTEGER NOT NULL CHECK (
    nota >= 0
    AND nota <= 5
  ),
  conteudo TEXT,
  CONSTRAINT PK_Avaliacao PRIMARY KEY (email, id_midia),
  CONSTRAINT FK_Avaliacao_Usuario FOREIGN KEY (email) REFERENCES Usuario(email) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT FK_Avaliacao_Midia FOREIGN KEY (id_midia) REFERENCES Midia(id_midia) ON DELETE CASCADE ON UPDATE CASCADE
  -- Nao faz sentido existir avaliacao para midia que nao existe ou que foi alterada. Por esses motivos CASCADE foi utilizado
  -- Nao faz sentido existir avaliacao de usuario que nao existe ou que foi alterado. Por esses motivos CASCADE foi utilizado
);

CREATE TABLE Mod_Avaliacao (
  email VARCHAR(255),
  email_avaliador VARCHAR(255),
  id_midia UUID,
  data TIMESTAMP,
  acao char(9) NOT NULL CHECK (UPPER(acao) IN ('EXCLUIDO', 'CENSURADO')),
  motivo TEXT NOT NULL,
  penalidade INTEGER NOT NULL CHECK (
    penalidade >= 0
    AND penalidade <= 5
  ),
  CONSTRAINT PK_Mod_Avaliacao PRIMARY KEY (email, email_avaliador, id_midia, data),
  CONSTRAINT FK_Mod_Avaliacao_Usuario FOREIGN KEY (email) REFERENCES Usuario(email) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT FK_Mod_Avaliacao_Avaliacao FOREIGN KEY (email_avaliador, id_midia) REFERENCES Avaliacao(email, id_midia) ON DELETE RESTRICT ON UPDATE CASCADE
  -- Como eh necessario manter historico de moderaçoes, pois são acoes de grande seriedade, nao deve-se permitir a exclusao do usuario moderador ou da avaliação moderada enquanto essa moderação existir, por esse motivo RESTRICT foi utilizado
);

CREATE TABLE Edicao (
  email VARCHAR(255),
  id_midia UUID,
  data_edicao TIMESTAMP,
  conteudo TEXT NOT NULL,
  -- Conteudo da edicao é basicamente um diff
  CONSTRAINT PK_Edicao PRIMARY KEY (email, id_midia, data_edicao),
  CONSTRAINT FK_Edicao_Usuario FOREIGN KEY (email) REFERENCES Usuario(email) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT FK_Edicao_Midia FOREIGN KEY (id_midia) REFERENCES Midia(id_midia) ON DELETE CASCADE ON UPDATE CASCADE
  -- Nao faz sentido existir edicao para midia que nao existe ou que foi alterada. Por esses motivos CASCADE foi utilizado
  -- Nao faz sentido existir edicao de usuario que nao existe ou que foi alterado. Por esses motivos CASCADE foi utilizado
);

CREATE TABLE Mod_Edicao (
  email VARCHAR(255),
  email_editor VARCHAR(255),
  id_midia UUID,
  data_edicao TIMESTAMP,
  data TIMESTAMP,
  acao char(9) NOT NULL CHECK (UPPER(acao) IN ('EXCLUIDO', 'CENSURADO')),
  motivo TEXT NOT NULL,
  penalidade INTEGER NOT NULL CHECK (
    penalidade >= 0
    AND penalidade <= 5
  ),
  CONSTRAINT PK_Mod_Edicao PRIMARY KEY (email, email_editor, id_midia, data_edicao, data),
  CONSTRAINT FK_Mod_Edicao_Usuario FOREIGN KEY (email) REFERENCES Usuario(email) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT FK_Mod_Edicao_Edicao FOREIGN KEY (email_editor, id_midia, data_edicao) REFERENCES Edicao(email, id_midia, data_edicao) ON DELETE RESTRICT ON UPDATE CASCADE
  -- Como eh necessario manter historico de moderaçoes, pois são acoes de grande seriedade, nao deve-se permitir a exclusao do usuario moderador ou da edicao moderada enquanto essa moderação existir, por esse motivo RESTRICT foi utilizado
);

CREATE TABLE Cadastro (
  email VARCHAR(255),
  id_midia UUID,
  data_cadastro TIMESTAMP,
  aprovado BOOLEAN DEFAULT FALSE,
  CONSTRAINT PK_Cadastro PRIMARY KEY (email, id_midia),
  CONSTRAINT FK_Cadastro_Usuario FOREIGN KEY (email) REFERENCES Usuario(email) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT FK_Cadastro_Midia FOREIGN KEY (id_midia) REFERENCES Midia(id_midia) ON DELETE CASCADE ON UPDATE CASCADE
  -- Nao faz sentido existir cadastro para midia que nao existe ou que foi alterada. Por esses motivos CASCADE foi utilizado
  -- Nao faz sentido existir cadastro de usuario que nao existe ou que foi alterado. Por esses motivos CASCADE foi utilizado
);

CREATE TABLE Mod_Cadastro (
  email VARCHAR(255),
  email_cadastrante VARCHAR(255),
  id_midia UUID,
  data TIMESTAMP,
  acao char(9) NOT NULL CHECK (UPPER(acao) IN ('EXCLUIDO', 'CENSURADO')),
  motivo TEXT NOT NULL,
  penalidade INTEGER NOT NULL CHECK (
    penalidade >= 0
    AND penalidade <= 5
  ),
  CONSTRAINT PK_Mod_Cadastro PRIMARY KEY (email, email_cadastrante, id_midia, data),
  CONSTRAINT FK_Mod_Cadastro_Usuario FOREIGN KEY (email) REFERENCES Usuario(email) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT FK_Mod_Cadastro_Cadastro FOREIGN KEY (email_cadastrante, id_midia) REFERENCES Cadastro(email, id_midia) ON DELETE RESTRICT ON UPDATE CASCADE
  -- Como eh necessario manter historico de moderaçoes, pois são acoes de grande seriedade, nao deve-se permitir a exclusao do usuario moderador ou do cadastro moderado enquanto essa moderação existir, por esse motivo RESTRICT foi utilizado
);

CREATE TABLE Comentario (
  id_comentario UUID DEFAULT gen_random_uuid(),
  email VARCHAR(255) NOT NULL,
  id_midia UUID NOT NULL,
  data TIMESTAMP NOT NULL,
  conteudo TEXT NOT NULL,
  id_comentario_respondido UUID,
  CONSTRAINT PK_Comentario PRIMARY KEY (id_comentario),
  CONSTRAINT UQ_Comentario UNIQUE (email, id_midia, data),
  CONSTRAINT FK_Comentario_Usuario FOREIGN KEY (email) REFERENCES Usuario(email) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT FK_Comentario_Midia FOREIGN KEY (id_midia) REFERENCES Midia(id_midia) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT FK_Comentario_Comentario FOREIGN KEY (id_comentario_respondido) REFERENCES Comentario(id_comentario) ON DELETE CASCADE ON UPDATE CASCADE
  -- Nao faz sentido existir comentario para midia que nao existe ou que foi alterada. Por esses motivos CASCADE foi utilizado
  -- Nao faz sentido existir comentario de usuario que nao existe ou que foi alterado. Por esses motivos CASCADE foi utilizado
  -- Nao faz sentido existir comentario resposta de comentario que nao existe ou que foi alterado. Por esses motivos CASCADE foi utilizado
);

CREATE TABLE Reacao (
  email_reagente VARCHAR(255),
  id_comentario UUID,
  reacao char(1) NOT NULL,
  -- Reação é um emoji
  CONSTRAINT PK_Reacao PRIMARY KEY (email_reagente, id_comentario),
  CONSTRAINT FK_Reacao_Usuario FOREIGN KEY (email_reagente) REFERENCES Usuario(email) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT FK_Reacao_Comentario FOREIGN KEY (id_comentario) REFERENCES Comentario(id_comentario) ON DELETE CASCADE ON UPDATE CASCADE
  -- Nao faz sentido existir reacao de usuario que nao existe ou que foi alterado. Por esses motivos CASCADE foi utilizado
  -- Nao faz sentido existir reacao de comentario que nao existe ou que foi alterado. Por esses motivos CASCADE foi utilizado
);

CREATE TABLE Mod_Comentario (
  email VARCHAR(255),
  id_comentario UUID,
  data TIMESTAMP,
  acao char(9) NOT NULL CHECK (UPPER(acao) IN ('EXCLUIDO', 'CENSURADO')),
  motivo TEXT NOT NULL,
  penalidade INTEGER NOT NULL CHECK (
    penalidade >= 0
    AND penalidade <= 5
  ),
  CONSTRAINT PK_Mod_Comentario PRIMARY KEY (email, id_comentario, data),
  CONSTRAINT FK_Mod_Comentario_Usuario FOREIGN KEY (email) REFERENCES Usuario(email) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT FK_Mod_Comentario_Comentario FOREIGN KEY (id_comentario) REFERENCES Comentario(id_comentario) ON DELETE RESTRICT ON UPDATE CASCADE
  -- Como eh necessario manter historico de moderaçoes, pois são acoes de grande seriedade, nao deve-se permitir a exclusao do usuario moderador ou do comentario moderado enquanto essa moderação existir, por esse motivo RESTRICT foi utilizado
);
