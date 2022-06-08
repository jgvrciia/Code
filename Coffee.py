# Let's Build A Bobot Barista

import time

print("Hello, Welcome to Baytech Coffee!!!\n\n\n")
time.sleep(3)

NAME = input("What is your name?\n> ")

# We Don't Want Evil Diego's Or Duc's In Our Shop

if NAME.capitalize() == "Diego" or NAME.capitalize() == "Duc":
    EVIL = input("Are you evil? (yes/no)\n> ")
    if EVIL.casefold() == "yes":
        print("GET OUT EVIL " + NAME.upper() +
              "!! YOU'RE BANNED FROM THIS COFFEE SHOP!!")
        exit()
    else:
        print("Sorry for the confusion we have an evil " +
              NAME.capitalize() + " roaming around")


print("Hello, " + NAME.capitalize() +
      " thank you so much for coming in today.\n")
time.sleep(1)

# Creating Menu Options

MENU = "Coffee: $3 \nEspresso: $5 \nFrappuccino: $7 \nLatte: $6 \nTea: $2 \nCappuccino: $4\n"

ORDER = input(
    ("What would you like to drink? Today's menu is:\n" + MENU + "\n> ")).casefold()

# Loop For Ordering The Right Beverage

while ORDER != "Coffee".casefold() and ORDER != "Espresso".casefold() and ORDER != "Frappuccino".casefold() and ORDER != "Latte".casefold() and ORDER != "Tea".casefold() and ORDER != "Cappuccino".casefold():
    print("Sorry we don't make that here. Please choose a menu option.")
    ORDER = input(
        ("What would you like to drink? Today's menu is\n" + MENU + "\n> ")).casefold()

print("Sounds good " + NAME.capitalize() + ".")

# Defining Beverage Price

COFFEE_PRICE = 3
ESPRESSO_PRICE = 5
FRAPPUCCINO_PRICE = 7
LATTE_PRICE = 6
TEA_PRICE = 2
CAPPUCCINO_PRICE = 4

AMOUNT = input("How many " + ORDER.capitalize() + "'s would you like?\n> ")

# Defining Total Cost Based On Beverage Chosen

if ORDER == "Coffee".casefold():
    total = COFFEE_PRICE * int(AMOUNT)
if ORDER == "Espresso".casefold():
    total = ESPRESSO_PRICE * int(AMOUNT)
if ORDER == "Frappuccino".casefold():
    total = FRAPPUCCINO_PRICE * int(AMOUNT)
if ORDER == "Latte".casefold():
    total = LATTE_PRICE * int(AMOUNT)
if ORDER == "Tea".casefold():
    total = TEA_PRICE * int(AMOUNT)
if ORDER == "Cappuccino".casefold():
    total = CAPPUCCINO_PRICE * int(AMOUNT)

print("Thank you. Your total is: $" + str(total) + ".00\n")

time.sleep(3)

# Making Beverage

if AMOUNT == "1":
    print("Thank you " + NAME.capitalize() + ", we'll have your " +
          ORDER.capitalize() + " ready soon.\n")
    time.sleep(4)
    print("Here is your " + ORDER.capitalize())
else:
    print("Thank you " + NAME.capitalize() + ", we'll have your " +
          AMOUNT + " " + ORDER.capitalize() + "'s ready soon.\n")
    time.sleep(4)
    print("Here is your " + ORDER.capitalize() + ".")

input("\nHAVE A NICE DAY!!\n")
