import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../domain/model/note_model.dart';

class NoteController extends GetxController {
  final RxList<NoteModel> notes = <NoteModel>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNotes();
  }

  void fetchNotes() async {
    isLoading.value = true;

    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid != null) {
        final snapshot =
            await FirebaseFirestore.instance
                .collection('users')
                .doc(uid)
                .collection('notes')
                .get();

        notes.value =
            snapshot.docs.map((doc) => NoteModel.fromFirestore(doc)).toList();
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load notes');
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> addNote(String title, String description) async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) return false;

      final note = {
        'title': title,
        'description': description,
        'createdAt': FieldValue.serverTimestamp(),
      };

      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('notes')
          .add(note);

      fetchNotes(); // refresh notes after adding
      return true;
    } catch (e) {
      Get.snackbar('Error', 'Failed to add note');
      return false;
    }
  }
}
