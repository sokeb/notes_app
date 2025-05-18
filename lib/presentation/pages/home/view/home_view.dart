import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../../domain/model/note_model.dart';
import '../../../controller/note_controller.dart';

class HomeView extends StatelessWidget {
  final noteController = Get.find<NoteController>();

  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Notes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
              onPressed: () async {}
          ),
        ],
      ),
      body: Obx(() {
        if (noteController.isLoading.value) {
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
}
