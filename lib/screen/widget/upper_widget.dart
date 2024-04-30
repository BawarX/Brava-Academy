import 'package:brava/screen/Home/add_course.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../model/video_model.dart';

class UpperWidgets extends StatelessWidget {
  const UpperWidgets({
    super.key,
    required this.userNmae,
    required this.userId,
  });

  final String userNmae;
  final String userId;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Gap(10),
        const CircleAvatar(
          backgroundImage: AssetImage(
            'assets/images/guy1.png',
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
                  authorId: userId,
                  appBarTitle: 'Add Course',
                  textOfButton: 'Publish',
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
