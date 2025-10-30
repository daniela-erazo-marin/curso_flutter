import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(
                context,
              ).colorScheme.primary, // Usa el color primario del tema
            ),
            child: const Text(
              'Menú',
              style: TextStyle(
                color: Colors
                    .white, // Texto blanco para contrastar con el color primario
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Inicio'),
            onTap: () {
              //context.go('/'); // Navega a la ruta principal
              //Reemplaza la ruta actual en la pila de navegación.
              //No permite volver atrás automáticamente, ya que no agrega la nueva ruta a la pila.
              //Útil para navegación sin historial, como en barra de navegación o cambiar de pestañas.
              context.go('/'); // Navega a la ruta principal
              Navigator.pop(context); // Cierra el drawer
            },
          ),
          /*ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Configuración'),
            onTap: () {
              //context.push(String route)
              //Añade la nueva ruta a la pila de navegación.
              //Permite volver atrás con context.pop().
              //Ideal para flujos donde el usuario puede regresar, como navegar a una pantalla de detalles.
              context.push(
                '/settings',
              ); // Navega a la pantalla de configuración
              Navigator.pop(context); // Cierra el drawer
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Perfil'),
            onTap: () {
              //context.replace(String route)
              //Similar a go(), pero en este caso reemplaza la ruta actual sin eliminar el historial anterior.
              //Útil si quieres evitar que el usuario regrese a la pantalla anterior
              //pero manteniendo la posibilidad de navegar hacia otras rutas en la pila
              context.replace('/profile'); // Navega a la pantalla de perfil
              Navigator.pop(context); // Cierra el drawer
            },
          ),*/
          //!PASO DE PARAMETROS
          ListTile(
            leading: const Icon(Icons.input),
            title: const Text('Paso de Parámetros'),
            onTap: () {
              context.go('/paso_parametros');
            },
          ),
           ListTile(
            leading: const Icon(Icons.insert_chart),
            title: const Text('Paso de Parámetros 2'),
            onTap: () {
              context.go('/paso_parametros2');
            },
          ),
          ListTile(
            leading: const Icon(Icons.loop),
            title: const Text('Ciclo de Vida'),
            onTap: () {
              context.go('/ciclo_vida');
            },
          ),
          ListTile(
            leading: const Icon(Icons.widgets),
            title: const Text('Widgets Demo'),
            onTap: () {
              context.go('/widgets_demo');
            },
          ),
           //!FUTURE
          ListTile(
            leading: const Icon(Icons.input),
            title: const Text('Future'),
            onTap: () {
              context.go('/future');
            },
          ),
          //!ISOLATE
          ListTile(
            leading: const Icon(Icons.input),
            title: const Text('Isolate'),
            onTap: () {
              context.go('/isolate');
            },
          ),
          //!TIMER
           ListTile(
            leading: const Icon(Icons.timelapse),
            title: const Text('TIMER'),
            onTap: () {
              context.go('/timer');
            },
          ),
            //!POKEMONS
          ListTile(
            leading: const Icon(Icons.pets),
            title: const Text('Pokemons'),
            onTap: () {
              context.go('/pokemons');
            },
          ),
          //!CDTS
           ListTile(
            leading: const Icon(Icons.money),
            title: const Text('money'),
            onTap: () {
              context.go('/cdts');
            },
          ),
          //!MEALS
          ListTile(
            leading: const Icon(Icons.restaurant_menu),
            title: const Text('Meal'),
            onTap: () {
              context.go('/meal');
            },
          ),
          //!LOGIN
          ListTile(
            leading: const Icon(Icons.login),
            title: const Text('Login'),
            onTap: () {
              context.go('/login');
            },
          ),
        ],
      ),
    );
  }
}