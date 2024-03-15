import 'package:brava/api/api_service.dart';
import 'package:brava/model/courses.dart';
import 'package:brava/screen/Home/VideoList/video_list.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:video_player/video_player.dart';

class CourseDetail extends StatelessWidget {
  CourseDetail({super.key, required this.course});
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.network(
                  course.backgroundImage,
                  width: 400,
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
                  return course.videos.isEmpty
                      ? Center(
                          child: Column(
                            children: [
                              const Text("No videos available"),
                              SvgPicture.asset('assets/svg/no_videos.svg'),
                            ],
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              //  videoPreviewWidget();
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const VideoList()),
                              );
                            },
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
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    width: 38,
                                    height: 38,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(Icons.play_arrow),
                                  ),
                                  Text(
                                    course.videos[index],
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  const Text(
                                    "10:15",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                },
              ))
            ],
          ),
        ),
      ),
    );
  }
}
