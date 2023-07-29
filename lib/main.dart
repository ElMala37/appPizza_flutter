import 'package:flutter/material.dart';
import 'package:tuto/recipeScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false, //Pour enlever le bandeau "debug"
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: RecipeScreen(),
    );
  }
}


