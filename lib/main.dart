import 'package:curso_flutter/data/local/task_local_datasource.dart';
import 'package:curso_flutter/data/remote/task_remote_datasource.dart';
import 'package:curso_flutter/provider/task_provider.dart';
import 'package:curso_flutter/provider/theme_provider.dart';
import 'package:curso_flutter/repositories/task_repository.dart';
import 'package:curso_flutter/routes/app_router.dart';
import 'package:curso_flutter/services/sync_service.dart';
import 'package:curso_flutter/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

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

  final local = TaskLocalDataSource();
  final remote = TaskRemoteDataSource();
  final repo = TaskRepository(local: local, remote: remote);
  final sync = SyncService(local: local, remote: remote);


runApp(
    //! MultiProvider permite usar varios providers en la app
    //! En este caso solo se usa el ThemeProvider, pero se pueden agregar más
    MultiProvider(
        providers: [
         ChangeNotifierProvider(create: (_) => ThemeProvider()),
         ChangeNotifierProvider(
          create: (_) => TaskProvider(repo: repo, sync: sync)..init(),
          ),
     ],
      child: const MyApp(),
    ),
  );
      
  }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Consumer escucha los cambios del ThemeProvider y reconstruye la app
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return MaterialApp.router(
          theme: AppTheme.lightTheme(themeProvider.color),
          title: 'Flutter - UCEVA',
          routerConfig: appRouter,
        );
      },
    );
  }
}
