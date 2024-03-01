import 'package:flutter/material.dart';
import 'package:flutter_barrage_craft/flutter_barrage_craft.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Barrage Craft'),
        ),
        body: const Center(
          child: Text('Hello Barrage Craft'),
        ),
      ),
    );
  }
}
