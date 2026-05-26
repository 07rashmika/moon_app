import 'package:moon_app/features/home/domain/entities/post.dart';

abstract class PostState {}

//initial state
class PostInitial extends PostState {}

//loading state
class PostLoading extends PostState {}

//loaded with posts
class PostsLoaded extends PostState {
  PostsLoaded(this.posts, {required this.commentCounts});

  final List<Post> posts;
  final Map<String, int> commentCounts;
}

//error state
class PostError extends PostState {
  PostError(this.message);

  final String message;
}

//post created successfully
class PostCreated extends PostState {}

//post deleted successfully
class PostDeleted extends PostState {}
