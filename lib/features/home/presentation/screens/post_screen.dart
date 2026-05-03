import 'package:flutter/material.dart';
import 'package:moon_app/features/home/domain/entities/post.dart';
import 'package:moon_app/features/home/presentation/components/post_tile.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(post.title)),
      body: PostTile(post: post, onDelete: () {}, onTap: () {}),
    );
  }
}
