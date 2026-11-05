clock = 2
if clock > 23:
    print('None')
elif clock >= 6 and clock < 12:
    print('Jutro')
elif clock >= 12 and clock < 18:
    print('Popodne')
elif clock >= 18 and clock < 22:
    print('Vece')
else:
    print('Noc')
