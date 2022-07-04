import psycopg2
from myUtils import *
from dotenv import dotenv_values

dbConfig = dotenv_values(".env")


def connectDB():
    try:
        clearScreen()
        print("Conectando ao banco de dados...")
        conn = psycopg2.connect(host=dbConfig["DB_HOST"], database=dbConfig["DB_NAME"],
                                user=dbConfig["DB_USER"], password=dbConfig["DB_PASSWORD"], port=dbConfig["DB_PORT"])
        print("Conectado com sucesso!")
        return conn
    except:
        print("Erro ao conectar ao banco de dados! Verifique se o banco de dados está rodando e configurado corretamente!")
        finishProgram()
