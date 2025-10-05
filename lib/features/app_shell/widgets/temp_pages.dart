import 'package:flutter/material.dart';

class SpellsPage extends StatelessWidget {
  const SpellsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SpellsPage')),
      body: const Center(child: Text('SpellsPage — içerik gelecek')),
    );
  }
}

class SpellsQuizPage extends StatelessWidget {
  const SpellsQuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SpellsQuizPage')),
      body: const Center(child: Text('SpellsQuizPage — içerik gelecek')),
    );
  }
}
