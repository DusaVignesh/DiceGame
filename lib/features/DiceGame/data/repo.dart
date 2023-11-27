import 'dart:math';

import 'package:dice_game/constants/test.dart';
import 'package:dice_game/features/DiceGame/domain/option.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class testRepo {
  final List<Option> _options = ktest;
  Future<List<Option>> fetchOptions() async {
    return Future.value(_options);
  }

  Future<Option?> fetchOption(int id) async {
    return Future.value(_options.firstWhere((option) => option.ID == id));
  }
}

final testRepoProvider = Provider<testRepo>((ref) {
  return testRepo();
});

final optionsFutureProvider = FutureProvider<List<Option>>((ref) async {
  return ref.watch(testRepoProvider).fetchOptions();
});

final OptionProvider = FutureProvider.family<Option?, int>((ref, id) async {
  return ref.watch(testRepoProvider).fetchOption(id);
});
final initialRandomOptionProvider =
    FutureProvider.autoDispose<Option?>((ref) async {
  await Future.delayed(Duration(seconds: 1));
  return ref.watch(testRepoProvider).fetchOption(Random().nextInt(6).ceil());
});
