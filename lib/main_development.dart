import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:uponorflix/app/app.dart';
import 'package:uponorflix/bootstrap.dart';
import 'package:video_local_storage/video_local_storage.dart';
import 'package:video_repository/video_repository.dart';

Future<void> main() async {
  await SentryFlutter.init(
    (options) {
      options
        ..environment = 'development'
        ..debug = true
        ..dsn =
            'https://d33afab7ef667351c283d356b960fb22@o4509521998774272.ingest.de.sentry.io/4509521999691856';
    },
    appRunner: () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Sentry.captureMessage(
        'App started in development',
      );
      final videoLocalStorage = VideoLocalStorage();
      var path = '';
      if (!kIsWeb) {
        final dir = await path_provider.getApplicationDocumentsDirectory();
        path = dir.path;
      }
      await VideoLocalStorage.init(path);
      final hiveVideoRepository = HiveVideoRepository(videoLocalStorage);
      await hiveVideoRepository.seedIfEmpty();
      await bootstrap(
        () => App(
          videoLocalStorage: videoLocalStorage,
          hiveVideoRepository: hiveVideoRepository,
        ),
      );
    },
  );
}
