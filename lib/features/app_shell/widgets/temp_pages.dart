import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BooksPage extends StatelessWidget {
  const BooksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BooksPage')),
      body: Center(
        child: InkWell(
          child: const Text('BooksPage — içerik gelecek'),
          onTap: () => context.push('/bookDetail'),
        ),
      ),
    );
  }
}

class HousesPage extends StatelessWidget {
  const HousesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HousesPage')),
      body: const Center(child: Text('HousesPage — içerik gelecek')),
    );
  }
}

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

class BookDetailPage extends StatelessWidget {
  const BookDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BookDetail Page')),
      body: const Center(child: Text('BookDetailPage — içerik gelecek')),
    );
  }
}
