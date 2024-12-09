import 'package:ecom_admin/main.dart';
import 'package:ecom_admin/pages/login_page.dart';
import 'package:ecom_admin/providers/auth_provider.dart';
import 'package:ecom_admin/providers/product_provider.dart';
import 'package:ecom_admin/utils/widget_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  static const String routeName = '/category';

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('All Categories'),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.logout))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showSingleTextInputDialogue(
              title: 'New Category',
              context: context,
              onSave: (value) async {
                EasyLoading.show(status: 'Please wait....');
                await context.read<ProductProvider>().addNewCategory(value);
                EasyLoading.dismiss();
                showMsg(context, 'Category Saved');
              },
            );
          },
          child: const Icon(Icons.add),
        ),
        body: Consumer<ProductProvider>(
          builder: (context, provider, child) => provider.categoryList.isEmpty
              ? Center(
                  child: Text('No category found'),
                )
              : ListView.builder(itemCount: provider.categoryList.length,
          itemBuilder:(context, index) =>  ListTile(
            title: Text(provider.categoryList[index].name),
          ),),
        ));
  }
}
