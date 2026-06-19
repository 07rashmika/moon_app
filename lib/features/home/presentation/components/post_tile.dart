import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moon_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:moon_app/features/home/domain/entities/post.dart';

class PostTile extends StatelessWidget {
  const PostTile({
    super.key,
    required this.post,
    required this.onDelete,
    required this.onTap,
    this.commentCount = 0,
    this.showFullContent = false,
  });

  final Post post;
  final void Function() onDelete;
  final void Function() onTap;
  final int commentCount;
  final bool showFullContent;

  @override
  Widget build(BuildContext context) {
    //get username of current signed user
    final authCubit = context.read<AuthCubit>();
    final String currentUser = authCubit.currentUser?.email ?? '';

    //check if comment was posted by this user
    final bool canDelete = post.username == currentUser;

    //prepare username to Display
    final displayUsername = post.username.split('@').first;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: .all(16),
        child: Column(
          crossAxisAlignment: .start,
          mainAxisSize: .min,
          children: [
            //header row: title & delete button
            Row(
              mainAxisAlignment: .spaceBetween,
              crossAxisAlignment: .center,
              children: [
                //title
                Text(
                  post.title,
                  style: TextStyle(fontWeight: .bold, fontSize: 20),
                ),

                //delete button
                if (canDelete)
                  IconButton(onPressed: onDelete, icon: Icon(Icons.more_horiz)),
              ],
            ),

            SizedBox(height: 15),

            //content
            Text(
              post.content,
              maxLines: showFullContent ? null : 2,
              overflow: showFullContent ? null : .ellipsis,
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),

            SizedBox(height: 15),

            //bottom row: username & comment count
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                //username
                Text(
                  displayUsername,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 12,
                  ),
                ),

                //comment count
                Text(
                  "$commentCount comments",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
