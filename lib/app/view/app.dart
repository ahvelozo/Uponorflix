import 'package:flutter/material.dart';
import 'package:uponorflix/l10n/l10n.dart';
import 'package:uponorflix/routes/routes.dart';
import 'package:uponorflix/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      title: 'uponoflix',
      debugShowCheckedModeBanner: false,
      theme: FlutterTagTheme.light,
      darkTheme: FlutterTagTheme.dark,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
