// ignore_for_file: must_be_immutable

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  VideoPlayerScreen({super.key, required this.videoUrl, required this.videoName});
  String videoUrl;
  String videoName;
  @override
  State<VideoPlayerScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<VideoPlayerScreen> {
  late VideoPlayerController videoPlayerController;
  ChewieController? chewieController;

  @override
  void initState() {
    super.initState();
    _initPlayer();
  }

  void _initPlayer() async {
    print(widget.videoUrl);
    videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
    await videoPlayerController.initialize();

    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      looping: true,
      // additionalOptions: (context) {
      //   return <OptionItem>[
      //     OptionItem(
      //       onTap: () => debugPrint('Option 1 pressed!'),
      //       iconData: Icons.chat,
      //       title: 'Option 1',
      //     ),
      //     OptionItem(
      //       onTap: () => debugPrint('Option 2 pressed!'),
      //       iconData: Icons.share,
      //       title: 'Option 2',
      //     ),
      //   ];
      // },
    );
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.videoName),
      ),
      body: chewieController != null
          ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Chewie(
                controller: chewieController!,
              ),
            )
          : const Center(
              child: Column(
                children: [
                  Text(
                    "Loading video please wait",
                    style: TextStyle(fontSize: 18),
                  ),
                  CircularProgressIndicator(),
                ],
              ),
            ),
    );
  }
}
