import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:notes_management_app/models/note.dart';
import 'package:notes_management_app/providers/note_provider.dart';
import 'package:notes_management_app/screens/add_edit_note_screen.dart';
import 'package:notes_management_app/widgets/note_card.dart';

class NotesListScreen extends StatelessWidget {
  const NotesListScreen({super.key});

  void _showDeleteConfirmation(
    BuildContext context,
    Note note,
    NoteProvider noteProvider,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Note'),
          content: const Text('Are you sure you want to delete this note?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                noteProvider.deleteNote(note.id);
                Navigator.of(context).pop();
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('Note deleted')));
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Notes'), elevation: 0),
      body: Consumer<NoteProvider>(
        builder: (context, noteProvider, child) {
          return StreamBuilder<List<Note>>(
            stream: noteProvider.notesStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              final notes = snapshot.data ?? [];

              if (notes.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.note_outlined,
                        size: 64,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No notes found',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Create a new note to get started',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.grey[500],
                            ),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  final note = notes[index];
                  return NoteCard(
                    note: note,
                    onEdit: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AddEditNoteScreen(note: note),
                        ),
                      );
                    },
                    onDelete: () {
                      _showDeleteConfirmation(context, note, noteProvider);
                    },
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const AddEditNoteScreen()),
          );
        },
        tooltip: 'Add note',
        child: const Icon(Icons.add),
      ),
    );
  }
}
