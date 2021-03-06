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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBYz2ooGwr4JzPiQoP_SEXGX4Cxh_UCn6c',
    appId: '1:430155608251:web:702eac5fd7729ec07af99e',
    messagingSenderId: '430155608251',
    projectId: 'beeblio-74494',
    authDomain: 'beeblio-74494.firebaseapp.com',
    storageBucket: 'beeblio-74494.appspot.com',
    measurementId: 'G-4SV6JJ5T42',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDkhVA2kv_t2u87XOzZZcbdmxtIUWT2wpM',
    appId: '1:430155608251:android:3897238a6647cc8f7af99e',
    messagingSenderId: '430155608251',
    projectId: 'beeblio-74494',
    storageBucket: 'beeblio-74494.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCYOXuJWhxlLYXBJ6k7jXz5UQEXtj2wgfg',
    appId: '1:430155608251:ios:ed84af80214cec427af99e',
    messagingSenderId: '430155608251',
    projectId: 'beeblio-74494',
    storageBucket: 'beeblio-74494.appspot.com',
    iosClientId: '430155608251-1t1le6epk7q4802o9dr7n9hp0ntugatb.apps.googleusercontent.com',
    iosBundleId: 'com.example.childrensbookapp',
  );
}
