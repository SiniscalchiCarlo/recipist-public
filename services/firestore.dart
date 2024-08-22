import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_shopping_list/models/ShopList.dart';

class FirestoreService {
  final CollectionReference listsDb =
      FirebaseFirestore.instance.collection('shopping_lists');
  Future saveListToDb(String id, ShopList shoppingList) async {
    return listsDb.doc(id).set({"list": shoppingList});
  }

  Future<DocumentSnapshot> getListFromDb(String id) async {
    DocumentSnapshot docSnapshot = await listsDb.doc(id).get();
    return docSnapshot;
  }
}
