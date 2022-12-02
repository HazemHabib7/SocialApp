import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class CounterScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterCubit(),
      child:BlocConsumer<CounterCubit,CounterStates>(
        listener: (context, state) {
          if(state is InitialState) print('State Is Initial State');
          if(state is PlusState) print('State Is PlusState State ${state.counter}');
          if(state is MinusState) print('State Is MinusState State ${state.counter}');
        },
        builder: (context, state) {
          CounterCubit cubit = CounterCubit.get(context);
          return  Scaffold(
            appBar: AppBar(
              title: Text('Counter'),
            ),
            body: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: (){
                        cubit.minus();
                      },
                      child: Text('Min')),
                  Text('${cubit.count}',style: TextStyle(fontSize: 60.0),),
                  TextButton(
                      onPressed: (){
                          cubit.plus();
                      },
                      child: Text('Plus')),
                ],
              ),
            ),
          );
        },
      )
    );
  }
}
