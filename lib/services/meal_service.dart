import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../models/meal.dart';

class MealService {
  final String baseUrl;

  MealService()
      : baseUrl = dotenv.env['MEAL_API_URL']?.trim() ??
            (throw Exception('MEAL_API_URL no está definida en el archivo .env'));

  /// Busca comidas por nombre (o todas si query es cadena vacía)
  Future<List<Meal>> searchMeals(String query) async {
    final uri = Uri.parse('$baseUrl/search.php?s=${Uri.encodeQueryComponent(query)}');
    try {
      final response = await http.get(uri);
      if (response.statusCode != 200) {
        throw Exception('Error en búsqueda: ${response.statusCode}');
      }
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic>? mealsJson = data['meals'];
      if (mealsJson == null) {
        // No hay resultados
        return [];
      }
      return mealsJson
          .map((e) => Meal.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      // Puedes capturar más información si quieres, o loguear
      throw Exception('Error al buscar comidas: $e');
    }
  }

  /// Obtiene el detalle de una comida por su id
  Future<Meal> getMealDetailById(String id) async {
    final uri = Uri.parse('$baseUrl/lookup.php?i=${Uri.encodeQueryComponent(id)}');
    try {
      final response = await http.get(uri);
      if (response.statusCode != 200) {
        throw Exception('Error en detalle: ${response.statusCode}');
      }
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic>? mealsJson = data['meals'];
      if (mealsJson == null || mealsJson.isEmpty) {
        throw Exception('Detalle de receta no encontrado');
      }
      return Meal.fromJson(mealsJson.first as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Error al obtener detalle de la receta: $e');
    }
  }
}