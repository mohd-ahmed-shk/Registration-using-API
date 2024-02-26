import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/widgets/app_button.dart';

class SignupConfirmationPage extends StatefulWidget {
  const SignupConfirmationPage({super.key});

  @override
  State<SignupConfirmationPage> createState() => _SignupConfirmationPageState();
}

class _SignupConfirmationPageState extends State<SignupConfirmationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20).r,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              100.verticalSpace,
              Image.asset("assets/images/img_7.png",color: Colors.green,width: 120,height: 80,),
              30.verticalSpace,
              Text(
                "You’re all done!",
                style: TextStyle(fontSize: 35.sp),
              ),
              20.verticalSpace,
              Text(
                "Hang tight!  We are currently reviewing your account and will follow up with you in 2-3 business days. In the meantime, you can setup your inventory.",
                style: TextStyle(
                  fontSize: 15.sp,
                  color: Colors.grey.withOpacity(0.8),
                ),
                textAlign: TextAlign.center,
              ),
              const Expanded(child: SizedBox.shrink()),
              AppButton(onPressed: () {
                showSnackBar("Account created successfully");
              }, title: "Got it!"),
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
