import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:video_local_storage/video_local_storage.dart';
import 'package:video_repository/video_repository.dart';

class FakeVideoLocalStorage extends Fake implements VideoLocalStorage {}

void main() {
  // Necesario para NNBD cuando usamos Fake con mocktail.
  setUpAll(() {
    registerFallbackValue(FakeVideoLocalStorage());
  });

  group('HiveVideoRepository', () {
    test('se puede instanciar con un VideoLocalStorage', () {
      final repo = HiveVideoRepository(FakeVideoLocalStorage());

      // Asertamos que devuelva algo del tipo esperado
      expect(repo, isA<VideoRepository>());
    });
  });
}
