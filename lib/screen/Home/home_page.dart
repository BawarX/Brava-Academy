import 'dart:convert';
import 'dart:ffi';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:brava/api/api_service.dart';
import 'package:brava/model/author.dart';
import 'package:brava/screen/Home/course_detail.dart';
import 'package:http/http.dart' as http;
import 'package:brava/data/instructor_data.dart';
import 'package:brava/model/courses.dart';
import 'package:brava/provider/bookmark.dart';
import 'package:brava/provider/user.dart';
import 'package:brava/screen/Home/add_course.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiService serivce = ApiService();
  List<int> bookmarkedIndices = [];

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  void getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email') ?? '';
    String userName = prefs.getString('username') ?? '';
    String imageUrl = prefs.getString('imageUrl') ?? '';
    context.read<UserProvider>().setUser(username: userName, imageUrl: imageUrl, email: email);
  }

  @override
  Widget build(BuildContext context) {
    String email = context.watch<UserProvider>().email;
    String userNmae = context.watch<UserProvider>().username;
    String imageUrl = context.watch<UserProvider>().imageUrl;

    final bookmarkProvider = Provider.of<BookmarkProvider>(context, listen: true);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(10),
              Row(
                children: [
                  const Gap(10),
                  CircleAvatar(
                    backgroundImage: NetworkImage(imageUrl),
                  ),
                  const Gap(5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hi $userNmae",
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        "Welcome Back 👋",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const AddMyCourse()));
                    },
                    child: Container(
                      width: 40,
                      height: 40,
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
                      child: Icon(
                        Icons.add_circle_outline_rounded,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(left: 5, top: 5),
                child: Text(
                  "Enjoy a new learning experience\nwith this great community",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              const Gap(10),
              SizedBox(
                height: 50,
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(5),
                    hintText: 'What are you looking for?',
                    prefixIcon: const Icon(
                      Icons.search,
                    ),
                    suffixIcon: Icon(
                      Icons.menu,
                      color: Theme.of(context).primaryColor,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              const Gap(15),
              Column(
                children: [
                  Row(
                    children: [
                      const Text(
                        "Top Instructor",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const Spacer(),
                      const Text(
                        "See All",
                        style: TextStyle(color: Colors.grey),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Theme.of(context).primaryColor,
                      )
                    ],
                  ),
                  //TODO: move to person profile
                  SizedBox(
                    height: 60,
                    child: FutureBuilder<List<Course>>(
                      future: serivce.getCourse(),
                      builder: (context, snapshot) {
                        final courses = snapshot.data;
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage('${courses![index].author!.image}'),
                                  ),
                                  Text(
                                    '${courses[index].author!.firstname}',
                                    style: const TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
              const Gap(5),
              Row(
                children: [
                  const Text(
                    "Top Courses",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    "See All",
                    style: TextStyle(color: Colors.grey),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Theme.of(context).primaryColor,
                  )
                ],
              ),
              Expanded(
                child: FutureBuilder<List<Course>>(
                  future: serivce.getCourse(),
                  builder: ((context, snapshot) {
                    if (snapshot.hasData) {
                      final courses = snapshot.data!;
                      return GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisExtent: 220),
                        itemCount: courses.length,
                        itemBuilder: (context, index) {
                          Course courseModel = courses[index];

                          return GestureDetector(
                            onTap: () {
                              print("button presed");
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CourseDetail(
                                            course: courseModel,
                                          )));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Container(
                                width: 200,
                                height: 200,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      spreadRadius: 2,
                                      blurRadius: 0.5,
                                      offset: const Offset(0, 1.5),
                                    )
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Stack(
                                      children: [
                                        SizedBox(
                                          width: double.infinity,
                                          height: 140,
                                          child: Image.network(
                                            courses[index].backgroundImage,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Positioned(
                                          top: 5,
                                          left: 5,
                                          child: Container(
                                            width: 40,
                                            height: 20,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(
                                                10,
                                              ),
                                            ),
                                            child: const Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Icon(
                                                  Icons.star,
                                                  size: 14,
                                                  color: Colors.yellow,
                                                ),
                                                Text(
                                                  '4',
                                                  style: TextStyle(fontSize: 12),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 5,
                                          right: 5,
                                          child: Container(
                                            width: 30,
                                            height: 25,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(
                                                10,
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(
                                                      () {
                                                        if (!bookmarkProvider.isBookmarked(courseModel)) {
                                                          bookmarkProvider.addItem(courseModel);
                                                          print('item added');
                                                        } else {
                                                          bookmarkProvider.removeItem(courseModel);
                                                          print('item removed');
                                                        }
                                                      },
                                                    );
                                                  },
                                                  child: Icon(
                                                    bookmarkProvider.isBookmarked(courseModel) ? Icons.bookmark : Icons.bookmark_outline,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Gap(10),
                                    Flexible(
                                      child: AutoSizeText(
                                        courses[index].name,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5, left: 5, right: 5),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Icon(
                                            Icons.group,
                                            size: 16,
                                          ),
                                          const Gap(5),
                                          Text(courses[index].numberOfStudents.toString()),
                                          const Spacer(),
                                          Text('\$${courses[index].price.toString()}'),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return const Text("something is compeletly wrong");
                    }
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
