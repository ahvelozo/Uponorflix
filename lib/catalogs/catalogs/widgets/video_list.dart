import 'package:flutter/material.dart';
import 'package:uponorflix/catalogs/catalogs/widgets/video_card.dart';
import 'package:uponorflix/catalogs/models/video_view_model.dart';

class VideoList extends StatelessWidget {
  const VideoList({
    required this.videos,
    required this.controller,
    required this.hasReachedMax,
    super.key,
  });

  final List<VideoViewModel> videos;
  final ScrollController controller;
  final bool hasReachedMax;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: controller,
      padding: const EdgeInsets.all(12),
      itemCount: hasReachedMax ? videos.length : videos.length + 1,
      itemBuilder: (context, index) {
        if (index >= videos.length) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: VideoCard(video: videos[index]),
        );
      },
    );
  }
}
