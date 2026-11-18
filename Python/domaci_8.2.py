import csv

def get_header(path: str) -> list:
    with open(path, 'r', encoding='utf-8') as f:
        reader = csv.reader(f)
        return next(reader)

print(get_header('python/data/raw/teams.csv'))  # ['team', 'city', 'points']


#############################################################################

import csv

def read_rows(path: str) -> list:
    with open(path, 'r', encoding='utf-8') as f:
        reader = csv.reader(f)
        next(reader)  # preskace zaglavlje
        return list(reader)

print(read_rows('/Workspace/Users/npadrov@gmail.com/python/data/raw/teams.csv'))


#############################################################################


import csv


def total_points(path: str) -> int:
    total = 0
    with open(path, 'r', encoding='utf-8') as f:
        reader = csv.DictReader(f)
        for row in reader:
            total += int(row['points'])

    return total

print(total_points('python/data/raw/teams.csv'))  # Broj bodova: 122