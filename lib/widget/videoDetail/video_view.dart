import 'package:bt_bili/util/color.dart';
import 'package:bt_bili/util/view_util.dart';
import 'package:bt_bili/widget/videoDetail/video_contros.dart';
import 'package:chewie/chewie.dart' hide MaterialControls;
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoView extends StatefulWidget {
  final String url;
  final String cover;
  final bool autoplay;
  final bool looping;
  final double aspectRatio;
  final Widget? overlayUI;
  final Widget? barrageUI;

  const VideoView({
    super.key,
    required this.url,
    required this.cover,
    this.autoplay = false,
    this.looping = false,
    this.aspectRatio = 16 / 9,
    this.overlayUI,
    this.barrageUI,
  });

  @override
  State<VideoView> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  //封面
  FractionallySizedBox get _placeholder =>
      FractionallySizedBox(widthFactor: 1, child: cachedImage(widget.cover));

  //进度条颜色配置
  ChewieProgressColors get _progressColors => ChewieProgressColors(
    playedColor: primary,
    handleColor: primary,
    backgroundColor: Colors.grey,
    bufferedColor: primary,
  );

  //配置进度条颜色

  @override
  void initState() {
    super.initState();
    print(widget.url);
    _videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(widget.url),
    );
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      aspectRatio: widget.aspectRatio,
      autoPlay: widget.autoplay,
      looping: widget.looping,
      allowMuting: false,
      allowPlaybackSpeedChanging: false,
      placeholder: _placeholder,
      materialProgressColors: _progressColors,
      customControls: MaterialControls(
        showLoadingOnInitialize: false,
        showBigPlayIcon: false,
        bottomGradient: blackLinearGradient(),
        overlayUI: widget.overlayUI,
        barrageUI: widget.barrageUI,
      ),
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double playerHeight = screenWidth / widget.aspectRatio;

    return Container(
      width: screenWidth,
      height: playerHeight,
      color: Colors.grey,
      child: Chewie(controller: _chewieController),
    );
  }
}
