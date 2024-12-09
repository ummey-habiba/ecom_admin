import 'package:ecom_admin/main.dart';
import 'package:ecom_admin/models/product_model.dart';
import 'package:ecom_admin/pages/login_page.dart';
import 'package:ecom_admin/pages/product_details_page.dart';
import 'package:ecom_admin/providers/auth_provider.dart';
import 'package:ecom_admin/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewProductPage extends StatefulWidget {
  const ViewProductPage({super.key});

  static const String routeName = '/viewproduct';

  @override
  State<ViewProductPage> createState() => _ViewProductPageState();
}

class _ViewProductPageState extends State<ViewProductPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Product'),
        actions: [
          IconButton(onPressed: () {

          }, icon: Icon(Icons.logout))
        ],
      ),
      body: Consumer<ProductProvider>(
        builder: (context, provider, child) => ListView.builder(itemCount:provider.productList.length,itemBuilder: (context, index) {
          final product= provider.productList[index];
          return ListTile(
            onTap:() =>  Navigator.pushNamed(context, ProductDetailsPage.routeName),
            title: Text(product.productName),
            subtitle: Text(product.categoryModel.name),
            trailing: Text('Stock: ${product.stock}'),

          );
        },),),
    );
  }
}
