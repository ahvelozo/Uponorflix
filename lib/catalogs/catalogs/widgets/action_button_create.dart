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
      label: const Row(
        children: [
          Icon(Icons.add),
          SizedBox(width: 16),
          Text(
            'Add Video',
          ),
        ],
      ),
      tooltip: 'Add Video',
      onPressed: () {
        context.go('/catalog/new');
      },
    );
  }
}
