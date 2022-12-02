import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/todo_app/cubit/cubit.dart';
import '../../../layout/todo_app/cubit/states.dart';
import '../../../shared/components/components.dart';

class DoneScreen extends StatelessWidget {
  const DoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit,TodoStates>(
      listener: (context, state) {},
      builder: (context, state) {
        TodoCubit cubit = TodoCubit.get(context);
        return cubit.doneTasks.length==0 ? emptyScreen()
            : ListView.separated(
            itemBuilder: (context, index) => taskItem(cubit.doneTasks[index],context),
            separatorBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Container(
                color: Colors.grey[300],
                height: 1.0,
                width: double.infinity,
              ),
            ),
            itemCount: cubit.doneTasks.length);
      },
    );
  }
}
