# Notes Management App

A Flutter application for managing notes with full CRUD functionality using Firebase Firestore and Provider state management.

## Features

- **Create Notes** - Add new notes with title and description
- **View Notes** - Display all notes sorted by creation date (newest first)
- **Edit Notes** - Update existing notes
- **Delete Notes** - Remove notes with confirmation dialog
- **Real-time Updates** - Notes list updates in real-time using Firestore streams
- **Form Validation** - Title and description validation
- **Material 3 Design** - Modern UI with Material Design 3
- **Empty State** - User-friendly empty state message

## Project Structure

```
lib/
├── models/
│   └── note.dart                 # Note data model
├── services/
│   └── firestore_service.dart    # Firestore database operations
├── providers/
│   └── note_provider.dart        # Provider for state management
├── screens/
│   ├── notes_list_screen.dart    # Display all notes
│   └── add_edit_note_screen.dart # Add/Edit note form
├── widgets/
│   └── note_card.dart            # Individual note card widget
├── firebase_options.dart         # Firebase configuration
└── main.dart                     # App entry point
```

## Prerequisites

- Flutter SDK (>=3.0.0)
- Dart (>=3.0.0)
- Firebase account
- A Firebase project with Firestore database

## Firebase Setup

### 1. Create a Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Add project" and follow the setup wizard
3. Name your project (e.g., "notes-management-app")
4. Enable Google Analytics (optional)
5. Create the project

### 2. Set Up Firestore Database

1. In Firebase Console, select your project
2. Go to "Firestore Database" in the left menu
3. Click "Create database"
4. Start in **test mode** (for development):
   ```
   allow read, write: if request.time < timestamp.date(2024, 12, 31);
   ```
5. Choose your database location
6. Click "Enable"

### 3. Configure for Web

If building for web:

1. In Firebase Console, go to Project Settings
2. Click "Web" icon to register your app
3. Copy the Firebase config object

### 4. Configure for Android

If building for Android:

1. In Firebase Console, go to Project Settings
2. Click "Android" icon to register your app
3. Download the `google-services.json` file
4. Place it in `android/app/` directory
5. Follow the prompted setup instructions

### 5. Configure for iOS

If building for iOS:

1. In Firebase Console, go to Project Settings
2. Click "iOS" icon to register your app
3. Download the `GoogleService-Info.plist` file
4. Open `ios/Runner.xcworkspace` in Xcode
5. Add `GoogleService-Info.plist` to the Runner project

## Configuration

### Update firebase_options.dart

Replace the placeholder values in `lib/firebase_options.dart` with your Firebase credentials:

```dart
static const FirebaseOptions web = FirebaseOptions(
  apiKey: 'YOUR_API_KEY',
  appId: '1:YOUR_APP_ID:web:YOUR_WEB_APP_ID',
  messagingSenderId: 'YOUR_MESSAGING_SENDER_ID',
  projectId: 'YOUR_PROJECT_ID',
  authDomain: 'YOUR_PROJECT_ID.firebaseapp.com',
  databaseURL: 'https://YOUR_PROJECT_ID.firebaseio.com',
  storageBucket: 'YOUR_PROJECT_ID.appspot.com',
);
```

You can find these values in Firebase Console > Project Settings > Your Apps

## Installation & Setup

1. **Clone or extract the project**
   ```bash
   cd notes_management_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase** (as described above)

4. **Run the app**
   ```bash
   flutter run
   ```

   Or for web:
   ```bash
   flutter run -d chrome
   ```

## Usage

### Creating a Note
1. Tap the "+" Floating Action Button
2. Enter a title and description
3. Tap "Create Note"
4. See the success message and return to the notes list

### Viewing Notes
- The main screen displays all notes sorted by creation date (newest first)
- Each note card shows the title, description preview, and creation time
- Empty state message appears when no notes exist

### Editing a Note
1. Tap the edit icon (pencil) on a note card
2. Modify the title and/or description
3. Tap "Update Note"
4. See the success message and return to the notes list

### Deleting a Note
1. Tap the delete icon (trash) on a note card
2. Confirm the deletion in the dialog
3. See the success message
4. The note is removed from the list

## Code Quality

- Clean separation of concerns with Models, Services, Providers, and UI layers
- StreamBuilder for real-time Firestore updates
- Form validation for user input
- Error handling and loading states
- Reusable widgets (NoteCard)
- Material 3 design system
- Proper null safety throughout

## Dependencies

- **firebase_core** (^2.24.2) - Firebase initialization
- **cloud_firestore** (^4.14.0) - Firestore database
- **provider** (^6.0.0) - State management

## Firestore Database Schema

**Collection:** `notes`

**Document Fields:**
- `title` (string) - Note title
- `description` (string) - Note content
- `createdAt` (timestamp) - Creation timestamp

**Example Document:**
```json
{
  "title": "My First Note",
  "description": "This is my first note created with Flutter",
  "createdAt": "2024-01-15T10:30:00Z"
}
```

## Troubleshooting

### App won't compile
- Run `flutter clean`
- Run `flutter pub get` again
- Check that your Flutter SDK is updated: `flutter upgrade`

### Firebase connection errors
- Verify your Firebase project exists and is active
- Check that the correct Firebase credentials are in `firebase_options.dart`
- For web, ensure CORS is properly configured
- Check Firestore security rules allow test mode access

### Firestore writes fail
- Check Firestore rules in Firebase Console
- Verify you're in test mode or have proper authentication rules
- Check that the `notes` collection exists (Firestore creates it on first write)

### Hot reload not working
- Try hot restart: `r` in terminal or press "R" in VS Code
- Rebuild the app if hot restart fails

## Development Notes

- The app uses Material 3 design with a blue seed color
- Notes are ordered by `createdAt` descending (newest first)
- Validation ensures both title and description are non-empty
- All database operations include proper error handling
- SnackBars provide user feedback for all CRUD operations

## Future Enhancements

Possible features for future versions:
- Note search and filtering
- Note categories/tags
- Rich text editing
- Dark mode support
- Note sharing
- Offline sync
- Cloud backup and restore

## License

This project is provided as-is for educational purposes.
