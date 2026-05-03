import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moon_app/components/my_drawer.dart';
import 'package:moon_app/features/auth/presentation/components/my_textfield.dart';
import 'package:moon_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:moon_app/features/home/domain/entities/post.dart';
import 'package:moon_app/features/home/presentation/components/post_tile.dart';
import 'package:moon_app/features/home/presentation/cubits/post_cubit.dart';
import 'package:moon_app/features/home/presentation/cubits/post_state.dart';
import 'package:moon_app/features/home/presentation/screens/post_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  //tab controller
  late final _tabController = TabController(length: 3, vsync: this);

  //cubits
  late final postCubit = context.read<PostCubit>();

  @override
  void initState() {
    super.initState();

    //load posts initially
    postCubit.loadPosts();
  }

  //add new post to a given category
  void addPost() {
    //get current category
    String currentCategory;

    switch (_tabController.index) {
      case 0:
        currentCategory = 'Build';
        break;
      case 1:
        currentCategory = 'Launch';
        break;
      case 2:
        currentCategory = 'Monetize';
        break;
      default:
        currentCategory = 'Build';
    }

    //text controllers
    final titleController = TextEditingController();
    final contentController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('New Post'),
        content: Column(
          mainAxisSize: .min,
          children: [
            //title text field
            MyTextfield(
              controller: titleController,
              hintText: "Title",
              obscureText: false,
            ),

            const SizedBox(height: 16),

            //content text field
            MyTextfield(
              controller: contentController,
              hintText: "Content",
              obscureText: false,
            ),
          ],
        ),
        actions: [
          //cancel button
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),

          //post button
          TextButton(
            onPressed: () {
              if (titleController.text.isNotEmpty) {
                //access cubits
                final authCubit = context.read<AuthCubit>();

                //create post
                postCubit.createPost(
                  title: titleController.text,
                  content: contentController.text,
                  category: currentCategory,
                  username: authCubit.currentUser!.email,
                );

                //pop the dialog
                Navigator.pop(context);
              }
            },
            child: const Text('Post'),
          ),
        ],
      ),
    );
  }

  //delete post
  void deletePost(String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Post?'),
        actions: [
          //cancel button
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),

          //delete button
          TextButton(
            onPressed: () {
              postCubit.deletePost(id);
              Navigator.pop(context);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  //build list of posts for the given category
  Widget _buildCategoryPosts(String category, List<Post> posts) {
    //filter posts for given category
    final postsInThisCategory = posts
        .where((post) => post.category == category)
        .toList();

    //if empty
    if (postsInThisCategory.isEmpty) {
      return const Center(child: Text('No posts in here yet'));
    }

    //list of posts in the given category
    return ListView.builder(
      itemCount: postsInThisCategory.length,
      itemBuilder: (context, index) {
        final post = postsInThisCategory[index];

        return PostTile(
          post: post,
          onDelete: () {
            deletePost(post.id);
          },
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PostScreen(post: post)),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //app bar
      appBar: AppBar(
        title: const Text('Home'),
        bottom: TabBar(
          controller: _tabController,
          dividerColor: Colors.transparent,
          labelColor: Theme.of(context).colorScheme.inversePrimary,
          unselectedLabelColor: Theme.of(context).colorScheme.primary,
          tabs: const [
            Tab(text: 'Build'),
            Tab(text: 'Launch'),
            Tab(text: 'Monetize'),
          ],
        ),

        //new post button
        actions: [IconButton(onPressed: addPost, icon: const Icon(Icons.add))],
      ),

      //drawer
      drawer: MyDrawer(),

      body: BlocBuilder<PostCubit, PostState>(
        builder: (context, state) {
          print(state);
          //loaded
          if (state is PostsLoaded) {
            return TabBarView(
              controller: _tabController,
              children: [
                _buildCategoryPosts("Build", state.posts),
                _buildCategoryPosts("Launch", state.posts),
                _buildCategoryPosts("Monetize", state.posts),
              ],
            );
          }

          //loading
          if (state is PostLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          //error
          if (state is PostError) {
            return Center(child: Text(state.message));
          }

          //fallback default
          return const SizedBox();
        },
      ),
    );
  }
}
