// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primaryColor: Colors.red[900]),
        home: YoutubeVideo(videoId: 'dYZGnPuWmfQ'),
    );
  }
}

class YoutubeVideo extends StatefulWidget {
  // ignore: use_key_in_widget_constructors, prefer_const_constructors_in_immutables
  YoutubeVideo({this.videoId});
  // ignore: prefer_typing_uninitialized_variables
  final videoId;

  @override
  YoutubeVideoState createState() => YoutubeVideoState();
}

class YoutubeVideoState extends State<YoutubeVideo> {
  late YoutubePlayerController _controller;

  void runYoutubePlayer() {
    _controller = YoutubePlayerController(
        initialVideoId: widget.videoId,
        flags: const YoutubePlayerFlags(
          enableCaption: false,
          isLive: false,
          autoPlay: false,
        ),
    );
  }

  @override
  void initState() {
    runYoutubePlayer();
    super.initState();
  }

  @override
  // ignore: override_on_non_overriding_member
  void deactive() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: _controller,
            bottomActions: [
              CurrentPosition(),
              ProgressBar(isExpanded: true),
              PlayPauseButton(),
            ],
        ),
        builder: (content, player){
          return Scaffold(
            appBar: AppBar(
              title: const Text('Youtube Video Player'),
            ),
            body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    player,
                    SizedBox(height: 40.0,),
                    Text(
                        'Youtube Player'
                    ),
                  ]
              ),
          );
        }
    );
  }
}
