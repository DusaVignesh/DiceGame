import 'package:dice_game/features/DiceGame/domain/option.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class diceState {
  diceState({required this.option, this.value = const AsyncValue.data(null)});
  final Option option;
  final AsyncValue<void> value;
  bool get isloading => value.isLoading;
  diceState copywith({Option? option, AsyncValue<void>? value}) {
    return diceState(option: option ?? this.option, value: value ?? this.value);
  }
}
