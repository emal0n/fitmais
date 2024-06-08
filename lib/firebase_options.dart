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
    apiKey: 'AIzaSyBz3Ej8aU0RV9RzcBPY3HTPQT3imxZQsyE',
    appId: '1:55725043193:web:e51f7f67b82b0b2f572128',
    messagingSenderId: '55725043193',
    projectId: 'fitmais-4266a',
    authDomain: 'fitmais-4266a.firebaseapp.com',
    storageBucket: 'fitmais-4266a.appspot.com',
    measurementId: 'G-LFPJP78TH4',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAmrEdiUingHFAOc5Tb4QmfBzi8uzLWujQ',
    appId: '1:55725043193:android:4107b923624aebdc572128',
    messagingSenderId: '55725043193',
    projectId: 'fitmais-4266a',
    storageBucket: 'fitmais-4266a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBJ-QO3lWCUwLKLm8EcefFHBI97ksDBakM',
    appId: '1:55725043193:ios:e50c87d7c4423797572128',
    messagingSenderId: '55725043193',
    projectId: 'fitmais-4266a',
    storageBucket: 'fitmais-4266a.appspot.com',
    iosBundleId: 'com.example.fitmais',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBJ-QO3lWCUwLKLm8EcefFHBI97ksDBakM',
    appId: '1:55725043193:ios:e50c87d7c4423797572128',
    messagingSenderId: '55725043193',
    projectId: 'fitmais-4266a',
    storageBucket: 'fitmais-4266a.appspot.com',
    iosBundleId: 'com.example.fitmais',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBz3Ej8aU0RV9RzcBPY3HTPQT3imxZQsyE',
    appId: '1:55725043193:web:f2bfe467873cf1e6572128',
    messagingSenderId: '55725043193',
    projectId: 'fitmais-4266a',
    authDomain: 'fitmais-4266a.firebaseapp.com',
    storageBucket: 'fitmais-4266a.appspot.com',
    measurementId: 'G-SX9KGPLEP3',
  );
}
