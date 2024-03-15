import 'dart:developer';

import 'package:brava/api/api_service.dart';
import 'package:brava/model/courses.dart';
import 'package:brava/provider/user.dart';
import 'package:brava/screen/Home/bookmarked_course.dart';
import 'package:brava/screen/authentication/start_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ApiService serivce = ApiService();
  String? email;
  String? imageUrll;

  Future getEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      email = preferences.getString('email')!;
      imageUrll = preferences.getString('imageUrl')!;
    });
  }

  Future logOut(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('email');
    preferences.remove('imageUrl');
    Navigator.push(context, MaterialPageRoute(builder: (context) => const InitialPages()));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEmail();
  }

  @override
  Widget build(BuildContext context) {
    String userName = context.watch<UserProvider>().username;
    //String email = context.watch<UserProvider>().email;
    String imageUrl = context.watch<UserProvider>().imageUrl;
    String courseNumber = '1';
    String rank = '100';

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(imageUrll!),
              maxRadius: 45,
            ),
            const Gap(15),
            Text(
              userName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const Gap(25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      "Courses",
                      style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      courseNumber,
                      style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "Rank",
                      style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      rank,
                      style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
              ],
            ),
            const Gap(10),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "My Courses",
                  style: TextStyle(fontSize: 20, color: Theme.of(context).primaryColor),
                ),
              ),
            ),
            Text('$email this is the email'),
            ElevatedButton(
              onPressed: () {
                logOut(context);
              },
              child: const Text("Sign out"),
            ),
            // adding a consumer so it listens to the events if there are courses show it here. these are my courses!!
            //const course_bookmarked(),
            Expanded(
              child: FutureBuilder<List<Course>>(
                future: serivce.getCourse(),
                builder: (context, snapshot) {
                  final courses = snapshot.data;
                  return ListView.builder(
                    itemCount: courses!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 120,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(15),
                              ),
                              border: Border.all(
                                color: Theme.of(context).primaryColor,
                              )),
                          child: Row(
                            children: [
                              const Gap(10),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(18),
                                child: SizedBox(
                                  width: 150,
                                  child: Image.network(
                                    courses[index].backgroundImage,
                                  ),
                                ),
                              ),
                              const Gap(10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Gap(15),
                                  Text(
                                    courses[index].name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const Gap(15),
                                  Text(
                                    courses[index].description,
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
