import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GoPage extends StatefulWidget {
  const GoPage({super.key});

  @override
  State<GoPage> createState() => _GoPageState();
}

class _GoPageState extends State<GoPage> {

  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose(); // Liberamos la memoria del controlador
    // el metodo super.dispose() se encarga de liberar la memoria de los recursos utilizados por el widget
    super.dispose();
  }

  /// !goToDetalle
  /// recibe el tipo de navegación (go, push, replace)
  /// y redirige a la pantalla de detalle con el valor ingresado.
  void goToDetalle(String metodo) {
    String valor = controller.text; // Capturamos el valor del campo de texto

    if (valor.isEmpty) return; // Si el campo está vacio, no hacemos nada

    switch (metodo) {
      case 'go':
        context.go('/home/$valor desde go/$metodo');
        break;
      case 'push':
        context.push('/home/$valor desde push/$metodo');
        break;
      case 'replace':
        context.replace('/home/$valor desde replace/$metodo');
        break;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
      
        const SizedBox(height: 24),
        const Text(
          'Estudiante: DANIELA ERAZO MARIN',
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.all(8.0),
              color: const Color.fromARGB(255, 184, 249, 186),
              width: 120.0,
              height: 120.0,
              child: Image.network(
                'https://www.telemundo.com/sites/nbcutelemundo/files/styles/fit-560w/public/images/article/cover/2018/04/19/tigre-caminando.jpg?ramen_itok=iqwQftIcTf',
                fit: BoxFit.cover,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.all(8.0),
              color: const Color.fromARGB(255, 184, 249, 186),
              width: 130.0,
              height: 130.0,
              child: Image.asset(
                'assets/leon.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 34),
        Expanded(
          child: ListView(
            children: [
              const ListTile(
                leading: Icon(Icons.star, color: Colors.amber),
                title: Text('Elemento 1: estrella es primordial'),
              ),
              const ListTile(
                leading: Icon(Icons.favorite, color: Colors.red),
                title: Text('Elemento 2: corazón de acero'),
              ),
              const ListTile(
                leading: Icon(Icons.map,
                    color: Color.fromARGB(255, 62, 181, 90)),
                title: Text('Elemento 3: mapa del mundo'),
              ),

              Column(
                children: [
                  const SizedBox(height: 10),

                  const SizedBox(
                    child: ListTile(
                      title: Center(
                        child: Text(
                          'Practica paso parametros',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  SizedBox(
                    width: 300,
                    child: TextField(
                      //*asignamos el controlador al campo de texto
                      controller: controller,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Ingrese un valor',
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () => goToDetalle('go'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Ir con Go'),
                    ),
                  ),

                  const SizedBox(height: 10),

                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () => goToDetalle('push'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 15, 236, 37),
                        foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                      ),
                      child: const Text('Ir con Push'),
                    ),
                  ),

                  const SizedBox(height: 10),

                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () => goToDetalle('replace'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                          255,
                          207,
                          204,
                          11,
                        ),
                        foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                      ),
                      child: const Text('Ir con Replace'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
