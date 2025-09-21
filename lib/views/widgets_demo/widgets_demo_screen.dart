import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../widgets/custom_drawer.dart';

class WidgetsDemoScreen extends StatefulWidget {
  const WidgetsDemoScreen({super.key});

  @override
  State<WidgetsDemoScreen> createState() => _WidgetsDemoScreenState();
}

class _WidgetsDemoScreenState extends State<WidgetsDemoScreen>
    with SingleTickerProviderStateMixin {
  
  int counter = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    if (kDebugMode) {
      print("🟢 initState() -> La pantalla se ha inicializado");
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
     if (kDebugMode) {
      print("🟡 didChangeDependencies() -> Tema actual");
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
     if (kDebugMode) {
      print("🔴 dispose() -> La pantalla se ha destruido");
    }
  }

  void incrementarCounter() {
  setState(() {
    counter++;
    if (kDebugMode) {
      print("setState() ejecutado → contador: $counter");
    }
  });
}

  @override
  Widget build(BuildContext context) {
     if (kDebugMode) {
      print("🔵 build() -> Construyendo la pantalla");
    }
     return Scaffold(
      appBar: AppBar(
        title: const Text("Demo Widgets"),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.grid_on), text: "Grid"),
            Tab(icon: Icon(Icons.list), text: "Otros"),
          ],
        ),
      ),
      drawer: const CustomDrawer(),
      body: TabBarView(
        controller: _tabController,
        children: [
          // TAB 1: GridView con íconos y colores diferentes
          Column(
            children: [
              ElevatedButton(
                onPressed: incrementarCounter,
                child: const Text("Incrementar contador"),
              ),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: 10,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // dos columnas
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    // Lista de colores
                    final colors = [
                      Colors.red.shade200,
                      Colors.green.shade200,
                      Colors.blue.shade200,
                      Colors.orange.shade200,
                      Colors.purple.shade200,
                      Colors.teal.shade200,
                      Colors.yellow.shade200,
                      Colors.pink.shade200,
                      Colors.cyan.shade200,
                      Colors.lime.shade200,
                    ];

                    // Lista de íconos
                    final icons = [
                      Icons.home,
                      Icons.star,
                      Icons.person,
                      Icons.settings,
                      Icons.phone,
                      Icons.map,
                      Icons.school,
                      Icons.shopping_cart,
                      Icons.camera_alt,
                      Icons.favorite,
                    ];

                    return Card(
                      color: colors[index % colors.length],
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              icons[index % icons.length],
                              size: 40,
                              color: Colors.black54,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Item $index",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),

          // TAB 2: ExpansionTile como tercer widget
          ListView(
            children: const [
              ExpansionTile(
                leading: Text('🦁'),//Icon(Icons.lion),
                title: Text("León"),
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("El león es un mamífero carnívoro de la familia de los félidos, conocido como el “rey de la selva”. Se caracteriza por su gran tamaño, su melena en el caso de los machos y su vida social en manadas, algo poco común en los felinos. Habita principalmente en sabanas y praderas de África, y destaca por su fuerza, agilidad y rugido imponente."),
                  )
                ],
              ),
              ExpansionTile(
                leading: Text('🐯'),//Icon(Icons.ja),
                title: Text("Tigre"),
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("El tigre es el felino más grande del mundo y se distingue por su pelaje anaranjado con rayas negras únicas en cada individuo. Es un cazador solitario y territorial que habita principalmente en bosques y selvas de Asia. Posee gran fuerza, agilidad y una excelente capacidad de camuflaje, lo que lo convierte en un depredador muy eficaz."),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}