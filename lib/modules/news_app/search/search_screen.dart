import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/news_app/cubit/cubit.dart';
import '../../../layout/news_app/cubit/states.dart';
import '../../../shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        NewsCubit cubit = NewsCubit.get(context);
        List<dynamic> search = cubit.search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultTextFormField(
                  onChange: (value){
                    cubit.getSearch(value);
                  },
                    validateText: 'Type Something To Search',
                    controller: searchController,
                    keyboardType: TextInputType.text,
                    label: 'Search',
                    prefixIcon: Icon(Icons.search)),
              ),
              Expanded(child: buildArticleList(list: search,isSearch: true)),
            ],
          ),
        );
      },
    );
  }
}
