import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// 1. BLoC EVENTS
abstract class CounterEvent {}

class Increment extends CounterEvent {}

class Decrement extends CounterEvent {}

class Reset extends CounterEvent {}

// 2. BLoC LOGIC
class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    on<Increment>((event, emit) {
      if (state < 10) {
        emit(state + 1);
      }
    });

    on<Decrement>((event, emit) {
      if (state > 0) {
        emit(state - 1);
      }
    });

    on<Reset>((event, emit) {
      emit(0);
    });
  }
}

// 3. MAIN
void main() {
  runApp(
    BlocProvider(
      create: (_) => CounterBloc(),
      child: const MyApp(),
    ),
  );
}

// 4. MY APP
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const CounterPage(),
    );
  }
}

// 5. COUNTER PAGE
class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF1A1A40),
              Color(0xFF270082),
              Color(0xFF4B0082),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Counter Card
              Container(
                padding: const EdgeInsets.all(30),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.2),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Text(
                      "Counter",
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white70,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Counter Number
                    BlocBuilder<CounterBloc, int>(
                      builder: (context, count) {
                        return Text(
                          '$count',
                          style: const TextStyle(
                            fontSize: 80,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 10),

                    // Progress
                    BlocBuilder<CounterBloc, int>(
                      builder: (context, count) {
                        return Text(
                          '$count / 10',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white60,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildButton(
                    context,
                    Icons.remove,
                    "Decrease",
                    Colors.red,
                    () {
                      context.read<CounterBloc>().add(
                            Decrement(),
                          );
                    },
                  ),

                  _buildButton(
                    context,
                    Icons.refresh,
                    "Reset",
                    Colors.grey,
                    () {
                      context.read<CounterBloc>().add(
                            Reset(),
                          );
                    },
                  ),

                  _buildButton(
                    context,
                    Icons.add,
                    "Increase",
                    Colors.green,
                    () {
                      context.read<CounterBloc>().add(
                            Increment(),
                          );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(
    BuildContext context,
    IconData icon,
    String label,
    Color color,
    VoidCallback onPressed,
  ) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: Colors.white,
      ),
      label: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}