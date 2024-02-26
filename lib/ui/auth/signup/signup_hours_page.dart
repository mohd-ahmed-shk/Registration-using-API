import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/ui/auth/signup/signup_confirmation_page.dart';
import 'package:task/ui/auth/signup/signup_verification_page.dart';
import 'package:weekday_selector/weekday_selector.dart';
import 'package:http/http.dart' as http;

import '../../../model/signup_hours_model.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/base_app_bar.dart';

class SignupHoursPage extends StatefulWidget {
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
      zipcode,
      fileName;

  const SignupHoursPage(
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
      this.zipcode,
      this.fileName});

  @override
  State<SignupHoursPage> createState() => _SignupHoursPageState();
}

class _SignupHoursPageState extends State<SignupHoursPage> {
  final values = <bool?>[false, null, null, true, false, false, false];

  List<SignupHoursModel> selectedTimeList = [];

  final List<SignupHoursModel> signupHoursList = [
    SignupHoursModel(
      time: "8:00am - 10:00am",
    ),
    SignupHoursModel(
      time: "10:00am - 1:00pm",
    ),
    SignupHoursModel(
      time: "1:00pm - 4:00pm",
    ),
    SignupHoursModel(
      time: "4:00pm - 7:00pm",
    ),
    SignupHoursModel(
      time: "7:00pm - 10:00pm",
    ),
  ];

  String? isRegistered;

  Future<void> postData() async {
    final url = Uri.parse('https://sowlab.pw/assignment/user/register');

    Map<String, dynamic> requestData = {
      "full_name": widget.fullName,
      "email": widget.email,
      "phone": widget.phoneNumber,
      "password": widget.password,
      "role": "farmer",
      "business_name": widget.bName,
      "informal_name": widget.iName,
      "address": widget.address,
      "city": widget.city,
      "state": widget.state,
      "zip_code": int.tryParse(widget.zipcode ?? ''),
      "registration_proof": widget.fileName,
      "business_hours": {
        "mon": ["8:00am - 10:00am", "10:00am - 1:00pm"],
        "tue": ["8:00am - 10:00am", "10:00am - 1:00pm"],
        "wed": ["8:00am - 10:00am", "10:00am - 1:00pm", "1:00pm - 4:00pm"],
        "thu": ["8:00am - 10:00am", "10:00am - 1:00pm", "1:00pm - 4:00pm"],
        "fri": ["8:00am - 10:00am", "10:00am - 1:00pm"],
        "sat": ["8:00am - 10:00am", "10:00am - 1:00pm"],
        "sun": ["8:00am -10:00am"]
      },
      "device_token": "0imfnc8mVLWwsAawjYr4Rx-Af50DDqtlx",
      "type": "email/facebook/google/apple",
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
        isRegistered = data["message"];
      } else {
        showSnackBar("message  : ${data["message"]}");
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
              12.verticalSpace,
              Text(
                "Signup 4 of 4",
                style: TextStyle(
                    fontSize: 15.sp, color: Colors.grey.withOpacity(0.8)),
              ),
              5.verticalSpace,
              Text(
                "Business Hours",
                style: TextStyle(fontSize: 35.sp),
              ),
              20.verticalSpace,
              Text(
                "Choose the hours your farm is open for pickups. This will allow customers to order deliveries.",
                style: TextStyle(
                    fontSize: 15.sp, color: Colors.grey.withOpacity(0.8)),
              ),
              20.verticalSpace,
              WeekdaySelector(
                color: Colors.grey.withOpacity(0.8),
                selectedFillColor: const Color(0xFFD5715B),
                selectedColor: Colors.white,
                disabledColor: Colors.black,
                elevation: 0,
                selectedElevation: 0,
                disabledElevation: 0,
                disabledShape: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 0, color: Colors.transparent),
                    gapPadding: 0,
                    borderRadius: BorderRadius.circular(5).r),
                selectedShape: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 0, color: Colors.transparent),
                    gapPadding: 0,
                    borderRadius: BorderRadius.circular(5).r),
                shortWeekdays: const ["Su", "M", "T", "W", "Th", "F", "S"],
                shape: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1, color: Colors.grey.withOpacity(0.8)),
                    gapPadding: 0,
                    borderRadius: BorderRadius.circular(5).r),
                onChanged: (int v) {
                  setState(() {
                    values[v % 7] = !values[v % 7]!;
                  });
                },
                values: values,
              ),
              20.verticalSpace,
              Expanded(
                  child: GridView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    mainAxisExtent: 42.h),
                itemCount: signupHoursList.length,
                itemBuilder: (context, index) {
                  SignupHoursModel value = signupHoursList[index];
                  return InkWell(
                    onTap: () {
                      setState(() {
                        if (selectedTimeList.contains(signupHoursList[index])) {
                          selectedTimeList.remove(signupHoursList[index]);
                        } else {
                          selectedTimeList.add(signupHoursList[index]);
                        }
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: selectedTimeList.contains(value)
                              ? const Color(0xffF8C569)
                              : Colors.black12.withOpacity(0.05)),
                      child: Center(
                          child: Text(
                        value.time,
                        style: TextStyle(color: Colors.black, fontSize: 15.sp),
                      )),
                    ),
                  );
                },
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const SignupVerificationPage(),
                            ));
                      },
                      child: const Icon(Icons.arrow_back)),
                  AppButton(
                      width: 220.w,
                      onPressed: () async {
                        if (selectedTimeList.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Select the time")));
                        } else {
                          await postData();
                          if (isRegistered == "Registered.") {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const SignupConfirmationPage(),
                                ));
                          }
                        }
                      },
                      title: "Signup")
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
