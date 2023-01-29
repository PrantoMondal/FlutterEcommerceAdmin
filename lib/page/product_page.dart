import 'package:flutter/material.dart';

import 'new_product_page.dart';

class ProductPage extends StatefulWidget {
  static const routeName = '/product';

  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, NewProductPage.routeName),
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(title: Text('New Product Page'),),
    );
  }
}
