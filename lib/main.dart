import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Intro Flutter',
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
       theme: ThemeData(
      
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 30, 185, 110)),
      ),
    );
  }
}


class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String title = 'Hola, Flutter';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title)),

      body: Padding(
        padding: const EdgeInsets.all(16),
        
        child: Column(
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
                  padding: const EdgeInsets.all(8.0), // espacio interno para que se vea el borde
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
                  padding: const EdgeInsets.all(8.0), // espacio interno para que se vea el borde
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
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  title = (title == 'Hola, Flutter') ? '¡Título cambiado!' : 'Hola, Flutter';
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Título actualizado')),
                );
              },
              child: const Text('Cambiar título'),
            ),
            const SizedBox(height: 34),
            Expanded(
              child: ListView(
                children: const [
                  ListTile(
                    leading: Icon(Icons.star, color: Colors.amber),
                    title: Text('Elemento 1: estrella es primordial'),
                  ),
                  ListTile(
                    leading: Icon(Icons.favorite, color: Colors.red),
                    title: Text('Elemento 2: corazón de acero'),
                  ),
                  ListTile(
                    leading: Icon(Icons.map, color: Color.fromARGB(255, 24, 148, 53)),
                    title: Text('Elemento 3: mapa del mundo'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}