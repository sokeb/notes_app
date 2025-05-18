import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../domain/model/note_model.dart';
import 'note_details_view.dart';

class NoteDetailsPage extends StatelessWidget {
  const NoteDetailsPage({super.key, required this.note});

  final NoteModel note;

  static final route = GoRoute(
    path: '/note_detail',
    name: 'note_detail',
    builder: (context, state) {
      final note = state.extra as NoteModel;
      return NoteDetailsPage(note: note);
    },
  );

  @override
  Widget build(BuildContext context) {
    return NoteDetailsView(note: note);
  }
}
