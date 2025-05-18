import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../../domain/model/note_model.dart';
import '../../../controller/controller.dart';



class HomeView extends StatefulWidget {

  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final noteController = Get.find<NoteController>();
  final authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    getNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Notes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              final success = await authController.signOut();
              if (success && context.mounted) {
                context.pushReplacementNamed('sign_in');
              }
            },
          ),
        ],
      ),
      body: GetBuilder<NoteController>(builder: (noteController) {
        if (noteController.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        final notes = noteController.notes;

        if (notes.isEmpty) {
          return const Center(child: Text("No notes yet"));
        }

        return ListView.builder(
          itemCount: notes.length,
          itemBuilder: (_, index) {
            final NoteModel note = notes[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListTile(
                title: Text(note.title),
                subtitle: Text(
                  note.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed('note_entry');
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> getNotes() async {
    final noteController = Get.find<NoteController>();
      await noteController.fetchNotes();
    return;
  }

}
