import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:video_player/video_player.dart';

class PlayVideo extends StatefulWidget {
  const PlayVideo({super.key, required this.videoURL, required this.videoName});
  final String videoURL;
  final String videoName;

  @override
  State<PlayVideo> createState() => _PlayVideoState();
}

class _PlayVideoState extends State<PlayVideo> {
  late VideoPlayerController _controller;
  late Future<void> _initalizeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    print('this issssssssssssssssssssazzzzzzzzzzzzzzz ${widget.videoURL}');
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.videoURL),
    );
    _initalizeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.videoName),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              _controller.play();
            }
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
      body: Center(
        child: FutureBuilder(
          future: _initalizeVideoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return SizedBox(
                height: 600,
                width: double.infinity,
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
              );
            } else {
              return const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Loading video: Let's say some zikir:"),
                  // Text(
                  //   "سُبْحَانَ اللّهِ وَ بِحَمْدِهِ",
                  //   style: TextStyle(fontSize: 25),
                  // ),
                  // Text(
                  //   "لا حَوْلَ وَ لا قُوَّةَ اِلَّا بِاللّهِ",
                  //   style: TextStyle(fontSize: 25),
                  // ),
                  // Text(
                  //   "اللّهُ اَكْبَرُ",
                  //   style: TextStyle(fontSize: 25),
                  // ),
                  // Text(
                  //   "لا اِلهَ اِلَّا اللّهُ",
                  //   style: TextStyle(fontSize: 25),
                  // ),
                  CircularProgressIndicator(),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
