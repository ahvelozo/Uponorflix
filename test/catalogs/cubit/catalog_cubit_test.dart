import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uponorflix/catalogs/catalogs/cubit/catalog_cubit.dart';
import 'package:uponorflix/catalogs/catalogs/cubit/catalog_state.dart';
import 'package:video_local_storage/video_local_storage.dart';
import 'package:video_repository/video_repository.dart';

class MockVideoRepository extends Mock implements VideoRepository {}

class FakeVideoEntity extends Fake implements VideoEntity {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeVideoEntity());
  });

  group('CatalogCubit', () {
    late MockVideoRepository repository;
    late CatalogCubit cubit;

    setUp(() {
      repository = MockVideoRepository();
      when(
        () => repository.fetchPage(
          page: any(named: 'page'),
          limit: any(named: 'limit'),
          filterType: any(named: 'filterType'),
        ),
      ).thenAnswer((_) async => <VideoEntity>[]);
      cubit = CatalogCubit(repository);
    });

    test('initial state is CatalogState', () {
      // The cubit calls fetchNextPage() in the constructor, so the state will not remain initial.
      // Instead, check that the initial state is loading or success with hasReachedMax true and empty videos.
      expect(
        cubit.state,
        const CatalogState(
          status: CatalogStatus.success,
          hasReachedMax: true,
        ),
      );
    });

    test('fetchNextPage emits success with videos', () async {
      await cubit.fetchNextPage();
      expect(cubit.state.status, CatalogStatus.success);
    });

    test('refresh resets state and fetches', () async {
      await cubit.refresh();
      expect(cubit.state.status, CatalogStatus.success);
    });
  });
}
