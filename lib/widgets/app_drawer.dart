import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uponorflix/l10n/gen/app_localizations.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.black87),
            child: Center(
              child: Text(
                AppLocalizations.of(context).appTitle,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge!.copyWith(color: Colors.red),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: Text(AppLocalizations.of(context).home),
            onTap: () {
              Navigator.pop(context); // cierra drawer
              context.go('/home');
            },
          ),
          ListTile(
            leading: const Icon(Icons.video_library),
            title: Text(AppLocalizations.of(context).manageVideos),
            onTap: () {
              Navigator.pop(context);
              context.go('/catalog');
            },
          ),
        ],
      ),
    );
  }
}
