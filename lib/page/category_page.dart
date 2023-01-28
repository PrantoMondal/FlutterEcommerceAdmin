import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_admin/providers/product_provider.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';

class CategoryPage extends StatelessWidget {
  static const routeName = '/category';

  const CategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<ProductProvider>(context, listen: false).getAllCategories();
    return Scaffold(
      appBar: AppBar(title: const Text('Category Page')),
      body: Consumer<ProductProvider>(
        builder: (context, provider, _) => provider.categoryList.isEmpty
            ? Center(
                child: Stack(
                  children: [
                    // Image.asset('images/person.png'),
                    Text(
                      'No item found',
                      style: Styles.textStyle,
                    ),
                  ],

                ),
              )
            : ListView.builder(
                itemCount: provider.categoryList.length,
                itemBuilder: (context, index) {
                  final category = provider.categoryList[index];
                  return ListTile(
                    title: Text('${category.name}(${category.productCount})'),
                  );
                },
              ),
      ),
    );
  }
}
