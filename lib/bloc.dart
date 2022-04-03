import 'package:flutter_riverpod/flutter_riverpod.dart';

const kCounterKey = 'counter';

final someBLoCProvider = AutoDisposeStateNotifierProvider<SomeBLoC, int>((ref) {
  ref.onDispose(() {
    print("never disposed");
  });
  return SomeBLoC();
}, name: 'someBLoCProvider');

final someFutureProvider = AutoDisposeFutureProvider<String>((ref) async {
  final result = await ref.watch(someBLoCProvider.notifier).someFuture();
  ref.maintainState = true;
  return result;
}, name: 'someFutureProvider');

class SomeBLoC extends StateNotifier<int> {
  SomeBLoC() : super(0);

  Future<String> someFuture() => Future.delayed(
        const Duration(seconds: 1),
        () => 'Something',
      );
}
