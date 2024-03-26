import 'dart:convert';

import 'package:brava/api/api_service.dart';
import 'package:brava/constant.dart';
import 'package:brava/data/course_data.dart';
import 'package:brava/data/instructor_data.dart';
import 'package:brava/model/courses.dart';
import 'package:brava/model/video_model.dart';
import 'package:brava/provider/bookmark.dart';
import 'package:brava/screen/Home/add-course-page/add_course.dart';
import 'package:brava/screen/Home/course_detail.dart';
import 'package:brava/screen/Home/profile.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void fetchData() async {
    await ApiService.fetchData();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    String userNmae =
        jsonDecode(sharedPreferences.getString('user')!)['firstname'] ?? "User";
    final provider = Provider.of<BookmarkProvider>(context, listen: true);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          width: double.infinity,
          height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(10),
                upperWidgets(userNmae: userNmae),
                const Padding(
                  padding: EdgeInsets.only(left: 5, top: 10),
                  child: Text(
                    "Enjoy a new learning experience\nwith this great community",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
                    SizedBox(
                      height: 60,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: instructorData.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  backgroundImage:
                                      AssetImage(instructorData[index].image),
                                ),
                                Text(
                                  instructorData[index].name,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const Gap(10),
                Row(
                  children: [
                    const Text(
                      "Courses",
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
                courseData.isEmpty
                    ? const Expanded(
                        child: Center(
                          child: Text('Sorry We Don\'t have any course yet'),
                        ),
                      )
                    : Expanded(
                        child: GridView.builder(
                          itemCount: courseData.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, mainAxisExtent: 220),
                          itemBuilder: (context, index) {
                            CourseModel courseModel = courseData[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CourseDetail(
                                      courseModel: courseModel,
                                    ),
                                  ),
                                );
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
                                        offset: const Offset(0,
                                            1.5), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Gap(5),
                                      Stack(
                                        children: [
                                          SizedBox(
                                            width: double.infinity,
                                            height: 140,
                                            child: Image.network(
                                              courseModel.image,
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
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  10,
                                                ),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  const Icon(
                                                    Icons.star,
                                                    size: 14,
                                                    color: Colors.yellow,
                                                  ),
                                                  Text(
                                                    courseModel.rank.toString(),
                                                    style: const TextStyle(
                                                        fontSize: 12),
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
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  10,
                                                ),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        courseModel
                                                                .isBookmarked =
                                                            !courseModel
                                                                .isBookmarked;
                                                        if (courseModel
                                                            .isBookmarked) {
                                                          provider.addItem(
                                                              courseModel);
                                                        } else {
                                                          provider.removeItem(
                                                              courseModel);
                                                        }
                                                      });
                                                    },
                                                    child:
                                                        courseModel.isBookmarked
                                                            ? Icon(
                                                                Icons.bookmark,
                                                                size: 18,
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColor,
                                                              )
                                                            : Icon(
                                                                Icons
                                                                    .bookmark_outline,
                                                                size: 18,
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColor,
                                                              ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Gap(10),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 5.0),
                                        child: Text(
                                          courseModel.courseTitle,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                      const Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 5, left: 5, right: 5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('${courseModel.duration} H'),
                                            Text(courseModel.price),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class upperWidgets extends StatelessWidget {
  const upperWidgets({
    super.key,
    required this.userNmae,
  });

  final String userNmae;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Gap(10),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProfileScreen(),
              ),
            );
          },
          child: const CircleAvatar(
            backgroundImage: AssetImage(
              'assets/images/guy1.png',
            ),
          ),
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
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddMyCourse(
                  controllers: [
                    Video(videoTitle: TextEditingController(), videoUrl: ''),
                  ],
                  numberOfVideos: 1,
                  courseDescriptionController: TextEditingController(),
                  courseNameController: TextEditingController(),
                  selectedImage: null,
                ),
              ),
            );
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
    );
  }
}
