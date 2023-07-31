import 'package:flutter/material.dart';
import 'package:tuto/recipe.dart';
import 'package:tuto/recipeListScreen.dart';
import 'package:tuto/recipeScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/', //pour dire sur quelle page on commence
      onGenerateRoute: (settings)=> RouteGenerator.generateRoute(settings), //
      debugShowCheckedModeBanner: false, //Pour enlever le bandeau "debug"
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
    );
  }
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch(settings.name){
      case'/':
        return MaterialPageRoute(builder: (context)=> RecipeListScreen());
      case'/recipe':
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation)=> RecipeScreen(recipe: settings.arguments as Recipe),
          transitionsBuilder: (context, animation, secondaryAnimation, child){
            animation = CurvedAnimation(curve: Curves.ease, parent: animation);
            return FadeTransition(
              opacity: animation,
               child: child,
            );
          }
        );
        default:
          return MaterialPageRoute(
            builder: (context)=> Scaffold(
              appBar: AppBar(title:Text("Error"), centerTitle: true),
              body: Center(child: Text("Page not found"),)
            )
          );
    }
  }
}


