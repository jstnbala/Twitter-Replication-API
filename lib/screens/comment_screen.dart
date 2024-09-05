// screens/comment_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/constants.dart';
import '../utils/widgets.dart';
import '../models/post_model.dart'; // Import your Post model

class CommentScreen extends StatelessWidget {
  const CommentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieve the post data passed to this screen
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    final Post post = arguments['post'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: TWITTER_BLACK,
        elevation: 2,
        leading: IconButton(
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: TWITTER_WHITE,
          ),
        ),
        centerTitle: true,
        title: InterFont(
          text: 'Comments',
          fontSize: ScreenUtil().setSp(17.5),
          fontWeight: FontWeight.bold,
          color: TWITTER_WHITE,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: TWITTER_BLACK,
          width: ScreenUtil().screenWidth,
          height: ScreenUtil().screenHeight,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: post.comments.length,
            itemBuilder: (context, index) {
              final comment = post.comments[index];
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
                    const Icon(
                      Icons.account_circle_rounded,
                      color: TWITTER_GREY,
                      size: 40,
                    ),
                    SizedBox(width: ScreenUtil().setWidth(10)),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            comment['author'] ?? 'Unknown',
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(17.5),
                              color: TWITTER_WHITE,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: ScreenUtil().setHeight(5)),
                          Text(
                            comment['text'] ?? 'No comment text',
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(15),
                              color: TWITTER_WHITE,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
