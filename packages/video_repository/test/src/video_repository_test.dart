import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:video_local_storage/video_local_storage.dart';
import 'package:video_repository/video_repository.dart';

class MockVideoLocalStorage extends Mock implements VideoLocalStorage {}

void main() {
  group('HiveVideoRepository', () {
    late MockVideoLocalStorage mockStorage;
    late HiveVideoRepository repository;

    setUp(() {
      mockStorage = MockVideoLocalStorage();
      repository = HiveVideoRepository(mockStorage);
    });

    test('fetchPage delegates to storage', () async {
      final videos = [
        VideoEntity(
          id: '1',
          title: 'Test Video',
          year: 2020,
          thumbnailUrl: 'https://example.com/thumb.jpg',
          type: CatalogTypeHive.movie,
        ),
      ];

      when(
        mockStorage.fetchPage(page: 0, limit: 1),
      ).thenAnswer((_) async => videos);

      final result = await repository.fetchPage(page: 0, limit: 1);

      expect(result, videos);
      verify(mockStorage.fetchPage(page: 0, limit: 1)).called(1);
    });
  });
}
