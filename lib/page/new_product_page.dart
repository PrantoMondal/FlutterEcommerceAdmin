import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_admin/models/date_model.dart';
import 'package:flutter_ecommerce_admin/models/product_model.dart';
import 'package:flutter_ecommerce_admin/models/purchase_model.dart';
import 'package:flutter_ecommerce_admin/utils/helper_functions.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../providers/product_provider.dart';

class NewProductPage extends StatefulWidget {
  static const String routeName = '/new_product';

  const NewProductPage({Key? key}) : super(key: key);

  @override
  State<NewProductPage> createState() => _NewProductPageState();
}

class _NewProductPageState extends State<NewProductPage> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final salePriceController = TextEditingController();
  final purchasePriceController = TextEditingController();
  final quantityController = TextEditingController();
  DateTime? _purchaseDate;
  String? _imageUrl;
  String? _category;
  ImageSource _imageSource = ImageSource.camera;
  final from_key = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    salePriceController.dispose();
    purchasePriceController.dispose();
    quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Product'),
        actions: [
          IconButton(onPressed: _saveProduct, icon: Icon(Icons.save)),
        ],
      ),
      body: Form(
        key: from_key,
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Plant Name',
                prefixIcon: Icon(Icons.drive_file_rename_outline),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This field must not be empty';
                }
                if (value.length > 20) {
                  return 'Name must be in 20 character';
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              keyboardType: TextInputType.text,
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: 'Product Description',
                prefixIcon: Icon(Icons.description),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This field must not be empty';
                } else {
                  return null;
                }
              },
            ),
            TextFormField(
              controller: purchasePriceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Purchase Price',
                prefixIcon: Icon(Icons.monetization_on),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This field must not be empty';
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: salePriceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Sale Price',
                prefixIcon: Icon(Icons.monetization_on),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This field must not be empty';
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: quantityController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Quantity',
                prefixIcon: Icon(Icons.numbers),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This field must not be empty';
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Consumer<ProductProvider>(
              builder: (context, provider, _) =>
                  DropdownButtonFormField<String>(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field must not be empty';
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  setState(() {
                    _category = value;
                  });
                },
                hint: const Text('Select Category'),
                value: _category,
                items: provider.categoryList
                    .map((model) => DropdownMenuItem<String>(
                          value: model.name,
                          child: Text(model.name!),
                        ))
                    .toList(),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: _selectDate,
                      child: Text('Select Purchase Date')),
                  Text(_purchaseDate == null
                      ? 'No Date Chosen'
                      : getFormattedDateTime(_purchaseDate!, 'dd/MM/yyyy')),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Card(
              margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 80),
              elevation: 5,
              child: _imageUrl == null
                  ? Image.asset(
                      'images/plant.png',
                      height: 120,
                      width: 100,
                      fit: BoxFit.contain,
                    )
                  : Image.network(
                      _imageUrl!,
                      height: 120,
                      width: 100,
                      fit: BoxFit.contain,
                    ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      _imageSource = ImageSource.camera;
                      _getImage();
                    },
                    child: const Text('Camera')),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      _imageSource = ImageSource.gallery;
                      _getImage();
                    },
                    child: Text('Gallary')),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _saveProduct() async {
    if (_imageUrl == null) {
      showMsg(context, 'Image required for product');
      return;
    }
    if (_purchaseDate == null) {
      showMsg(context, 'Purchase Date is required');
      return;
    }
    if (from_key.currentState!.validate()) {
      final productModel = ProductModel(
        name: nameController.text,
        description: descriptionController.text,
        category: _category,
        salesPrice: num.parse(salePriceController.text),
        imageUrl: _imageUrl,
      );
      final purchaseModel = PurchaseModel(
        dateModel: DateModel(
          timestamp: Timestamp.fromDate(_purchaseDate!),
          day: _purchaseDate!.day,
          month: _purchaseDate!.month,
          year: _purchaseDate!.year,
        ),
        price: num.parse(purchasePriceController.text),
        quantity: num.parse(quantityController.text),
      );
      final catModel =
          context.read<ProductProvider>().getCategoryByName(_category!);
      context
          .read<ProductProvider>()
          .addProduct(productModel, purchaseModel, catModel)
          .then((value) {
        setState(() {
          nameController.clear();
          descriptionController.clear();
          purchasePriceController.clear();
          salePriceController.clear();
          quantityController.clear();
          _purchaseDate = null;
          _imageUrl = null;
          _category = null;
        });
      });
    }
  }

  void _selectDate() async {
    final selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime.now());
    if (selectedDate != null) {
      setState(() {
        _purchaseDate = selectedDate;
      });
    }
  }

  void _getImage() async {
    final selectedImage = await ImagePicker().pickImage(source: _imageSource);
    if (selectedImage != null) {
      try {
        final url =
            await context.read<ProductProvider>().updateImage(selectedImage);
        setState(() {
          _imageUrl = url;
        });
      } catch (e) {}
    }
  }
}
