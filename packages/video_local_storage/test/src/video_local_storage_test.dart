// Not required for test files
// ignore_for_file: prefer_const_constructors
import 'package:test/test.dart';
import 'package:video_local_storage/video_local_storage.dart';

void main() {
  group('VideoLocalStorage', () {
    test('can be instantiated', () {
      expect(VideoLocalStorage.init(), isNotNull);
    });
  });
}
