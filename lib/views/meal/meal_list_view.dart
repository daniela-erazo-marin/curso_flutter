import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:curso_flutter/models/meal.dart';
import 'package:curso_flutter/services/meal_service.dart';
import '../../widgets/base_view.dart';

class MealListView extends StatefulWidget {
  const MealListView({Key? key}) : super(key: key);

  @override
  State<MealListView> createState() => _MealListViewState();
}

class _MealListViewState extends State<MealListView> {
  late Future<List<Meal>> _futureMeals;
  final MealService _mealService = MealService();
  String _searchTerm = '';

  @override
  void initState() {
    super.initState();

    // ✅ Inicializar el Future con el método seguro
    _loadMeals();
  }

  void _loadMeals([String search = '']) {
    // Usamos then/catchError para controlar éxito y error
    _futureMeals = _mealService.searchMeals(search)
     
     /*_futureMeals = Future.delayed(
    const Duration(seconds: 1),
    () => throw '¡Error de prueba!',
  )*/
      ..then((meals) {
        // Mostrar SnackBar de éxito después de obtener datos
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            final message = meals.isEmpty
                ? 'No se encontraron recetas para "$search"'
                : 'Recetas cargadas correctamente';
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
                backgroundColor: meals.isEmpty ? Colors.red : Colors.green,
                duration: const Duration(seconds: 3),
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        });
      }).catchError((error) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error al cargar recetas: $error'),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 3),
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        });
      });
  }

  void _doSearch(String term) {
    setState(() {
      _searchTerm = term;
      _loadMeals(term);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      title: 'Recetas',
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Buscar receta',
                border: OutlineInputBorder(),
              ),
              onSubmitted: _doSearch,
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Meal>>(
              future: _futureMeals,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  // Solo mostramos un texto de error en la UI
                  return Center(
                      child: Text('Error al cargar recetas: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  final meals = snapshot.data!;
                  if (meals.isEmpty) {
                    return const Center(child: Text('No se encontraron recetas'));
                  }

                  return ListView.builder(
                    itemCount: meals.length,
                    itemBuilder: (context, index) {
                      final meal = meals[index];
                      return ListTile(
                        leading: meal.thumbnail.isNotEmpty
                            ? Image.network(
                                meal.thumbnail,
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              )
                            : null,
                        title: Text(meal.name),
                        subtitle: Text(meal.category),
                        onTap: () {
                          print(
                              '🍽️ Navegando al detalle de la receta: ${meal.name}');
                          print('📍 ID de la receta: ${meal.id}');
                          print(
                              '🔄 Usando pushNamed para mantener la navegación anterior');

                          context.pushNamed(
                            'meal_detail_view',
                            pathParameters: {'id': meal.id},
                            extra: meal,
                          );
                        },
                      );
                    },
                  );
                } else {
                  return const Center(child: Text('Sin datos'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
