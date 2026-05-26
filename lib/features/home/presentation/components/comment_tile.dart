import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moon_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:moon_app/features/home/domain/entities/comment.dart';

class CommentTile extends StatelessWidget {
  const CommentTile({super.key, required this.comment, required this.onDelete});

  final Comment comment;
  final void Function()? onDelete;

  @override
  Widget build(BuildContext context) {
    //get username of current signed user
    final authCubit = context.read<AuthCubit>();
    final String currentUser = authCubit.currentUser?.email ?? '';

    //check if comment was posted by this user
    final bool canDelete = comment.username == currentUser;

    final displayUsername = comment.username.split('@').first;

    return Container(
      margin: const .only(left: 16, top: 20),
      child: Row(
        children: [
          //text & username
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                //text
                Text(
                  comment.text,
                  style: TextStyle(fontSize: 16, fontWeight: .bold),
                ),

                //username
                Text(
                  displayUsername,
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),

          //delete button
          if (canDelete)
            IconButton(onPressed: onDelete, icon: const Icon(Icons.more_horiz)),
        ],
      ),
    );
  }
}
