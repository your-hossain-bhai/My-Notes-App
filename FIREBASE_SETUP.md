# Firebase Setup Guide for Notes Management App

## Prerequisites
- A Google account
- A Firebase account (free tier available at https://firebase.google.com)
- The project files from this repository

## Step 1: Create a Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click on **"Add project"**
3. Enter your project name (e.g., `notes-management-app`)
4. Disable Google Analytics (optional, for simplicity)
5. Click **"Create project"**
6. Wait for the project to be created (about 1-2 minutes)

## Step 2: Enable Firestore Database

1. In your Firebase Console, go to **"Build"** → **"Firestore Database"**
2. Click **"Create database"**
3. Select **"Start in test mode"** (for development)
4. Click **"Next"**
5. Select your preferred location (default is fine)
6. Click **"Enable"**

### Firestore Security Rules (Test Mode)
For **development only**, test mode allows read/write access:
```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write: if request.time < timestamp.date(2024, 12, 31);
    }
  }
}
```

For **production**, use authentication:
```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /notes/{document=**} {
      allow read, write: if request.auth != null;
    }
  }
}
```

## Step 3: Register Your App

### For Web:
1. In Firebase Console, go to **Project Settings** (gear icon, top left)
2. Click on the **Web** tab (or click **"Add app"** → select **Web**)
3. If prompted, enter an app nickname (e.g., "Notes App - Web")
4. Check **"Also set up Firebase Hosting for this app"** (optional)
5. Click **"Register app"**
6. Copy the Firebase config object shown. It will look like:

```javascript
const firebaseConfig = {
  apiKey: "YOUR_API_KEY",
  authDomain: "YOUR_PROJECT_ID.firebaseapp.com",
  projectId: "YOUR_PROJECT_ID",
  storageBucket: "YOUR_PROJECT_ID.appspot.com",
  messagingSenderId: "YOUR_MESSAGING_SENDER_ID",
  appId: "YOUR_APP_ID"
};
```

7. Update `lib/firebase_options.dart` with these values

### For Android:
1. In Firebase Console, go to **Project Settings**
2. Click **"Add app"** → select **Android**
3. Enter your package name (find in `android/app/build.gradle`: `applicationId`)
4. (Optional) Enter SHA-1 certificate fingerprint
5. Click **"Register app"**
6. Download `google-services.json`
7. Place the file in `android/app/` directory

### For iOS:
1. In Firebase Console, go to **Project Settings**
2. Click **"Add app"** → select **iOS**
3. Enter your bundle ID (find in `ios/Runner/Info.plist`: `CFBundleIdentifier`)
4. Click **"Register app"**
5. Download `GoogleService-Info.plist`
6. Open `ios/Runner.xcworkspace` in Xcode
7. Add the file to the Runner project

## Step 4: Update firebase_options.dart

Replace the placeholder values in `lib/firebase_options.dart`:

```dart
import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    return web;  // or android, ios, etc.
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'YOUR_API_KEY_HERE',  // Copy from Firebase Config
    appId: '1:YOUR_APP_ID:web:YOUR_WEB_APP_ID',
    messagingSenderId: 'YOUR_MESSAGING_SENDER_ID',
    projectId: 'YOUR_PROJECT_ID',
    authDomain: 'YOUR_PROJECT_ID.firebaseapp.com',
    databaseURL: 'https://YOUR_PROJECT_ID.firebaseio.com',
    storageBucket: 'YOUR_PROJECT_ID.appspot.com',
  );
}
```

## Step 5: Install Dependencies

```bash
flutter pub get
```

## Step 6: Run the App

### For Web:
```bash
flutter run -d chrome
```

### For Android:
```bash
flutter run
```
(Make sure an Android emulator is running or device is connected)

### For iOS:
```bash
flutter run
```
(Make sure iOS simulator is running or device is connected)

## Step 7: Test the App

1. **Create a Note:**
   - Tap the **"+"** button
   - Enter a title and description
   - Tap **"Create Note"**
   - You should see a success message

2. **View Notes:**
   - Notes should appear in the list sorted by creation date

3. **Edit a Note:**
   - Tap the **edit icon** on a note
   - Modify the title/description
   - Tap **"Update Note"**

4. **Delete a Note:**
   - Tap the **delete icon** on a note
   - Confirm in the dialog
   - Note should disappear from the list

## Troubleshooting

### "Project not found" Error
- Make sure your project ID in `firebase_options.dart` matches your Firebase Console project
- Check that Firestore is enabled in your project

### "Permission denied" Error
- Verify Firestore is in test mode
- Check your security rules allow access
- For Android/iOS, ensure authentication is set up

### "Connection timeout"
- Check your internet connection
- Verify the Firebase project is active in Firebase Console
- Try rebuilding: `flutter clean && flutter pub get && flutter build web`

### Build Fails
- Run `flutter clean`
- Run `flutter pub get`
- Make sure you're using Flutter 3.0 or newer: `flutter --version`
- Check that all dependencies are installed: `flutter doctor`

## Next Steps

1. Set up **Authentication** for production use
2. Implement **user-specific notes** using Firebase Auth
3. Add **search and filtering** functionality
4. Deploy to **Firebase Hosting** for web
5. Add **push notifications** using Firebase Cloud Messaging

## References

- [Firebase Documentation](https://firebase.google.com/docs)
- [Flutter Firebase Plugin](https://firebase.flutter.dev/)
- [Cloud Firestore Documentation](https://firebase.google.com/docs/firestore)
- [Flutter Documentation](https://flutter.dev/docs)
