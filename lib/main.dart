import 'package:flutter/material.dart';
import 'package:harry_potter/core/theme/hp_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wizarding Compendium',
      themeMode: ThemeMode.system,
      theme: HpTheme.light(),
      darkTheme: HpTheme.dark(),
      home: const MyHomePage(title: 'Wizarding Compendium'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(),
    );
  }
}
