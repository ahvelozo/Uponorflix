import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uponorflix/l10n/l10n.dart';

class ActionButtonCreate extends StatelessWidget {
  const ActionButtonCreate({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return FloatingActionButton.extended(
      label: Row(
        children: [
          const Icon(Icons.add),
          const SizedBox(width: 16),
          Text(l10n.addVideo),
        ],
      ),
      tooltip: l10n.addVideo,
      onPressed: () {
        context.go('/catalog/new');
      },
    );
  }
}
