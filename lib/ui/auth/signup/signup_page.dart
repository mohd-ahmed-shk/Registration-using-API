import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/ui/auth/login/login_page.dart';
import 'package:task/ui/auth/signup/signup_farm_page.dart';
import 'package:task/widgets/app_button.dart';

import '../../../widgets/app_text_field.dart';
import '../../../widgets/base_app_bar.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _nameController = TextEditingController();
  final _numberController = TextEditingController(text: "+");
  final _confirmController = TextEditingController();


  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passController.dispose();
    _nameController.dispose();
    _numberController.dispose();
    _confirmController.dispose();
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
                10.verticalSpace,
                Text(
                  "Signup 1 of 4",
                  style: TextStyle(fontSize: 15.sp, color: Colors.black),
                ),
                Text(
                  "Welcome",
                  style: TextStyle(fontSize: 35.sp),
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
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "or signup with",
                    style: TextStyle(
                        fontSize: 10.sp, color: Colors.grey.withOpacity(0.4)),
                  ),
                ),
                20.verticalSpace,
                AppTextField(
                  controller: _nameController,
                  textInputAction: TextInputAction.next,
                  hintText: 'Full name',
                  prefixIcon: const Icon(
                    Icons.lock_outline_rounded,
                  ),
                ),
                20.verticalSpace,
                AppTextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  hintText: 'Email Address',
                  prefixIcon: const Icon(Icons.alternate_email_rounded),
                ),
                20.verticalSpace,
                AppTextField(
                  controller: _numberController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  maxLength: 12,
                  hintText: 'Phone Number',
                  prefixIcon: const Icon(Icons.phone_outlined),
                ),
                20.verticalSpace,
                AppTextField(
                  controller: _passController,
                  textInputAction: TextInputAction.next,
                  hintText: 'Password',
                  prefixIcon: const Icon(
                    Icons.lock_outline_rounded,
                  ),
                ),
                20.verticalSpace,
                AppTextField(
                  controller: _confirmController,
                  keyboardType: TextInputType.emailAddress,
                  hintText: 'Re-enter Password',
                  prefixIcon: const Icon(Icons.lock_outline),
                ),
                30.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        onTap: () {

                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginPage()),
                                (route) => false,
                          );
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 15.sp,
                              color: Colors.black,
                              decoration: TextDecoration.underline),
                        )),
                    AppButton(
                        width: 200.w,
                        onPressed: () {
                          RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
                          bool isValidEmail = emailRegex.hasMatch(_emailController.text);
                          if (_nameController.text.isEmpty) {
                            showSnackBar("Enter your full name");
                          } else if (_emailController.text.isEmpty) {
                            showSnackBar("Enter your email");
                          } else if(isValidEmail == false) {
                            showSnackBar("Enter correct email");

                          }
                          else if (_numberController.text.isEmpty) {
                            showSnackBar("Enter your Phone number");
                          } else if (_passController.text.isEmpty || _passController.text.length < 6) {
                            showSnackBar("Enter password");
                          } else if (_confirmController.text.isEmpty || _confirmController.text.length < 6) {
                            showSnackBar("Enter confirm password");
                          } else if (_passController.text !=
                              _confirmController.text) {
                            showSnackBar("Password does not match");
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignupFarmPage(
                                      fullName: _nameController.text,
                                      email: _emailController.text,
                                      phoneNumber: _numberController.text,
                                      password: _passController.text,
                                      confirmPassword: _passController.text),
                                ));
                          }
                        },
                        title: "Continue")
                  ],
                ),
                20.verticalSpace
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
