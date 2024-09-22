// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
//import 'package:http/http.dart';
import '../services/post_service.dart';
import '../utils/constants.dart';
import '../utils/widgets.dart';
//import 'package:image_network/image_network.dart';
 
class PostScreen extends StatefulWidget {
  const PostScreen({super.key});
 
  @override
  State<PostScreen> createState() => _PostScreenState();
}
 
class _PostScreenState extends State<PostScreen> {
  List posts = [];
 
  Future<List> loadAllProducts() async {
    PostService postService = PostService();
    posts = await postService.fetchAllPosts();
    return posts;
  }
 
  @override
  void initState() {
    super.initState();
  }
 
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: ScreenUtil().screenWidth,
        color: TWITTER_BLACK,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: ScreenUtil().setHeight(630),
              child: FutureBuilder(
                future: loadAllProducts(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      color: TWITTER_BLACK,
                      child: Center(child: genericLoading()),
                    );
                  } else if (snapshot.hasError) {
                    print("hasError: ${snapshot.error}");
                    Navigator.popAndPushNamed(context, '/splash');
                    return Container(
                      color: TWITTER_WHITE,
                      child: Center(child: genericLoading()),
                    );
                  } else if (snapshot.hasData && posts.isNotEmpty) {
                    return ListView.builder(
                      shrinkWrap: true,
                     // physics: const NeverScrollableScrollPhysics(), // Disable internal scrolling of ListView
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        var post = posts[index];
                        return Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(20),
                            vertical: ScreenUtil().setHeight(10),
                          ),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: TWITTER_GREY,
                                width: 0.5,
                              ),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.account_circle_rounded,
                                color: TWITTER_GREY,
                                size: ScreenUtil().setSp(40),
                              ),
                              SizedBox(width: ScreenUtil().setWidth(10)),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            post.author,
                                            style: TextStyle(
                                              fontSize: ScreenUtil().setSp(20),
                                              color: TWITTER_WHITE,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: ScreenUtil().setWidth(10)),
                                        Text(
                                          post.getFormattedTimestamp(),
                                          style: TextStyle(
                                            fontSize: ScreenUtil().setSp(12),
                                            color: TWITTER_WHITE,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: ScreenUtil().setHeight(5)),
                                    Text(
                                      post.title,
                                      style: TextStyle(
                                        fontSize: ScreenUtil().setSp(17.5),
                                        color: TWITTER_WHITE,
                                      ),
                                    ),
                                    SizedBox(height: ScreenUtil().setHeight(5)),
                                    Text(
                                      post.content,
                                      style: TextStyle(
                                        fontSize: ScreenUtil().setSp(15),
                                        color: TWITTER_WHITE,
                                      ),
                                    ),
                                    SizedBox(height: ScreenUtil().setHeight(5)),
                                    Row(
                                      children: [
                                        IconButton(
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(),
                                          onPressed: () {
                                            print('Comments: ' +
                                                post.comments.length.toString());
                                            Navigator.pushNamed(
                                              context,
                                              '/comment_screen',
                                              arguments: {
                                                'post': post,
                                              },
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.messenger_outline_outlined,
                                            color: TWITTER_WHITE,
                                          ),
                                        ),
                                        SizedBox(width: ScreenUtil().setWidth(5)),
                                        Text(
                                          post.comments.length.toString(),
                                          style: TextStyle(
                                            fontSize: ScreenUtil().setSp(15),
                                            color: TWITTER_WHITE,
                                          ),
                                        ),
                                        SizedBox(width: ScreenUtil().setWidth(15)),
                                        IconButton(
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(),
                                          onPressed: () {
                                            print('Likes: ' + post.likes.toString());
                                          },
                                          icon: const Icon(
                                            Icons.thumb_up_alt_outlined,
                                            color: TWITTER_WHITE,
                                          ),
                                        ),
                                        SizedBox(width: ScreenUtil().setWidth(5)),
                                        Text(
                                          post.likes.toString(),
                                          style: TextStyle(
                                            fontSize: ScreenUtil().setSp(15),
                                            color: TWITTER_WHITE,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    print("No data available");
                    Navigator.popAndPushNamed(context, '/splash');
                    return Container(
                      color: TWITTER_WHITE,
                      child: Center(child: genericLoading()),
                    );
                  }
                },
              ),
            ),
            SizedBox(height: ScreenUtil().setHeight(40)),
          ],
        ),
      ),
    );
  }
}