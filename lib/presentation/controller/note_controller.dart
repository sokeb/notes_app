import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../data/services/firestore_service.dart';
import '../../domain/model/note_model.dart';

class NoteController extends GetxController {
  final _firestoreService = FirestoreService();

  List<NoteModel> _notes = [];
  bool _isLoading = true;

  List<NoteModel> get notes => _notes;

  bool get loading => _isLoading;

  @override
  void onInit() {
    super.onInit();
    fetchNotes();
  }

  Future<void> fetchNotes() async {
    try {
      _notes = await _firestoreService.getNotes();
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
    try {
      final note = {
        'title': title.trim(),
        'description': description.trim(),
        'createdAt': FieldValue.serverTimestamp(),
      };
      await _firestoreService.addNote(note);
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
