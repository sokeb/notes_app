import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/model/note_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Get current user ID
  String? get userId => _auth.currentUser?.uid;

  /// Add a new note for the current user
  Future<void> addNote(Map<String, Object> note) async {
    if (userId == null) throw Exception("User not logged in");

    await _firestore
        .collection('users')
        .doc(userId)
        .collection('notes')
        .add(note);
  }

  /// Fetch all notes for the current user
  Future<List<NoteModel>> getNotes() async {
    if (userId == null) throw Exception("User not logged in");

    final snapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection('notes')
        .get();

    return snapshot.docs.map((doc) => NoteModel.fromFirestore(doc)).toList();
  }
}
