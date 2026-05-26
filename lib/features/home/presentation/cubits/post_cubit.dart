import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moon_app/features/home/domain/entities/comment.dart';
import 'package:moon_app/features/home/domain/entities/post.dart';
import 'package:moon_app/features/home/domain/repos/post_repo.dart';
import 'package:moon_app/features/home/presentation/cubits/post_state.dart';

/*
  This manages the state for posts
*/

class PostCubit extends Cubit<PostState> {
  PostCubit({required this.postRepo}) : super(PostInitial());

  final PostRepo postRepo;

  //locally cache posts
  List<Post> _posts = [];

  //get all posts
  List<Post> get posts => _posts;

  //load all posts
  Future<void> loadPosts() async {
    try {
      emit(PostLoading());

      //get all posts from repo
      _posts = await postRepo.loadAllPosts();

      //map of comment counts per post
      final Map<String, int> commentCounts = {};

      //go through each post and fetch comment counts
      for (final post in _posts) {
        final comments = await postRepo.getComments(post.id);
        commentCounts[post.id] = comments.length;
      }

      emit(PostsLoaded(posts, commentCounts: commentCounts));
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }

  //create new post
  Future<void> createPost({
    required String title,
    required String content,
    required String category,
    required String username,
  }) async {
    try {
      emit(PostLoading());

      final post = Post(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        content: content,
        category: category,
        username: username,
      );

      await postRepo.createPost(post);

      emit(PostCreated());

      await loadPosts();
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }

  //delete a post
  Future<void> deletePost(String id) async {
    try {
      emit(PostLoading());

      await postRepo.deletePost(id);

      emit(PostDeleted());

      await loadPosts();
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }

  //load comments
  Future<List<Comment>> getComments(String postId) async {
    try {
      return await postRepo.getComments(postId);
    } catch (e) {
      emit(PostError(e.toString()));
      return [];
    }
  }

  //add new comments
  Future<void> addComment({
    required String postId,
    required String text,
    required String username,
  }) async {
    try {
      //create comment
      final comment = Comment(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        postId: postId,
        text: text,
        username: username,
      );

      //add comment via repo
      await postRepo.addComment(comment);

      //reloads to the posts to update the comments
      await loadPosts();
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }

  //delete comment
  Future<void> deleteComment({
    required String commentId,
    required String postId,
  }) async {
    try {
      //delete comment via repo
      await postRepo.deleteComment(postId, commentId);

      //reload posts
      await loadPosts();
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }
}
