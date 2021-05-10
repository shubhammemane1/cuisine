import 'package:get/get.dart';
import '../models/cuisine.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CuisinesController extends GetxController {
  //variables
  List<Dishes> _cuisinesList;
  List<Dishes> _favouritesList;
  SharedPreferences _prefs;

  @override
  void onInit() async {
    super.onInit();

    _prefs = await SharedPreferences.getInstance();

    _cuisinesList = _getCuisinesList();
    _favouritesList = _getFavouritesList();
  }

  //getters
  get cuisinesList => _cuisinesList;
  get favouritesList => _favouritesList;

  List<Dishes> _getFavouritesList() {
    List<Dishes> _myFavourites = [];

    _cuisinesList.forEach((cuisine) {
      bool isFavourite = _prefs.getBool('${cuisine.id}');
      if (isFavourite) _myFavourites.add(cuisine);
    });

    return _myFavourites;
  }

  static List<Dishes> _getCuisinesList() {
    return [
      Dishes(
        id: 'm1',
        name: "Misal Pav",
        time: '45 mins',
        cuisine: ['c4', 'c9', 'c1'], //ithe sort havet
        ingredients: [
          '2 bowls sprouted, boiled Moth',
          '1 big onion',
          '1 big tomato',
          '9-10 garlic cloves crushed',
          '3-4 small coconut slices',
          '1 tsp Misal Masala',
          'to taste Red Chilli Powder',
          '1 pinch Asafoetida',
          '1 tsp Goda Masala',
          'To taste Salt',
          '2 tsp Jaggery',
          '3 tbsp oil',
          '1 tsp Mustard seeds',
          '1 tsp Cumin seeds',
          'As needed Finely chopped coriander',
          '2 tsp Khada Masala (Badi Elaichi, Bay leaf, Clove, Black Pepper)',
          '6-8 curry leaves',
        ],
        recipe: [
          'Heat oil in a pan. Add mustard, cumin, asafoetida, khada masala, onion, tomato, garlic, curry leaves. Saute for 7-10 minutes over low flame',
          'Add misal masala, goda masala, red chilli powder, boiled moth, salt, jaggery & water. Mix well, cook for 5-7 minutes',
          'Serve hot Misal in a plate garnished with farsan, onion & coriander with soft Pav and Enjoy!',
        ],
        img: 'gs://testing-6a320.appspot.com/cuisine/misalpav.webp',
        favourite: false,
      ),
      Dishes(
        id: "m2",
        name: "dal Bati",
        time: '1 hour 25 mins',
        cuisine: [
          'c7',
          'c1',
        ],
        ingredients: [
          '1 cup chana dal',
          '1 cup split moong dal',
          '1 onion chopped',
          "1 tomato chopped",
          "4 green chillies chopped",
          "5 curry leaves",
          "4 dry red chillies",
          "2 bay leaves",
          "4 cloves",
          "2 cinnamon stick",
          "1 tbsp crushed garlic",
          "1 tbsp red chilli powder",
          "1 tsp garam masala",
          "1 tsp cumin seeds",
          "1 tsp hing",
          "1 tsp turmeric",
          "3 tbsp ghee",
          "Salt as per taste",
          "1 cup whole wheat flour",
          "4 tbsp ghee",
          'Water for kneading',
        ],
        recipe: [
          'Boil the chana dal and split green moong dal and keep it ready.',
          'Heat ghee in a pan.',
          'Add cumin seeds, bay leaves, cloves, cinnamon, garlic, dry red chillies green chillies and onions. Sautee till onions are translucent.',
          'Now add tomatoes and all dry masalas. Let it cook for 15 mins.',
          'Now add dal, salt and water. Let it cook for 15 mins. Garnish with coriander leaves.',
          'For Baati',
          'In a bowl, add the flour, salt, ghee and water.',
          'Just mix it well. Don’t knead it like chapatti flour.',
          'Pre-heat the oven at 180 degrees.',
          'Bake in the oven for 30 mins or until it appears brown',
        ],
        img: 'gs://testing-6a320.appspot.com/cuisine/dalbati.jpg',
        favourite: false,
      ),
      Dishes(
        id: "m3",
        name: 'Mendu Vada',
        time: '1 hour 15 mins',
        cuisine: ['c6', 'c1'],
        ingredients: [
          '1 cup of whole, skinned, urad dal',
          '2 of green chillies, chopped',
          '2 tsp of whole, black pepper',
          '10-12 of curry leaves, torn roughly',
          '2 tsp of salt (adjust to taste)',
          '1 tsp of minced ginger (optional)',
          '4 cups of oil, to deep fry, depending on the size of your pan',
        ],
        recipe: [
          'Soak the urad dal for at least 45 mins in enough water.',
          'Grind adding water by the teaspoon until you have a smooth, thick batter that falls off with reluctance as you drop it off a spoon.',
          'Mix the rest of the ingredients (except oil) with the batter.',
          'Heat oil until smoking point',
          'Shape the vadai using wet hands into a donut shape (read notes)',
          'Dunk into the hot oil. Take care not to over crowd the pan and also, regulate the heat to medium-low so that the insides of the vadai get cooked and the outside crisps up.',
          'Drain and set aside.'
        ],
        img: 'gs://testing-6a320.appspot.com/cuisine/Medu-Vada.jpg',
        favourite: false,
      ),
      Dishes(
        id: "m4",
        name: "Khaman",
        time: "30 mins",
        cuisine: ['c8', 'c1'],
        ingredients: [
          '1½ cup besan / gram flour',
          '3 tbsp rava / semolina / suji (fine)',
          '½ tsp ginger paste',
          '2 chilli (finely chopped)',
          '¼ tsp turmeric',
          '1 tsp sugar',
          'pinch hing / asafoetida',
          '½ tsp salt',
          '1 tbsp lemon juice',
          '1 tbsp oil',
          '1 cup water',
          '½ tsp eno fruit salt',
          '3 tsp oil',
          '½ tsp mustard',
          '½ tsp cumin / jeera',
          '1 tsp sesame / til',
          'pinch hing / asafoetida',
          'few curry leaves',
          '2 chilli (slit)',
          '¼ cup water',
          '1 tsp sugar',
          '¼ tsp salt',
          '1 tsp lemon juice',
        ],
        recipe: [
          'firstly, in a large mixing bowl sieve 1½ cup besan and 3 tbsp rava.',
          'add ½ tsp ginger paste, 2 chilli, ¼ tsp turmeric, 1 tsp sugar, pinch hing, ½ tsp salt, 1 tbsp lemon juice and 1 tbsp oil.',
          'prepare a smooth batter adding 1 cup of water or as required.',
          'additionally, add ½ tsp of eno fruit salt. you can alternatively use a pinch of baking soda.',
          'immediately steam the dhokla batter for 20 minutes.',
          'further, cut the dhokla and pour tempering.',
          'garnish the dhokla with 2 tbsp chopped coriander leaves and 2 tbsp fresh grated coconut.',
          'finally, serve instant khaman dhokla with green chutney and tamarind chutney.'
        ],
        img: 'gs://testing-6a320.appspot.com/cuisine/khaman.jpg',
        favourite: false,
      ),
      Dishes(
        id: "m5",
        name: 'Wiener Schnitzel',
        time: "60 mins",
        cuisine: [
          'c3',
        ],
        ingredients: [
          '8 Veal Cutlets',
          '4 Eggs',
          '200g Bread Crumbs',
          '100g Flour',
          '300ml Butter',
          '100g Vegetable Oil',
          'Salt',
          'Lemon Slices'
        ],
        recipe: [
          'Tenderize the veal to about 2–4mm, and salt on both sides.',
          'On a flat plate, stir the eggs briefly with a fork.',
          'Lightly coat the cutlets in flour then dip into the egg, and finally, coat in breadcrumbs.',
          'Heat the butter and oil in a large pan (allow the fat to get very hot) and fry the schnitzels until golden brown on both sides.',
          'Make sure to toss the pan regularly so that the schnitzels are surrounded by oil and the crumbing becomes ‘fluffy’.',
          'Remove, and drain on kitchen paper. Fry the parsley in the remaining oil and drain.',
          'Place the schnitzels on awarmed plate and serve garnishedwith parsley and slices of lemon.'
        ],
        img: 'gs://testing-6a320.appspot.com/cuisine/schnitzel.jpg',
        favourite: false,
      ),
      Dishes(
        id: "m6",
        name: "Pancakes",
        time: "20 mins",
        cuisine: [
          'c9',
        ],
        ingredients: [
          '1 1/2 Cups all-purpose Flour',
          '3 1/2 Teaspoons Baking Powder',
          '1 Teaspoon Salt',
          '1 Tablespoon White Sugar',
          '1 1/4 cups Milk',
          '1 Egg',
          '3 Tablespoons Butter, melted',
        ],
        recipe: [
          'In a large bowl, sift together the flour, baking powder, salt and sugar.',
          'Make a well in the center and pour in the milk, egg and melted butter; mix until smooth.',
          'Heat a lightly oiled griddle or frying pan over medium high heat.',
          'Pour or scoop the batter onto the griddle, using approximately 1/4 cup for each pancake. Brown on both sides and serve hot.'
        ],
        img: 'gs://testing-6a320.appspot.com/cuisine/pancake.jpg',
        favourite: false,
      ),
      Dishes(
        id: "m7",
        name: "Hamburger",
        time: "30 mins",
        cuisine: [
          'c9',
        ],
        ingredients: [
          '300g Cattle Hack',
          '1 Tomato',
          '1 Cucumber',
          '1 Onion',
          'Ketchup',
          '2 Burger Buns'
        ],
        recipe: [
          'Form 2 patties',
          'Fry the patties for c. 4 minutes on each side',
          'Quickly fry the buns for c. 1 minute on each side',
          'Bruch buns with ketchup',
          'Serve burger with tomato, cucumber and onion'
        ],
        img: 'gs://testing-6a320.appspot.com/cuisine/burger.webp',
        favourite: false,
      ),
      Dishes(
        id: "m8",
        name: 'Zunka',
        time: '20 mins',
        cuisine: ['c4', 'c1'],
        ingredients: [
          '1 small onion – finely chopped',
          '2 tsp garlic – chopped',
          '1 tsp mustard seeds',
          '1 tsp cumin seeds',
          '3 dried red chilies',
          '1 cup besan flour',
          '2 tsp oil',
          '1 tsp red chilli powder',
          '2 cups water',
        ],
        recipe: [
          'Add besan in a deep bowl.',
          'Add water and whisk till the mixture turns smooth.',
          'Heat oil in a pan.',
          'Add mustard seeds, cumin seeds, dried red chillies, and chopped garlic.',
          'Cook until the garlic turns a light golden color.',
          'Add chopped onions and cook till they turn translucent.',
          'Add besan batter and stir vigorously.',
          'Mix in salt.',
          'Cover and cook at a low temperature for 5 minutes.',
          'Garnish with chopped coriander leaves.',
        ],
        img: 'gs://testing-6a320.appspot.com/cuisine/Zunka.jpg',
        favourite: false,
      )
    ];
  }
}
