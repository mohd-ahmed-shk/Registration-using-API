import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:task/model/onboarding_model.dart';
import 'package:task/ui/auth/login/login_page.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: PageView.builder(
          controller: controller,
          itemCount: boardingList.length,
          itemBuilder: (context, index) {
            OnboardingModel value = boardingList[index];
            return ColoredBox(
                color: value.color,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Image.asset(
                      value.image,
                      width: MediaQuery.of(context).size.width,
                      height: 320.h,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      top: 340.h,
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(40).r,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: const Radius.circular(50).r,
                                topRight: const Radius.circular(50).r)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              value.title,
                              style: TextStyle(
                                  color: Colors.black, fontSize: 22.sp),
                            ),
                            25.verticalSpace,
                            Text(
                              value.description,
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 15.sp,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            25.verticalSpace,
                            SmoothPageIndicator(
                              controller: controller,
                              count: boardingList.length,
                              axisDirection: Axis.horizontal,
                              effect: const ExpandingDotsEffect(
                                  dotWidth: 5,
                                  dotHeight: 5,
                                  dotColor: Colors.black,
                                  activeDotColor: Colors.black),
                            ),
                            30.verticalSpace,
                            Container(
                              padding: const EdgeInsets.all(15).r,
                              width: 200.w,
                              decoration: BoxDecoration(
                                  color: value.color,
                                  borderRadius: BorderRadius.circular(50).r),
                              child: Center(
                                child: Text(
                                  value.movement,
                                  style: TextStyle(
                                      fontSize: 15.sp, color: Colors.white),
                                ),
                              ),
                            ),
                            20.verticalSpace,
                            InkWell(
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const LoginPage(),
                                      ));
                                },
                                child: Text(
                                  value.login,
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      color: Colors.black,
                                      decoration: TextDecoration.underline),
                                ))
                          ],
                        ),
                      ),
                    )
                  ],
                ));
          },
        ),
      ),
    );
  }

  List<OnboardingModel> boardingList = [
    OnboardingModel(
        description:
            "Sell your farm fresh products directly to consumers, cutting out the middleman and reducing emissions of the global supply chain.",
        movement: "Join the movement!",
        login: "Login",
        image: "assets/images/img_3.png",
        color: const Color(0xff5EA25F),
        title: "Quality"),
    OnboardingModel(
        description:
            "Our team of delivery drivers will make sure your orders are picked up on time and promptly delivered to your customers.",
        movement: "Join the movement!",
        login: "Login",
        image: "assets/images/img_4.png",
        color: const Color(0xffD5715B),
        title: "Convenient"),
    OnboardingModel(
        description:
            "We love the earth and know you do too! Join us in reducing our local carbon footprint one order at a time.",
        movement: "Join the movement!",
        login: "Login",
        image: "assets/images/img_5.png",
        color: const Color(0xffF8C569),
        title: "Local"),
  ];
}
