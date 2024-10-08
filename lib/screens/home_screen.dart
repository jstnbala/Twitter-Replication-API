// home_screen.dart
 
import 'package:activity_twitter_replication_api/screens/profile_screen.dart';
import 'package:activity_twitter_replication_api/screens/search_screen.dart'; // Import SearchScreen
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/widgets.dart';
import '../utils/constants.dart';
import 'post_screen.dart';
 
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
 
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
 
class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TWITTER_BLACK,
        elevation: 2,
        leading: Icon(
          Icons.account_circle_rounded,
          color: TWITTER_GREY,
          size: ScreenUtil().setSp(30),
        ),
        centerTitle: true,
        title: InterFont(
          text: _selectedIndex == 0
              ? 'Home'
              : _selectedIndex == 1
              ? 'Search'
              : 'Profile',
          fontSize: ScreenUtil().setSp(17.5),
          fontWeight: FontWeight.bold,
          color: TWITTER_WHITE,
        ),
      ),
      backgroundColor: TWITTER_BLACK,
      body: PageView(
        controller: _pageController,
        children: const <Widget>[
          PostScreen(),
          SearchScreen(), // Use the new SearchScreen
          ProfileScreen()
        ],
        onPageChanged: (page) {
          setState(() {
            _selectedIndex = page;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: _onTappedBar,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        elevation: 10.0,
        selectedItemColor: TWITTER_WHITE,
        unselectedItemColor: TWITTER_GREY,
        currentIndex: _selectedIndex,
        backgroundColor: TWITTER_BLACK,
      ),
    );
  }
 
  void _onTappedBar(int value) {
    setState(() {
      _selectedIndex = value;
    });
    _pageController.jumpToPage(value);
  }
}