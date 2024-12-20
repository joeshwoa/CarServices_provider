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
    apiKey: 'AIzaSyC_TXt-z2OCJGrruS9Ab_rWWTUM69KWP-E',
    appId: '1:772025988490:web:db8193b86dbf3c65b28473',
    messagingSenderId: '772025988490',
    projectId: 'autoflex-7b32d',
    authDomain: 'autoflex-7b32d.firebaseapp.com',
    storageBucket: 'autoflex-7b32d.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAOifBnuZXcTXwluowb-jmULjwTvIqRmvg',
    appId: '1:772025988490:android:4a07e22b04941b8ab28473',
    messagingSenderId: '772025988490',
    projectId: 'autoflex-7b32d',
    storageBucket: 'autoflex-7b32d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyChp6XMzqjRe7gfWwIDHcFAs5XHKKqlz4Y',
    appId: '1:772025988490:ios:48b1b91c614abd82b28473',
    messagingSenderId: '772025988490',
    projectId: 'autoflex-7b32d',
    storageBucket: 'autoflex-7b32d.appspot.com',
    iosBundleId: 'com.example.autoflexProviderWorker',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyChp6XMzqjRe7gfWwIDHcFAs5XHKKqlz4Y',
    appId: '1:772025988490:ios:48b1b91c614abd82b28473',
    messagingSenderId: '772025988490',
    projectId: 'autoflex-7b32d',
    storageBucket: 'autoflex-7b32d.appspot.com',
    iosBundleId: 'com.example.autoflexProviderWorker',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC_TXt-z2OCJGrruS9Ab_rWWTUM69KWP-E',
    appId: '1:772025988490:web:c0f385ab2dab8755b28473',
    messagingSenderId: '772025988490',
    projectId: 'autoflex-7b32d',
    authDomain: 'autoflex-7b32d.firebaseapp.com',
    storageBucket: 'autoflex-7b32d.appspot.com',
  );
}
