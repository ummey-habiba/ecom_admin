import 'package:ecom_admin/pages/dashboard_page.dart';
import 'package:ecom_admin/pages/login_page.dart';
import 'package:ecom_admin/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LauncherPage extends StatefulWidget {
  const LauncherPage({super.key});

  static const String routeName = '/';

  @override
  State<LauncherPage> createState() => _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage> {
  @override
  void didChangeDependencies() {
    final authProvider = context.read<FirebaseAuthProvider> ();
    Future.delayed(const Duration(seconds: 0),(){
      if(authProvider.currentUser != null){
        Navigator.pushReplacementNamed(context, DashBoardPage.routeName);
      }else{
        Navigator.pushReplacementNamed(context, LoginPage.routeName);
      }
      
    });
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
