import 'dart:io';
import '../../../core/design/app_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class MixView extends StatefulWidget {
  const MixView({Key? key}) : super(key: key);

  @override
  State<MixView> createState() => _MixViewState();
}

class _MixViewState extends State<MixView> {
  String? imagePath;
  List<XFile> files = [];

  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            if (files.isNotEmpty)
              Wrap(
                children: List.generate(
                  files.length,
                  (index) => AppImage(
                    files[index].path,
                    width: 100.w,
                    height: 100.h,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
            ElevatedButton(
              onPressed: () async {
                var myFiles =
                    await ImagePicker.platform.getMultiImageWithOptions();
                if (myFiles.isNotEmpty) {
                  files.addAll(myFiles);
                  setState(() {});
                }
              },
              child: Text("show"),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 400,
              child: _controller.value.isInitialized
                  ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
                  : CircularProgressIndicator(),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _controller.value.isPlaying
                      ? _controller.pause()
                      : _controller.play();
                });
              },
              child: Icon(
                _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
