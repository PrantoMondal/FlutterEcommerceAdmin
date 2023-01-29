import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_admin/providers/product_provider.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';

class CategoryPage extends StatelessWidget {
  static const routeName = '/category';

  const CategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();

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
                    title: Text('${category.name} (${category.productCount})'),
                  );
                },
              ),
      ),
      bottomSheet: DraggableScrollableSheet(
        initialChildSize: 0.1,
        expand: false,
        minChildSize: 0.1,
        maxChildSize: 0.4,
        builder: (BuildContext context, ScrollController scrollController) {
          return Container(
            color: Colors.blue[100],
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            child: ListView(
              controller: scrollController,
              children: [
                const Icon(Icons.drag_handle),
                const ListTile(
                  title: Text('ADD CATEGORY'),
                ),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    hintText: 'Enter New Category',
                    filled: true,
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: ElevatedButton(
                      onPressed: () async {
                        nameController.text.isEmpty
                            ? ""
                            : await Provider.of<ProductProvider>(context,
                                    listen: false)
                                .addCategory(nameController.text);
                        nameController.clear();
                      },
                      child: const Text('ADD')),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
