// ignore_for_file: library_private_types_in_public_api

import 'package:activity_twitter_replication_api/screens/comment_screen.dart';
import 'package:activity_twitter_replication_api/screens/home_screen.dart';
import 'package:activity_twitter_replication_api/screens/post_screen.dart';
import 'package:activity_twitter_replication_api/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const SampleTwitter());
}

class SampleTwitter extends StatefulWidget {
  const SampleTwitter({Key? key}) : super(key: key);

  @override
  _SampleTwitterState createState() => _SampleTwitterState();
}

class _SampleTwitterState extends State<SampleTwitter> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.bottom,
    ]);
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values); // to re-show bars
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(412, 715),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Twitter',
          initialRoute: '/splash',
          routes: {
            '/splash': (context) => const SplashScreen(),
            '/home_screen': (context) => const HomeScreen(),
            '/post_screen': (context) => const PostScreen(),
            '/comment_screen': (context) => const CommentScreen(),
          },
        );
      },
    );
  }
}
