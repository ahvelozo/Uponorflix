// ignore_for_file: unused_element_parameter, document_ignores

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uponorflix/home/cubit/cubit.dart';
import 'package:uponorflix/catalogs/models/video_view_model.dart';
import 'package:uponorflix/widgets/app_drawer.dart';

class CatalogView extends StatelessWidget {
  const CatalogView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            floating: true,
            snap: true,
            backgroundColor: Colors.transparent,
            title: Text(
              'UPONORFLIX',
              style: TextStyle(color: Colors.red),
            ),
          ),
          const _RecentGallerySection(),
          ..._shuffledTypes().map((t) => _CategorySection(type: t)),
          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }

  List<CatalogType> _shuffledTypes() {
    final l = CatalogType.values.toList();
    return l;
  }
}

/*──────────────────────── Latest Gallery ───────────────────────*/
class _RecentGallerySection extends StatelessWidget {
  const _RecentGallerySection({this.limit = 10});
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
                height: 250,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: recents.length,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  separatorBuilder: (_, _) => const SizedBox(width: 8),
                  itemBuilder: (_, i) => _RectCard(video: recents[i]),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/*──────────────────────── Category Row ───────────────────────*/
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
    setState(() {}); // update arrow visibility
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
        if (list.isEmpty) {
          // If no items, return empty sliver
          return const SliverToBoxAdapter();
        } else {
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
                  height: 250,
                  child: Stack(
                    children: [
                      ListView.builder(
                        controller: _controller,
                        scrollDirection: Axis.horizontal,
                        itemCount: list.length,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        itemBuilder: (_, i) => _RectCard(video: list[i]),
                      ),
                      // Left arrow
                      if (_controller.hasClients && _controller.offset > 0)
                        Positioned(
                          left: 0,
                          top: 0,
                          bottom: 0,
                          child: _ArrowButton(
                            direction: AxisDirection.left,
                            onTap: () {
                              _controller.animateTo(
                                (_controller.offset - 300).clamp(
                                  0,
                                  _controller.position.maxScrollExtent,
                                ),
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeOut,
                              );
                            },
                          ),
                        ),
                      // Right arrow
                      if (_controller.hasClients &&
                          _controller.offset <
                              _controller.position.maxScrollExtent)
                        Positioned(
                          right: 0,
                          top: 0,
                          bottom: 0,
                          child: _ArrowButton(
                            direction: AxisDirection.right,
                            onTap: () {
                              _controller.animateTo(
                                (_controller.offset + 300).clamp(
                                  0,
                                  _controller.position.maxScrollExtent,
                                ),
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeOut,
                              );
                            },
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
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

/*──────────────────────── Card ───────────────────────*/
class _RectCard extends StatefulWidget {
  const _RectCard({required this.video});
  final VideoViewModel video;

  @override
  State<_RectCard> createState() => _RectCardState();
}

class _RectCardState extends State<_RectCard> {
  bool _hovering = false;

  void _setHover(bool h) => setState(() => _hovering = h);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _setHover(true),
      onExit: (_) => _setHover(false),
      child: GestureDetector(
        onTap: () => _setHover(true),
        onLongPress: () => context.go(
          '/catalog/${widget.video.id}/edit',
        ),
        onTapDown: (_) => _setHover(true),
        onTapCancel: () => _setHover(false),
        onTapUp: (_) => _setHover(false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 140,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          transform: _hovering ? Matrix4.identity() : Matrix4.identity(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.network(
                      widget.video.thumbnailUrl,
                      height: 180,
                      width: 140,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) =>
                          Container(height: 180, color: Colors.grey),
                    ),
                  ),
                  if (_hovering)
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.black.withValues(alpha: 0.75),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.video.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Year: ${widget.video.year}',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Type: ${widget.video.type.name}',
                              style: const TextStyle(
                                color: Colors.white54,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                widget.video.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '${widget.video.year}',
                style: const TextStyle(color: Colors.white70, fontSize: 11),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*──────────────────────── Arrow Button ───────────────────────*/
class _ArrowButton extends StatelessWidget {
  const _ArrowButton({required this.direction, required this.onTap});
  final AxisDirection direction;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final icon = direction == AxisDirection.left
        ? Icons.chevron_left
        : Icons.chevron_right;
    return Container(
      width: 36,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: direction == AxisDirection.left
              ? [Colors.black.withValues(alpha: 0.7), Colors.transparent]
              : [Colors.transparent, Colors.black.withValues(alpha: 0.7)],
        ),
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white70),
        onPressed: onTap,
      ),
    );
  }
}
