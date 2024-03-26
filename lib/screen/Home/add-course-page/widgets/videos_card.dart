import 'dart:io';

import 'package:brava/input_field.dart';
import 'package:brava/screen/Home/add-course-page/add_course.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CardOfVideoTitleAndSelectVideo extends StatelessWidget {
  CardOfVideoTitleAndSelectVideo({
    super.key,
    required this.videoTitleController,
    required this.videoNumber,
    required this.ontap,
    this.validator,
    this.video,
    required this.deleteButtonOnTap,
    this.imageType = ImageType.File,
  });
  final void Function() ontap;
  final void Function() deleteButtonOnTap;
  final TextEditingController videoTitleController;
  final int videoNumber;
  final FormFieldValidator? validator;
  final String? video;
  ImageType imageType;
  @override
  Widget build(BuildContext context) {
    VideoPlayerController? controller;
    initalizeVideo() {
      imageType == ImageType.File
          ? controller = VideoPlayerController.file(
              File(video!),
            )
          : VideoPlayerController.networkUrl(Uri.parse(video!));
      controller!..initialize().then((value) => null);
      controller!.pause();
      controller!.setLooping(false);
    }

    if (video != null) {
      initalizeVideo();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Video $videoNumber',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor, fontSize: 18),
                ),
                GestureDetector(
                  onTap: deleteButtonOnTap,
                  child: const CircleAvatar(
                    radius: 13,
                    backgroundColor: Colors.red,
                    child: Center(
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          InputField(
            controller: videoTitleController,
            validator: validator,
            label: 'Video-$videoNumber Title',
            hint: 'Enter the Title for the video',
          ),
          video == null
              ? GestureDetector(
                  onTap: ontap,
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    width: MediaQuery.of(context).size.width - 50,
                    height: 170,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                      color: Color.fromARGB(255, 225, 222, 249),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            border: Border.all(width: 5, color: Colors.white),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Icon(
                            Icons.add,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Select Video $videoNumber',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                )
              : Container(
                  width: MediaQuery.of(context).size.width - 50,
                  height: 150,
                  margin: const EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 1.2,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Chewie(
                      controller: ChewieController(
                        videoPlayerController: controller!,
                        aspectRatio: 16 / 10,
                        autoPlay: true,
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
