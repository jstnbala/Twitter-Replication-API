import 'package:activity_twitter_replication_api/utils/constants.dart';
import 'package:activity_twitter_replication_api/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart'; // Import your User model
import '../providers/user_provider.dart'; // Import UserProvider
 
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
 
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}
 
class _ProfileScreenState extends State<ProfileScreen> {
  UserProvider? userProvider;
  User? user;
 
  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UserProvider>(context, listen: true);
    user = userProvider!.getUserModel;
 
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setWidth(25),
              vertical: ScreenUtil().setHeight(25)), // EdgeInsets.symmetric
          color: TWITTER_BLACK,
          height: ScreenUtil().screenHeight,
          width: ScreenUtil().screenWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.person_3,
                color: TWITTER_GREY,
                size: ScreenUtil().setSp(50),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(38),
              ),
              InterFont(
                  text: user!.name,
                  fontSize: ScreenUtil().setSp(30),
                  color: TWITTER_WHITE),
              SizedBox(
                height: ScreenUtil().setHeight(3),
              ),
              InterFont(
                  text: user!.occupation,
                  fontSize: ScreenUtil().setSp(20),
                  color: TWITTER_WHITE),
              SizedBox(
                height: ScreenUtil().setHeight(18),
              ),
              InterFont(
                  text: 'Age: ${user!.age}',
                  fontSize: ScreenUtil().setSp(12),
                  color: TWITTER_WHITE),
              SizedBox(
                height: ScreenUtil().setHeight(10),
              ),
              InterFont(
                  text: 'Address: ${user!.address['street']}, ${user!.address['city']}',
                  fontSize: ScreenUtil().setSp(12),
                  color: TWITTER_WHITE),
              SizedBox(
                height: ScreenUtil().setHeight(10),
              ),
              InterFont(
                  text: 'Phone: ${user!.phone}',
                  fontSize: ScreenUtil().setSp(12),
                  color: TWITTER_WHITE),
              SizedBox(
                height: ScreenUtil().setHeight(10),
              ),
              InterFont(
                  text: 'Website: ${user!.website}',
                  fontSize: ScreenUtil().setSp(12),
                  color: TWITTER_WHITE),
              SizedBox(
                height: ScreenUtil().setHeight(10),
              ),
              InterFont(
                  text: 'Hobbies: ${user!.hobbies[0]}, ${user!.hobbies[1]}',
                  fontSize: ScreenUtil().setSp(12),
                  color: TWITTER_WHITE),
              SizedBox(
                height: ScreenUtil().setHeight(20),
              ),
              ElevatedButton(
                onPressed: () {
                  userProvider!.clearUser(); // Clear user data
                  Navigator.pushReplacementNamed(context, '/'); // Navigate to login screen
                },
                child: Text(
                  'Logout',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(16),
                    color: TWITTER_BLACK,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
 