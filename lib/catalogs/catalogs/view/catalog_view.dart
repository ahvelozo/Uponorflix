import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uponorflix/catalogs/catalogs/cubit/cubit.dart';
import 'package:uponorflix/catalogs/catalogs/widgets/action_button_create.dart';
import 'package:uponorflix/catalogs/catalogs/widgets/responsive_catalog.dart';
import 'package:uponorflix/widgets/app_drawer.dart';
import 'package:video_repository/video_repository.dart';

class CatalogView extends StatefulWidget {
  const CatalogView({super.key});

  @override
  State<CatalogView> createState() => CatalogViewState();
}

class CatalogViewState extends State<CatalogView> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (currentScroll >= maxScroll * 0.9) {
      context.read<CatalogCubit>().fetchNextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    final repo = RepositoryProvider.of<HiveVideoRepository>(context);
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: _appBarCustom(repo, context),
      floatingActionButton: const ActionButtonCreate(),
      body: BlocBuilder<CatalogCubit, CatalogState>(
        builder: (context, state) {
          switch (state.status) {
            case CatalogStatus.failure:
              return Center(
                child: Text('Error: ${state.errorMessage ?? 'unknown'}'),
              );
            case CatalogStatus.loading:
              return const Center(child: CircularProgressIndicator());
            case CatalogStatus.success:
              if (state.videos.isEmpty &&
                  state.status == CatalogStatus.loading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state.videos.isEmpty) {
                return const Center(child: Text('No videos'));
              }
              return ResponsiveCatalog(
                videos: state.videos,
                controller: _scrollController,
                hasReachedMax: state.hasReachedMax,
              );
            case CatalogStatus.initial:
              return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  AppBar _appBarCustom(VideoRepository repo, BuildContext context) {
    return AppBar(
      title: const Text('Catalog'),
      centerTitle: true,
      actions: [
        IconButton(
          tooltip: 'Seed demo data',
          icon: const Icon(Icons.cloud_download_outlined),
          onPressed: () async {
            await repo.seedIfEmpty(count: 50);
            if (context.mounted) await context.read<CatalogCubit>().refresh();
          },
        ),
        IconButton(
          tooltip: 'Delete all',
          icon: const Icon(Icons.delete_forever),
          onPressed: () async {
            await repo.deleteAll();
            if (context.mounted) await context.read<CatalogCubit>().refresh();
          },
        ),
      ],
    );
  }
}
