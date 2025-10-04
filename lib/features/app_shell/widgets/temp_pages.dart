import 'package:flutter/material.dart';

class CharactersPage extends StatelessWidget {
  const CharactersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CharactersPage')),
      body: const Center(child: Text('CharactersPage — içerik gelecek')),
    );
  }
}

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
