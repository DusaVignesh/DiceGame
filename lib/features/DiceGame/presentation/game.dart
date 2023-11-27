import 'package:dice_game/features/DiceGame/data/repo.dart';
import 'package:dice_game/features/DiceGame/presentation/game_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DiceGame extends ConsumerWidget {
  const DiceGame({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initOption = ref.watch(initialRandomOptionProvider);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Dice Game'),
        ),
        body: Center(
            child: initOption.when(
          data: (option) => Consumer(
            builder: (context, ref, child) {
              final state = ref.watch(dNotifierProvider(option!));
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (state.isloading)
                    CircularProgressIndicator()
                  else ...[
                    Image.asset(state.option.imageUrl),
                    Text(state.option.ID.toString())
                  ],
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      ref.read(dNotifierProvider(option).notifier).rollDice();
                    },
                    child: Text('Roll Dice'),
                  ),
                ],
              );
            },
          ),
          error: (e, st) => Text(e.toString()),
          loading: () => CircularProgressIndicator(),
        )),
      ),
    );
  }
}
