// Not required for test files
// ignore_for_file: prefer_const_constructors
import 'package:test/test.dart';
import 'package:video_repository/video_repository.dart';

void main() {
  group('VideoRepository', () {
    test('can be instantiated', () {
      expect(VideoRepository(), isNotNull);
    });
  });
}
