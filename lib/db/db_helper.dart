import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_admin/models/category_model.dart';
import 'package:ecom_admin/models/product_model.dart';

class DbHelper {
  DbHelper._();

  static final _db = FirebaseFirestore.instance;
  static const String _collectionAdmin = 'Admins';
  static const String _collectionCategory = 'Categories';
  static const String _collectionProduct= 'Product';

  static Future<bool> isAdmin(String uid) async {
    final snapshot = await _db.collection(_collectionAdmin).doc(uid).get();
    return snapshot.exists;
  }

  static Future<void> addCategory(CategoryModel model) {
    return _db.collection(_collectionCategory).add(model.toMap());
  }
  static Future<void> addProduct(ProductModel model) {
    final doc= _db.collection(_collectionProduct).doc();
    model.id= doc.id;
    return doc.set(model.toMap());
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllCategories() =>
      _db.collection(_collectionCategory).orderBy('name').snapshots();
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllProducts() =>
      _db.collection(_collectionProduct).snapshots();

  static Future<void> updateSingleProductField(String id, String field, dynamic value){
    return _db.collection(_collectionProduct).doc(id).update({field: value});
  }
}
