import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tuto/recipe.dart';

class RecipeDataBase {
  RecipeDataBase._();

  static final RecipeDataBase instance = RecipeDataBase._();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null ) return _database!;
    _database = await initDB();
    return _database!;
  }

  initDB() async {
    WidgetsFlutterBinding.ensureInitialized();
    return await openDatabase(
      join(await getDatabasesPath(),'recipe_database.db'),
      onCreate: (db, version) {
        return db.execute(
        "CREATE TABLE recipe(title TEXT PRIMARY KEY, user TEXT, imageUrl TEXT, description TEXT, isFavorite INTEGER, favoriteCount INTEGER)",
        );
      },
      version: 1,
    );
  }

  void insertRecipe(Recipe recipe) async {
    final Database db = await database;

    await db.insert(
      'recipe',
      recipe.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  void updateRecipe(Recipe recipe) async {
    final Database db = await database;

    await db.update("recipe", recipe.toMap(),
    where: "title=?", whereArgs: [recipe.title]);
  }

  void deleteRecipe(String title) async {
    final db = await database;
    db.delete("recipe", where: "title=?", whereArgs: [title]);
  }

  Future<List<Recipe>> recipes() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('recipe');
    List<Recipe> recipes = List.generate(maps.length, (i) {
      return Recipe.fromMap(maps[i]);
    });

    if (recipes.isEmpty){
      for (Recipe recipe in defaultRecipes) {
        insertRecipe(recipe);
      }
      recipes = defaultRecipes;
    }
    return recipes;
  }

  final List<Recipe> defaultRecipes = [
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
}