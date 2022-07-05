import os
import datetime
import re


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
            durationCapture = re.search(
                r'(\d\d+):(\d{2}):(\d{2})', input(message))

            if(durationCapture is None):
                raise ValueError()

            hours = int(durationCapture.group(1))
            minutes = int(durationCapture.group(2))
            seconds = int(durationCapture.group(3))

            if(minutes > 59 or seconds > 59):
                raise ValueError()

            return datetime.timedelta(hours=hours, minutes=minutes, seconds=seconds)
        except ValueError:
            print("Insira uma duração válida! No formato hh:mm:ss")


def readMediaReleaseDate(message):
    while True:
        try:
            dateCapture = re.search(r'(\d{2})/(\d{2})/(\d{4})', input(message))
            if(dateCapture is None):
                raise ValueError()
            day = int(dateCapture.group(1))
            month = int(dateCapture.group(2))
            year = int(dateCapture.group(3))
            date = datetime.date(year, month, day)
            return date
        except ValueError:
            print("Insira uma data válida! No formato dd/mm/yyyy")


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
