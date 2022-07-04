import os
import datetime


def clearScreen():
    os.system('cls' if os.name == 'nt' else 'clear')


def readYesOrNo(message):
    while True:
        answer = input(message)
        if answer.upper() in ['S', 'N']:
            return answer.upper() == 'S'
        else:
            print("Insira S ou N!")


def readString(message, size=-1):
    while True:
        string = input(message)
        if size == -1 or len(string) <= size:
            return string
        else:
            print(f"Insira um valor de até {size} caracteres!")


def readInt(message):
    while True:
        try:
            return int(input(message))
        except ValueError:
            print("Insira um número inteiro!")


def readMediaDuration(message):
    while True:
        try:
            duration = readInt(message)
            return datetime.timedelta(seconds=duration)
        except ValueError:
            print("Insira uma duração válida!")


def readMediaYear(message):
    while True:
        try:
            year = readInt(message)
            yearDate = datetime.date(year, 1, 1)
            return yearDate
        except ValueError:
            print("Insira um ano válido!")


def readMediaType(message):
    validTypes = ['GENERICA',
                  'AUDIOBOOK',
                  'JOGO',
                  'FILME',
                  'SERIE']

    while True:
        mediaType = input(message)
        if mediaType.upper() in validTypes:
            return mediaType.upper()
        else:
            print(
                f"Tipo inválido! Insira um tipo válido: {', '.join(validTypes)}")


def readMediaStatus(message, mediaType):
    validStatus = ['EM PRODUCAO', 'FINALIZADA', 'CANCELADA']
    if mediaType == 'SERIE':
        validStatus.append('EM EXIBICAO')
    while True:
        mediaStatus = input(message)
        if mediaStatus.upper() in validStatus:
            return mediaStatus.upper()
        else:
            print(
                f"Status inválido! Os status válidos para o tipo de mídia {mediaType} são: {', '.join(validStatus)}")
