import 'dart:math';

import 'package:brava/api/api_service.dart';
import 'package:brava/model/courses.dart';
import 'package:brava/screen/Home/VideoList/play_video.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:video_player/video_player.dart';

class CourseDetailOwner extends StatelessWidget {
  CourseDetailOwner({super.key, required this.course});
  Course course;
  String userNmae = "Bawar khalid";
  double rate = 4.4;
  ApiService serv = ApiService();

  @override
  Widget build(BuildContext context) {
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
      floatingActionButton: SizedBox(
        width: 130,
        height: 50,
        child: FloatingActionButton(
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Edit Course",
                style: TextStyle(color: Colors.purple),
              ),
              Icon(
                Icons.edit,
                color: Colors.purple,
              ),
            ],
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  insetPadding: const EdgeInsets.all(10),
                  child: SizedBox(
                    height: 650,
                    width: double.infinity,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const Gap(10),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Add a new video",
                                  style: TextStyle(fontSize: 18),
                                ),
                                IconButton(
                                  onPressed: () {
                                   
                                  },
                                  icon: const Icon(
                                    Icons.add,
                                    size: 20,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
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
                    course.backgroundImage,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const Gap(5),
              Text(
                course.name,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const Gap(5),
              Row(
                children: [
                  const Gap(10),
                  CircleAvatar(
                    backgroundImage: NetworkImage(course.author?.image ?? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTVz7Mxv3O1i6Yr_x0Uyokbw2pUDCMNrYUe6oJ58zXDoKqNroFqrsTFEXqZNNWCCUvYeMM&usqp=CAU"),
                  ),
                  const Gap(5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        course.author?.firstname ?? 'uknown',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "No. Student: ${course.numberOfStudents}",
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                  const Spacer(),
                  Text(
                    '${course.price} \$',
                    style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, fontSize: 20),
                  )
                ],
              ),
              const Gap(10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Descripition',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(course.description)
                ],
              ),
              const Gap(10),
              const Text("Lessons"),
              Expanded(
                child: ListView.builder(
                  itemCount: course.videos.length,
                  itemBuilder: (context, index) {
                    final courseUrl = course.videos[index];
                    return GestureDetector(
                      onTap: () {
                        print('this issssssssssssssssss $courseUrl');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PlayVideo(
                              videoURL: courseUrl,
                              videoName: 'test video player',
                            ),
                          ),
                        );
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
                              const Text(
                                'Test Name',
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
