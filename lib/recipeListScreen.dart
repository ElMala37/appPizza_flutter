import 'package:flutter/material.dart';
import 'package:tuto/recipe.dart';
import 'package:tuto/recipeDataBase.dart';
import 'package:tuto/recipeScreen.dart';

class RecipeListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState(){
    return RecipeListScreenState();
  }
}


class RecipeListScreenState extends State<RecipeListScreen> {

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Mes recettes"),
      ),
      body: FutureBuilder<List<Recipe>>(
          future : RecipeDataBase.instance.recipes(),
          builder: (BuildContext context, AsyncSnapshot<List<Recipe>> snapshot) {
            if (snapshot.hasData) {
              List<Recipe> recipes = snapshot.data ?? []; // si snapshot est null alors recipes = []
                return ListView.builder(
                  itemCount: recipes.length,
                  itemBuilder: (context, index) {
                    final recipe = recipes[index];
                    return Dismissible(
                      key: Key(recipe.title),
                      onDismissed: (direction) {
                        setState(() {
                          RecipeDataBase.instance.deleteRecipe(recipe.title);
                          //recipes.removeAt(index);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("${recipe.title} supprimé")));
                      },
                      background: Container(color: Colors.red),
                      child: RecipeItemWidget(recipe: recipe),
                    );
                  },
                );
            } else {
              return Center(child: Text("No Data"));
            }

          }
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