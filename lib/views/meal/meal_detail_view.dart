import 'package:curso_flutter/models/meal.dart';
import 'package:curso_flutter/services/meal_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MealDetailView extends StatefulWidget {
  final String id;
  final Meal? maybeMeal;

  const MealDetailView({Key? key, required this.id, this.maybeMeal}) : super(key: key);

  @override
  State<MealDetailView> createState() => _MealDetailViewState();
}

class _MealDetailViewState extends State<MealDetailView> {
  late Future<Meal> _futureMeal;
  final MealService _mealService = MealService();

  @override
  void initState() {
    super.initState();
    if (widget.maybeMeal != null) {
      _futureMeal = Future.value(widget.maybeMeal!);
    } else {
      _futureMeal = _mealService.getMealDetailById(widget.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle Receta'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            print('🔙 Volviendo a la lista de recetas');
            print('📍 Desde la receta con ID: ${widget.id}');
            if (widget.maybeMeal != null) {
              print('🍽️ Nombre de la receta: ${widget.maybeMeal!.name}');
            }
            print('🔄 Usando pop() para mantener el historial de navegación');
            context.pop();
          },
        ),
      ),
      body: FutureBuilder<Meal>(
        future: _futureMeal,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final meal = snapshot.data!;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (meal.thumbnail.isNotEmpty)
                    Image.network(meal.thumbnail),
                  const SizedBox(height: 16),
                  Text(
                    meal.name,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text('Categoría: ${meal.category}'),
                  Text('Área: ${meal.area}'),
                  const SizedBox(height: 16),
                  const Text('Instrucciones:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(meal.instructions),
                  const SizedBox(height: 16),
                  if (meal.ingredients.isNotEmpty) ...[
                    const Text('Ingredientes:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    ...meal.ingredients.map((ing) => Text('• $ing')),
                  ],
                  const SizedBox(height: 16),
                  if (meal.tags.isNotEmpty) ...[
                    const Text('Tags:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: meal.tags.map((tag) => Chip(label: Text(tag))).toList(),
                    ),
                  ],
                ],
              ),
            );
          } else {
            return const Center(child: Text('Sin datos'));
          }
        },
      ),
    );
  }
}
