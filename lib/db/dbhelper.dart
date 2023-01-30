import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_ecommerce_admin/models/product_model.dart';
import 'package:flutter_ecommerce_admin/models/purchase_model.dart';

import '../models/category_model.dart';

class DbHelper {
  static const String collectionAdmin = 'Admins';
  static const String collectionCategory = 'Categories';
  static const String collectionProduct = 'Products';
  static const String collectionPurchase = 'Purchases';
  static FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<bool> isAdmin(String uid) async {
    final snapshot = await _db.collection(collectionAdmin).doc(uid).get();
    return snapshot.exists;
  }

  static Future<void> addCategory(CategoryModel categoryModel) {
    final doc = _db.collection(collectionCategory).doc();
    categoryModel.id = doc.id;
    return doc.set(categoryModel.toMap());
  }

  static Future<void> addProduct(ProductModel productModel,
      PurchaseModel purchaseModel, String categoryId, num count) {
    final wb = _db.batch();
    final productDoc = _db.collection(collectionProduct).doc();
    final purchaseDoc = _db.collection(collectionPurchase).doc();
    final categoryDoc = _db.collection(collectionCategory).doc(categoryId);
    productModel.id = productDoc.id;
    purchaseModel.id = purchaseDoc.id;
    purchaseModel.productId = productDoc.id;
    wb.set(productDoc, productModel.toMap());
    wb.set(purchaseDoc, purchaseModel.toMap());
    wb.update(categoryDoc, {'productCount': count});
    return wb.commit();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllCategories() =>
      _db.collection(collectionCategory).snapshots();

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllProducts() =>
      _db.collection(collectionProduct).snapshots();
}
