import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_shopping_list/models/ShopList.dart';
import 'package:smart_shopping_list/screens/edit_recipe.dart';

class FirestoreService {
  final CollectionReference listsDb =
      FirebaseFirestore.instance.collection('shopping_lists');

  Future saveListToDb(String id, ShopList shoppingList) async {
    printWarning("SAVING DATA");
    print(shoppingList.toMap());
    return listsDb.doc(id).set(shoppingList.toMap());
  }

  Future<DocumentSnapshot> getListFromDb(String id) async {
    DocumentSnapshot docSnapshot = await listsDb.doc(id).get();
    return docSnapshot;
  }

  Future<void> deleteListFromDb(String id) async {
    return listsDb.doc(id).delete();
  }
}
