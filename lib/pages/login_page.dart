import 'package:ecom_admin/main.dart';
import 'package:ecom_admin/pages/dashboard_page.dart';
import 'package:ecom_admin/providers/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static const String routeName = '/login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _errorMsg = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
               children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 46, vertical: 4),
                  child: TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        hintText: 'Email Address',
                        prefixIcon: Icon(Icons.email)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is empty';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 46, vertical: 4),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                        hintText: 'Password', prefixIcon: Icon(Icons.lock)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is empty';
                      }
                      return null;
                    },
                  ),
                ),SizedBox(height: 20,),
                ElevatedButton(
                    onPressed: _loginAdmin,
                    child: const Text('Login as Admin')),
                SizedBox(height: 20,),
                Text(
                  _errorMsg,
                  style: TextStyle(color: Colors.red, fontSize: 20),
                ),
              ],
            )),
      ),
    );
  }

  Future<void> _loginAdmin() async {
    if(_formKey.currentState!.validate()){
      final email= _emailController.text;
      final password = _passwordController.text;
      EasyLoading.show(status: 'Please wait.....');

     try{
      final isAdmin= await context.read<FirebaseAuthProvider>().login(email, password);
       if(isAdmin){
         Navigator.pushReplacementNamed(context, DashBoardPage.routeName);

       } else{
        await  context.read<FirebaseAuthProvider>().logout();
        setState(() {
          _errorMsg= 'This email address is not associated with an Admin account. Please log in with a valid email address to login as Admin ';
        });
    }
     }on FirebaseException catch(error){
       setState(() {
         _errorMsg= 'Login failed${error.message!}';
       });

     }finally{
       EasyLoading.dismiss();
     }
    }
  }
}
