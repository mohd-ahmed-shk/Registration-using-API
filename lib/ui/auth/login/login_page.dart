import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/ui/auth/forgot_password/forgot_password_page.dart';
import 'package:task/ui/auth/signup/signup_page.dart';
import 'package:task/widgets/app_button.dart';
import 'package:task/widgets/app_text_field.dart';
import 'package:task/widgets/base_app_bar.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  Future<void> postData(String email, String pass) async {
    final url = Uri.parse('https://sowlab.pw/assignment/user/login');

    Map<String, dynamic> requestData = {
      // "email": "johndoe@mail.com",
      // "password": "12345678",
      "email": email,
      "password": pass,
      "role": "farmer",
      "device_token": "0imfnc8mVLWwsAawjYr4Rx-Af50DDqtlx",
      "type": "email",
      "social_id": "0imfnc8mVLWwsAawjYr4Rx-Af50DDqtlx"
    };

    try {
      final response = await http.post(
        url,
        body: jsonEncode(requestData),
        headers: {
          'Accept': 'application/json',
        },
      );

      var data = json.decode(response.body);

      if (response.statusCode == 200) {
        showSnackBar("message : ${data["message"]}");
      } else {
        showSnackBar("message : ${data["message"]}");
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 5.0).r,
          child: Text(
            "FarmerEats",
            style: TextStyle(fontSize: 18.sp, color: Colors.black),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20).r,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                60.verticalSpace,
                Text(
                  "Welcome back!",
                  style: TextStyle(fontSize: 35.sp),
                ),
                20.verticalSpace,
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignupPage(),
                        ));
                  },
                  child: Text.rich(
                    TextSpan(
                        text: "New here? ",
                        style: TextStyle(fontSize: 15.sp, color: Colors.grey),
                        children: const [
                          TextSpan(
                              text: "Create Account",
                              style: TextStyle(color: Color(0xFFD5715B)))
                        ]),
                  ),
                ),
                70.verticalSpace,
                AppTextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  hintText: 'Email Address',
                  prefixIcon: const Icon(Icons.alternate_email_rounded),
                ),
                20.verticalSpace,
                AppTextField(
                  controller: _passController,
                  textInputAction: TextInputAction.done,
                  hintText: 'Password',
                  prefixIcon: const Icon(
                    Icons.lock_outline_rounded,
                  ),
                  suffixIcon: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ForgetPasswordPage(),
                          ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 15.0, top: 15).r,
                      child: Text(
                        'Forget?',
                        style: TextStyle(
                            fontSize: 15.sp, color: const Color(0xFFD5715B)),
                      ),
                    ),
                  ),
                  // suffixIcon: Text('Forget Password?'),
                ),
                30.verticalSpace,
                AppButton(
                  onPressed: () {
                    RegExp emailRegex =
                        RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
                    bool isValidEmail =
                        emailRegex.hasMatch(_emailController.text);
                    if (_emailController.text.isEmpty) {
                      showSnackBar("Enter your email address");
                    } else if (isValidEmail == false) {
                      showSnackBar("Enter your correct email address");
                    } else if (_passController.text.isEmpty) {
                      showSnackBar("Enter your password");
                    } else {
                      postData(_emailController.text, _passController.text);
                    }
                  },
                  title: 'Login',
                ),
                35.verticalSpace,
                Center(
                  child: Text(
                    "or login with",
                    style: TextStyle(
                        fontSize: 12.sp, color: Colors.grey.withOpacity(0.8)),
                  ),
                ),
                35.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 30)
                          .r,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40).r,
                          border:
                              Border.all(color: Colors.grey.withOpacity(0.4))),
                      child: Image.asset(
                        "assets/images/img_2.png",
                        width: 30.r,
                        height: 30.r,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 30)
                          .r,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40).r,
                          border:
                              Border.all(color: Colors.grey.withOpacity(0.4))),
                      child: Image.asset(
                        "assets/images/img.png",
                        width: 30.r,
                        height: 30.r,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 30)
                          .r,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40).r,
                          border:
                              Border.all(color: Colors.grey.withOpacity(0.4))),
                      child: Image.asset(
                        "assets/images/img_1.png",
                        width: 30.r,
                        height: 30.r,
                      ),
                    ),
                  ],
                ),
                20.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }

  showSnackBar(String text) {
    return ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(text)));
  }
}
