import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'note_entry_view.dart';


class NoteEntryPage extends StatelessWidget {
  const NoteEntryPage({super.key});

  static final route = GoRoute(
    path: '/note_entry',
    name: 'note_entry',
    builder: (context, state) => const NoteEntryPage(),
  );

  @override
  Widget build(BuildContext context) {
    return NoteEntryView();
  }
}
