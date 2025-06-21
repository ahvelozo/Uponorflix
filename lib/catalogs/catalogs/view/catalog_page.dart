// -----------------------------------------------------------------------------
// UI – adaptive list/grid with infinite scroll
// -----------------------------------------------------------------------------
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uponorflix/catalogs/catalogs/cubit/cubit.dart';
import 'package:uponorflix/catalogs/catalogs/view/catalog_view.dart';
import 'package:video_repository/video_repository.dart';

class CatalogPage extends StatelessWidget {
  const CatalogPage({super.key});

  @override
  Widget build(BuildContext context) {
    final videoRepository = RepositoryProvider.of<VideoRepository>(context);
    return BlocProvider(
      create: (_) => CatalogCubit(videoRepository),
      child: const CatalogView(),
    );
  }
}
