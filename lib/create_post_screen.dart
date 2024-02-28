// In file: create_post_page.dart
import 'package:flutter/material.dart';
import './widget/create_post.dart'; // Adjust the import path as needed

class CreatePostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create a New Post'),
      ),
      body: CreatePostWidget(), // Your CreatePostWidget is used here
    );
  }
}
