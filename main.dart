import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:smart_shopping_list/firebase_options.dart';
import 'package:smart_shopping_list/models/Ingredient.dart';
import 'package:smart_shopping_list/models/ListRecipe.dart';
import 'package:smart_shopping_list/models/Recipe.dart';
import 'package:smart_shopping_list/models/ShopList.dart';
import 'package:smart_shopping_list/screens/home_page.dart';
import 'package:smart_shopping_list/screens/login_page.dart';
import 'package:smart_shopping_list/screens/recipes_page.dart';
import 'package:smart_shopping_list/theme/theme_provider.dart';
import 'package:uni_links/uni_links.dart';
import 'dart:async';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late StreamSubscription _sub;
  String? _currentPath;

  @override
  void initState() {
    super.initState();
    _handleIncomingLinks();
  }

  void _handleIncomingLinks() {
    // This will handle the deep link when the app is already running
    _sub = uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        setState(() {
          _currentPath = uri.path;
        });
      }
    }, onError: (Object err) {
      print('Failed to handle link: $err');
    });

    // This will handle the deep link when the app is opened via a link
    getInitialUri().then((Uri? uri) {
      if (uri != null) {
        setState(() {
          _currentPath = uri.path;
        });
      }
    }).catchError((err) {
      print('Failed to get initial link: $err');
    });
  }

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (_currentPath) {
      case '/recipes':
        page = RecipesPage();
        break;
      case '/':
      default:
        page = HomePage();
        break;
    }

    return MaterialApp(
      home: page,
    );
  }
}
