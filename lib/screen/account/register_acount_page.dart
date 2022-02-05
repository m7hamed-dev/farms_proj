import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm/tools/push.dart';
import 'package:farm/tools/random_id.dart';
import 'package:farm/widget/app_text.dart';
import 'package:farm/widget/btn.dart';
import 'package:farm/widget/input.dart';
import 'package:farm/widget/varaible.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'loging_page.dart';

class RegisterAccountPage extends StatefulWidget {
  const RegisterAccountPage({Key? key, this.isShowAppBar}) : super(key: key);

  ///
  final bool? isShowAppBar;
  @override
  State<RegisterAccountPage> createState() => _RegisterAccountPageState();
}

class _RegisterAccountPageState extends State<RegisterAccountPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  //
  bool visibleEmail = true;
  bool visiblePassword = true;
  //
  //
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> _map = Map<String, dynamic>();

  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20.0),
                const AppText(
                  text: 'إنشاء حساب',
                  fontSize: 30.0,
                ),
                const SizedBox(height: 20.0),
                //iprofile image----------------------------------------------------------------
                _headerProfile(),
                //----------------------------------------------------------------
                const SizedBox(height: 20.0),
                //name textField----------------------------------------------------------------

                Input(
                  controller: _nameController,
                  hintText: 'الاسم',
                  icon: nameIcon,
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                ),
                const SizedBox(height: 10.0),
                //number textField----------------------------------------------------------------

                Input(
                  controller: _numberController,
                  hintText: 'رقم السجل التجاري',
                  icon: recordIcon,
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                ),
                const SizedBox(height: 10.0),
                //phone textField----------------------------------------------------------------

                Input(
                  controller: _phoneController,
                  hintText: 'رقم الجوال',
                  icon: phoneIcon,
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                ),
                const SizedBox(height: 10.0),
                //email textField----------------------------------------------------------------

                Input(
                  controller: _emailController,
                  hintText: 'الايميل',
                  icon: emailIcon,
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  validator: (value) {},
                ),
                const SizedBox(height: 10.0),
                //pass textField----------------------------------------------------------------

                Input(
                  controller: _passwordController,
                  hintText: 'كلمة المرور',
                  icon: showPassIcon,
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                ),
                const SizedBox(height: 20.0),
                //sing up buttom ----------------------------------------------------------------

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Btn(
                    onPressed: () {
                      // for auth
                      final _firebaseAuth = FirebaseAuth.instance;
                      // for save data on firestore
                      final _db = FirebaseFirestore.instance;
                      //
                      _firebaseAuth
                          .createUserWithEmailAndPassword(
                        email: _emailController.text.trim(),
                        password: _passwordController.text.trim(),
                      )
                          .then((value) {
                        _map = {
                          'account_id': randomId,
                          'name': _nameController.text,
                          'number_comercial': _numberController.text,
                          'email': _emailController.text,
                          'password': _passwordController.text,
                          'role': 'user',
                        };
                        _db
                            .collection('accountCollection')
                            .doc(randomId)
                            .set(_map)
                            .then((value) {
                          EasyLoading.showSuccess('Register success');
                        });
                        // Push.to(context, DashboardScreen());
                      }).catchError((onError) {
                        debugPrint('onError $onError');
                        EasyLoading.showError('Error While Register !!');
                      });
                      //
                    },
                    title: 'التسجيل بالتطبيق',
                  ),
                ),
                const SizedBox(height: 10.0),
                //logging buttom----------------------------------------------------------------

                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Btn(
                    color: Colors.white,
                    onPressed: () {
                      Push.to(context, const LoginPage());
                    },
                    title: 'تسجيل دخول',
                    txtColor: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

//-----------------------------------------------------------------------------------------
  InkWell _headerProfile() {
    return InkWell(
      onTap: () {},
      child: Stack(
        clipBehavior: Clip.none,
        children: [
//image===========================
          const CircleAvatar(
            radius: 55.0,
            backgroundImage: AssetImage(
              'assets/images/profile.png',
            ),
          ),
//icon===========================

          Positioned(
            bottom: 0,
            left: -10,
            child: CircleAvatar(
              radius: 17.0,
              child: IconButton(
                padding: const EdgeInsets.all(4.0),
                onPressed: () {},
                icon: const Icon(Icons.add),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
