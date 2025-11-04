import 'package:curso_flutter/routes/app_router.dart';
import 'package:curso_flutter/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  // Asegurarse de que los widgets de Flutter estén inicializados
  WidgetsFlutterBinding.ensureInitialized();
  // Optimizar la carga del .env
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    debugPrint('Error loading .env file: $e');
  }
  // Inicializar dotenv para cargar las variables de entorno
  // await dotenv.load(fileName: ".env");

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    //run go_router para navegacion
      return MaterialApp.router(
        theme:
          AppTheme.lightTheme, //Thema personalizado y permanente en toda la app
        title: 'Intro Flutter',
        routerConfig: appRouter, //usa el router configurado 
      
    );
  }
}
