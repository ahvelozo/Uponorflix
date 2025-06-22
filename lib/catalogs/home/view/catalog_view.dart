// ignore_for_file: unused_element_parameter, document_ignores

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uponorflix/catalogs/home/cubit/cubit.dart';
import 'package:uponorflix/catalogs/models/video_view_model.dart';

class CatalogView extends StatelessWidget {
  const CatalogView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            snap: true,
            backgroundColor: Colors.transparent,
            title: Text(
              'Uponorflix'.toUpperCase(),
              style: const TextStyle(color: Colors.red),
            ),
          ),

          // Gallery with the 3-5 most recent videos.
          const _RecentGallerySection(),

          // Category rows (shuffled each time).
          ...(CatalogType.values.toList()..shuffle()).map(
            (t) => _CategorySection(type: t),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 32)),
        ],
      ),
    );
  }
}

/*────────────────── “Latest” Gallery ──────────────────*/
class _RecentGallerySection extends StatelessWidget {
  const _RecentGallerySection({
    this.limit = 5,
  });
  final int limit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CatalogCubit, CatalogState>(
      buildWhen: (p, c) => p.recent != c.recent,
      builder: (_, state) {
        final recents = state.recent.take(limit).toList();
        if (recents.isEmpty) return const SliverToBoxAdapter();

        return SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Text(
                  'Latest',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 220,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  itemCount: recents.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 6),
                  itemBuilder: (_, i) => _GalleryItem(video: recents[i]),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _GalleryItem extends StatelessWidget {
  const _GalleryItem({required this.video});
  final VideoViewModel video;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/catalog/${video.id}/edit'),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Image.network(
          video.thumbnailUrl,
          width: 140,
          height: 220,
          fit: BoxFit.cover,
          errorBuilder: (_, _, _) => Container(color: Colors.grey),
        ),
      ),
    );
  }
}

/*────────────────── Category Row ──────────────────*/
class _CategorySection extends StatefulWidget {
  const _CategorySection({required this.type});
  final CatalogType type;

  @override
  State<_CategorySection> createState() => _CategorySectionState();
}

class _CategorySectionState extends State<_CategorySection> {
  final _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<CatalogCubit>().fetchNextPage(widget.type);
    _controller.addListener(_onScroll);
  }

  void _onScroll() {
    if (_controller.position.pixels >=
        _controller.position.maxScrollExtent - 200) {
      context.read<CatalogCubit>().fetchNextPage(widget.type);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CatalogCubit, CatalogState>(
      buildWhen: (p, c) => p.items[widget.type] != c.items[widget.type],
      builder: (_, state) {
        final list = state.items[widget.type] ?? [];

        return SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Text(
                  _titleFor(widget.type),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 160,
                child: ListView.builder(
                  controller: _controller,
                  scrollDirection: Axis.horizontal,
                  itemCount: list.length,
                  itemBuilder: (_, i) => _VideoThumb(video: list[i]),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _titleFor(CatalogType t) {
    switch (t) {
      case CatalogType.movie:
        return 'Movies';
      case CatalogType.series:
        return 'Series';
      case CatalogType.clip:
        return 'Clips';
      case CatalogType.other:
        return 'Other';
    }
  }
}

/*────────────────── Card Thumbnail ──────────────────*/
class _VideoThumb extends StatelessWidget {
  const _VideoThumb({required this.video});
  final VideoViewModel video;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, '/catalog/${video.id}/edit'),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Image.network(
            video.thumbnailUrl,
            width: 110,
            height: 160,
            fit: BoxFit.cover,
            errorBuilder: (_, _, _) => Container(color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
