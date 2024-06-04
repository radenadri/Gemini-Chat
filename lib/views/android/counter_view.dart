import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_counter_app/riverpod/counter_provider.dart';

class CounterView extends ConsumerWidget {
  const CounterView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You have pressed the button ${ref.watch(counterProvider)} times.',
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () => ref.read(counterProvider.notifier).increment(),
              child: const Icon(Icons.add),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () => ref.read(counterProvider.notifier).decrement(),
              child: const Icon(Icons.remove),
            ),
          ],
        ),
      ),
    );
  }
}
