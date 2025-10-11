import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../models/cdt.dart';

//! el CDT service es el encargado de hacer las peticiones a la api
class CDTService {
  // ! Se obtiene la url de la api desde el archivo .env
  String apiUrl = dotenv.env['CDT_API_URL']!;

  // ! Método para obtener la lista de CDTs
  // * Se hace una petición directa a la API de datos.gov.co que retorna el JSON de CDTs
  Future<List<CDT>> getCDTs() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((data) => CDT.fromJson(data)).toList();
      } else {
        throw Exception('Error al obtener la lista de CDTs. Status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error en la conexión con la API de CDTs: $e');
    }
  }

  // Método para obtener CDTs filtrados por entidad bancaria usando la API de Socrata
  Future<List<CDT>> getCDTsByEntidad(String nombreEntidad) async {
    try {
      // Usando la sintaxis SoQL de datos.gov.co para filtrar
      final queryUrl = '$apiUrl?\$where=lower(nombreentidad) like lower("%25$nombreEntidad%25")';
      final response = await http.get(Uri.parse(queryUrl));
      
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((data) => CDT.fromJson(data)).toList();
      } else {
        throw Exception('Error al obtener los CDTs de la entidad. Status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al filtrar CDTs por entidad: $e');
    }
  }

  // Método para obtener CDTs ordenados por tasa
  Future<List<CDT>> getCDTsByTasa({bool descending = true}) async {
    try {
      // Usando la sintaxis SoQL para ordenar
      final order = descending ? 'DESC' : 'ASC';
      final queryUrl = '$apiUrl?\$order=tasa $order';
      final response = await http.get(Uri.parse(queryUrl));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((data) => CDT.fromJson(data)).toList();
      } else {
        throw Exception('Error al obtener los CDTs ordenados. Status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al ordenar CDTs por tasa: $e');
    }
  }

  // Método para obtener CDTs con monto mayor a un valor específico
  Future<List<CDT>> getCDTsByMinMonto(double minMonto) async {
    try {
      // Usando la sintaxis SoQL para filtrar por monto
      final queryUrl = '$apiUrl?\$where=CAST(monto AS double) >= $minMonto';
      final response = await http.get(Uri.parse(queryUrl));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((data) => CDT.fromJson(data)).toList();
      } else {
        throw Exception('Error al filtrar CDTs por monto. Status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al filtrar CDTs por monto mínimo: $e');
    }
  }
}
