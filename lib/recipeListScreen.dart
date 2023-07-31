import 'package:flutter/material.dart';
import 'package:tuto/recipe.dart';
import 'package:tuto/recipeScreen.dart';

class RecipeListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState(){
    return RecipeListScreenState();
  }
}


class RecipeListScreenState extends State<RecipeListScreen> {

  final List<Recipe> recipes = [
    Recipe(
        "Pizza facile",
        "Par Thomas Mallay",
        "https://th.bing.com/th/id/OIP.ZZsn6lD6PCjocBzx1tuu1QHaEo?w=292&h=182&c=7&r=0&o=5&pid=1.7",
        "\nPréparez une pâte à pizza faite maison ou achetée dans le commerce.\n\nÉtalez la pâte sur une plaque de cuisson légèrement farinée.\n\nÉtalez une généreuse couche de sauce tomate ou de sauce tomate assaisonnée sur la pâte.\n\nAjoutez une couche de fromage mozzarella râpé sur la sauce.\n\nPersonnalisez votre pizza avec vos garnitures préférées : pepperoni, champignons, poivrons, oignons, olives, etc.\n\nAssaisonnez avec des herbes italiennes, du sel et du poivre selon votre goût.\n\nPréchauffez votre four à 220°C et enfournez la pizza.\n\nFaites cuire pendant 12 à 15 minutes ou jusqu'à ce que la croûte soit bien dorée et le fromage fondu et légèrement doré.\n\nSortez la pizza du four, laissez-la refroidir légèrement, puis coupez-la en parts égales.\n\nServez et dégustez votre délicieuse pizza faite maison ! Bon appétit !",
        true,
        50
    ),
    Recipe(
        "Burger maison",
        "Par Thomas Mallay",
        "https://th.bing.com/th/id/R.a54a97f72b1d8a096a52ca62418c3295?rik=Rq7DKMI7TDb1ZA&pid=ImgRaw&r=0",
        "\nMélangez 500g de viande hachée avec un œuf, de l'ail émincé, du sel et du poivre. \nFaçonnez des steaks et faites-les cuire dans une poêle chaude avec un peu d'huile. \nDans un autre récipient, mélangez mayonnaise, moutarde et ketchup pour préparer la sauce. \nToastez les pains à burger puis assemblez les burgers en ajoutant du fromage, de la salade, des tomates et des oignons. \nServez chaud avec des frites ou des légumes grillés en accompagnement. \nBon appétit!",
        true,
        50
    ),
  ];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Mes recettes"),
      ),
      body: ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (context, index){
          final recipe = recipes[index];
          return Dismissible(key: Key(recipe.title),
          onDismissed: (direction){
            setState((){
              recipes.removeAt(index);
          });
            ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("${recipe.title} supprimé")));
          },
          background: Container(color: Colors.red),
          child: RecipeItemWidget(recipe: recipe));
        },
      ),
    );
  }
}

class RecipeItemWidget extends StatelessWidget {
  const RecipeItemWidget ({Key? key, required this.recipe}) : super(key: key);
  final Recipe recipe;

  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, '/recipe', arguments: recipe,);
      },
      child: Card(
        margin: EdgeInsets.all(8),
        elevation: 8,
        child: Row(
          children: [
            Hero(
              tag: "imageRecipe" + recipe.title,
              child: Image.network( // si j'utilise Image.network 'https://th.bing.com/th/id/OIP.szvqcft2uwVcYLSH2vvjYgHaE6?pid=ImgDet&rs=1', si j'utilise Image.asset 'images/pizza.jpg',
                recipe.imageUrl,
                width: 100,
                height: 100,
                fit: BoxFit.cover, //permet d'afficher au mieux l'image
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(recipe.title,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  ),
                  Text(recipe.user,
                      style: TextStyle(color: Colors.grey[500], fontSize: 15))
                ]
              ),
            )
          ]
        ),
      ),
    );
  }
}