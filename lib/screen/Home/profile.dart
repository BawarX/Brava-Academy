import 'dart:convert';

import 'package:brava/api/api_service.dart';
import 'package:brava/constant.dart';
import 'package:brava/data/course_data.dart';
import 'package:brava/model/video_model.dart';
import 'package:brava/screen/Home/add-course-page/add_course.dart';
import 'package:brava/screen/authentication/start_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gap/gap.dart';
import 'package:quickalert/quickalert.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var user = jsonDecode(sharedPreferences.getString('user')!);
  int courseNumber = 0;
  int rank = 0;
  getCourseNumberAndTotalStudent() {
    for (var element in courseData) {
      if (element.authorId == user['_id']) {
        courseNumber++;
        rank = rank + element.rank;
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCourseNumberAndTotalStudent();
  }

  @override
  Widget build(BuildContext context) {
    String firstName = "${user['firstname']} ";
    String lastName = "${user['lastname']} ";
    String image = "${user['image']} ";
    String email = "${user['email']} ";
    String pass = "${user['password']} ";
    String id = "${user['_id']} ";

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
                      backgroundImage:
                          image.isNotEmpty ? NetworkImage(image) : null,
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
                              offset: const Offset(
                                  0, 1.5), // changes position of shadow
                            ),
                          ],
                        ),
                        child: GestureDetector(
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
              Text("pass: $pass"),
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
                  onPressed: () async {
                    print(sharedPreferences.getBool('isLogin'));
                    print(sharedPreferences.getString('user'));
                    await sharedPreferences.clear();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Screen1(),
                      ),
                    );
                  },
                  child: const Text("Sign out"),
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(user['image']),
                ),
              ),
            ),
            const Gap(15),
            Text(
              '$firstName $lastName',
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
                      style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      courseNumber.toString(),
                      style: TextStyle(
                          fontSize: 16, color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "Rank",
                      style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      rank.toString(),
                      style: TextStyle(
                          fontSize: 16, color: Theme.of(context).primaryColor),
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
                  style: TextStyle(
                      fontSize: 20, color: Theme.of(context).primaryColor),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: courseData.length,
                itemBuilder: ((context, index) {
                  return courseData[index].authorId == user['_id']
                      ? Slidable(
                          direction: Axis.horizontal,
                          endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    QuickAlert.show(
                                        context: context,
                                        type: QuickAlertType.warning,
                                        title: 'Delete Course',
                                        text:
                                            'Are you sure you want to delete this course?',
                                        confirmBtnText: 'Delete',
                                        confirmBtnColor: Colors.red,
                                        onConfirmBtnTap: () async {
                                          await ApiService.deleteTheCourse(
                                              courseData[index].id);
                                          courseData.removeAt(index);
                                          Navigator.pop(context);
                                          setState(() {});
                                        },
                                        cancelBtnText: 'Cancel',
                                        showCancelBtn: true,
                                        onCancelBtnTap: () {
                                          Navigator.pop(context);
                                        });
                                  },
                                  child: Container(
                                    width: 80,
                                    height: 100,
                                    color: Colors.red,
                                    child: const Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.delete,
                                          size: 26,
                                          color: Colors.white,
                                        ),
                                        Gap(5),
                                        Text(
                                          'Delete',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    print(courseData[index].videos);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AddMyCourse(
                                          authorId: user['_id'],
                                          courseId: courseData[index].id,
                                          appBarTitle: 'Edit Course',
                                          textOfButton: 'Update',
                                          controllers: [
                                            for (int i = 0;
                                                i <
                                                    courseData[index]
                                                        .videos
                                                        .length;
                                                i++)
                                              Video(
                                                videoTitle: TextEditingController(
                                                    text: courseData[index]
                                                            .videos[i][
                                                        'video${i + 1} title']),
                                                videoUrl:
                                                    courseData[index].videos[i]
                                                        ['video${1 + i} url'],
                                                videoType: ImageType.Network,
                                              ),
                                          ],
                                          numberOfVideos:
                                              courseData[index].videos.length,
                                          courseDescriptionController:
                                              TextEditingController(
                                                  text: courseData[index]
                                                      .description),
                                          courseNameController:
                                              TextEditingController(
                                                  text: courseData[index]
                                                      .courseTitle),
                                          selectedImage:
                                              courseData[index].image,
                                          selectedImageType: ImageType.Network,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: 80,
                                    height: 100,
                                    color: Theme.of(context).primaryColor,
                                    child: const Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.edit,
                                          size: 26,
                                          color: Colors.white,
                                        ),
                                        Gap(5),
                                        Text(
                                          'Edit',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ]),
                          child: Container(
                            margin: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            courseData[index].image),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(25),
                                        bottomLeft: Radius.circular(25),
                                      ),
                                    ),
                                  ),
                                ),
                                const Gap(10),
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Gap(5),
                                      Text(
                                        courseData[index].courseTitle,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                      const Gap(5),
                                      Row(
                                        children: [
                                          Container(
                                            width: 90,
                                            height: 40,
                                            margin: const EdgeInsets.all(5),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                            child: const Row(
                                              children: [
                                                Icon(
                                                  Icons.edit_square,
                                                  color: Colors.white,
                                                  size: 22,
                                                ),
                                                Gap(5),
                                                Text(
                                                  'Edit',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: 90,
                                            height: 40,
                                            margin: const EdgeInsets.all(5),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                              color: Colors.red,
                                            ),
                                            child: const Row(
                                              children: [
                                                Icon(
                                                  Icons.delete,
                                                  color: Colors.white,
                                                  size: 22,
                                                ),
                                                Gap(5),
                                                Text(
                                                  'Delete',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            // Text(snapshot.data![index]['name']),
                          ),
                        )
                      : const SizedBox();
                  //
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
