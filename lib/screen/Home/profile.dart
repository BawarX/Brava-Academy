import 'dart:developer';

import 'package:brava/api/api_service.dart';
import 'package:brava/model/courses.dart';
import 'package:brava/provider/user.dart';
import 'package:brava/screen/Home/bookmarked_course.dart';
import 'package:brava/screen/Home/course_detail.dart';
import 'package:brava/screen/Home/course_detail_owner.dart';
import 'package:brava/screen/Home/home_page.dart';
import 'package:brava/screen/Home/nav_bar.dart';
import 'package:brava/screen/authentication/start_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  String? imageUrl;
  String? id;
  String? firstName;
  String? lastName;
  String? password;
  Future getEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      email = preferences.getString('email')!;
      imageUrl = preferences.getString('imageUrl')!;
      id = preferences.getString('_id')!;
      firstName = preferences.getString('firstname')!;
      lastName = preferences.getString('lastname')!;
      password = preferences.getString('password');
    });
  }

  Future logOut(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('email');
    preferences.remove('imageUrl');
    preferences.remove('_id');
    preferences.remove('firstname');
    preferences.remove('lastname');
    Navigator.push(context, MaterialPageRoute(builder: (context) => const InitialPages()));
  }

  @override
  void initState() {
    super.initState();
    getEmail();
  }

  @override
  Widget build(BuildContext context) {
    String firstName = context.watch<UserProvider>().firstName;
    String lastName = context.watch<UserProvider>().lastName;
    String email = context.watch<UserProvider>().email;
    String imageUrl = context.watch<UserProvider>().imageUrl;
    String password = context.watch<UserProvider>().password;
    String courseNumber = '1';
    String rank = '100';

    return Scaffold(
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(30),
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      backgroundImage: imageUrl.isNotEmpty ? NetworkImage(imageUrl) : null,
                      maxRadius: 45,
                    ),
                    Positioned(
                      top: 65,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 35,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: const Offset(0, 1.5), // changes position of shadow
                            ),
                          ],
                        ),
                        child: GestureDetector(
                          onTap: () {
                            log('change user image ');
                          },
                          child: Icon(
                            Icons.add_a_photo,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(50),
              Text("First Name: $firstName"),
              Text("last Name: $lastName"),
              Text("email: $email"),
              Text("pass: $password"),
              Text("ID(test): $id"),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: const ButtonStyle(
                    foregroundColor: MaterialStatePropertyAll(Colors.black),
                    surfaceTintColor: MaterialStatePropertyAll(Colors.purple),
                    shadowColor: MaterialStatePropertyAll(Colors.purple),
                  ),
                  onPressed: () {
                    logOut(context);
                  },
                  child: const Text("Sign out"),
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(imageUrl),
              maxRadius: 45,
            ),
            const Gap(15),
            Text(
              "$firstName $lastName",
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
            Expanded(
              child: FutureBuilder<List<Course>>(
                future: serivce.getCourse(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasData) {
                    final courses = snapshot.data;
                    return ListView.builder(
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return courses![index].author!.sId == id
                            ? GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CourseDetailOwner(
                                                course: courses[index],
                                              )));
                                },
                                child: Padding(
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
                                            height: 100,
                                            child: Image.network(
                                              courses[index].backgroundImage,
                                              fit: BoxFit.fill,
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
                                            const Gap(5),
                                            Flexible(
                                              child: SizedBox(
                                                width: 200,
                                                child: Text(
                                                  softWrap: true,
                                                  courses[index].description,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox();
                      },
                    );
                  } else {
                    return const Text("no courses av");
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
