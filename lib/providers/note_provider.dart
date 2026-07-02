import 'package:flutter/material.dart';
import 'package:notes_management_app/models/note.dart';
import 'package:notes_management_app/services/firestore_service.dart';

class NoteProvider extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  final List<Note> _notes = [];

  List<Note> get notes => _notes;
  Stream<List<Note>> get notesStream => _firestoreService.getNotes();

  Future<void> addNote(String title, String description) async {
    final note = Note(
      id: '',
      title: title,
      description: description,
      createdAt: DateTime.now(),
    );
    await _firestoreService.addNote(note);
  }

  Future<void> updateNote(String id, String title, String description) async {
    final note = Note(
      id: id,
      title: title,
      description: description,
      createdAt: DateTime.now(),
    );
    await _firestoreService.updateNote(note);
  }

  Future<void> deleteNote(String noteId) async {
    await _firestoreService.deleteNote(noteId);
  }
}
