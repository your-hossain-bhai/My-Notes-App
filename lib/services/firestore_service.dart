import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes_management_app/models/note.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'notes';

  Stream<List<Note>> getNotes() {
    return _firestore
        .collection(_collection)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => Note.fromFirestore(doc.data(), doc.id))
              .toList();
        });
  }

  Future<String> addNote(Note note) async {
    final docRef = await _firestore.collection(_collection).add(note.toFirestore());
    return docRef.id;
  }

  Future<void> updateNote(Note note) async {
    await _firestore
        .collection(_collection)
        .doc(note.id)
        .update(note.toFirestore());
  }

  Future<void> deleteNote(String noteId) async {
    await _firestore.collection(_collection).doc(noteId).delete();
  }
}
