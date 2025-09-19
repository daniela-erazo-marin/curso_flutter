import 'package:flutter/material.dart';
import '../../widgets/custom_drawer.dart';
import 'home_page.dart'; 

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard Principal')),
      drawer: const CustomDrawer(),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: HomePage(), 
      ),
    );
  }
}
