// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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

// ...

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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBTDW89-t242M_gl_cYmJfwLyDRaGJNmOE',
    appId: '1:286153118585:android:dce85247f801349c4f55a8',
    messagingSenderId: '286153118585',
    projectId: 'blaze-buddy',
    databaseURL: 'https://blaze-buddy-default-rtdb.firebaseio.com',
    storageBucket: 'blaze-buddy.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD7i9fQXpkqQL63S1ZPpJ2BALNdqmncK0M',
    appId: '1:286153118585:ios:3a60beaa010472744f55a8',
    messagingSenderId: '286153118585',
    projectId: 'blaze-buddy',
    databaseURL: 'https://blaze-buddy-default-rtdb.firebaseio.com',
    storageBucket: 'blaze-buddy.appspot.com',
    iosBundleId: 'com.example.miniProject',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCJXlGqamUrGHs9uD-oFTlhhWmCvk4o7ts',
    appId: '1:286153118585:web:95d896f1c3550c574f55a8',
    messagingSenderId: '286153118585',
    projectId: 'blaze-buddy',
    authDomain: 'blaze-buddy.firebaseapp.com',
    databaseURL: 'https://blaze-buddy-default-rtdb.firebaseio.com',
    storageBucket: 'blaze-buddy.appspot.com',
    measurementId: 'G-4MCL4X0GVB',
  );

}