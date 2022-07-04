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
    1. Inserir Nova Mídia
    2. Listar Mídias
    3. Listar Atores de um Filme
    q. Fechar OMDB
    """)
    selection = input("Selecione uma opção: ")
    if selection == "1":
        if insertMedia(cursor, connection) == False:
            finishProgram()
    elif selection == "2":
        listMedia(cursor)
    elif selection == "3":
        if listActorFromMovie(cursor) == False:
            finishProgram()
    elif selection == "q":
        finishProgram()
    else:
        print("Opção inválida!")
    menu()


connection = connectDB()
cursor = connection.cursor()
menu()
