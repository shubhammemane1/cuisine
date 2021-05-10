class Cuisine {
  final String id;
  final String name;
  final String img;
  bool favourite;

  Cuisine({
    this.id,
    this.name,
    this.img,
    this.favourite = false,
  });
}

class Dishes {
  final String id;
  final List<String> cuisine;
  final String name;
  final String time;
  final List<String> ingredients;
  final List<String> recipe;
  final String img;
  bool favourite;

  Dishes({
    this.id,
    this.cuisine,
    this.name,
    this.time,
    this.ingredients,
    this.recipe,
    this.img,
    this.favourite,
  });
}
