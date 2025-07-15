import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
  show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAhGMj9vWf1S2kY6w5Z0d5Z0d5Z0d5Z0d',
    authDomain: 'your-project.firebaseapp.com',
    projectId: 'your-project',
    storageBucket: 'your-project.appspot.com',
    messagingSenderId: '1234567890',
    appId: '1:1234567890:web:abcdefghijklmno',
    measurementId: 'G-ABCDEF',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAhGMj9vWf1S2kY6w5Z0d5Z0d5Z0d5Z0d',
    appId: '1:1234567890:android:abcdefghijklmno',
    messagingSenderId: '1234567890',
    projectId: 'your-project',
    storageBucket: 'your-project.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAhGMj9vWf1S2kY6w5Z0d5Z0d5Z0d5Z0d',
    appId: '1:1234567890:ios:abcdefghijklmno',
    messagingSenderId: '1234567890',
    projectId: 'your-project',
    storageBucket: 'your-project.appspot.com',
    iosClientId: '1:1234567890:ios:abcdefghijklmno',
    iosBundleId: 'com.example.lumiframe',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAhGMj9vWf1S2kY6w5Z0d5Z0d5Z0d5Z0d',
    appId: '1:1234567890:ios:abcdefghijklmno',
    messagingSenderId: '1234567890',
    projectId: 'your-project',
    storageBucket: 'your-project.appspot.com',
    iosClientId: '1:1234567890:ios:abcdefghijklmno',
    iosBundleId: 'com.example.lumiframe.RunnerTests',
  );
}