import 'package:ecom_admin/customwidgets/dashboard_item_view.dart';
import 'package:ecom_admin/main.dart';
import 'package:ecom_admin/models/dashboard_models.dart';
import 'package:ecom_admin/pages/login_page.dart';
import 'package:ecom_admin/providers/auth_provider.dart';
import 'package:ecom_admin/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashBoardPage extends StatelessWidget {
  const DashBoardPage({super.key});


  static const String routeName = '/dashboard';

  @override
  Widget build(BuildContext context) {
    context.read<ProductProvider>().getAllCategories();
    context.read<ProductProvider>().getAllProducts();
    return Scaffold(
        appBar: AppBar(
          title: Text('Dashboard'),
          actions: [
            IconButton(
                onPressed: () {
                  context.read<FirebaseAuthProvider>().logout().then((_) =>
                      Navigator.pushReplacementNamed(
                          context, LoginPage.routeName));
                },
                icon: Icon(Icons.logout))
          ],
        ),
        body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 2,
            mainAxisSpacing: 2
          ),
          itemCount: dashboarditem.length,
          itemBuilder: (context, index) {
            final item = dashboarditem[index];
            return DashboardItemView(model: item);
          },
        ));
  }
}
