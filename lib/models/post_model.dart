import 'package:intl/intl.dart';

class Post {
  final String id;
  final String author;
  final String title;
  final String content;
  final String image;
  final DateTime timestamp;
  final int likes;
  final int commentsCount;
  final List<dynamic> comments;

  Post({
    required this.id,
    required this.author,
    required this.title,
    required this.content,
    required this.image,
    required this.timestamp,
    required this.likes,
    required this.commentsCount,
    required this.comments,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'].toString(),
      author: json['author']?.toString() ?? 'Unknown',
      title: json['title']?.toString() ?? 'Untitled',
      content: json['content']?.toString() ?? 'No content available',
      image: json['image']?.toString() ?? '',
      timestamp: DateTime.parse(json['timestamp']?.toString() ?? DateTime.now().toString()),
      likes: json['likes'] is int ? json['likes'] : int.tryParse(json['likes'].toString()) ?? 0,
      commentsCount: (json['comments'] as List<dynamic>?)?.length ?? 0,
      comments: json['comments'] ?? [],
    );
  }

  String getFormattedTimestamp() {
    final DateFormat formatter = DateFormat('E, M/d/yyyy');
    return formatter.format(timestamp);
  }
}
