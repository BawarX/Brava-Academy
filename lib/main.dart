import 'package:brava/provider/bookmark.dart';
import 'package:brava/screen/Home/bookmarked_course.dart';
import 'package:brava/screen/Home/course_detail.dart';
import 'package:brava/screen/Home/home_page.dart';
import 'package:brava/screen/Home/nav_bar.dart';
import 'package:brava/screen/Home/profile.dart';
import 'package:brava/screen/authentication/log_in.dart';
import 'package:brava/screen/authentication/sign_up.dart';
import 'package:brava/screen/authentication/start_screen.dart';
import 'package:brava/screen/on_boarding/screen_1.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => BookmarkProvider(),
        )
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
        home: const Screen1(),
      ),
    );
  }
}
