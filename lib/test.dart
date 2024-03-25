import 'dart:developer';
import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerClass extends StatefulWidget {
  const VideoPlayerClass({super.key});

  @override
  State<VideoPlayerClass> createState() => _VideoPlayerClassState();
}

class _VideoPlayerClassState extends State<VideoPlayerClass> {
  late VideoPlayerController _controller;
  XFile? selectedVideo;
  late FlickManager _flickManager;
  @override
  Widget build(BuildContext context) {
    Future pickVideoFromGallery() async {
      final returnedVideo =
          await ImagePicker().pickVideo(source: ImageSource.gallery);
      if (returnedVideo == null) return;
      setState(() {
        selectedVideo = returnedVideo;
        _controller = VideoPlayerController.file(
          File(selectedVideo!.path),
        )..initialize().then((value) => null);
        _controller.play();
        _controller.setLooping(false);
        _flickManager = FlickManager(
          videoPlayerController: _controller,
        );
        setState(() {});
        log('=======================${_controller.value.duration}');
      });
    }

    return Scaffold(
      body: selectedVideo != null
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Center(
                //   child: SizedBox(
                //       width: double.infinity,
                //       height: 250,
                //       child: AspectRatio(
                //           aspectRatio: 16 / 10, child: VideoPlayer(_controller))),
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    width: double.infinity,
                    height: 200,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Chewie(
                        controller: ChewieController(
                          videoPlayerController: _controller,
                          aspectRatio: 16 / 10,
                          autoPlay: true,
                        ),
                      ),
                    ),
                  ),
                ),
                OutlinedButton(
                  onPressed: () async {
                    pickVideoFromGallery();
                  },
                  child: const Text('Pick Video'),
                ),
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircularProgressIndicator(),
                OutlinedButton(
                  onPressed: () async {
                    pickVideoFromGallery();
                  },
                  child: const Text('Pick Video'),
                ),
              ],
            ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
    _flickManager.dispose();
  }
}
