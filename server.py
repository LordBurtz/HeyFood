from flask import Flask, render_template, jsonify, Response
import json

data = [
    {
        'id': 1,
        'name': 'Harissa chicken on quinoa with green olives',
        'headline': 'combining eggs and Tofu this is the perfect suplement for your workout',
        'prepTime': 25,
        'imageURL': 'https://pinchofyum.com/wp-content/uploads/Chipotle-Tahini-Bowls-with-Egg-Square.jpg',
        'websiteURL': 'https://www.hellofresh.de/recipes/balsamico-linsen-salat-mit-hahnchenbrust-64df2a75552e10127649f25f',
        'tags': ['pasta', 'Italian', 'dinner'],
        'nutrition': {
            'energy': 450,
            'protein': 20,
            'carbohydrate': 60,
            'calories': 15
        }
    },
    {
        'id': 6,
        'name': 'Spaghetti Carbonara',
        'headline': 'Savor the creamy delight of our classic carbonara a taste of Italy in every bite!',
        'prepTime': 30,
        'imageURL': 'https://keyassets-p2.timeincuk.net/wp/prod/wp-content/uploads/sites/53/2018/07/Spaghetti-carbonara-recipe.jpg',
        'websiteURL': 'https://www.chefkoch.de/rezepte/3716921562602313/Spaghetti-Carbonara.html',
        'tags': ['pasta', 'Italian', 'dinner'],
        'nutrition': {
            'energy': 450,
            'protein': 20,
            'carbohydrate': 60,
            'calories': 15
        }
    },
    {
        'id': 2,
        'name': 'Chicken Caesar Salad',
        'headline': 'Busy day, huh - what about a quick salad',
        'prepTime': 20,
        'imageURL': 'https://3.bp.blogspot.com/-dwLgeHNLFu4/W6YYTffTyhI/AAAAAAACEqQ/2xopeunyIWgUc8b_0VuFRmA7jBgicb4CgCLcBGAs/s1600/DSCN1627.JPG',
        'websiteURL': 'https://www.chefkoch.de/rezepte/956701201250684/Caesar-Salad.html',
        'tags': ['salad', 'chicken', 'healthy'],
        'nutrition': {
            'energy': 300,
            'protein': 25,
            'carbohydrate': 15,
            'calories': 18
        }
    },
        {
        'id': 4,
        'name': 'Grilled Salmon',
        'headline': 'You got the time - treat yourself to a high quality dish',
        'prepTime': 25,
        'imageURL': 'https://www.cookingclassy.com/wp-content/uploads/2018/05/grilled-salmon-3.jpg',
        'websiteURL': 'https://www.chefkoch.de/rezepte/4259071697032288/Cedar-Plank-Salmon-vom-Grill-mit-Pfirsich-Rucola-Salat.html?ck_source=search-recipe&ck_element=recipe_search_list',
        'tags': ['seafood', 'healthy', 'grilled'],
        'nutrition': {
            'energy': 350,
            'protein': 30,
            'carbohydrate': 5,
            'calories': 22
        }
    },
    {
        'id': 5,
        'name': 'Vegetarian Stir-Fry',
        'headline': 'Taste the last fragrances of autumn',
        'prepTime': 20,
        'imageURL': 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fhealthyfitnessmeals.com%2Fwp-content%2Fuploads%2F2020%2F09%2FSWEET-SOUR-VEGETABLE-STIR-FRY_-5-819x1024.jpg&f=1&nofb=1&ipt=35267234e1e0f69eaa5742d798616edbdd1e9b4def3e1bc994919f0bf6992014&ipo=imagesg',
        'websiteURL': 'https://www.chefkoch.de/rezepte/1925511313931855/Stir-fry.html',
        'tags': ['vegetarian', 'stir-fry', 'quick'],
        'nutrition': {
            'energy': 280,
            'protein': 15,
            'carbohydrate': 40,
            'calories': 12
        }
    },
    {
        'id': 3,
        'name': 'Chocolate Chip Cookies',
        'headline': 'Happy cheat day, may the cookies be ever in your flavour',
        'prepTime': 15,
        'imageURL': 'https://i2.wp.com/www.livewellbakeoften.com/wp-content/uploads/2018/08/MM-Chocolate-Chip-Cookies-6.jpg',
        'websiteURL': 'https://www.chefkoch.de/rezepte/2257651361176625/Subway-Cookies.html',
        'tags': ['dessert', 'cookies', 'baking'],
        'nutrition': {
            'energy': 200,
            'protein': 2,
            'carbohydrate': 30,
            'calories': 10
        }
    },
    # Add more mock recipes as needed
]

app = Flask(__name__)

@app.route('/')
def home():
    return render_template('index.html')

@app.route('/homeview')
def homeView():

    # Manually serialize the object to JSON
    json_data = json.dumps(data)

    # Create a Flask response with the serialized JSON data
    response = Response(json_data, content_type='application/json')

    return response

if __name__ == '__main__':
    app.run(debug=True)
