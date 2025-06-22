import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:uponorflix/app/app.dart';
import 'package:uponorflix/bootstrap.dart';
import 'package:video_local_storage/video_local_storage.dart';
import 'package:video_repository/video_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final videoLocalStorage = VideoLocalStorage();
  var path = '';
  if (!kIsWeb) {
    final dir = await path_provider.getApplicationDocumentsDirectory();
    path = dir.path;
  }
  await VideoLocalStorage.init(path);
  final hiveVideoRepository = HiveVideoRepository(videoLocalStorage);
  await bootstrap(
    () => App(
      videoLocalStorage: videoLocalStorage,
      hiveVideoRepository: hiveVideoRepository,
    ),
  );
}
