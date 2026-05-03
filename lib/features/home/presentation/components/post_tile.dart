import 'package:flutter/material.dart';
import 'package:moon_app/features/home/domain/entities/post.dart';

class PostTile extends StatelessWidget {
  const PostTile({
    super.key,
    required this.post,
    required this.onDelete,
    required this.onTap,
  });

  final Post post;
  final void Function() onDelete;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: .circular(12),
        ),
        padding: .all(16),
        margin: .symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: .start,
          mainAxisSize: .min,
          children: [
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Text(
                  post.username,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 12,
                  ),
                ),

                IconButton(onPressed: onDelete, icon: Icon(Icons.cancel)),
              ],
            ),
            SizedBox(height: 10),
            Text(post.title, style: TextStyle(fontWeight: .bold, fontSize: 20)),
            SizedBox(height: 5),
            Text(
              post.content,
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
          ],
        ),
      ),
    );
  }
}
