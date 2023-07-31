import 'package:flutter/material.dart';
import 'package:tuto/favoriteChangeNotifier.dart';
import 'package:tuto/favoriteWidget.dart';
import 'package:tuto/recipe.dart';
import 'package:provider/provider.dart';


class RecipeScreen extends StatelessWidget {

  const RecipeScreen ({Key? key, required this.recipe}) : super(key: key);
  final Recipe recipe;

  @override
  Widget build(BuildContext context) {

    Widget titleSection = Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(recipe.title,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20
                          )),
                    ),
                    Text(recipe.user,
                        style: TextStyle(
                            color: Colors.grey[500], fontSize: 15
                        ))
                  ],
                )
            ),
            FavoriteIconWidget(),
            FavoriteTextWidget()
          ],
        )
    );

    Widget buttonSection = Container(
        padding: const EdgeInsets.all(8),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButtonColumn(Colors.blue, Icons.comment, "COMMENT"),
              _buildButtonColumn(Colors.blue, Icons.share, "SHARE")
            ]
        )
    );

    Widget descriptionSection = Container(
        padding: const EdgeInsets.all(32),
        child: Text( recipe.description,
          softWrap: true,
        )
    );

    return ChangeNotifierProvider(
      create: (context)=> FavoriteChangeNotifier(recipe),
      child: Scaffold(
          appBar: AppBar(
            title: Text("Mes recettes"),
          ),
          body: ListView(
              children: [
                Stack(
                    children: [
                      Container(
                        width: 600,
                        height: 240,
                        child: Center(child: CircularProgressIndicator()),
                      ),
                      Hero(
                        tag: "imageRecipe" + recipe.title,
                        child: Image.network( // si j'utilise Image.network 'https://th.bing.com/th/id/OIP.szvqcft2uwVcYLSH2vvjYgHaE6?pid=ImgDet&rs=1', si j'utilise Image.asset 'images/pizza.jpg',
                          recipe.imageUrl,
                          width: 600,
                          height: 240,
                          fit: BoxFit.cover, //permet d'afficher au mieux l'image
                        ),
                      ),
                    ]
                ),
                titleSection,
                buttonSection,
                descriptionSection,
              ]
          )
      ),
    );
  }

  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            padding: const EdgeInsets.only(bottom: 8),
            child: Icon(icon, color: color)
        ),
        Text(label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: color,
            ))
      ],
    );
  }
}
