// ignore_for_file: avoid_print

// services/post_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post_model.dart';
import '../utils/constants.dart';

class PostService {
  Future<List<Post>> fetchAllPosts() async {
    try {
      final response = await http.get(Uri.parse('$HOST/api/v1/posts'));

      print("API Response: ${response.body}");


      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Post.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }
}

