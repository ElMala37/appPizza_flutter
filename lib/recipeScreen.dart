import 'package:flutter/material.dart';
import 'package:tuto/favoriteWidget.dart';


class RecipeScreen extends StatelessWidget {
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
                      child: Text("Pizza facile",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20
                          )),
                    ),
                    Text("Par Thomas Mallay",
                        style: TextStyle(
                            color: Colors.grey[500], fontSize: 15
                        ))
                  ],
                )
            ),
            FavoriteWidget(isFavorited: true, favoriteCount:123)
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
        child: Text(
          "\nPréparez une pâte à pizza faite maison ou achetée dans le commerce.\n\nÉtalez la pâte sur une plaque de cuisson légèrement farinée.\n\nÉtalez une généreuse couche de sauce tomate ou de sauce tomate assaisonnée sur la pâte.\n\nAjoutez une couche de fromage mozzarella râpé sur la sauce.\n\nPersonnalisez votre pizza avec vos garnitures préférées: pepperoni, champignons, poivrons, oignons, olives, etc.\n\nAssaisonnez avec des herbes italiennes, du sel et du poivre selon votre goût.\n\nPréchauffez votre four à 220°C et enfournez la pizza.\n\nFaites cuire pendant 12 à 15 minutes ou jusqu'à ce que la croûte soit bien dorée et le fromage fondu et légèrement doré.\n\nSortez la pizza du four, laissez-la refroidir légèrement, puis coupez-la en parts égales.\n\nServez et dégustez votre délicieuse pizza faite maison ! Bon appétit !",
          softWrap: true,
        )
    );

    return Scaffold(

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
                    Image
                        .network( // si j'utilise Image.network 'https://th.bing.com/th/id/OIP.szvqcft2uwVcYLSH2vvjYgHaE6?pid=ImgDet&rs=1', si j'utilise Image.asset 'images/pizza.jpg',
                      'https://th.bing.com/th/id/OIP.szvqcft2uwVcYLSH2vvjYgHaE6?pid=ImgDet&rs=1 ',
                      width: 600,
                      height: 240,
                      fit: BoxFit.cover, //permet d'afficher au mieux l'image
                    ),
                  ]
              ),
              titleSection,
              buttonSection,
              descriptionSection,
            ]
        )
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
