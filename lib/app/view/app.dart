import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uponorflix/l10n/l10n.dart';
import 'package:uponorflix/routes/routes.dart';
import 'package:uponorflix/theme/theme.dart';
import 'package:video_local_storage/video_local_storage.dart';
import 'package:video_repository/video_repository.dart';

class App extends StatelessWidget {
  const App({
    required this.videoLocalStorage,
    required this.hiveVideoRepository,
    super.key,
  });

  final VideoLocalStorage videoLocalStorage;
  final HiveVideoRepository hiveVideoRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => videoLocalStorage,
        ),
        RepositoryProvider(
          create: (context) => hiveVideoRepository,
        ),
      ],
      child: MaterialApp.router(
        routerConfig: appRouter,
        title: 'uponoflix',
        debugShowCheckedModeBanner: false,
        theme: FlutterTagTheme.light,
        darkTheme: FlutterTagTheme.dark,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
  }
}
