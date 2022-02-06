import 'package:farm/widget/app_text.dart';
import 'package:farm/widget/btn.dart';
import 'package:farm/widget/input.dart';
import 'package:farm/widget/varaible.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../tools/validations.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //logo----------------------------------------------------------------
                  const CircleAvatar(
                    radius: 55.0,
                    backgroundImage: AssetImage(
                      'assets/images/profile.png',
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  //تسجيل الدخول----------------------------------------------------------------
                  const AppText(
                    text: 'تسجيل الدخول',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  const SizedBox(height: 20.0),
                  //تسجيل الدخول----------------------------------------------------------------

                  Input(
                    controller: _emailController,
                    hintText: 'البريد الالكتروني',
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    icon: nameIcon,
                    validator: (value) {
                      return ValidatorClass.validateEmail(value);
                    },
                  ),
                  const SizedBox(height: 10.0),
                  //كلمة المرور ----------------------------------------------------------------

                  Input(
                    controller: _passwordController,
                    hintText: 'كلمة المرور',
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    icon: emailIcon,
                    validator: (value) {
                      return ValidatorClass.emptyField(value);
                    },
                  ),

                  const SizedBox(height: 40.0),
                  //logging buttom---------------------------------------------------------------

                  Btn(
                    onPressed: () {
                      // for validations
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                      //
                      if (_emailController.text.isNotEmpty &&
                          _passwordController.text.isNotEmpty) {
                        //
                        final _firebaseAuth = FirebaseAuth.instance;
                        // signInWithEmailAndPassword() from firebase auth package
                        _firebaseAuth
                            .signInWithEmailAndPassword(
                                email: _emailController.text.trim(),
                                password: _passwordController.text.trim())
                            .then((value) {
                          EasyLoading.showSuccess('login success');
                          debugPrint('value $value');
                          // Push.to(context, DashboardScreen());
                        }).catchError((onError) {
                          if (onError != null) {
                            EasyLoading.showError('$onError');
                          }
                          debugPrint('onError $onError');
                        });
                      }
                    },
                    title: 'تسجيل دخول',
                  ),
                  const SizedBox(height: 5.0),
                  //singup buttom---------------------------------------------------------------

                  Btn(
                    color: Colors.white,
                    txtColor: Colors.black,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    title: 'إنشاء حساب ',
                  ),
                  //---------------------------------------------------------------
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
