import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:smart_shopping_list/firebase_options.dart';
import 'package:smart_shopping_list/models/Ingredient.dart';
import 'package:smart_shopping_list/models/ListRecipe.dart';
import 'package:smart_shopping_list/models/Recipe.dart';
import 'package:smart_shopping_list/models/ShopList.dart';
import 'package:smart_shopping_list/screens/auth/auth_page.dart';
import 'package:smart_shopping_list/screens/edit_recipe.dart';
import 'package:smart_shopping_list/screens/shop%20list/edit_shop_list.dart';
import 'package:smart_shopping_list/screens/home_page.dart';
import 'package:smart_shopping_list/services/firestore.dart';
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

  var box1 = await Hive.openBox<Recipe>('recipes');
  var box2 = await Hive.openBox<ShopList>('shopLists');
  // await box1.clear();
  // await box2.clear();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late StreamSubscription _sub;
  String? _currentPath;
  String? _listId;

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
          _listId = uri.queryParameters['listId'];
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
          _listId = uri.queryParameters['listId'];
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
    printWarning("CURRENT PATH $_currentPath");
    switch (_currentPath) {
      case '/list':
        printWarning("list id $_listId");
        page = FutureBuilder(
          future: FirestoreService().getListFromDb(_listId ?? ""),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                color: Colors.white,
                child: Center(
                  child: Image.asset('assets/cooking_loading.gif'),
                ),
              );
            } else if (snapshot.hasError) {
              // If there's an error, show an error message
              return AlertDialog(
                content: Text('Failed to load the shopping list.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return AuthPage();
                      }));
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            } else if (!snapshot.hasData || snapshot.data == null) {
              // If the snapshot has no data, show an alert
              return AlertDialog(
                content: Text('This shopping list does not exist.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return AuthPage();
                      }));
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            } else {
              // If data is successfully retrieved, show the EditShopList page
              var documentSnapshot = snapshot.data;
              Map<String, dynamic> data =
                  documentSnapshot!.data() as Map<String, dynamic>;
              printWarning("DATA");
              print(data);
              ShopList shopList = ShopList.fromMap(data);
              return EditShopList(shopList: shopList);
            }
          },
        );
        break;
      case '/':
      default:
        page = HomePage();
        break;
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: page,
    );
  }
}
