import 'package:curso_flutter/routes/app_router.dart';
import 'package:curso_flutter/themes/app_theme.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());


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
