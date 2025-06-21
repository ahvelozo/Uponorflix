import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uponorflix/catalogs/models/video_view_model.dart';

class VideoListTile extends StatelessWidget {
  const VideoListTile({required this.video, super.key});
  final VideoViewModel video;

  Color _badgeColor(BuildContext context) {
    switch (video.type) {
      case CatalogType.movie:
        return Colors.redAccent;
      case CatalogType.series:
        return Colors.blueAccent;
      case CatalogType.clip:
        return Colors.greenAccent;
      case CatalogType.other:
        return Theme.of(context).colorScheme.secondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => context.go('/catalog/${video.id}/edit'),
      leading: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image.network(
              video.thumbnailUrl,
              width: 64,
              height: 96,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
            ),
          ),
          Positioned(
            top: 4,
            left: 4,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
              decoration: BoxDecoration(
                color: _badgeColor(context).withValues(alpha: 0.85),
                borderRadius: BorderRadius.circular(3),
              ),
              child: Text(
                video.type.name.toUpperCase(),
                style: const TextStyle(fontSize: 9, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      title: Text(
        video.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text('${video.year}'),
      trailing: const Icon(Icons.chevron_right),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
    );
  }
}
