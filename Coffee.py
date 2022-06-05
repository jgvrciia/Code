# Let's build a robot barrista
import time

print("Hello, welcome to Baytech Coffee!!!\n\n\n")
time.sleep(3)
name = input("What is your name?\n> ")

print("Hello, " + name + " thank you so much for coming in today\n")
time.sleep(1)
menu = "Coffee, Espresso, Frappuccino, Latte, Tea, Cappucino"

order = input(("What would you like to drink? Today's Menu is\n" + menu + "\n> "))

print("Sounds good " + name)


Coffee_price = 3
Espresso_price = 5
Frappuccino_price = 7
Latte_price = 6
Tea_price = 2
Cappucino_price = 4

ammount = input("How many " + order + "'s would you like?\n> ")


if order == "Coffee":
    total = Coffee_price * int(ammount)
if order == "Espresso":
    total = Espresso_price * int(ammount)
if order == "Frappuccino":
    total = Frappuccino_price * int(ammount)
if order == "Latte":
    total = Latte_price * int(ammount)
if order == "Tea":
    total = Tea_price * int(ammount)
if order == "Cappucino":
    total = Cappucino_price * int(ammount)

print("Thank you. Your total is: $" + str(total) + ".00\n")

time.sleep(3)

print("Thank you " + name + ", We'll have your " + ammount + " " + order + "'s ready in a few minutes")