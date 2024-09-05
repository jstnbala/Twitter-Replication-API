import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../services/post_service.dart';
import '../models/post_model.dart';
import '../utils/constants.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  late Future<List<Post>> posts;

  @override
  void initState() {
    super.initState();
    posts = PostService().fetchAllPosts();
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
              child: FutureBuilder<List<Post>>(
                future: posts,
                builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      color: TWITTER_BLACK,
                      child: const Center(child: CircularProgressIndicator()),
                    );
                  } else if (snapshot.hasError) {
                    debugPrint("Error loading posts: ${snapshot.error}");
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (ModalRoute.of(context)?.settings.name != '/splash') {
                        Navigator.pushReplacementNamed(context, '/splash');
                      }
                    });
                    return Container(
                      color: TWITTER_WHITE,
                      child: const Center(child: CircularProgressIndicator()),
                    );
                  } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final post = snapshot.data![index];
                        return Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(20),
                            vertical: ScreenUtil().setHeight(10),
                          ),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: TWITTER_GREY,
                                width: 8.5,
                              ),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.account_circle_rounded,
                                    color: TWITTER_GREY,
                                    size: 40,
                                  ),
                                  SizedBox(width: ScreenUtil().setWidth(10)),
                                  Image.network(
                                    post.image,
                                    height: ScreenUtil().setHeight(50),
                                    width: ScreenUtil().setWidth(50),
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Icon(Icons.error);
                                    },
                                  ),
                                  SizedBox(width: ScreenUtil().setWidth(10)),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                post.author,
                                                style: TextStyle(
                                                  fontSize: ScreenUtil().setSp(20),
                                                  color: TWITTER_WHITE,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            SizedBox(width: ScreenUtil().setWidth(5)),
                                            Text(
                                              post.getFormattedTimestamp(),
                                              style: TextStyle(
                                                fontSize: ScreenUtil().setSp(15),
                                                color: TWITTER_GREY,
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
                                            fontWeight: FontWeight.bold,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: ScreenUtil().setHeight(5)),
                                        Text(
                                          post.content,
                                          style: TextStyle(
                                            fontSize: ScreenUtil().setSp(15),
                                            color: TWITTER_WHITE,
                                          ),
                                          // Ensures the text wraps and expands
                                          maxLines: null,
                                          overflow: TextOverflow.visible,
                                        ),
                                        SizedBox(height: ScreenUtil().setHeight(5)),
                                        Row(
                                          children: [
                                            IconButton(
                                              padding: EdgeInsets.zero,
                                              constraints: const BoxConstraints(),
                                              onPressed: () {
                                                Navigator.pushNamed(
                                                  context,
                                                  '/comment_screen',
                                                  arguments: {'post': post},
                                                );
                                              },
                                              icon: const Icon(
                                                Icons.messenger_outline_outlined,
                                                color: TWITTER_WHITE,
                                              ),
                                            ),
                                            SizedBox(width: ScreenUtil().setWidth(5)),
                                            Text(
                                              post.commentsCount.toString(),
                                              style: TextStyle(
                                                fontSize: ScreenUtil().setSp(15),
                                                color: TWITTER_WHITE,
                                              ),
                                            ),
                                            SizedBox(width: ScreenUtil().setWidth(100)),
                                            IconButton(
                                              padding: EdgeInsets.zero,
                                              constraints: const BoxConstraints(),
                                              onPressed: () {
                                                // Handle like action
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
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return Container(
                      color: TWITTER_WHITE,
                      child: const Center(child: CircularProgressIndicator()),
                    );
                  }
                },
              ),
            ),
            SizedBox(height: ScreenUtil().setHeight(48)),
          ],
        ),
      ),
    );
  }
}
