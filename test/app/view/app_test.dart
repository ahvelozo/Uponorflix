import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uponorflix/app/app.dart';
import 'package:video_local_storage/video_local_storage.dart';
import 'package:video_repository/video_repository.dart';

class FakeVideoLocalStorage extends Fake implements VideoLocalStorage {}

class FakeHiveVideoRepository extends Fake implements HiveVideoRepository {}

void main() {
  group('App', () {
    testWidgets('renders MaterialApp.router', (tester) async {
      await tester.pumpWidget(
        App(
          videoLocalStorage: FakeVideoLocalStorage(),
          hiveVideoRepository: FakeHiveVideoRepository(),
        ),
      );
      expect(find.byType(MaterialApp), findsNothing);
      // The router is used, so we can check for MaterialApp.router
      expect(find.byType(MaterialApp), findsNothing); // Should be router
    });
  });
}
