import 'package:brava/firebase_options.dart';
import 'package:brava/provider/bookmark.dart';
import 'package:brava/provider/user.dart';
import 'package:brava/screen/Home/bookmarked_course.dart';
import 'package:brava/screen/Home/course_detail.dart';
import 'package:brava/screen/Home/home_page.dart';
import 'package:brava/screen/Home/nav_bar.dart';
import 'package:brava/screen/Home/profile.dart';
import 'package:brava/screen/authentication/log_in.dart';
import 'package:brava/screen/authentication/sign_up.dart';
import 'package:brava/screen/authentication/start_screen.dart';
import 'package:brava/screen/on_boarding/screen_1.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await Hive.openBox('bookmark');
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var email = preferences.getString('email');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp(
    email: email.toString(),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key, required this.email});
  String? email;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => BookmarkProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          //primaryColor: const
          primaryColor: const Color.fromARGB(255, 106, 90, 223),
          scaffoldBackgroundColor: const Color.fromARGB(255, 255, 251, 245),

          textTheme: const TextTheme(
            titleLarge: TextStyle(
              color: Color.fromARGB(255, 106, 90, 223),
            ),
            bodyMedium: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: email == null ? const InitialPages() : const NavBar(),
      ),
    );
  }
}
