import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    getIsLogin();
  }

  void getIsLogin() {
  Timer(
    const Duration(seconds: 2),
    () => Navigator.pushReplacementNamed(context, '/'),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: ScreenUtil().screenHeight,
        color: TWITTER_BLACK,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: ScreenUtil().setHeight(50),
            ),
            Align(
              alignment: Alignment.center,
              child: SvgPicture.asset(
                'assets/icons/x-logo.svg',
                width: ScreenUtil().setWidth(75),
                height: ScreenUtil().setHeight(75),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
