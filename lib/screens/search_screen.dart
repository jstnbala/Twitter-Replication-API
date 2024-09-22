// screens/search_screen.dart

 // ignore_for_file: unused_field
 
import 'package:flutter/material.dart';
import '../models/post_model.dart';
import '../services/post_service.dart'; // Ensure this imports your PostService
import '../utils/constants.dart';
 
class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);
 
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}
 
class _SearchScreenState extends State<SearchScreen> {
  List<Post> _posts = [];
  List<Post> _filteredPosts = [];
  String _searchQuery = '';
 
  @override
  void initState() {
    super.initState();
    fetchPosts();
  }
 
  Future<void> fetchPosts() async {
    // Fetch posts from your service
    _posts = await PostService().fetchAllPosts();
    _filteredPosts = _posts;
    setState(() {});
  }
 
  void _filterPosts(String query) {
    setState(() {
      _searchQuery = query;
      _filteredPosts = _posts.where((post) {
        return post.title.toLowerCase().contains(query.toLowerCase()) ||
               post.content.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TWITTER_BLACK,
        title: const Text(
          'Search Posts',
          style: TextStyle(color: TWITTER_WHITE),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: TWITTER_BLACK,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: _filterPosts,
              decoration: InputDecoration(
                hintText: 'Search...',
                fillColor: TWITTER_GREY,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredPosts.length,
                itemBuilder: (context, index) {
                  final post = _filteredPosts[index];
                  return ListTile(
                    title: Text(post.title, style: const TextStyle(color: TWITTER_WHITE)),
                    subtitle: Text(post.content, style: const TextStyle(color: TWITTER_GREY)),
                    onTap: () {
                      // Navigate to the post detail screen (if applicable)
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}