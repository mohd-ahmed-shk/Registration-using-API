import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/ui/auth/verify_otp/verify_otp_page.dart';
import 'package:task/widgets/app_button.dart';
import 'package:http/http.dart' as http;

import '../../../widgets/app_text_field.dart';
import '../../../widgets/base_app_bar.dart';
import '../login/login_page.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final _numberController = TextEditingController(text: "+");

  Future<void> postData(
    String number,
  ) async {
    final url = Uri.parse('https://sowlab.pw/assignment/user/forgot-password');

    Map<String, dynamic> requestData = {"mobile": number};

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              60.verticalSpace,
              Text(
                "Forgot Password?",
                style: TextStyle(fontSize: 35.sp),
              ),
              20.verticalSpace,
              InkWell(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                    (route) => false,
                  );
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
                controller: _numberController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                maxLength: 12,
                hintText: 'Phone Number',
                prefixIcon: const Icon(Icons.phone_outlined),
              ),
              20.verticalSpace,
              AppButton(
                  onPressed: () {
                    if (_numberController.text.isEmpty) {
                      showSnackBar("Enter your phone number");
                    } else if (_numberController.text.length != 12) {
                      showSnackBar("Enter correct phone number");
                    } else {
                      postData(_numberController.text);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const VerifyOTPPage(),
                          ));
                    }
                  },
                  title: "Send Code")
            ],
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
