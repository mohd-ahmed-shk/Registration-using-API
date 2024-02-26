import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/ui/auth/signup/signup_farm_page.dart';
import 'package:task/ui/auth/signup/signup_hours_page.dart';
import 'package:task/widgets/app_button.dart';
import 'package:task/widgets/app_text_field.dart';

import '../../../widgets/base_app_bar.dart';

class SignupVerificationPage extends StatefulWidget {
  final String? fullName,
      email,
      phoneNumber,
      password,
      confirmPassword,
      bName,
      iName,
      address,
      city,
      state,
      zipcode;

  const SignupVerificationPage(
      {super.key,
      this.fullName,
      this.email,
      this.phoneNumber,
      this.password,
      this.confirmPassword,
      this.bName,
      this.iName,
      this.address,
      this.city,
      this.state,
      this.zipcode});

  @override
  State<SignupVerificationPage> createState() => _SignupVerificationPageState();
}

class _SignupVerificationPageState extends State<SignupVerificationPage> {
  final controller = TextEditingController();
  String fileName = '';

  void pickFile() async {
    String? filePath = await FilePicker.platform
        .pickFiles(
          type: FileType.any,
        )
        .then((result) => result?.files.single.path);

    if (filePath != null) {
      setState(() {
        fileName = filePath.split('/').last;
        controller.text = fileName;
      });
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
              12.verticalSpace,
              Text(
                "Signup 3 of 4",
                style: TextStyle(
                    fontSize: 15.sp, color: Colors.grey.withOpacity(0.8)),
              ),
              5.verticalSpace,
              Text(
                "Verification",
                style: TextStyle(fontSize: 35.sp),
              ),
              30.verticalSpace,
              Text(
                "Attached proof of Department of Agriculture registrations i.e. Florida Fresh, USDA Approved, USDA Organic",
                style: TextStyle(
                    fontSize: 15.sp, color: Colors.grey.withOpacity(0.8)),
              ),
              30.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Attach proof pf registration",
                    style: TextStyle(fontSize: 15.sp, color: Colors.black87),
                  ),
                  InkWell(
                    onTap: () {
                      pickFile();
                    },
                    child: Container(
                        padding: const EdgeInsets.all(10).r,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: const Color(0xFFD5715B)),
                        child: Image.asset(
                          "assets/images/img_6.png",
                          color: Colors.white,
                          width: 23.w,
                          height: 20.h,
                        )),
                  ),
                ],
              ),
              30.verticalSpace,
              fileName.isEmpty
                  ? const SizedBox.shrink()
                  : AppTextField(
                      readOnly: true,
                      controller: controller,
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10).r,
                      style: TextStyle(
                          fontSize: 15.sp,
                          color: Colors.black,
                          decoration: TextDecoration.underline),
                    ),
              const Expanded(child: SizedBox.shrink()),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignupFarmPage(),
                            ));
                      },
                      child: const Icon(Icons.arrow_back)),
                  AppButton(
                      width: 220.w,
                      onPressed: () {
                        if (fileName.isEmpty) {
                          showSnackBar("Attach the proof");
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignupHoursPage(
                                  fullName: widget.fullName,
                                  email: widget.email,
                                  phoneNumber: widget.phoneNumber,
                                  password: widget.password,
                                  confirmPassword: widget.confirmPassword,
                                  bName: widget.bName,
                                  iName: widget.iName,
                                  address: widget.address,
                                  city: widget.city,
                                  state: widget.state,
                                  zipcode: widget.zipcode,
                                  fileName: fileName,
                                ),
                              ));
                        }
                      },
                      title: controller.text.isEmpty ? "Continue" : "Submit")
                ],
              ),
              20.verticalSpace
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
