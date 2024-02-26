import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/ui/auth/login/login_page.dart';
import 'package:task/ui/auth/signup/signup_farm_page.dart';
import 'package:task/ui/auth/signup/signup_hours_page.dart';
import 'package:task/ui/auth/signup/signup_page.dart';
import 'package:task/ui/auth/signup/signup_verification_page.dart';
import 'package:task/ui/auth/signup/signup_confirmation_page.dart';
import 'package:task/ui/onboarding/onboarding_page.dart';
import 'package:task/ui/splash/splash_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (_ , child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: child,
        );
      },
      child: const SplashPage(),
    );
  }
}