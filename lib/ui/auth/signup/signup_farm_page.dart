import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/ui/auth/signup/signup_page.dart';
import 'package:task/ui/auth/signup/signup_verification_page.dart';
import 'package:task/widgets/app_button.dart';

import '../../../widgets/app_text_field.dart';
import '../../../widgets/base_app_bar.dart';

class SignupFarmPage extends StatefulWidget {
  final String? fullName, email, phoneNumber, password, confirmPassword;

  const SignupFarmPage(
      {super.key,
      this.fullName,
      this.email,
      this.phoneNumber,
      this.password,
      this.confirmPassword});

  @override
  State<SignupFarmPage> createState() => _SignupFarmPageState();
}

class _SignupFarmPageState extends State<SignupFarmPage> {
  final _addressController = TextEditingController();
  final _nameController = TextEditingController();
  final _businessController = TextEditingController();
  final _cityController = TextEditingController();
  final _zipController = TextEditingController();

  String? selectedValue;

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = const [
      DropdownMenuItem(value: "Maharashtra", child: Text("Maharashtra")),
      DropdownMenuItem(value: "MP", child: Text("MP")),
      DropdownMenuItem(value: "UP", child: Text("UP")),
      DropdownMenuItem(value: "Bihar", child: Text("Bihar")),
      DropdownMenuItem(value: "Punjab", child: Text("Punjab")),
      DropdownMenuItem(value: "Gujrat", child: Text("Gujarat")),
      DropdownMenuItem(value: "Kashmir", child: Text("Kashmir")),
    ];
    return menuItems;
  }

  @override
  void dispose() {
    super.dispose();
    _addressController.dispose();
    _nameController.dispose();
    _businessController.dispose();
    _cityController.dispose();
    _zipController.dispose();
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
                12.verticalSpace,
                Text(
                  "Signup 2 of 4",
                  style: TextStyle(
                      fontSize: 15.sp, color: Colors.grey.withOpacity(0.8)),
                ),
                5.verticalSpace,
                Text(
                  "Farm Info",
                  style: TextStyle(fontSize: 35.sp),
                ),
                40.verticalSpace,
                AppTextField(
                  controller: _businessController,
                  textInputAction: TextInputAction.next,
                  hintText: 'Business Name',
                  prefixIcon: const Icon(
                    Icons.type_specimen,
                  ),
                ),
                20.verticalSpace,
                AppTextField(
                  controller: _nameController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  hintText: 'Informal Name',
                  prefixIcon: const Icon(Icons.emoji_emotions),
                ),
                20.verticalSpace,
                AppTextField(
                  controller: _addressController,
                  textInputAction: TextInputAction.next,
                  hintText: 'Street Address',
                  prefixIcon: const Icon(
                    Icons.home_outlined,
                  ),
                ),
                20.verticalSpace,
                AppTextField(
                  controller: _cityController,
                  textInputAction: TextInputAction.next,
                  hintText: 'City',
                  prefixIcon: const Icon(Icons.location_on_outlined),
                ),
                20.verticalSpace,
                Row(children: [
                  Container(
                    width: 120.w,
                    height: 45.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10).r,
                      color: const Color(0xFF261C12).withOpacity(0.1),
                    ),
                    child: DropdownButtonFormField(
                        value: selectedValue,
                        isExpanded: true,
                        isDense: true,
                        hint: Text(
                          "Select State",
                          style: TextStyle(
                              fontSize: 15.sp,
                              color: Colors.grey.withOpacity(0.8)),
                        ),
                        padding: EdgeInsets.zero,
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10).r,
                                borderSide: BorderSide.none)),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedValue = newValue!;
                          });
                        },
                        items: dropdownItems),
                  ),
                  10.horizontalSpace,
                  Expanded(
                      child: AppTextField(
                    controller: _zipController,
                    hintText: "Enter Zipcode",
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 15, horizontal: 10)
                            .r,
                  ))
                ]),
                150.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignupPage(),
                              ));
                        },
                        child: const Icon(Icons.arrow_back)),
                    AppButton(
                        width: 220.w,
                        onPressed: () {
                          if (_businessController.text.isEmpty) {
                            showSnackBar("Enter business Name");
                          } else if (_nameController.text.isEmpty) {
                            showSnackBar("Enter your informal name");
                          } else if (_addressController.text.isEmpty) {
                            showSnackBar("Enter your street address");
                          } else if (_cityController.text.isEmpty) {
                            showSnackBar("Enter your City");
                          } else if (selectedValue == null) {
                            showSnackBar("Select your State");
                          } else if (_zipController.text.isEmpty) {
                            showSnackBar("Enter your Zipcode");
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignupVerificationPage(
                                    fullName: widget.fullName,
                                    email: widget.email,
                                    phoneNumber: widget.phoneNumber,
                                    password: widget.password,
                                    confirmPassword: widget.confirmPassword,
                                    bName: _businessController.text,
                                    iName: _nameController.text,
                                    address: _addressController.text,
                                    city: _cityController.text,
                                    state: selectedValue,
                                    zipcode: _zipController.text,
                                  ),
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
