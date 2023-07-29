import 'package:flutter/material.dart';
import 'package:tuto/recipe.dart';
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
      home: RecipeScreen(
        recipe: Recipe(
          "Pizza facile",
          "Par Thomas Mallay",
          "https://th.bing.com/th/id/OIP.ZZsn6lD6PCjocBzx1tuu1QHaEo?w=292&h=182&c=7&r=0&o=5&pid=1.7",
          "\nPréparez une pâte à pizza faite maison ou achetée dans le commerce.\n\nÉtalez la pâte sur une plaque de cuisson légèrement farinée.\n\nÉtalez une généreuse couche de sauce tomate ou de sauce tomate assaisonnée sur la pâte.\n\nAjoutez une couche de fromage mozzarella râpé sur la sauce.\n\nPersonnalisez votre pizza avec vos garnitures préférées : pepperoni, champignons, poivrons, oignons, olives, etc.\n\nAssaisonnez avec des herbes italiennes, du sel et du poivre selon votre goût.\n\nPréchauffez votre four à 220°C et enfournez la pizza.\n\nFaites cuire pendant 12 à 15 minutes ou jusqu'à ce que la croûte soit bien dorée et le fromage fondu et légèrement doré.\n\nSortez la pizza du four, laissez-la refroidir légèrement, puis coupez-la en parts égales.\n\nServez et dégustez votre délicieuse pizza faite maison ! Bon appétit !",
          true,
          50
        )
      ),
    );
  }
}


