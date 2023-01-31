import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_admin/page/product_details_page.dart';
import 'package:provider/provider.dart';
import '../constants/constants.dart';
import '../providers/product_provider.dart';
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
      appBar: AppBar(
        title: const Text('New Product Page'),
      ),
      body: Consumer<ProductProvider>(
        builder: (context, provider, _) => provider.productList.isEmpty
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
                itemCount: provider.productList.length,
                itemBuilder: (context, index) {
                  final product = provider.productList[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 2.0),
                    child: ListTile(
                      onTap: () {
                        Navigator.pushNamed(context, ProductDetailsPage.routeName,arguments: product.id);
                      },
                      tileColor: index.isEven
                          ? Colors.blue.shade100
                          : Colors.cyanAccent.shade100,
                      title: Text(product.name!),
                      leading: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network(product.imageUrl!)),
                      trailing:
                          Text('Price: $currencySymbol ${product.salesPrice}'),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
