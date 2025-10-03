import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/theme/hp_theme.dart';
import '../router/router.dart';

class HPApp extends ConsumerWidget {
  const HPApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      title: 'Wizarding Compendium',
      theme: HpTheme.light(),
      darkTheme: HpTheme.dark(),
      themeMode: ThemeMode.system,
      routerConfig: router,
    );
  }
}
