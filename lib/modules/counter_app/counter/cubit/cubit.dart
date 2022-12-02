import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy/modules/counter_app/counter/cubit/states.dart';

class CounterCubit extends Cubit<CounterStates> {
CounterCubit() : super(InitialState());
static CounterCubit get(context) => BlocProvider.of(context);
int count=1;

void plus(){
  count++;
  emit(PlusState(count));
}

void minus(){
  count--;
  emit(MinusState(count));
}

}
