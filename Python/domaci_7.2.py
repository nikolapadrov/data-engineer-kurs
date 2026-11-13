# 1. Napisati program kojim se prevodi temperatura iz Celzijusove skale u Farenhajtovu skalu,
# ako je odgovaraju´ca formula oblika T [◦F] = T [◦C] · 1.80 + 32. Na ulazu se unosi vrednost
# temperature u stepenima Celzijusa (realan broj) a ispisuje se vrednost temperature u stepenima
# Farenhajta

def celsius_to_fahrenheit(temp_c):
    return temp_c * 1.8 + 32
     
print(f'Temperatura u Farenhajtima iznosi: {celsius_to_fahrenheit(18.3):.2f}°F')


####################################################################################################

# 2. Napisati program koji za uneti redni broj dana u nedelji (od 1 do 7) ispisuje naziv tog
# dana (ponedeljak - nedelja). Ukoliko je unet broj koji nije izmedju 1 i 7, ispisati pogresan unos.

def day_name(day_number):
    if day_number == 1:
        return 'ponedeljak'
    elif day_number == 2:
        return 'utorak'
    elif day_number == 3:
        return 'sreda'
    elif day_number == 4:
        return 'četvrtak'
    elif day_number == 5:
        return 'petak'
    elif day_number == 6:
        return 'subota'
    elif day_number == 7:
        return 'nedelja'
    else:
        return 'Pogrešan unos'

print(day_name(0), day_name(5), day_name(1), day_name(8))

####################################################################################################

# 3. Napisati program koji racuna najveci negativni element u listi.
#list = [5, 18, -100, 3, -1, -42]
def max_negative(list):
    check = None
    for l in list:
        if l < 0:
            if check is None or l > check:
                check = l 
    return check   
print(max_negative([5, 18, -100, 3, -1, -0.5,-42]))

####################################################################################################

# 5. Napisati program koji racuna broj parnih elemenata date liste.

def count_even_numbers(numbers):
    counter = 0
    for n in numbers:
        if n % 2 == 0:
            counter += 1
    return counter
print(count_even_numbers([14, 1, 3, 22, 16, 13, 1026, -16]))

####################################################################################################

# 6. Napisati program koji racuna sume elemenata liste celih brojeva koji su deljivi sa 2 odnosno sa 3
def sum_numbers(numbers):
    sum_2 = 0
    sum_3 = 0
    for n in numbers:
        if n % 2 == 0:
            sum_2 += n
        if n % 3 == 0:
            sum_3 += n
    return sum_2, sum_3
print(sum_numbers([5,4,8,3,1,9,6,21]))