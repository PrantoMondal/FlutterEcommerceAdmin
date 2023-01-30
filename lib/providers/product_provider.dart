import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_ecommerce_admin/db/dbhelper.dart';
import 'package:flutter_ecommerce_admin/models/category_model.dart';
import 'package:flutter_ecommerce_admin/models/product_model.dart';
import 'package:flutter_ecommerce_admin/models/purchase_model.dart';
import 'package:image_picker/image_picker.dart';

class ProductProvider extends ChangeNotifier {
  List<ProductModel> productList = [];
  List<CategoryModel> categoryList = [];

  getAllCategories() {
    DbHelper.getAllCategories().listen((snapshot) {
      categoryList = List.generate(snapshot.docs.length,
          (index) => CategoryModel.fromMap(snapshot.docs[index].data()));
      notifyListeners();
    });
  }


  Future<void> addCategory(String category) {
    final categoryModel = CategoryModel(
      name: category,
    );
    return DbHelper.addCategory(categoryModel);
  }

  Future<void> addProduct(ProductModel productModel, PurchaseModel purchaseModel, CategoryModel categoryModel) {
    final count = categoryModel.productCount + purchaseModel.quantity;
    return DbHelper.addProduct(productModel, purchaseModel, categoryModel.id!, count);
  }


  CategoryModel getCategoryByName(String name) {
    final model = categoryList.firstWhere((element) => element.name == name);
    return model;
  }

  Future<String> updateImage(XFile xFile) async {
    final imageName = DateTime.now().millisecondsSinceEpoch.toString();
    final photoRef =
        FirebaseStorage.instance.ref().child('Pictures/$imageName');
    final uploadTask = photoRef.putFile(File(xFile.path));
    final snapshot = await uploadTask.whenComplete(() => null);
    return snapshot.ref.getDownloadURL();
  }
}
