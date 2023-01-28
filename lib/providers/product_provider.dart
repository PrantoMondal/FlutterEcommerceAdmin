import 'package:flutter/cupertino.dart';
import 'package:flutter_ecommerce_admin/db/dbhelper.dart';
import 'package:flutter_ecommerce_admin/models/category_model.dart';
import 'package:flutter_ecommerce_admin/models/product_model.dart';

class ProductProvider extends ChangeNotifier {
  List<ProductModel> productList = [];
  List<CategoryModel> categoryList = [];

  getAllCategories(){
    DbHelper.getAllCategories().listen((snapshot){
      categoryList = List.generate(snapshot.docs.length, (index) => CategoryModel.fromMap(snapshot.docs[index].data()));
      notifyListeners();
    });

  }



}