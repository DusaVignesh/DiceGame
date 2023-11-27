import 'package:dice_game/routing/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gorouter = ref.watch(goRouterProvider);
    return MaterialApp.router(
      routerConfig: gorouter,
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (context) => 'DiceGame',
    );
  }
}
