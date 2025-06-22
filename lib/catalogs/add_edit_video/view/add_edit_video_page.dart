import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uponorflix/catalogs/add_edit_video/cubit/cubit.dart';
import 'package:uponorflix/catalogs/add_edit_video/view/video_form_view.dart';
import 'package:video_repository/video_repository.dart';

class AddEditVideoPage extends StatelessWidget {
  const AddEditVideoPage({super.key, this.videoId});
  final String? videoId;

  @override
  Widget build(BuildContext context) {
    final repo = RepositoryProvider.of<HiveVideoRepository>(context);
    return BlocProvider(
      create: (_) => VideoFormCubit(repo: repo, videoId: videoId),
      child: const VideoFormView(),
    );
  }
}
