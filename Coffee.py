# Let's build a robot barista
import time

print("Hello, welcome to Baytech Coffee!!!\n\n\n")
time.sleep(3)
name = input("What is your name?\n> ")

# We don't want Diego's in our shop
if name == "Diego":
    evil = input("Are you evil? (yes/no)\n> ")
    if evil == "Yes".casefold():
        print("GET OUT EVIL DIEGO!! YOU'RE BANNED FROM THIS COFFEE SHOP!!")
        exit()

print("Hello, " + name + " thank you so much for coming in today\n")
time.sleep(1)
menu = "Coffee: $3 \nEspresso: $5 \nFrappuccino: $7 \nLatte: $6 \nTea: $2 \nCappuccino: $4\n"

order = input(("What would you like to drink? Today's Menu is\n" + menu + "\n> ")).casefold()

while order != "Coffee".casefold() and order != "Espresso".casefold() and order != "Frappuccino".casefold() and order != "Latte".casefold() and order != "Tea".casefold() and order != "Cappuccino".casefold():
    print("Please Choose a menu option")
    order = input(("What would you like to drink? Today's Menu is\n" + menu + "\n> ")).casefold()


print("Sounds good " + name)


Coffee_price = 3
Espresso_price = 5
Frappuccino_price = 7
Latte_price = 6
Tea_price = 2
Cappuccino_price = 4

amount = input("How many " + order + "'s would you like?\n> ")


if order == "Coffee".casefold():
    total = Coffee_price * int(amount)
if order == "Espresso".casefold():
    total = Espresso_price * int(amount)
if order == "Frappuccino".casefold():
    total = Frappuccino_price * int(amount)
if order == "Latte".casefold():
    total = Latte_price * int(amount)
if order == "Tea".casefold():
    total = Tea_price * int(amount)
if order == "Cappuccino".casefold():
    total = Cappuccino_price * int(amount)

print("Thank you. Your total is: $" + str(total) + ".00\n")

time.sleep(3)

print("Thank you " + name + ", We'll have your " + amount + " " + order + "'s ready in a few minutes")
