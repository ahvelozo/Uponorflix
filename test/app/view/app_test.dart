import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uponorflix/app/app.dart';
import 'package:video_local_storage/video_local_storage.dart';
import 'package:video_repository/video_repository.dart';

class FakeVideoLocalStorage extends Fake implements VideoLocalStorage {}

class FakeHiveVideoRepository extends Fake implements HiveVideoRepository {}

void main() {
  group('App', () {
    testWidgets('App usa MaterialApp.router', (tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(
          App(
            videoLocalStorage: FakeVideoLocalStorage(),
            hiveVideoRepository: FakeHiveVideoRepository(),
          ),
        );
        // Avanza el tiempo lo suficiente para que cualquier Timer termine
        await tester.pump(const Duration(seconds: 3));
      });

      final app = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(app.routerConfig ?? app.routerDelegate, isNotNull);
    });
  });
}
