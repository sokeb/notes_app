import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../domain/model/note_model.dart';

class NoteController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<NoteModel> _notes = [];
  bool _isLoading = false;

  List<NoteModel> get notes => _notes;

  bool get loading => _isLoading;

  Future<void> fetchNotes() async {
    if (_auth.currentUser == null) return;

    _isLoading = true;
    update();

    try {
      final snapshot =
          await _firestore
              .collection('users')
              .doc(_auth.currentUser!.uid)
              .collection('notes')
              .orderBy('createdAt', descending: true)
              .get();

      _notes =
          snapshot.docs.map((doc) => NoteModel.fromFirestore(doc)).toList();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load notes',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      _isLoading = false;
      update();
    }
  }

  Future<bool> addNote(String title, String description) async {
    if (_auth.currentUser == null) return false;

    try {
      final note = {
        'title': title.trim(),
        'description': description.trim(),
        'createdAt': FieldValue.serverTimestamp(),
      };

      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('notes')
          .add(note);

      await fetchNotes();
      return true;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to add note',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }
}
