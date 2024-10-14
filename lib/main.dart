import 'package:flutter/material.dart';
import 'package:langtransapp/languagetrans.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Language Translator Application',
      debugShowCheckedModeBanner: false,
      color: Colors.black12,
     
      home:LanguageTranslationPage(),
    );
  }
}

