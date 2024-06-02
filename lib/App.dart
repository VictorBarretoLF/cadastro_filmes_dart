
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teste/view/cadastrar_filme.dart';
import 'package:teste/view/home_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }

}