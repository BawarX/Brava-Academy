// ignore_for_file: non_constant_identifier_names, unnecessary_null_comparison

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
import 'package:random_string/random_string.dart';

class AddMyCourse extends StatefulWidget {
  const AddMyCourse({super.key});

  @override
  State<AddMyCourse> createState() => _AddMyCourseState();
}

class _AddMyCourseState extends State<AddMyCourse> {
  Future _pickImageFromGallery() async {
    final returnedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage == null) return;
    setState(() {
      selectedImage = File(returnedImage.path);
    });
  }

  Future _pickVideoFromGallery(String video) async {
    final returnedVideo = await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (returnedVideo == null) return;
    setState(() {
      selectedVideos[video] = File(returnedVideo.path);
    });
  }

  Future uploadBackgroundImage() async {
    print('upload method running================>');
    String addID = randomAlphaNumeric(10);
    Reference FirebaseStorageref = FirebaseStorage.instance.ref().child('courseBackgroundImages').child(courseNameController.text).child('$addID.jpg');
    final UploadTask task = FirebaseStorageref.putFile(selectedImage!);
    backgroundImageUrl = await (await task).ref.getDownloadURL();
    print('backgroundurl =========================> $backgroundImageUrl');
  }

  Future uploadCourseVideos(File file, int index, String videoname) async {
    if (selectedVideos.isNotEmpty) {
      String addID = randomAlphaNumeric(10);
      Reference FirebaseStorageref = FirebaseStorage.instance.ref().child('courseVideos').child(courseNameController.text).child('$videoname-$addID.mp4');
      final UploadTask task = FirebaseStorageref.putFile(file);
      controllers[index].videoUrl = await (await task).ref.getDownloadURL();
    }
  }

  final provider = SettingsProvider();
  File? selectedImage;
  Map<String, File> selectedVideos = {};
  final _formkey = GlobalKey<FormState>();
  int numberOfVideos = 1;
  String? backgroundImageUrl;
  TextEditingController courseNameController = TextEditingController();
  TextEditingController courseDescriptionController = TextEditingController();
  List<Video> controllers = [
    Video(videoTitle: TextEditingController(), videoUrl: ''),
  ];
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
              selectedImage != null
                  ? Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: double.infinity,
                            height: 160,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                selectedImage!,
                                fit: BoxFit.cover,
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
                                selectedImage = null;
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
                controller: courseNameController,
                validator: (v) => provider.courseTitleValidator(v),
              ),

              //description of course
              InputField(
                label: 'Course Description',
                hint: 'enter Description of the Course',
                controller: courseDescriptionController,
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
                        controllers.add(
                          Video(videoTitle: TextEditingController(), videoUrl: ''),
                        );
                        numberOfVideos++;
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
              for (int i = 0; i < numberOfVideos; i++)
                CardOfVideoTitleAndSelectVideo(
                  videoNumber: i + 1,
                  controller: controllers[i].videoTitle,
                  validator: (value) => provider.videoTitleValidator(value),
                  ontap: () async {
                    await _pickVideoFromGallery('video${i + 1}');
                  },
                  deleteButtonOnTap: () async {
                    setState(() {
                      controllers.removeAt(i);
                      numberOfVideos--;
                      var removedata = selectedVideos.remove('video${i + 1}');
                      Map<String, File> newmap = {};
                      int k = 1;
                      selectedVideos.keys.toList().forEach((element) {
                        newmap.addAll({
                          '${element.substring(0, 5)}$k': selectedVideos[element]!,
                        });
                        k++;
                      });
                      selectedVideos = newmap;
                      print(removedata);
                    });
                  },
                  video: selectedVideos.length > i ? selectedVideos['video${i + 1}'] : null,
                ),
              const Gap(10),

              //publish Button
              GestureDetector(
                onTap: () async {
                  if (numberOfVideos == 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('At least 1 video must be added'),
                      ),
                    );
                    return;
                  }
                  if (selectedImage == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please Selecte the background Image'),
                      ),
                    );
                    return;
                  }

                  if (_formkey.currentState!.validate()) {
                    if (numberOfVideos != selectedVideos.length) {
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
                      await uploadBackgroundImage();
                      for (int i = 0; i < numberOfVideos; i++) {
                        await uploadCourseVideos(selectedVideos['video${i + 1}'] as File, i, controllers[i].videoTitle.text);
                        log('upload=================================>$i');
                      }

                      Map<String, dynamic> course = {
                        'backgroundImage': backgroundImageUrl,
                        'name': courseNameController.text,
                        'description': courseDescriptionController.text,
                        'author': '65da3e9a03319490bcc5b81c',
                        'videos': [
                          for (int i = 0; i < numberOfVideos; i++)
                            {
                              'video${i + 1} title': controllers[i].videoTitle.text,
                              'video${i + 1} url': controllers[i].videoUrl,
                            }
                        ],
                        'price': 15,
                        'numberOfStudents': 0,
                      };
                      print(course);
                      await ApiService.addCourse(course);
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
              const Gap(15),
            ],
          ),
        ),
      ),
    );
  }
}
