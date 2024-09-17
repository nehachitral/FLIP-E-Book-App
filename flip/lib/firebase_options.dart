// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyBNddLMEUZwXERqJs3KZ8NFt7di-N8bNlI',
    appId: '1:524021897040:web:51a0c9d39a751f0cd97e55',
    messagingSenderId: '524021897040',
    projectId: 'e-book-ea360',
    authDomain: 'e-book-ea360.firebaseapp.com',
    storageBucket: 'e-book-ea360.appspot.com',
    measurementId: 'G-ZTN3CBDH5N',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA3o77_W5EVvR7EMUPisditkhr1DgElVqw',
    appId: '1:524021897040:android:99438c27a4e86f30d97e55',
    messagingSenderId: '524021897040',
    projectId: 'e-book-ea360',
    storageBucket: 'e-book-ea360.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAO_hfkvaKRFtKvAEDLKOezkYe4ppFvGaE',
    appId: '1:524021897040:ios:3edd1e2736b38bb0d97e55',
    messagingSenderId: '524021897040',
    projectId: 'e-book-ea360',
    storageBucket: 'e-book-ea360.appspot.com',
    iosBundleId: 'com.example.flip',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAO_hfkvaKRFtKvAEDLKOezkYe4ppFvGaE',
    appId: '1:524021897040:ios:3edd1e2736b38bb0d97e55',
    messagingSenderId: '524021897040',
    projectId: 'e-book-ea360',
    storageBucket: 'e-book-ea360.appspot.com',
    iosBundleId: 'com.example.flip',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBNddLMEUZwXERqJs3KZ8NFt7di-N8bNlI',
    appId: '1:524021897040:web:5872e6cb9795f753d97e55',
    messagingSenderId: '524021897040',
    projectId: 'e-book-ea360',
    authDomain: 'e-book-ea360.firebaseapp.com',
    storageBucket: 'e-book-ea360.appspot.com',
    measurementId: 'G-145Y0RGHNE',
  );
}
