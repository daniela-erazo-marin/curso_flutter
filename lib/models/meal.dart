
class Meal {
  final String id;
  final String name;
  final String category;
  final String area;
  final String instructions;
  final String thumbnail;
  final List<String> tags;
  final List<String> ingredients; // extra: ingredientes listados
  // opcional: medidas, etc.

  Meal({
    required this.id,
    required this.name,
    required this.category,
    required this.area,
    required this.instructions,
    required this.thumbnail,
    required this.tags,
    required this.ingredients,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    // tags pueden venir como string separada por comas
    final tagsString = json['strTags'] as String?;
    final List<String> tagsList = tagsString != null && tagsString.isNotEmpty
        ? tagsString.split(',')
        : [];

    // ingredientes vienen como campos strIngredient1, strIngredient2, etc.
    List<String> ingreds = [];
    for (int i = 1; i <= 20; i++) {
      final ingredient = json['strIngredient$i'] as String?;
      final measure = json['strMeasure$i'] as String?;
      if (ingredient != null && ingredient.isNotEmpty) {
        // podrías combinar ingrediente + medida
        final text = measure != null && measure.isNotEmpty
            ? '$ingredient — $measure'
            : ingredient;
        ingreds.add(text);
      }
    }

    return Meal(
      id: json['idMeal'] as String,
      name: json['strMeal'] as String,
      category: json['strCategory'] as String? ?? '',
      area: json['strArea'] as String? ?? '',
      instructions: json['strInstructions'] as String? ?? '',
      thumbnail: json['strMealThumb'] as String? ?? '',
      tags: tagsList,
      ingredients: ingreds,
    );
  }
}