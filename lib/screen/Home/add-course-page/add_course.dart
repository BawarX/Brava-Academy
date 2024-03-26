// ignore_for_file: non_constant_identifier_names, unnecessary_null_comparison, must_be_immutable

import 'dart:developer';
import 'dart:io';

import 'package:brava/api/api_service.dart';
import 'package:brava/input_field.dart';
import 'package:brava/model/video_model.dart';
import 'package:brava/provider/input_field_provider.dart';
import 'package:brava/screen/Home/add-course-page/widgets/videos_card.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quickalert/quickalert.dart';
import 'package:random_string/random_string.dart';

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
    this.selectedVideos = const {},
  });
  int numberOfVideos;
  String? selectedImage;
  TextEditingController courseNameController;
  TextEditingController courseDescriptionController;
  List<Video> controllers;
  ImageType selectedImageType;
  Map<String, dynamic> selectedVideos;

  @override
  State<AddMyCourse> createState() => _AddMyCourseState();
}

class _AddMyCourseState extends State<AddMyCourse> {
  getImage(ImageType status) {
    print(widget.selectedImage);
    switch (status) {
      case ImageType.Network:
        return widget.selectedImage!;
      case ImageType.File:
        return widget.selectedImage!;
    }
  }

  Future _pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage == null) return;
    setState(() {
      widget.selectedImage = returnedImage.path;
    });
  }

  Future _pickVideoFromGallery(String video) async {
    final returnedVideo =
        await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (returnedVideo == null) return;
    setState(() {
      widget.selectedVideos[video] = returnedVideo.path;
    });
  }

  Future uploadBackgroundImage() async {
    print('upload method running================>');
    String addID = randomAlphaNumeric(10);
    Reference FirebaseStorageref = FirebaseStorage.instance
        .ref()
        .child('courseBackgroundImages')
        .child(widget.courseNameController.text)
        .child('$addID.jpg');
    final UploadTask task =
        FirebaseStorageref.putFile(File(getImage(ImageType.File)));
    backgroundImageUrl = await (await task).ref.getDownloadURL();
    print('backgroundurl =========================> $backgroundImageUrl');
  }

  Future uploadCourseVideos(File file, int index, String videoname) async {
    if (widget.selectedVideos.isNotEmpty) {
      String addID = randomAlphaNumeric(10);
      Reference FirebaseStorageref = FirebaseStorage.instance
          .ref()
          .child('courseVideos')
          .child(widget.courseNameController.text)
          .child('$videoname-$addID.mp4');
      final UploadTask task = FirebaseStorageref.putFile(file);
      widget.controllers[index].videoUrl =
          await (await task).ref.getDownloadURL();
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
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).primaryColor,
          ),
        ),
        title: Text(
          'Add Course',
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
                                child:
                                    widget.selectedImageType == ImageType.File
                                        ? Image.file(
                                            File(getImage(ImageType.File)),
                                            fit: BoxFit.cover,
                                          )
                                        : Image.network(
                                            getImage(ImageType.Network))),
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
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                const Gap(10),
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Theme.of(context)
                                          .primaryColor
                                          .withOpacity(.6),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
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
                          Video(
                              videoTitle: TextEditingController(),
                              videoUrl: ''),
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
                    await _pickVideoFromGallery('video${i + 1}');
                  },
                  deleteButtonOnTap: () async {
                    setState(() {
                      widget.controllers.removeAt(i);
                      widget.numberOfVideos--;
                      var removedata =
                          widget.selectedVideos.remove('video${i + 1}');
                      Map<String, File> newmap = {};
                      int k = 1;
                      widget.selectedVideos.keys.toList().forEach((element) {
                        newmap.addAll({
                          '${element.substring(0, 5)}$k':
                              widget.selectedVideos[element]!,
                        });
                        k++;
                      });
                      widget.selectedVideos = newmap;
                      print(removedata);
                    });
                  },
                  video: widget.selectedVideos.length < i
                      ? widget.selectedVideos['video${i + 1}']
                      : null,
                ),
              const Gap(10),

              //publish Button
              GestureDetector(
                onTap: () async {
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
                    if (widget.numberOfVideos != widget.selectedVideos.length) {
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
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          });
                      await uploadBackgroundImage();
                      for (int i = 0; i < widget.numberOfVideos; i++) {
                        await uploadCourseVideos(
                            File(widget.selectedVideos['video${i + 1}']),
                            i,
                            widget.controllers[i].videoTitle.text);
                        log('upload=================================>$i');
                      }

                      Map<String, dynamic> course = {
                        'backgroundImage': backgroundImageUrl,
                        'name': widget.courseNameController.text,
                        'description': widget.courseDescriptionController.text,
                        'author': '65da3e9a03319490bcc5b81c',
                        'videos': [
                          for (int i = 0; i < widget.numberOfVideos; i++)
                            {
                              'video${i + 1} title':
                                  widget.controllers[i].videoTitle.text,
                              'video${i + 1} url':
                                  widget.controllers[i].videoUrl,
                            }
                        ],
                        'price': 15,
                        'numberOfStudents': 0,
                      };
                      print(course);
                      await ApiService.addCourse(course);
                      Navigator.pop(context);
                      QuickAlert.show(
                        context: context,
                        type: QuickAlertType.success,
                        autoCloseDuration: const Duration(seconds: 3),
                        title: 'Course Added Successfully',
                        confirmBtnText: 'Ok',
                      );
                      widget.selectedImage = null;
                      widget.courseNameController.clear();
                      widget.courseDescriptionController.clear();
                      widget.controllers.clear();
                      widget.selectedVideos.clear();
                      widget.controllers = [
                        Video(
                            videoTitle: TextEditingController(), videoUrl: ''),
                      ];
                      widget.numberOfVideos = 1;
                      setState(() {});
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
                  child: const Center(
                    child: Text(
                      "Publish",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
