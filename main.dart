import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:smart_shopping_list/models/Ingredient.dart';
import 'package:smart_shopping_list/models/Recipe.dart';
import 'package:smart_shopping_list/models/ShopList.dart';
import 'package:smart_shopping_list/screens/home_page.dart';
import 'package:smart_shopping_list/theme/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // Register the adapter
  Hive.registerAdapter(IngredientAdapter());
  Hive.registerAdapter(RecipeAdapter());
  Hive.registerAdapter(ListRecipeAdapter());
  Hive.registerAdapter(ShopListAdapter());
  await Hive.openBox<Recipe>('recipes');
  await Hive.openBox<ShopList>('shopLists');

  runApp(ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
