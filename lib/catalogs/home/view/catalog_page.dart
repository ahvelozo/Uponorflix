// -----------------------------------------------------------------------------
// UI – adaptive list/grid with infinite scroll
// -----------------------------------------------------------------------------
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uponorflix/catalogs/home/cubit/cubit.dart';
import 'package:uponorflix/catalogs/home/view/catalog_view.dart';
import 'package:video_repository/video_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final videoRepository = RepositoryProvider.of<HiveVideoRepository>(context);
    return BlocProvider(
      create: (_) => CatalogCubit(videoRepository),
      child: const CatalogView(),
    );
  }
}
