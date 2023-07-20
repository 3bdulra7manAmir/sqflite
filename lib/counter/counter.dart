// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqlite/counter/cubit/states.dart';

import 'cubit/cubit.dart';

class Counter extends StatefulWidget {
  const Counter({super.key});

  @override
  State<Counter> createState() => _CounterState();
}

int counter = 1;

class _CounterState extends State<Counter> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CounterCubit(),
      child: BlocConsumer<CounterCubit, CounterStates>(
        listener: (context, state) {
          if(state is CounterInitialState) print("Inital State");
          if(state is CounterMinusState) print("Minus State: ${state.counter}");
          if(state is CounterPlusState) print("Plus State: ${state.counter}");
          
        },
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(onPressed: () {
                    CounterCubit.get(context).minus();
                  }, child: const Text("MINUS")),
                  const SizedBox(width: 15,),
                  Text("${CounterCubit.get(context).counter}",style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),),
                  const SizedBox(width: 15,),
                  TextButton(onPressed: () {
                    CounterCubit.get(context).plus();
                  }, child: const Text("PLUS"))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
