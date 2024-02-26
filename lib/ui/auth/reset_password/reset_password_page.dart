import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/ui/auth/login/login_page.dart';
import 'package:task/widgets/app_button.dart';
import 'package:http/http.dart' as http;

import '../../../widgets/app_text_field.dart';
import '../../../widgets/base_app_bar.dart';



class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  Future<void> postData() async {
    final url = Uri.parse('https://sowlab.pw/assignment/user/reset-password');

    Map<String, dynamic> requestData = {
      "token": "895642",
      "password": passwordController.text,
      "cpassword": confirmController.text
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
    passwordController.dispose();
    confirmController.dispose();
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
                  "Reset Password",
                  style: TextStyle(fontSize: 35.sp),
                ),
                20.verticalSpace,
                InkWell(
                  onTap: () {
                    // Navigator.pushAndRemoveUntil(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => const LoginPage()),
                    //       (route) => false,
                    // );
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage(),));
                    },
                  child: Text.rich(
                    TextSpan(
                        text: "Remember your password? ",
                        style: TextStyle(fontSize: 15.sp, color: Colors.grey),
                        children: const [
                          TextSpan(
                              text: "Login",
                              style: TextStyle(color: Color(0xFFD5715B)))
                        ]),
                  ),
                ),
                70.verticalSpace,
                AppTextField(
                  controller: passwordController,
                  keyboardType: TextInputType.emailAddress,
                  hintText: 'New Password',
                  prefixIcon: const Icon(Icons.lock_outline),
                ),
                20.verticalSpace,
                AppTextField(
                  controller: confirmController,
                  keyboardType: TextInputType.emailAddress,

                  hintText: 'Confirm New Password',
                  prefixIcon: const Icon(Icons.lock_outline),

                ),
                30.verticalSpace,
                AppButton(onPressed: () async {
                  if(passwordController.text.isEmpty || passwordController.text.length < 6) {
                    showSnackBar("Enter your new password");
                  } else if(confirmController.text.isEmpty) {
                    showSnackBar("Enter your confirm new password");
                  }  else if(confirmController.text != passwordController.text) {
                     showSnackBar("Password does not match");
                  } else {
                    await postData();
                    showSnackBar("Password updated successfully");
                  }
                }, title: "Submit")
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
