import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'counter_bloc.dart';
import 'counter_event.dart';
import 'counter_state.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BLoC Counter'),
      ),

      body: Center(
        child: BlocBuilder<CounterBloc, CounterState>(
          builder: (context, state) {
            return Text(
              '${state.count}',
              style: const TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      ),

      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [

          // Increment
          FloatingActionButton(
            onPressed: () {
              context.read<CounterBloc>().add(
                IncrementEvent(),
              );
            },
            child: const Icon(Icons.add),
          ),

          const SizedBox(height: 10),

          // Decrement
          FloatingActionButton(
            onPressed: () {
              context.read<CounterBloc>().add(
                DecrementEvent(),
              );
            },
            child: const Icon(Icons.remove),
          ),

          const SizedBox(height: 10),

          // Reset
          FloatingActionButton(
            onPressed: () {
              context.read<CounterBloc>().add(
                ResetEvent(),
              );
            },
            child: const Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }
}