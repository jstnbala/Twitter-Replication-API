// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:activity_twitter_replication_api/models/user_model.dart';
import 'package:activity_twitter_replication_api/providers/user_provider.dart';
import 'package:activity_twitter_replication_api/services/user_service.dart';
import 'package:activity_twitter_replication_api/utils/constants.dart';
import 'package:activity_twitter_replication_api/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  void validate() async {
    if (username.text.isEmpty || password.text.isEmpty) {
      customDialog(
        context,
        title: 'Error',
        content: 'Input all required fields',
      );
    } else {
      showLoadingDialog(context);
      UserService userService = UserService();
      await userService.fetchAllUser();

      for (var users in userService.data) {
        if ((users['username'] == username.text) &&
            (users['email'] == password.text)) {
          User user = User(
            id: users['id'],
            name: users['name'],
            age: users['age'],
            username: users['username'],
            email: users['email'],
            address: users['address'],
            phone: users['phone'],
            website: users['website'],
            occupation: users['occupation'],
            hobbies: users['hobbies'],
          );
          context.read<UserProvider>().setUserModel(user);
          Navigator.pushReplacementNamed(context, '/home_screen');
          break;
        } else if ((users['username'] == username.text) ||
            (users['email'] == password.text)) {
          Navigator.pop(context);
          customDialog(
            context,
            title: 'Error',
            content: 'Username and Password do not match',
          );
        } else {
          Navigator.pop(context);
          customDialog(
            context,
            title: 'Error',
            content: 'User not found',
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: TWITTER_BLACK,
          height: ScreenUtil().screenHeight,
          width: ScreenUtil().screenWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: ScreenUtil().screenWidth,
                height: ScreenUtil().setHeight(40),
                color: TWITTER_BLACK,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(25),
                ),
                child: Column(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/x-logo.svg',
                      height: ScreenUtil().setHeight(85),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(30),
                    ),
                    CustomIconTextField(
                      fillColor: TWITTER_GREY,
                      fontColor: TWITTER_WHITE,
                      prefixIcon: const Icon(
                        Icons.person,
                        color: TWITTER_BLACK,
                      ),
                      controller: username,
                      hintText: 'Username',
                      hintTextSize: ScreenUtil().setSp(15),
                      fontSize: ScreenUtil().setSp(15),
                      height: ScreenUtil().setHeight(45),
                      width: ScreenUtil().screenWidth,
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(10),
                    ),
                    CustomIconTextField(
                      fillColor: TWITTER_GREY,
                      fontColor: TWITTER_WHITE,
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: TWITTER_BLACK,
                      ),
                      controller: password,
                      isObscure: true,
                      hintText: 'Password',
                      hintTextSize: ScreenUtil().setSp(15),
                      fontSize: ScreenUtil().setSp(15),
                      height: ScreenUtil().setHeight(45),
                      width: ScreenUtil().screenWidth,
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(10),
                    ),
                    CustomButton(
                      bgColor: TWITTER_GREY,
                      onTap: validate,
                      height: ScreenUtil().setHeight(45),
                      width: ScreenUtil().screenWidth,
                      fontSize: ScreenUtil().setSp(20),
                      fontWeight: FontWeight.bold,
                      buttonName: 'Login',
                    ),
                  ],
                ),
              ),
              Container(
                width: ScreenUtil().screenWidth,
                height: ScreenUtil().setHeight(40),
                color: TWITTER_BLACK,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'You do not have an account?',
                      style: TextStyle(
                        color: Colors.grey.shade200,
                        fontSize: ScreenUtil().setSp(15),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => print('Test'),
                      child: Text(
                        'Register here',
                        style: TextStyle(
                          color: TWITTER_WHITE,
                          fontSize: ScreenUtil().setSp(15),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
