import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase/firebase_options.dart';
import 'Navegação/navegacao.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  
  runApp(const FitMais());
}

class FitMais extends StatelessWidget {
  const FitMais({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Fit+',
      debugShowCheckedModeBanner: false,
      home: TelaPrincipal(),
    );
  }
}