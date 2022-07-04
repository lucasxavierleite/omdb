import time
import psycopg2
from myUtils import *
from media import *
from db import *


def finishProgram():
    print("Fechando OMDB...")
    if cursor:
        cursor.close()
    if connection:
        connection.close()
    exit()


def menu(timeToWait=0.75):
    time.sleep(timeToWait)
    clearScreen()
    print("""
    ### Bem vindo ao OMDB ###
    1. Inserir nova Mídia
    2. Listar Mídias
    q. Fechar OMDB
    """)
    selection = input("Selecione uma opção: ")
    if selection == "1":
        if insertMedia(cursor, connection) == False:
            finishProgram()
    elif selection == "2":
        listMedia(cursor)
    elif selection == "q":
        finishProgram()
    else:
        print("Opção inválida!")
    menu()


connection = connectDB()
cursor = connection.cursor()
menu()
