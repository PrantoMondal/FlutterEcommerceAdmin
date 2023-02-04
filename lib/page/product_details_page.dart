import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_admin/models/product_model.dart';
import 'package:flutter_ecommerce_admin/utils/helper_functions.dart';
import 'package:provider/provider.dart';
import '../constants/constants.dart';
import '../providers/product_provider.dart';

class ProductDetailsPage extends StatelessWidget {
  static const routeName = '/product_details';

  const ProductDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pid = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: Consumer<ProductProvider>(
        builder: (context, provider, child) =>
            StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: provider.getProductById(pid),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final product = ProductModel.fromMap(snapshot.data!.data()!);
              return ListView(
                children: [
                  FadeInImage.assetNetwork(
                    placeholder: 'images/loading.gif',
                    image: product.imageUrl!,
                    fadeInDuration: const Duration(seconds: 2),
                    fadeInCurve: Curves.bounceInOut,
                    height: 300,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () {}, child: const Text('Re-Purchase')),
                      TextButton(
                          onPressed: () {
                            provider.getAllPurchaseByProduct(pid);
                            _showPurchaseHistory(context,provider);
                          },
                          child: const Text('Purchase-History')),
                    ],
                  ),
                  ListTile(
                    title: Text(product.name!),
                    trailing: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.edit),
                    ),
                  ),
                  ListTile(
                    title: Text('$currencySymbol${product.salesPrice}'),
                    trailing: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.edit),
                    ),
                  ),
                  ListTile(
                    title: const Text('Product Description'),
                    subtitle: Text(product.description ?? 'Not Available'),
                    trailing: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.edit),
                    ),
                  ),
                  SwitchListTile(
                    title: const Text('Available'),
                    value: product.available,
                    onChanged: (value) {
                      provider.updateProduct(pid, productAvailable, value);
                    },
                  ),
                  SwitchListTile(
                    title: const Text('Featured'),
                    value: product.featured,
                    onChanged: (value) {
                      provider.updateProduct(pid, productFeatured, value);
                    },
                  ),
                ],
              );
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text('Failed to get data'),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  void _showPurchaseHistory(BuildContext context, ProductProvider provider) {
    showModalBottomSheet(context: context, builder:(context) => ListView.builder(
      itemCount: provider.purchaseListOfSpecificProduct.length,
      itemBuilder: (context, index) {
        final purchase = provider.purchaseListOfSpecificProduct[index];
        return ListTile(
          title: Text(getFormattedDateTime(purchase.dateModel.timestamp.toDate(), 'dd/MM/yyyy')),
          subtitle: Text('Quantity: ${purchase.quantity}'),
          trailing: Text('$currencySymbol: ${purchase.price}'),
        );
      },
    ));
  }
}
