import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
                'UPONORFLIX',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge!.copyWith(color: Colors.red),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context); // cierra drawer
              context.go('/home');
            },
          ),
          ListTile(
            leading: const Icon(Icons.video_library),
            title: const Text('Manage Videos'),
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
