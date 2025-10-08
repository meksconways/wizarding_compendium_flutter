import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:harry_potter/app/di/app_providers.dart';
import 'app/app.dart';
import 'features/spells/di/spells_token.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ProviderScope(
      overrides: [
        spellRepositoryProvider.overrideWith((ref) => ref.watch(spellRepositoryImplProvider))
      ],
      child: const HPApp()));
}
