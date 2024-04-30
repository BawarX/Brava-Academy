import 'package:brava/global/constant.dart';
import 'package:brava/global/firebase_options.dart';
import 'package:brava/provider/bookmark.dart';
import 'package:brava/provider/input_field_provider.dart';
import 'package:brava/screen/widget/nav_bar.dart';
import 'package:brava/screen/authentication/start_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await GetSharedprefrence();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print("${sharedPreferences.getBool('isLogin')} bawar xalid ");
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
        ),
        ChangeNotifierProvider(
          create: (context) => SettingsProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
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
        home: sharedPreferences.getString('user') == null ? const Screen1() : const NavBar(),
      ),
    );
  }
}
