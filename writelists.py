#!/usr/bin/env python3
# SPDX-FileCopyrightText: 2026 Toon Verstraelen <Toon.Verstraelen@UGent.be>
# SPDX-License-Identifier: CC-BY-4.0
"""Write Markdown files with animals or foods for participants to edit in the sandbox.

Each item gets its own section, separated by enough unchanged lines,
so that pull requests editing different items can be merged without conflicts.
Emoji shortcodes are taken from GitHub's gemoji database:
https://github.com/github/gemoji/blob/master/db/emoji.json
"""

from stepup.core.call import driver

HEADER_TEMPLATE = """\
# Favorite {kind}s

"""

ITEM_TEMPLATE = """\
## {name} :{shortcode}:

Add an item to explain why you like this {kind}:

- ...
- ...
- ...

"""

ANIMALS = [
    ("ant", "ant"),
    ("badger", "badger"),
    ("bat", "bat"),
    ("bear", "bear"),
    ("beaver", "beaver"),
    ("bee", "bee"),
    ("beetle", "beetle"),
    ("bison", "bison"),
    ("black cat", "black_cat"),
    ("boar", "boar"),
    ("butterfly", "butterfly"),
    ("camel", "camel"),
    ("caterpillar", "bug"),
    ("chick", "hatched_chick"),
    ("chicken", "chicken"),
    ("chipmunk", "chipmunk"),
    ("cockroach", "cockroach"),
    ("cow", "cow2"),
    ("crab", "crab"),
    ("cricket", "cricket"),
    ("crocodile", "crocodile"),
    ("crow", "black_bird"),
    ("deer", "deer"),
    ("dodo", "dodo"),
    ("dog", "dog2"),
    ("dolphin", "dolphin"),
    ("donkey", "donkey"),
    ("dove", "dove"),
    ("dragon", "dragon"),
    ("dromedary", "dromedary_camel"),
    ("duck", "duck"),
    ("eagle", "eagle"),
    ("elephant", "elephant"),
    ("flamingo", "flamingo"),
    ("fly", "fly"),
    ("fox", "fox_face"),
    ("frog", "frog"),
    ("giraffe", "giraffe"),
    ("goat", "goat"),
    ("goose", "goose"),
    ("gorilla", "gorilla"),
    ("guide dog", "guide_dog"),
    ("hamster", "hamster"),
    ("hedgehog", "hedgehog"),
    ("hippopotamus", "hippopotamus"),
    ("horse", "racehorse"),
    ("jellyfish", "jellyfish"),
    ("kangaroo", "kangaroo"),
    ("koala", "koala"),
    ("ladybug", "lady_beetle"),
    ("leopard", "leopard"),
    ("lion", "lion"),
    ("lizard", "lizard"),
    ("llama", "llama"),
    ("lobster", "lobster"),
    ("mammoth", "mammoth"),
    ("monkey", "monkey"),
    ("moose", "moose"),
    ("mosquito", "mosquito"),
    ("mouse", "mouse2"),
    ("octopus", "octopus"),
    ("orangutan", "orangutan"),
    ("otter", "otter"),
    ("owl", "owl"),
    ("ox", "ox"),
    ("panda", "panda_face"),
    ("parrot", "parrot"),
    ("peacock", "peacock"),
    ("penguin", "penguin"),
    ("pig", "pig2"),
    ("polar bear", "polar_bear"),
    ("poodle", "poodle"),
    ("pufferfish", "blowfish"),
    ("rabbit", "rabbit2"),
    ("raccoon", "raccoon"),
    ("ram", "ram"),
    ("rat", "rat"),
    ("rhinoceros", "rhinoceros"),
    ("rooster", "rooster"),
    ("sauropod", "sauropod"),
    ("scorpion", "scorpion"),
    ("seal", "seal"),
    ("shark", "shark"),
    ("sheep", "sheep"),
    ("shrimp", "shrimp"),
    ("skunk", "skunk"),
    ("sloth", "sloth"),
    ("snail", "snail"),
    ("snake", "snake"),
    ("spider", "spider"),
    ("squid", "squid"),
    ("swan", "swan"),
    ("tiger", "tiger2"),
    ("tropical fish", "tropical_fish"),
    ("turkey", "turkey"),
    ("turtle", "turtle"),
    ("tyrannosaurus", "t-rex"),
    ("unicorn", "unicorn"),
    ("water buffalo", "water_buffalo"),
    ("whale", "whale2"),
    ("wolf", "wolf"),
    ("worm", "worm"),
    ("zebra", "zebra"),
]

FOODS = [
    ("apple", "apple"),
    ("avocado", "avocado"),
    ("bacon", "bacon"),
    ("bagel", "bagel"),
    ("baguette", "baguette_bread"),
    ("banana", "banana"),
    ("beans", "beans"),
    ("beer", "beer"),
    ("bell pepper", "bell_pepper"),
    ("bento box", "bento"),
    ("birthday cake", "birthday"),
    ("blueberries", "blueberries"),
    ("bread", "bread"),
    ("broccoli", "broccoli"),
    ("bubble tea", "bubble_tea"),
    ("burrito", "burrito"),
    ("butter", "butter"),
    ("candy", "candy"),
    ("carrot", "carrot"),
    ("cheese", "cheese"),
    ("cherries", "cherries"),
    ("chestnut", "chestnut"),
    ("chocolate", "chocolate_bar"),
    ("cocktail", "cocktail"),
    ("coconut", "coconut"),
    ("coffee", "coffee"),
    ("cookie", "cookie"),
    ("corn", "corn"),
    ("croissant", "croissant"),
    ("cucumber", "cucumber"),
    ("cupcake", "cupcake"),
    ("curry", "curry"),
    ("custard", "custard"),
    ("dango", "dango"),
    ("doughnut", "doughnut"),
    ("dumpling", "dumpling"),
    ("egg", "egg"),
    ("eggplant", "eggplant"),
    ("falafel", "falafel"),
    ("fish cake", "fish_cake"),
    ("flatbread", "flatbread"),
    ("fondue", "fondue"),
    ("fortune cookie", "fortune_cookie"),
    ("french fries", "fries"),
    ("fried egg", "fried_egg"),
    ("fried shrimp", "fried_shrimp"),
    ("garlic", "garlic"),
    ("ginger", "ginger_root"),
    ("grapes", "grapes"),
    ("green apple", "green_apple"),
    ("green salad", "green_salad"),
    ("hamburger", "hamburger"),
    ("honey", "honey_pot"),
    ("hot dog", "hotdog"),
    ("hot pepper", "hot_pepper"),
    ("ice cream", "ice_cream"),
    ("kiwi", "kiwi_fruit"),
    ("leafy greens", "leafy_green"),
    ("lemon", "lemon"),
    ("lollipop", "lollipop"),
    ("mango", "mango"),
    ("mate", "mate"),
    ("meat on the bone", "meat_on_bone"),
    ("melon", "melon"),
    ("milk", "milk_glass"),
    ("moon cake", "moon_cake"),
    ("mushroom", "mushroom"),
    ("oden", "oden"),
    ("olive", "olive"),
    ("onion", "onion"),
    ("orange", "tangerine"),
    ("oyster", "oyster"),
    ("pancakes", "pancakes"),
    ("peach", "peach"),
    ("peanuts", "peanuts"),
    ("pear", "pear"),
    ("peas", "pea_pod"),
    ("pie", "pie"),
    ("pineapple", "pineapple"),
    ("pizza", "pizza"),
    ("popcorn", "popcorn"),
    ("potato", "potato"),
    ("poultry leg", "poultry_leg"),
    ("pretzel", "pretzel"),
    ("ramen", "ramen"),
    ("rice", "rice"),
    ("rice ball", "rice_ball"),
    ("rice cracker", "rice_cracker"),
    ("sake", "sake"),
    ("sandwich", "sandwich"),
    ("shaved ice", "shaved_ice"),
    ("shortcake", "cake"),
    ("soft ice cream", "icecream"),
    ("spaghetti", "spaghetti"),
    ("steak", "cut_of_meat"),
    ("stew", "stew"),
    ("strawberry", "strawberry"),
    ("stuffed flatbread", "stuffed_flatbread"),
    ("sushi", "sushi"),
    ("sweet potato", "sweet_potato"),
    ("taco", "taco"),
    ("tamale", "tamale"),
    ("tea", "tea"),
    ("tomato", "tomato"),
    ("waffle", "waffle"),
    ("watermelon", "watermelon"),
    ("wine", "wine_glass"),
]


def run(out: list[str], kind: str):
    if kind == "animal":
        items = ANIMALS
    elif kind == "food":
        items = FOODS
    else:
        raise ValueError("kind must be either animal or food")
    with open(out[0], "w") as fh:
        fh.write(generate_items(items, kind))


def generate_items(items: list[tuple[str, str]], kind: str) -> str:
    parts = [HEADER_TEMPLATE.format(kind=kind)]
    for name, shortcode in items:
        parts.append(ITEM_TEMPLATE.format(name=name.capitalize(), shortcode=shortcode, kind=kind))
    return "".join(parts).rstrip() + "\n"


if __name__ == "__main__":
    driver()
