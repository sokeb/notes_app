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
          title: const Text('My Notes'),
          centerTitle: true,
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
        body: GetBuilder<NoteController>(
          builder: (noteController) {
            final notes = noteController.notes;

            if (noteController.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (notes.isEmpty) {
              return const Center(child: Text("No notes available", style: TextStyle(fontSize: 18)));
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: notes.length,
              itemBuilder: (_, index) {
                final NoteModel note = notes[index];
                return GestureDetector(
                  onTap: () {
                    context.pushNamed('note_detail', extra: note);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          note.title,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          note.description,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
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
