import 'package:ecom_admin/firebase_options.dart';
import 'package:ecom_admin/pages/category_page.dart';
import 'package:ecom_admin/pages/dashboard_page.dart';
import 'package:ecom_admin/pages/launcher_page.dart';
import 'package:ecom_admin/pages/login_page.dart';

import 'package:ecom_admin/pages/login_page.dart';
import 'package:ecom_admin/pages/new_product_page.dart';
import 'package:ecom_admin/pages/order_page.dart';
import 'package:ecom_admin/pages/product_details_page.dart';
import 'package:ecom_admin/pages/view_product_page.dart';
import 'package:ecom_admin/providers/auth_provider.dart';
import 'package:ecom_admin/providers/product_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => FirebaseAuthProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => ProductProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      builder: EasyLoading.init(),
      debugShowCheckedModeBanner: false,
      initialRoute: LauncherPage.routeName,
      routes: {
        LauncherPage.routeName: (context) => const LauncherPage(),
        LoginPage.routeName: (context) => const LoginPage(),
        DashBoardPage.routeName: (context) => const DashBoardPage(),
        NewProductPage.routeName: (context) => const NewProductPage(),
        ViewProductPage.routeName: (context) => const ViewProductPage(),
        CategoryPage.routeName: (context) => const CategoryPage(),
        OrderPage.routeName: (context) => const OrderPage(),
        ProductDetailsPage.routeName: (context) => const ProductDetailsPage(),
      },
    );
  }
}
