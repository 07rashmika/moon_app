import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:moon_app/features/auth/data/firebase_auth_repo.dart';
import 'package:moon_app/features/auth/presentation/components/loading.dart';
import 'package:moon_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:moon_app/features/auth/presentation/cubits/auth_states.dart';
import 'package:moon_app/features/auth/presentation/screens/auth_screen.dart';
import 'package:moon_app/features/home/data/firebase_post_repo.dart';
import 'package:moon_app/features/home/presentation/cubits/post_cubit.dart';
import 'package:moon_app/features/home/presentation/screens/home_screen.dart';
import 'package:moon_app/firebase_options.dart';
import 'package:moon_app/themes/dark_mode.dart';
import 'package:moon_app/themes/light_mode.dart';

void main() async {
  //firebase setup
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  //auth repo
  final firebaseAuthRepo =
      FirebaseAuthRepo(); // we need to define these repos in the main file

  //post repo
  final firebasePostRepo = FirebasePostRepo();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) =>
              AuthCubit(authRepo: firebaseAuthRepo)..checkAuth(),
        ),

        BlocProvider<PostCubit>(
          create: (context) => PostCubit(postRepo: firebasePostRepo),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightMode,
        darkTheme: darkMode,
        // home: HomeScreen(),
        home: BlocConsumer<AuthCubit, AuthState>(
          builder: (context, state) {
            print(state.toString());

            //unauthenticated? auth page
            if (state is Unauthenticated) {
              return const AuthScreen();
            }

            //authenticated? home
            if (state is Authenticated) {
              return const HomeScreen();
            }
            //loading
            else {
              return const LoadingScreen();
            }
          },
          //listen for state changes
          listener: (context, state) {
            if (state is AuthError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
        ),
      ),
    );
  }
}
