import 'dart:io';

import 'package:brava/screen/Home/resources/save_video.dart';
import 'package:brava/widget/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class AddMyCourse extends StatefulWidget {
  const AddMyCourse({super.key});

  @override
  State<AddMyCourse> createState() => _AddMyCourseState();
}

class _AddMyCourseState extends State<AddMyCourse> {
  String? _videoUrl;
  VideoPlayerController? _controller;
  String? _downloadUrl;
  final TextEditingController _controllerTitle = TextEditingController();
  final TextEditingController _controllerDescription = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  pickVideo() async {
    final picker = ImagePicker();
    XFile? videoFile;
    try {
      videoFile = await picker.pickVideo(source: ImageSource.gallery);
      return videoFile!.path;
    } catch (e) {
      print('error picking video: $e');
    }
  }

  void _initializeVideoPlayer() {
    _controller = VideoPlayerController.file(File(_videoUrl!))
      ..initialize().then((_) {
        setState(() {});
        _controller!.play();
      });
  }

  void _pickVideo() async {
    _videoUrl = await pickVideo();
    _initializeVideoPlayer();
  }

  Future selectedImages() async {
    final List<XFile> selectedImage = await ImagePicker().pickMultipleMedia();
    if (selectedImage.isNotEmpty) {
      selectedImage.addAll(selectedImage);
    }
  }

  Future _pickImageFromGallery() async {
    final returnedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage == null) return;
    setState(() {
      selectedImage = File(returnedImage.path);
    });
  }

  void _uploadVideo() async {
    _downloadUrl = await StoreData().uploadVideo(_videoUrl!);
    await StoreData().saveVideoData(_downloadUrl!);
    setState(() {
      _videoUrl = null;
    });
  }

  Widget _videoPreviewWidget() {
    if (_controller != null) {
      print("video should be seen");
      return Column(
        children: [
          ElevatedButton(
            onPressed: () {
              _uploadVideo();
            },
            child: const Text('upload video'),
          ),
          AspectRatio(
            aspectRatio: _controller!.value.aspectRatio,
            child: VideoPlayer(_controller!),
          ),
        ],
      );
    } else {
      return const CircularProgressIndicator();
    }
  }

  File? selectedImage;
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
                        IconButton(
                          onPressed: () {
                            setState(() {
                              selectedImage = null;
                            });
                          },
                          icon: const Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                        )
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "Select Background Image for your Course",
                                  style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, fontSize: 18),
                                ),
                                Icon(
                                  Icons.add_a_photo,
                                  color: Theme.of(context).primaryColor,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  width: double.infinity,
                  height: 60,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 225, 222, 249),
                    borderRadius: BorderRadius.all(
                      Radius.circular(25),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: _controllerTitle,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      decoration: InputDecoration(
                        hintText: "Enter the title of the course",
                        hintStyle: TextStyle(
                          color: Theme.of(context).primaryColor.withOpacity(0.6),
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        border: InputBorder.none,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter a title";
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  width: double.infinity,
                  height: 130,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 225, 222, 249),
                    borderRadius: BorderRadius.all(
                      Radius.circular(25),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: _controllerDescription,
                      maxLines: 5,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      decoration: InputDecoration(
                        hintText: "Enter the description of the course",
                        hintStyle: TextStyle(
                          color: Theme.of(context).primaryColor.withOpacity(0.6),
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        border: InputBorder.none,
                      ),
                      onSaved: (String? value) {
                        if (value != null) {
                          _controllerDescription.text = value;
                        }
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter a description";
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: GestureDetector(
                  onTap: () {
                    _pickVideo();
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
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Select Course videos",
                            style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Icon(
                            Icons.add,
                            color: Theme.of(context).primaryColor,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              const Gap(10),
              GestureDetector(
                onTap: () {
                  if (_formKey.currentState!.validate() && _videoUrl != null && selectedImage != null) {
                    print('validated');
                  } else {
                    print("form is not valid");
                  }
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
              // const Gap(100),
              // Container(
              //   width: double.infinity,
              //   height: 300,
              //   color: Colors.red,
              //   child: _videoUrl != null ? _videoPreviewWidget() : const Text("No Video selected"),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
