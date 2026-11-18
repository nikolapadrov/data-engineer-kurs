numbers = (10, 20, 30, 40, 50, 60)
def get_even_positions(data: tuple) -> tuple:
    return data[::2]

get_even_positions(numbers)

#############################################################

group1 = {'Ana', 'Marko', 'Jovan', 'Milica'}
group2 = {'Marko', 'Milica', 'Petar'}
def find_exclusive_students(group1: set, group2: set) -> set:
    return group1 - group2

find_exclusive_students(group1, group2)  

#############################################################

# input = ' Python | DATA | SQL '
# output = 'python-data-sql'
def clean_tags(text: str) -> str:
    tags = text.split('|')
    cleaned = [tag.strip().lower() for tag in tags]
    return '-'.join(cleaned)

print(clean_tags(' Python | DATA | SQL '))

