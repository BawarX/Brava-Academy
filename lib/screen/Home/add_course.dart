// ignore_for_file: non_constant_identifier_names, unnecessary_null_comparison, must_be_immutable

import 'dart:developer';
import 'dart:io';

import 'package:brava/api/api_service.dart';
import 'package:brava/screen/widget/input_field.dart';
import 'package:brava/model/video_model.dart';
import 'package:brava/provider/input_field_provider.dart';
import 'package:brava/screen/video/videos_card.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quickalert/quickalert.dart';
import 'package:random_string/random_string.dart';
import 'package:video_player/video_player.dart';

enum ImageType {
  Network,
  File,
}

class AddMyCourse extends StatefulWidget {
  AddMyCourse({
    super.key,
    required this.numberOfVideos,
    required this.controllers,
    required this.courseDescriptionController,
    required this.courseNameController,
    required this.selectedImage,
    this.selectedImageType = ImageType.File,
    this.videoType = ImageType.File,
    required this.appBarTitle,
    required this.textOfButton,
    this.courseId,
    required this.authorId,
  });
  int numberOfVideos;
  String? selectedImage;
  TextEditingController courseNameController;
  TextEditingController courseDescriptionController;
  List<Video> controllers;
  ImageType selectedImageType;
  ImageType videoType;
  final String appBarTitle;
  final String textOfButton;
  final String? courseId;
  final String authorId;
  @override
  State<AddMyCourse> createState() => _AddMyCourseState();
}

class _AddMyCourseState extends State<AddMyCourse> {
  getImage(ImageType status) {
    switch (status) {
      case ImageType.Network:
        return widget.selectedImage!;
      case ImageType.File:
        return widget.selectedImage!;
    }
  }

  Future _pickImageFromGallery() async {
    final returnedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage == null) return;
    setState(() {
      widget.selectedImage = returnedImage.path;
      widget.selectedImageType = ImageType.File;
    });
  }

  Future _pickVideoFromGallery(int index) async {
    final returnedVideo = await ImagePicker().pickVideo(source: ImageSource.gallery);

    if (returnedVideo == null) return;
    setState(() {
      widget.controllers[index].videoUrl = returnedVideo.path;
    });
  }

  Future uploadBackgroundImage() async {
    print('upload method running================>');
    String addID = randomAlphaNumeric(10);
    Reference FirebaseStorageref = FirebaseStorage.instance.ref().child('courseBackgroundImages').child(widget.courseNameController.text).child('$addID-${DateTime.now()}.jpg');
    final UploadTask task = FirebaseStorageref.putFile(
      File(
        getImage(ImageType.File),
      ),
    );
    widget.selectedImage = await (await task).ref.getDownloadURL();
  }

  Future uploadCourseVideos(File file, int index, String videoname) async {
    if (widget.controllers.isNotEmpty) {
      String addID = randomAlphaNumeric(10);
      Reference FirebaseStorageref = FirebaseStorage.instance.ref().child('courseVideos').child(widget.courseNameController.text).child('$videoname-$addID.mp4');
      final UploadTask task = FirebaseStorageref.putFile(file);
      widget.controllers[index].videoUrl = await (await task).ref.getDownloadURL();
      widget.controllers[index].videoType = ImageType.Network;
    }
  }

  final provider = SettingsProvider();
  final _formkey = GlobalKey<FormState>();
  String? backgroundImageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            widget.selectedImage = null;
            widget.courseNameController.clear();
            widget.courseDescriptionController.clear();
            widget.controllers.clear();
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).primaryColor,
          ),
        ),
        title: Text(
          widget.appBarTitle,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              widget.selectedImage != null
                  ? Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: double.infinity,
                            height: 160,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: widget.selectedImageType == ImageType.File
                                  ? Image.file(
                                      File(getImage(ImageType.File)),
                                      fit: BoxFit.cover,
                                    )
                                  : Image.network(
                                      getImage(ImageType.Network),
                                    ),
                            ),
                          ),
                        ),
                        Positioned(
                          height: 70,
                          right: 20,
                          child: GestureDetector(
                            onTap: () {
                              print('delete the image');
                              setState(() {
                                widget.selectedImage = null;
                              });
                            },
                            child: const CircleAvatar(
                              radius: 18,
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.close,
                                color: Colors.red,
                                size: 23,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Padding(
                      padding: const EdgeInsets.all(10),
                      child: GestureDetector(
                        onTap: () {
                          _pickImageFromGallery();
                        },
                        child: Container(
                          width: double.infinity,
                          height: 160,
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 225, 222, 249),
                            borderRadius: BorderRadius.all(
                              Radius.circular(25),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Select Background Image for your Course",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                                const Gap(10),
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Theme.of(context).primaryColor.withOpacity(.6),
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(50),
                                    ),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.add_a_photo,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

              InputField(
                label: 'Course Name',
                hint: 'Enter Name Of the Course',
                controller: widget.courseNameController,
                validator: (v) => provider.courseTitleValidator(v),
              ),

              //description of course
              InputField(
                label: 'Course Description',
                hint: 'enter Description of the Course',
                controller: widget.courseDescriptionController,
                validator: (v) => provider.courseTitleValidator(v),
              ),

              //videos Text and add icon
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Videos',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 20,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        widget.controllers.add(
                          Video(videoTitle: TextEditingController(), videoUrl: ''),
                        );
                        widget.numberOfVideos++;
                        setState(() {});
                      },
                      icon: CircleAvatar(
                        radius: 15,
                        child: Center(
                          child: Icon(
                            Icons.add,
                            color: Theme.of(context).primaryColor,
                            size: 24,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              //videos title field and selected videos button
              for (int i = 0; i < widget.numberOfVideos; i++)
                CardOfVideoTitleAndSelectVideo(
                  videoNumber: i + 1,
                  videoTitleController: widget.controllers[i].videoTitle,
                  validator: (value) => provider.videoTitleValidator(value),
                  ontap: () async {
                    await _pickVideoFromGallery(i);
                  },
                  deleteButtonOnTap: () async {
                    setState(() {
                      widget.controllers.removeAt(i);
                      widget.numberOfVideos--;
                    });
                  },
                  video: widget.controllers[i].videoUrl == '' ? null : widget.controllers[i].videoUrl,
                  controller: widget.controllers[i].videoType == ImageType.File
                      ? VideoPlayerController.file(
                          File(widget.controllers[i].videoUrl),
                        )
                      : VideoPlayerController.networkUrl(Uri.parse(widget.controllers[i].videoUrl)),
                ),

              const Gap(10),

              //publish Button
              GestureDetector(
                onTap: () async {
                  print(widget.selectedImageType);
                  for (int i = 0; i < widget.controllers.length; i++) {
                    print('$i =================> ${widget.controllers[i].videoType}');
                  }
                  if (widget.numberOfVideos == 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('At least 1 video must be added'),
                      ),
                    );
                    return;
                  }
                  if (widget.selectedImage == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please Selecte the background Image'),
                      ),
                    );
                    return;
                  }

                  if (_formkey.currentState!.validate()) {
                    int numberOfSelectedVideos = 0;
                    for (int i = 0; i < widget.controllers.length; i++) {
                      if (widget.controllers[i].videoUrl != '') {
                        numberOfSelectedVideos++;
                      }
                    }
                    if (widget.numberOfVideos != numberOfSelectedVideos) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please Selecte All the Video'),
                        ),
                      );
                      return;
                    } else {
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
                      if (widget.selectedImageType == ImageType.File) {
                        await uploadBackgroundImage();
                      }
                      for (int i = 0; i < widget.numberOfVideos; i++) {
                        if (widget.controllers[i].videoType == ImageType.File) {
                          await uploadCourseVideos(File(widget.controllers[i].videoUrl), i, widget.controllers[i].videoTitle.text);
                          log('upload=================================>$i');
                        }
                      }
                      log('data==================================>');
                      print(widget.selectedImage);
                      print(widget.courseNameController.text);
                      log('data==================================>');
                      Map<String, dynamic> course = {
                        'backgroundImage': widget.selectedImage,
                        'name': widget.courseNameController.text,
                        'description': widget.courseDescriptionController.text,
                        'author': widget.authorId,
                        'videos': [
                          for (int i = 0; i < widget.numberOfVideos; i++)
                            {
                              'video${i + 1} title': widget.controllers[i].videoTitle.text,
                              'video${i + 1} url': widget.controllers[i].videoUrl,
                            }
                        ],
                        'price': 15,
                        'numberOfStudents': 0,
                      };
                      widget.appBarTitle == 'Add Course' ? await ApiService.addCourse(course) : await ApiService.updateCourse(widget.courseId!, course);
                      Navigator.pop(context);
                      QuickAlert.show(
                        context: context,
                        type: QuickAlertType.success,
                        autoCloseDuration: const Duration(seconds: 3),
                        title: 'Course Added Successfully',
                        confirmBtnText: 'Ok',
                      );

                      if (widget.appBarTitle == 'Add Course') {
                        widget.selectedImage = null;
                        widget.courseNameController.clear();
                        widget.courseDescriptionController.clear();
                        widget.controllers.clear();
                        widget.controllers = [
                          Video(videoTitle: TextEditingController(), videoUrl: ''),
                        ];
                        widget.numberOfVideos = 1;
                        setState(() {});
                      }
                      Navigator.pop(context);
                    }
                  } else {
                    provider.showSnackBar('Fix the Error', context);
                  }
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 20),
                  height: 60,
                  width: 250,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      widget.textOfButton,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
              ),
              const Gap(15),
            ],
          ),
        ),
      ),
    );
  }
}
