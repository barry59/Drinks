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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBz1g7xXtootxA4eR8Q7kXgrfuHeT4ar00',
    appId: '1:841076641473:android:17be8728691e6251a1ce40',
    messagingSenderId: '841076641473',
    projectId: 'mobileapp1-ba3be',
    storageBucket: 'mobileapp1-ba3be.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDgtCzK4-NKhc6sJFLYulOjTostQWSu4cA',
    appId: '1:841076641473:ios:33c42f5523c3c09ba1ce40',
    messagingSenderId: '841076641473',
    projectId: 'mobileapp1-ba3be',
    storageBucket: 'mobileapp1-ba3be.appspot.com',
    iosClientId: '841076641473-refhmqtrauvq4idth9e77jcvmt0ffsp5.apps.googleusercontent.com',
    iosBundleId: 'com.example.drinks',
  );
}
