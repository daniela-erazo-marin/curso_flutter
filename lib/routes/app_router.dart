import 'package:curso_flutter/models/meal.dart';
import 'package:curso_flutter/views/auth/login_page.dart';
import 'package:curso_flutter/views/categoria_fb/categoria_fb_form_view.dart';
import 'package:curso_flutter/views/categoria_fb/categoria_fb_list_view.dart';
import 'package:curso_flutter/views/cdt/cdt_list_view.dart';
import 'package:curso_flutter/views/ciclo_vida/ciclo_vida_screen.dart';
import 'package:curso_flutter/views/future/future_view.dart';
import 'package:curso_flutter/views/home/home_screem.dart';
import 'package:curso_flutter/views/paso_parametros2/detalle_page.dart';
import 'package:curso_flutter/views/isolate/isolate_view.dart';
import 'package:curso_flutter/views/meal/meal_detail_view.dart';
import 'package:curso_flutter/views/meal/meal_list_view.dart';
import 'package:curso_flutter/views/paso_parametros/detalle_screen.dart';
import 'package:curso_flutter/views/paso_parametros/paso_parametros_screen.dart';
import 'package:curso_flutter/views/paso_parametros2/go_page.dart';
import 'package:curso_flutter/views/pokemons/pokemon_detail_view.dart';
import 'package:curso_flutter/views/pokemons/pokemon_list_view.dart';
import 'package:curso_flutter/views/timer/TimerView.dart';
import 'package:curso_flutter/views/universidad_fb/universidad_fb_form_view.dart';
import 'package:curso_flutter/views/universidad_fb/universidad_fb_list_view.dart';
import 'package:curso_flutter/views/widgets_demo/widgets_demo_screen.dart';
import 'package:go_router/go_router.dart';


final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(), // Usa HomeView
    ),
    // Rutas para el paso de parámetros
    GoRoute(
      path: '/paso_parametros',
      builder: (context, state) => const PasoParametrosScreen(),
    ),

    // !Ruta para el detalle con parámetros
    GoRoute(
      path:
          '/detalle/:parametro/:metodo', //la ruta recibe dos parametros los " : " indican que son parametros
      builder: (context, state) {
        //*se capturan los parametros recibidos
        // declarando las variables parametro y metodo
        // es final porque no se van a modificar
        final parametro = state.pathParameters['parametro']!;
        final metodo = state.pathParameters['metodo']!;
        return DetalleScreen(parametro: parametro, metodoNavegacion: metodo);
      },
    ),

    // !Ruta para el detalle con parámetros de la página Home

    GoRoute(
      path:
          '/home/:parametro/:metodo', //la ruta recibe dos parametros los " : " indican que son parametros
      builder: (context, state) {
        //*se capturan los parametros recibidos
        // declarando las variables parametro y metodo
        // es final porque no se van a modificar
        final parametro = state.pathParameters['parametro']!;
        final metodo = state.pathParameters['metodo']!;
        return DetallePage(parametro: parametro, metodoNavegacion: metodo);
      },
    ),
    //!Ruta para el ciclo de vida
    GoRoute(
      path: '/ciclo_vida',
      name: 'ciclo_vida',
      builder: (context, state) => const CicloVidaScreen(),
    ),
    
    GoRoute(
    path: '/widgets_demo',
    builder: (context, state) => const WidgetsDemoScreen(),
    ),

    //!Ruta para FUTURE
    GoRoute(
      path: '/future',
      name: 'future',
      builder: (context, state) => const FutureView(),
    ),
    //!Ruta para ISOLATE
    GoRoute(
      path: '/isolate',
      name: 'isolate',
      builder: (context, state) => const IsolateView(),
    ),
    //!Ruta para TIMER
    GoRoute(
      path: '/timer',
      name: 'timer',
      builder: (context, state) => const TimerView(),
    ),
    //!Ruta para listaado de pokemones
    GoRoute(
      path: '/pokemons',
      name: 'pokemons',
      builder: (context, state) => const PokemonListView(),
    ),
    //!Ruta para detalle de pokemones
    GoRoute(
      path: '/pokemon/:name', // se recibe el nombre del pokemon como parametro
      name: 'pokemon_detail',
      builder: (context, state) {
        final name =
            state.pathParameters['name']!; // se captura el nombre del pokemon.
        return PokemonDetailView(name: name);
      },
    ),
     //!Ruta para detalle de pokemones
    GoRoute(
      path: '/cdts', // se recibe el nombre del pokemon como parametro
      name: 'cdts',
      builder: (context, state) => const CDTListView(),
    ),
    //!Ruta para el Meal

    //!Ruta lista de comidas
    GoRoute(
      path: '/meal',
      builder: (context, state) => const MealListView(),
    ),

    //!Ruta detalle de receta
    GoRoute(
      path: '/meal/:id',
      name: 'meal_detail_view',
      builder: (context, state) {
        final String id = state.pathParameters['id']!;
        final extra = state.extra;

        // Realizar cast seguro:
        Meal? maybeMeal;
        if (extra != null && extra is Meal) {
          maybeMeal = extra;
        } else {
          maybeMeal = null;
        }
        return MealDetailView(
          id: id,
          maybeMeal: maybeMeal,
        );
      },
    ),
     GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
      //!Paso parametros 2
    GoRoute(
      path: '/paso_parametros2',
      name: 'paso_parametros2',
      builder: (context, state) => const GoPage(),
    ),
    //! Rutas para el manejo de Categorías (CRUD)
    GoRoute(
     path: '/categoriasFirebase',
     name: 'categoriasFirebase',
     builder: (_, __) => const CategoriaFbListView(),
    ),
    GoRoute(
     path: '/categoriasfb/create',
     name: 'categoriasfb.create',
     builder: (context, state) => const CategoriaFbFormView(),
    ),
    GoRoute(
     path: '/categoriasfb/edit/:id',
     name: 'categorias.edit',
     builder: (context, state) {
     final id = state.pathParameters['id']!;
        return CategoriaFbFormView(id: id);
      },
    ),
    //! Rutas para el manejo de Universidades (CRUD)
    GoRoute(
     path: '/universidadesFirebase',
     name: 'universidadesFirebase',
     builder: (_, __) => const UniversidadFbListView(),
    ),
    GoRoute(
     path: '/universidadesfb/create',
     name: 'universidadesfb.create',
     builder: (context, state) => const UniversidadFbFormView(),
    ),
    GoRoute(
     path: '/universidadesfb/edit/:id',
     name: 'universidadesfb.edit',
     builder: (context, state) {
     final id = state.pathParameters['id']!;
        return UniversidadFbFormView(id: id);
      },
    ),
  ],
);