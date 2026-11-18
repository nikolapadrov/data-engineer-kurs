class BankAccount:
    def __init__(self, owner: str, balance: float = 0):
        self.owner = owner
        self.balance = balance

    def deposit(self, amount: float) -> 'BankAccount':
        if amount > 0:
            self.balance += amount
        return self

    def withdraw(self, amount: float) -> 'BankAccount':
        if amount > 0 and amount <= self.balance:
            self.balance -= amount
        return self

    def display_balance(self) -> None:
        print(f'Stanje na racunu: {self.balance}')


account = BankAccount('Ana', 10000)
account.deposit(5000).withdraw(2000).deposit(1000)
account.display_balance()

#################################################################

class UserProfile:
    def __init__(self, username: str, email: str, city: str):
        self.username = username
        self.email = email
        self.city = city
        self.active = True

    def change_email(self, email: str) -> 'UserProfile':
        self.email = email
        return self

    def change_city(self, city: str) -> 'UserProfile':
        self.city = city
        return self

    def deactivate(self) -> 'UserProfile':
        self.active = False
        return self

    def activate(self) -> 'UserProfile':
        self.active = True
        return self

    def display_info(self) -> None:
        print(f'Korisnicko ime: {self.username}')
        print(f'Email: {self.email}')
        print(f'Grad: {self.city}')
        print(f'Aktivan: {self.active}')


user = UserProfile('ana123', 'ana@gmail.com', 'Nis')
user.change_email('ana@yahoo.com').change_city('Beograd').deactivate()
user.display_info()

#################################################################
