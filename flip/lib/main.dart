import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import './flip.dart'; // Update with the correct path to HomePage

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:
          HomePage(), // Make sure HomePage is defined in flip.dart or update the path correctly
    );
  }
}
