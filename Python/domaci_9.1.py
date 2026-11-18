def safe_divide(a: float, b: float) -> float | None:
    try:
        return a / b
    except ZeroDivisionError:
        return None
    
print(safe_divide(10, 2)) # 5.0
print(safe_divide(10, 0)) # None


######################################################

def safe_int(value: str) -> int | None:
    try:
        return int(value)
    except ValueError:
        return None
    
print(safe_int('25')) # 25
print(safe_int('-10')) # -10
print(safe_int('abc')) # None   


######################################################

def get_grade(grades: dict, student: str) -> int | None:
    try:
        return grades[student]
    except KeyError:
        return None
    
print(get_grade({'Ana': 5,'Marko': 4,'Jovana': 5},'Marko')) # 4
print(get_grade({'Ana': 5,'Marko': 4,'Jovana': 5},'Petar')) # None