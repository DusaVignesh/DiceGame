import 'dart:math';

import 'package:dice_game/features/DiceGame/data/repo.dart';
import 'package:dice_game/features/DiceGame/domain/option.dart';
import 'package:dice_game/features/DiceGame/presentation/game_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class dNotifier extends StateNotifier<diceState> {
  dNotifier({required this.tRepo, required this.option})
      : super(diceState(option: option));
  final testRepo tRepo;
  final Option option;
  Future<bool> rollDice() async {
    state = state.copywith(value: AsyncValue.loading());

    int id = Random().nextInt(6).ceil();

    final value = await AsyncValue.guard(() => tRepo.fetchOption(id));

    await Future.delayed(Duration(seconds: 1));

    value.whenData((value) {
      state = state.copywith(option: value);
    });
    state = state.copywith(value: value);
    return value.hasError == false;
  }
}

final dNotifierProvider = StateNotifierProvider.autoDispose
    .family<dNotifier, diceState, Option>((ref, option) {
  final tRepo = ref.watch(testRepoProvider);
  return dNotifier(tRepo: tRepo, option: option);
});
