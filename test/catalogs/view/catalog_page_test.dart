import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uponorflix/catalogs/catalogs/cubit/catalog_cubit.dart';
import 'package:uponorflix/catalogs/catalogs/cubit/catalog_state.dart';
import 'package:uponorflix/catalogs/catalogs/view/catalog_page.dart';
import 'package:uponorflix/catalogs/catalogs/view/catalog_view.dart';
import 'package:uponorflix/l10n/gen/app_localizations.dart';
import 'package:video_local_storage/video_local_storage.dart';
import 'package:video_repository/video_repository.dart';

class FakeVideoRepository extends Fake implements HiveVideoRepository {
  @override
  Future<List<VideoEntity>> fetchPage({
    int page = 0,
    int limit = 10,
    CatalogTypeHive? filterType,
  }) async => <VideoEntity>[];

  @override
  Future<void> upsert(VideoEntity entity) async {}
  @override
  Future<void> delete(String id) async {}
  @override
  Future<void> deleteAll() async {}
  @override
  Future<VideoEntity?> getById(String id) async => null;
  @override
  Future<void> seedIfEmpty({int count = 50}) async {}
}

class MockCatalogCubit extends Mock implements CatalogCubit {
  @override
  Stream<CatalogState> get stream => const Stream<CatalogState>.empty();
}

void main() {
  group('CatalogPage', () {
    testWidgets('renders CatalogView', (tester) async {
      await tester.pumpWidget(
        RepositoryProvider<HiveVideoRepository>(
          create: (_) => FakeVideoRepository(),
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: CatalogPage(),
          ),
        ),
      );
      expect(find.byType(CatalogView), findsOneWidget);
    });

    testWidgets('shows loading indicator when loading', (tester) async {
      final cubit = MockCatalogCubit();
      when(
        () => cubit.state,
      ).thenReturn(const CatalogState(status: CatalogStatus.loading));
      await tester.pumpWidget(
        RepositoryProvider<HiveVideoRepository>(
          create: (_) => FakeVideoRepository(),
          child: BlocProvider<CatalogCubit>.value(
            value: cubit,
            child: const MaterialApp(
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              home: CatalogView(),
            ),
          ),
        ),
      );
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('shows error message on failure', (tester) async {
      final cubit = MockCatalogCubit();
      const errorMsg = 'error!';
      when(() => cubit.state).thenReturn(
        const CatalogState(
          status: CatalogStatus.failure,
          errorMessage: errorMsg,
        ),
      );
      await tester.pumpWidget(
        RepositoryProvider<HiveVideoRepository>(
          create: (_) => FakeVideoRepository(),
          child: BlocProvider<CatalogCubit>.value(
            value: cubit,
            child: const MaterialApp(
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              home: CatalogView(),
            ),
          ),
        ),
      );
      // Use the l10n errorPrefix
      expect(find.textContaining('Error'), findsOneWidget);
      expect(find.textContaining(errorMsg), findsOneWidget);
    });

    testWidgets('shows no videos message when empty', (tester) async {
      final cubit = MockCatalogCubit();
      when(() => cubit.state).thenReturn(
        const CatalogState(status: CatalogStatus.success),
      );
      await tester.pumpWidget(
        RepositoryProvider<HiveVideoRepository>(
          create: (_) => FakeVideoRepository(),
          child: BlocProvider<CatalogCubit>.value(
            value: cubit,
            child: const MaterialApp(
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              home: CatalogView(),
            ),
          ),
        ),
      );
      // Use the l10n key for 'No videos'
      expect(find.text('No videos'), findsOneWidget);
    });
  });
}
