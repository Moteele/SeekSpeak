import 'package:seek_speak/app_export.dart';
import 'package:video_player/video_player.dart';

import '../objectbox.g.dart';

class Practice extends StatelessWidget {
  const Practice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Box<Syllable> sylBox = Get.find();
    Syllable? syl = sylBox.get(Get.arguments);
    return Scaffold(
      appBar: AppBar(title: Text("Syllable " + (syl?.name ?? 'X'))),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              width: 400,
              height: 400,
              color: Colors.white,
              child: VideoPlayerScreen()),
          Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Color(0xFFF6B26B)),
              child: Text(
                "Practice",
                style: TextStyle(fontSize: 40),
              ),
              onPressed: () {
                Get.toNamed('/speak', arguments: Get.arguments);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({Key? key}) : super(key: key);

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    );
    _initializeVideoPlayerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // If the VideoPlayerController has finished initialization, use
          // the data it provides to limit the aspect ratio of the video.
          return GestureDetector(
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                // Use the VideoPlayer widget to display the video.
                child: Stack(alignment: Alignment.center, children: [
                  VideoPlayer(_controller),
                  if (!_controller.value.isPlaying)
                    Icon(Icons.play_arrow,
                        size: 120, color: Colors.grey.withOpacity(0.8)),
                ]),
              ),
              onTap: () {
                setState(() {
                  // If the video is playing, pause it.
                  if (_controller.value.isPlaying) {
                    _controller.pause();
                  } else {
                    // If the video is paused, play it.
                    _controller.play();
                  }
                });
              });
        } else {
          // If the VideoPlayerController is still initializing, show a
          // loading spinner.
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
