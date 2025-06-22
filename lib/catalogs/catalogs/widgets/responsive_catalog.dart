import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:uponorflix/catalogs/catalogs/widgets/video_grid.dart';
import 'package:uponorflix/catalogs/catalogs/widgets/video_list.dart';
import 'package:uponorflix/catalogs/models/video_view_model.dart';

class ResponsiveCatalog extends StatelessWidget {
  const ResponsiveCatalog({
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
    return AdaptiveLayout(
      body: SlotLayout(
        config: <Breakpoint, SlotLayoutConfig>{
          Breakpoints.small: SlotLayout.from(
            key: const Key('top small'),
            builder: (_) => VideoList(
              videos: videos,
              controller: controller,
              hasReachedMax: hasReachedMax,
            ),
          ),
          Breakpoints.mediumAndUp: SlotLayout.from(
            key: const Key('top mediumAndUp'),
            builder: (_) => VideoGrid(
              videos: videos,
              controller: controller,
              hasReachedMax: hasReachedMax,
            ),
          ),
        },
      ),
    );
  }
}
