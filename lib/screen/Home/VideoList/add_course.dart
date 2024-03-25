import 'dart:developer';
import 'dart:io';

import 'package:brava/api/api_service.dart';
import 'package:brava/model/video.dart';
import 'package:brava/provider/user.dart';
import 'package:brava/screen/Home/VideoList/videos_card.dart';
import 'package:brava/screen/Home/VideoList/widget/input_field.dart';
import 'package:brava/screen/Home/resources/save_video.dart';
import 'package:brava/widget/utils.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:random_string/random_string.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

class AddMyCourse extends StatefulWidget {
  const AddMyCourse({super.key});

  @override
  State<AddMyCourse> createState() => _AddMyCourseState();
}

class _AddMyCourseState extends State<AddMyCourse> {
  String? _videoUrl;
  String? imageDownloadUrl;
  VideoPlayerController? _controller;
  File? selectedImage;
  UploadTask? uploadTask;
  final TextEditingController _controllerTitle = TextEditingController();
  final TextEditingController _controllerDescription = TextEditingController();
  TextEditingController? _controllerVideoName;
  final _formKey = GlobalKey<FormState>();
  final ApiService _service = ApiService();
  int numberOfVideos = 1;
  String? id;
  List<Map<String, File>> selectedVideos = [];
  List<Video> controllers = [
    Video(videoTitle: TextEditingController(), videoUrl: ''),
  ];

  @override
  void dispose() {
    _controller?.dispose();
    _controllerTitle.dispose();
    _controllerDescription.dispose();
    super.dispose();
  }

  // pickVideo() async {
  //   final picker = ImagePicker();
  //   XFile? videoFile;
  //   try {
  //     videoFile = await picker.pickVideo(source: ImageSource.gallery);
  //     return videoFile!.path;
  //   } catch (e) {
  //     print('error picking video: $e');
  //   }
  // }

  void _initializeVideoPlayer() {
    _controller = VideoPlayerController.file(File(_videoUrl!))
      ..initialize().then((_) {
        setState(() {});
        _controller!.play();
      });
  }

  // void _pickVideo() async {
  //   _videoUrl = await pickVideo();
  //   _initializeVideoPlayer();
  // }

  Future selectedImages() async {
    final List<XFile> selectedImage = await ImagePicker().pickMultipleMedia();
    if (selectedImage.isNotEmpty) {
      selectedImage.addAll(selectedImage);
    }
  }

  Future _pickVideoFromGallery(String video) async {
    final returnedVideo = await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (returnedVideo == null) return;
    setState(() {
      selectedVideos.add({video: File(returnedVideo.path)});
    });
  }

  Future _pickImageFromGallery() async {
    final returnedImage = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnedImage == null) return;
    setState(() {
      selectedImage = File(returnedImage.path);
    });
  }

  // void _uploadVideo() async {
  //   _downloadUrl = await StoreData().uploadVideo(_videoUrl!, _controllerTitle.text);
  //   await StoreData().saveVideoData(_downloadUrl!);
  //   setState(() {
  //     _videoUrl = null;
  //   });
  // }'

  Future uploadCourseVideos(File file, int index, TextEditingController c) async {
    if (selectedVideos.isNotEmpty) {
      String addID = randomAlphaNumeric(10);
      Reference FirebaseStorageref = FirebaseStorage.instance.ref().child('videos').child(_controllerTitle.text).child('$_controllerVideoName.mp4');
      final UploadTask task = FirebaseStorageref.putFile(file);
      controllers[index].videoUrl = await (await task).ref.getDownloadURL();
    }
  }

  Future<void> _uploadImage() async {
    final file = File(selectedImage!.path);
    String addID = randomAlphaNumeric(10);
    final ref = FirebaseStorage.instance.ref().child('images').child(_controllerTitle.text).child('$addID.jpg');

    uploadTask = ref.putFile(file);
    await uploadTask!.whenComplete(() {});

    final snapshot = await ref.getDownloadURL();
    if (snapshot.isNotEmpty) {
      imageDownloadUrl = snapshot;
      print("Image download URL: ${imageDownloadUrl.toString()}");
    } else {
      print("Error: Download URL is null or empty");
    }
  }

  Future getEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      id = preferences.getString('_id')!;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEmail();
  }

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
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        onChanged: () {},
        child: SingleChildScrollView(
          child: Column(
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
                              )),
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
                        // IconButton(
                        //   onPressed: () {
                        //     setState(() {
                        //       selectedImage = null;
                        //     });
                        //   },
                        //   icon: const Icon(
                        //     Icons.close,
                        //     color: Colors.white,
                        //   ),
                        // )
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
                controller: _controllerTitle,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Enter Course Name and more than 5 chars';
                  }
                  return null;
                },
              ),
              InputField(
                label: 'Course Description',
                hint: 'Enter Description of the course',
                controller: _controllerDescription,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Enter Course Name';
                  }
                  return null;
                },
              ),
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
              for (int i = 0; i < numberOfVideos; i++)
                CardOfVideoTitleAndSelectVideo(
                  videoNumber: i + 1,
                  controller: controllers[i].videoTitle,
                  ontap: () async {
                    await _pickVideoFromGallery('video$numberOfVideos');
                  },
                  video: selectedVideos.length > i ? selectedVideos[i]['video$i'] : null,
                ),
              const Gap(10),
              GestureDetector(
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    if (selectedVideos.isEmpty || (selectedImage == null)) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Video & Image Required"),
                            content: const Text("Please select video and image"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("OK"),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      await _uploadImage();
                      log(selectedVideos.length.toString());
                      for (int i = 0; i < selectedVideos.length; i++) {
                        await uploadCourseVideos(selectedVideos[i]['video${i + 1}'] as File, i, _controllerTitle);
                      }
                    }
                  }

                  List<String> videos = [];
                  for (int i = 0; i < numberOfVideos; i++) {
                    videos.add(controllers[i].videoUrl);
                  }
                  Map<String, dynamic> course = {'coursebackground': imageDownloadUrl, 'courseName': _controllerTitle.text, 'courseDescription': _controllerDescription.text, 'videos': videos};

                  await _service.addCourse(course['courseName'], course['courseDescription'], course['videos'], 2, 200, id.toString(), imageDownloadUrl.toString(), context);
                },
                child: Container(
                  height: 57,
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
              const Gap(25),
            ],
          ),
        ),
      ),
    );
  }
}
