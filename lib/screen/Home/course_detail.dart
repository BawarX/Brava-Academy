// ignore_for_file: must_be_immutable

import 'package:brava/model/courses.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';

class CourseDetail extends StatelessWidget {
  CourseDetail({super.key, required this.courseModel});
  CourseModel courseModel;
  //String userNmae = courseModel.authorId;
  double rate = 4.4;

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
                    fit: BoxFit.fill,
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
                  const CircleAvatar(),
                  const Gap(5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'author name here please',
                        style: TextStyle(
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
