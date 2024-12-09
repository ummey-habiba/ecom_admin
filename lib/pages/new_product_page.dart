import 'dart:io';

import 'package:ecom_admin/main.dart';
import 'package:ecom_admin/models/category_model.dart';
import 'package:ecom_admin/models/product_model.dart';
import 'package:ecom_admin/pages/login_page.dart';
import 'package:ecom_admin/providers/auth_provider.dart';
import 'package:ecom_admin/providers/product_provider.dart';
import 'package:ecom_admin/utils/widget_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class NewProductPage extends StatefulWidget {
  const NewProductPage({super.key});

  static const String routeName = '/newproduct';

  @override
  State<NewProductPage> createState() => _NewProductPageState();
}

class _NewProductPageState extends State<NewProductPage> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _stokeController = TextEditingController();
  final _discountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  CategoryModel? categoryModel;
  String? localImagePath;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('New Product'),
          actions: [
            IconButton(
                onPressed: _saveProduct,
                icon: Icon(Icons.save))
          ],
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                Column(
                  children: [
                    Card(
                      elevation: 5.0,
                      child: localImagePath == null
                          ? const Icon(
                        Icons.person,
                        size: 100,
                      )
                          : Image.file(
                        File(localImagePath!),
                        height: 100,
                        width: 100,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OutlinedButton.icon(
                          onPressed: () {
                            _getImage(ImageSource.camera);
                          },
                          label: const Text('Capture'),
                          icon: const Icon(Icons.camera),
                        ),
                        OutlinedButton.icon(
                          onPressed: () {
                            _getImage(ImageSource.gallery);
                          },
                          label: const Text('Gallery'),
                          icon: const Icon(Icons.photo),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Product Name',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Product name is empty';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: TextFormField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Product Description',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Description is empty';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: TextFormField(
                    controller: _priceController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Product Price',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Product price is empty';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: TextFormField(
                    controller: _stokeController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Product stoke',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Product stoke is empty';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: TextFormField(
                    controller: _discountController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Discount%',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Consumer<ProductProvider>(
                    builder: (context, provider, child) =>
                        DropdownButtonFormField<CategoryModel>(
                          hint: const Text('Select Category'),
                          isExpanded: true,
                          decoration:
                          const InputDecoration(border: InputBorder.none),
                          items: provider.categoryList
                              .map((model) =>
                              DropdownMenuItem<CategoryModel>(
                                  value: model, child: Text(model.name)))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              categoryModel = value!;
                            });
                          },
                        ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  void _getImage(ImageSource source) async {
    final xFile = await ImagePicker().pickImage(
        source: source, imageQuality: 60);
    if (xFile != null) {
      setState(() {
        localImagePath = xFile.path;
      });
    }
  }

  void _saveProduct()async {
    if (localImagePath == null) {
      return showMsg(context, 'No image selected');
    }
    if (_formKey.currentState!.validate()) {
      EasyLoading.show(status: 'Please wait...');
      try {
        final product = ProductModel(
          categoryModel: categoryModel!,
          productName: _nameController.text,
          price: num.parse(_priceController.text),
          stock: num.parse(_stokeController.text),
          description: _descriptionController.text,
          imageUrl: localImagePath!);
    await context.read<ProductProvider>().addNewProduct(product);
        EasyLoading.dismiss();
        showMsg(context, 'Saved');
        _resetFields();
  }catch(error){
EasyLoading.dismiss();
showMsg(context, error.toString());

    }
  }
  }

  void _resetFields() {
    setState(() {
      _nameController.clear();
      _priceController.clear();
      _stokeController.clear();
      _descriptionController.clear();
      _discountController.clear();
      categoryModel=null;
      localImagePath=null;
    });
  }
}
