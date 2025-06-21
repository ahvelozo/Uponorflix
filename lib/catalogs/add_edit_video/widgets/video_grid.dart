import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:uponorflix/catalogs/catalogs/widgets/video_card.dart';
import 'package:uponorflix/catalogs/models/video_view_model.dart';

class VideoGrid extends StatelessWidget {
  const VideoGrid({
    required this.videos,
    required this.controller,
    required this.hasReachedMax,
    super.key,
  });

  final List<VideoViewModel> videos;
  final ScrollController controller;
  final bool hasReachedMax;

  /// Basic helper that maps screen width to a sensible column count.
  int _columnsForWidth(BuildContext context) {
    if (Breakpoints.largeAndUp.isActive(context)) return 8;
    if (Breakpoints.large.isActive(context)) return 6;
    if (Breakpoints.mediumAndUp.isActive(context)) return 4;
    if (Breakpoints.smallAndUp.isActive(context)) return 3;
    return 2;
  }

  @override
  Widget build(BuildContext context) {
    final crossAxisCount = _columnsForWidth(context);

    return GridView.builder(
      controller: controller,
      padding: const EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.67,
      ),
      itemCount: hasReachedMax ? videos.length : videos.length + 1,
      itemBuilder: (_, i) {
        if (i >= videos.length) {
          return const Center(child: CircularProgressIndicator());
        }
        return VideoCard(video: videos[i]);
      },
    );
  }
}
