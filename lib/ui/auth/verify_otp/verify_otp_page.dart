import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

import '../../../widgets/app_button.dart';
import '../../../widgets/base_app_bar.dart';
import '../login/login_page.dart';
import '../reset_password/reset_password_page.dart';

class VerifyOTPPage extends StatefulWidget {
  const VerifyOTPPage({super.key});

  @override
  State<VerifyOTPPage> createState() => _VerifyOTPPageState();
}

class _VerifyOTPPageState extends State<VerifyOTPPage> {
  OtpFieldController otpController = OtpFieldController();

  String length = "";

  Future<void> postData(String otp) async {
    final url = Uri.parse('https://sowlab.pw/assignment/user/verify-otp');

    Map<String, dynamic> requestData = {"otp": "895642"};

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
    otpController.clear();
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
                  "Verify OTP",
                  style: TextStyle(fontSize: 35.sp),
                ),
                20.verticalSpace,
                InkWell(
                  highlightColor: Colors.transparent,
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
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
                OTPTextField(
                  length: 5,
                  controller: otpController,
                  width: MediaQuery.of(context).size.width,
                  textFieldAlignment: MainAxisAlignment.spaceBetween,
                  keyboardType: TextInputType.number,
                  fieldStyle: FieldStyle.box,
                  fieldWidth: 60.r,
                  otpFieldStyle: OtpFieldStyle(
                    backgroundColor: Colors.grey.withOpacity(0.2),
                    borderColor: Colors.grey.withOpacity(0.2),
                  ),
                  isDense: true,
                  outlineBorderRadius: 10.r,
                  contentPadding: const EdgeInsets.symmetric(vertical: 20).r,
                  onChanged: (value) {},
                  onCompleted: (pin) {
                    length = pin;
                  },
                ),
                30.verticalSpace,
                AppButton(
                  onPressed: () {
                    if (length.length != 5) {
                      showSnackBar("Enter the correct OTP");
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ResetPasswordPage(),
                          ));
                      postData(length);

                      length = "";
                      otpController.clear();
                    }
                  },
                  title: 'Submit',
                ),
                20.verticalSpace,
                Center(
                  child: Text(
                    "Resend Code",
                    style: TextStyle(
                        fontSize: 15.sp,
                        color: Colors.black,
                        decoration: TextDecoration.underline),
                  ),
                ),
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
