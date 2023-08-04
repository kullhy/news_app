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
    apiKey: 'AIzaSyCDyLl3zXIlMGkLz_YLQ85KI1yfUl3yhcM',
    appId: '1:1074033950267:web:349614c5b3cfd41c50261e',
    messagingSenderId: '1074033950267',
    projectId: 'news-app-6010c',
    authDomain: 'news-app-6010c.firebaseapp.com',
    storageBucket: 'news-app-6010c.appspot.com',
    measurementId: 'G-WG776Z35MT',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAArMs-zkjRLPSAgPM7PtlUlfAD2CNYY5c',
    appId: '1:1074033950267:android:f3659c563c26203650261e',
    messagingSenderId: '1074033950267',
    projectId: 'news-app-6010c',
    storageBucket: 'news-app-6010c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD80r0-vIUoEY7i5q99ptbVe7wXJYz0PR4',
    appId: '1:1074033950267:ios:59ab2aae9edea58250261e',
    messagingSenderId: '1074033950267',
    projectId: 'news-app-6010c',
    storageBucket: 'news-app-6010c.appspot.com',
    iosClientId: '1074033950267-edcc8hal77idn7i1i53pbal9cpihm8e6.apps.googleusercontent.com',
    iosBundleId: 'com.example.learnBloc2',
  );
}