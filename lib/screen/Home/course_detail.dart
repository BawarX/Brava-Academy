// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:brava/api/api_service.dart';
import 'package:brava/constant.dart';
import 'package:brava/model/courses.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:quickalert/quickalert.dart';

class CourseDetail extends StatelessWidget {
  CourseDetail({super.key, required this.courseModel, required this.authorName, required this.authorImage});
  CourseModel courseModel;
  String authorName;
  String authorImage;
  double rate = 4.4;
  final user = jsonDecode(sharedPreferences.getString('user')!);
  @override
  Widget build(BuildContext context) {
    print(sharedPreferences.getBool('isLogin'));
    print(sharedPreferences.getString('user'));
    print(courseModel.students);
    bool userEnrolled = false;
    checkUserEnrolledTheCourse() {
      if (courseModel.authorId == user['_id']) {
        userEnrolled = true;
      } else {
        for (int i = 0; i < courseModel.students.length; i++) {
          if (user['_id'] == courseModel.students[i]) {
            userEnrolled = true;
            break;
          }
        }
      }
    }

    checkUserEnrolledTheCourse();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Theme.of(context).primaryColor,
            )),
        title: const Text(
          "Course Detail",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 250,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image.network(
                    courseModel.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Gap(5),
              Text(
                courseModel.courseTitle,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const Gap(5),
              Row(
                children: [
                  const Gap(10),
                  CircleAvatar(
                    backgroundImage: NetworkImage(authorImage),
                  ),
                  const Gap(5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        authorName,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Rate: $rate",
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                  const Spacer(),
                  Text(
                    'free',
                    style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 20),
                  )
                ],
              ),
              const Gap(10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Description',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(courseModel.description)
                ],
              ),
              const Gap(10),
              const Text("Lessons"),
              Expanded(
                child: ListView.builder(
                  itemCount: courseModel.videos.length,
                  itemBuilder: (context, index) {
                    final courseUrl = courseModel.videos[index];
                    return GestureDetector(
                      onTap: () {
                        if (userEnrolled) {
                          print('this issssssssssssssssss $courseUrl');
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => PlayVideo(
                          //       videoURL: courseUrl,
                          //       videoName: 'video',
                          //     ),
                          //   ),
                          // );
                        } else {
                          QuickAlert.show(
                            context: context,
                            type: QuickAlertType.warning,
                            title: 'you aren\'t Enroll the course',
                            text: 'Please enroll the course to watch the video',
                            autoCloseDuration: const Duration(seconds: 3),
                          );
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: double.infinity,
                          height: 70,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.all(Radius.circular(15)),
                              border: Border.all(
                                color: Colors.grey,
                              )),
                          child: Row(
                            children: [
                              const Gap(15),
                              Container(
                                width: 38,
                                height: 38,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.play_arrow),
                              ),
                              const Gap(15),
                              Text(courseModel.videos[index]['video${index + 1} title'], style: const TextStyle()),
                              const Spacer(),
                              !userEnrolled
                                  ? Icon(
                                      Icons.lock,
                                      color: Theme.of(context).primaryColor,
                                    )
                                  : const SizedBox(),
                              const SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              !userEnrolled
                  ? OutlinedButton(
                      onPressed: () async {
                        showDialog(
                            context: context,
                            builder: (Context) {
                              return const Dialog(
                                  insetPadding: EdgeInsets.all(10),
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: 200,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          "Video Uploading...",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        CircularProgressIndicator(),
                                      ],
                                    ),
                                  ));
                            });
                        await ApiService.EnrollCourse(courseModel.id, user['_id']);
                        Navigator.pop(context);
                        // QuickAlert.show(context: context,type: QuickAlertType.success,
                        // title: 'Seccessfully Enrolled',);
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
                      ),
                      child: const Center(
                        child: Text(
                          'Enroll',
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    )
                  : const SizedBox(),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
