import 'package:ecom_admin/main.dart';
import 'package:ecom_admin/pages/login_page.dart';
import 'package:ecom_admin/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  static const String routeName = '/order';

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order'),
        actions: [
          IconButton(onPressed: () {

          }, icon: Icon(Icons.logout))
        ],
      ),
      body: const Center(
        child: Text('Order'),
      ),
    );
  }
}
