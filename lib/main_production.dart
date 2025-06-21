import 'package:uponorflix/app/app.dart';
import 'package:uponorflix/bootstrap.dart';
import 'package:video_local_storage/video_local_storage.dart';
import 'package:video_repository/video_repository.dart';

Future<void> main() async {
  final videoLocalStorage = VideoLocalStorage();
  await VideoLocalStorage.init();
  final hiveVideoRepository = HiveVideoRepository(videoLocalStorage);

  await bootstrap(
    () => App(
      videoLocalStorage: videoLocalStorage,
      hiveVideoRepository: hiveVideoRepository,
    ),
  );
}
