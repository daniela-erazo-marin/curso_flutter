import 'dart:async';
import 'package:flutter/material.dart';

import '../../widgets/base_view.dart';

class FutureView extends StatefulWidget {
  const FutureView({super.key});

  @override
  State<FutureView> createState() => _FutureViewState();
}

class _FutureViewState extends State<FutureView> {
  List<String> _nombres = []; // declarar una lista.

  @override
  // !inicializa el estado
  // *llama a la funcion obtenerDatos() para cargar los datos al iniciar
  void initState() {
    super.initState();
    obtenerDatos(); // carga al iniciar
  }

  // !Funcion que simula una carga de datos
  //*espera 5 segundos antes de cargar los datos, esto simula una carga de datos.
  Future<List<String>> cargarNombres() async {
    //future.delayed() simula una carga de datos
    await Future.delayed(const Duration(seconds: 5));

     //  Descomenta la siguiente línea para simular un error
   //throw Exception('Error al cargar los datos desde el servidor');

    return [
      '🐶 Perro',
      '🐱 Gato',
      '🐰 Conejo',
      '🐹 Hámster',
      '🐻 Oso',
      '🦊 Zorro',
      '🐼 Panda',
      '🐨 Koala',
      '🦁 León',
      '🐯 Tigre',
      '🐮 Vaca',
      '🐷 Cerdo',
      '🐸 Rana',
      '🐵 Mono',
      '🐔 Pollo',
      '🦉 Búho',
      '🐴 Caballo',
      '🐍 Serpiente',
      '🐢 Tortuga',
      '🐠 Pez'
    ];
  }

  

 // !Funcion que obtiene los datos
  // *carga los datos y los asigna a la lista _nombres
  Future<void> obtenerDatos() async {
    print("👉 [ANTES] Inicia el proceso para obtener los datos.");

    try {
      print("⏳ [DURANTE] Se inicia la carga de datos (esperando respuesta...)");
      final datos = await cargarNombres();
      print("✅ [DURANTE] Los datos fueron recibidos correctamente.");


    //!mounted es una propiedad de State que indica si el widget está montado en el árbol de widgets
    //mounted es true si el widget está montado en el árbol de widgets
    //mounted es false si el widget no está montado en el árbol de widgets

      if (!mounted) return;
      setState(() {
        //redibuja la pantalla
        _nombres = datos;
      });

      // 👇 Mostrar mensaje de éxito
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Datos cargados correctamente.'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      print("❌ [DURANTE] Ocurrió un error: $e");
      if (!mounted) return;
      setState(() {
        _nombres = [];
      });

      // 👇 Mostrar mensaje de error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error al cargar los datos.'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.redAccent,
        ),
      );
    } finally {
      print("🏁 [DESPUÉS] Finalizó el proceso de carga (éxito o error).");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      title: 'Futures - GridView',
      body:
          //*si la lista esta vacia muestra un CircularProgressIndicator
          _nombres.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView.builder(
                itemCount: _nombres.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // columnas
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 2,
                ),
                itemBuilder: (context, index) {
                  return Card(
                    color: const Color.fromARGB(255, 18, 206, 84),
                    child: Center(
                      child: Text(
                        _nombres[index], // muestra el nombre en la posicion index, index es el indice del item en la lista
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
