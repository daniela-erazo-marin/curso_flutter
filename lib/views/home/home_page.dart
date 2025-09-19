import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

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
                leading: Icon(Icons.map,
                    color: Color.fromARGB(255, 62, 181, 90)),
                title: Text('Elemento 3: mapa del mundo'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
