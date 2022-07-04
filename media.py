from myUtils import *
import psycopg2
from prettytable import from_db_cursor


def insertMediaGenero(cursor, connection, mediaId):
    genero = readString("Gênero: ", 50)
    try:
        cursor.execute("SELECT * FROM Genero WHERE nome = %s", (genero,))
        if cursor.rowcount == 0:
            cursor.execute("INSERT INTO Genero(nome) VALUES (%s)", (genero,))
        cursor.execute(
            "INSERT INTO Midia_Genero(id_midia, genero) VALUES (%s, %s)", (mediaId, genero))
        connection.commit()
    except psycopg2.errors.UniqueViolation:
        connection.rollback()
        print("Gênero já existe para mídia!")
    except Exception as e:
        print(e)
        print("Erro ao inserir gênero!")
        return False


def insertMidiaFranchise(cursor, connection, mediaId):
    franchise = readString("Nome da Franquia: ", 255)
    try:
        cursor.execute("SELECT * FROM Franquia WHERE nome = %s", (franchise,))
        if cursor.rowcount == 0:
            description = readString("Descrição da franquia: ")
            cursor.execute("INSERT INTO Franquia(nome, descricao) VALUES (%s, %s)",
                           (franchise, description))
        cursor.execute(
            "INSERT INTO Midia_Franquia(id_midia, nome) VALUES (%s, %s)", (mediaId, franchise))
        connection.commit()
    except psycopg2.errors.UniqueViolation:
        connection.rollback()
        print("Franquia já existe para mídia!")
    except Exception as e:
        print(e)
        print("Erro ao inserir franquia!")
        return False


def insertSerieSeason(cursor, connection, mediaId):
    season = readInt("Temporada: ")
    name = readString("Nome da temporada: ", 255)
    sinopsis = readString("Sinopse da temporada: ")
    try:
        cursor.execute("INSERT INTO Temporada(id_midia, nro_temporada, nome, sinopse) VALUES (%s, %s, %s, %s)",
                       (mediaId, season, name, sinopsis))
        connection.commit()
        return season
    except psycopg2.errors.UniqueViolation:
        connection.rollback()
        print("Temporada já existe para mídia!")
        return season
    except Exception as e:
        print(e)
        print("Erro ao inserir temporada!")
        return False


def insertSerieEpisode(cursor, connection, mediaId, season):
    episode = readInt("Episódio: ")
    name = readString("Nome do episódio: ", 255)
    sinopsis = readString("Sinopse do episódio: ")
    try:
        cursor.execute("INSERT INTO Episodio(id_midia, nro_temporada, nro_episodio, nome, sinopse) VALUES (%s, %s, %s, %s, %s)",
                       (mediaId, season, episode, name, sinopsis))
        connection.commit()
    except psycopg2.errors.UniqueViolation:
        connection.rollback()
        print("Episódio já existe para mídia!")
    except Exception as e:
        print(e)
        print("Erro ao inserir episódio!")
        return False


def insertMedia(cursor, connection):
    clearScreen()
    print("Inserindo nova mídia...")
    platform = duration = chapterCount = None
    title = readString("Título: ", 255)
    year = readMediaYear("Ano de Lançamento: ")
    mediaType = readMediaType("Tipo de Mídia: ")
    sinopsis = readString("Sinopse: ")
    status = readMediaStatus("Status: ", mediaType)
    if mediaType == 'JOGO':
        platform = readString("Plataforma: ", 255)
    elif mediaType == 'FILME':
        duration = readMediaDuration("Duração em segundos: ")
    elif mediaType == 'AUDIOBOOK':
        duration = readMediaDuration("Duração em segundos: ")
        chapterCount = readInt("Número de capítulos: ")

    print("Inserindo nova mídia...")
    try:
        cursor.execute("INSERT INTO Midia(titulo, data_lancamento, tipo, sinopse, status, nro_capitulos, duracao, plataforma) VALUES (%s, %s, %s, %s, %s, %s, %s, %s) RETURNING id_midia",
                       (title, year, mediaType, sinopsis, status, chapterCount, duration, platform))
        connection.commit()
    except psycopg2.errors.UniqueViolation:
        connection.rollback()
        print("Mídia já existe!")
        return
    except Exception as e:
        print(e)
        print("Erro ao inserir nova mídia!")
        return False

    insertedId = cursor.fetchone()[0]

    print("Mídia inserida com sucesso!")

    while readYesOrNo("Você deseja inserir um gênero para a mídia? (S/N) "):
        if insertMediaGenero(cursor, connection, insertedId) == False:
            return False

    while readYesOrNo("Você deseja inserir uma franquia para a mídia? (S/N) "):
        if insertMidiaFranchise(cursor, connection, insertedId) == False:
            return False

    if mediaType == 'SERIE':
        while readYesOrNo("Você deseja inserir uma temporada para a mídia? (S/N) "):
            season = insertSerieSeason(cursor, connection, insertedId)
            if season == False:
                return False
            while readYesOrNo(f"Você deseja inserir um episódio para a temporada {season}? (S/N) "):
                if insertSerieEpisode(
                        cursor, connection, insertedId, season) == False:
                    return False


def listMedia(cursor):
    clearScreen()
    cursor.execute(
        'SELECT M.titulo as "Título", M.data_lancamento as "Ano de Lançamento", M.tipo as "Tipo", SUBSTRING(M.sinopse,1,20) as "Sinopse", M.status as "Status", COALESCE(CAST(M.nro_capitulos as VARCHAR), \'-\') as "Número de Capítulos", COALESCE(CAST(M.duracao as VARCHAR), \'-\') as "Duração", COALESCE(M.plataforma, \'-\') as "Plataforma", CASE WHEN UPPER(M.tipo) = \'SERIE\' THEN CAST(COALESCE(T.nro_temporadas,0) AS VARCHAR) ELSE \'-\' END as "Número de Temporadas", CASE WHEN UPPER(M.tipo) = \'SERIE\' THEN CAST(COALESCE(E.nro_episodio,0) AS VARCHAR) ELSE \'-\' END as "Número de Episódios"  FROM Midia as M LEFT JOIN (SELECT id_midia, COUNT(*) as nro_temporadas FROM Temporada GROUP BY id_midia) as T ON M.id_midia = T.id_midia LEFT JOIN (SELECT id_midia, COUNT(*) as nro_episodio FROM Episodio GROUP BY id_midia) as E ON M.id_midia = E.id_midia')
    print("Mídias cadastradas:")
    table = from_db_cursor(cursor)
    print(table)
    input("Pressione ENTER para fechar...")


def listActorFromMovie(cursor):
    clearScreen()
    movieName = readString("Título do filme: ", 255)
    try:
        cursor.execute(
            "SELECT id_midia FROM Midia WHERE titulo = %s AND UPPER(tipo) = 'FILME' ", (movieName,))
        if cursor.rowcount == 0:
            print(f"Filme {movieName} não encontrado!")
            return
        cursor.execute(
            'SELECT Participacao.nome_pessoa as "Nome", TO_CHAR(Participacao.data_nasc_pessoa,\'DD/MM/YYYY\') as "Data de Nascimento", COALESCE(Indicacao.indicacao,\'-\') as "Indicação", CASE WHEN Indicacao.premiado = TRUE THEN \'Sim\' WHEN Indicacao.premiado = FALSE THEN \'Não\' ELSE \'-\' END as "Premiado" FROM (SELECT id_midia FROM Midia WHERE Midia.titulo = %s) M JOIN Participacao ON (M.id_midia = Participacao.id_midia AND Participacao.natureza = \'ATOR\') LEFT JOIN Indicacao ON (Participacao.id_participacao = Indicacao.id_participacao)', (movieName,))
        print(f"Atores do Filme {movieName}:")
        table = from_db_cursor(cursor)
        print(table)
        input("Pressione ENTER para fechar...")
    except Exception as e:
        print(e)
        print(f"Erro ao buscar atores do filme {movieName}!")
        return False
