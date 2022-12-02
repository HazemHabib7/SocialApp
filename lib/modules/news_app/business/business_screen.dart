import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../../layout/news_app/cubit/cubit.dart';
import '../../../layout/news_app/cubit/states.dart';
import '../../../shared/components/components.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        NewsCubit cubit = NewsCubit.get(context);
        return cubit.business.length == 0
            ? Center(child: CircularProgressIndicator())
            : ScreenTypeLayout(
                mobile: Builder(
                    builder: (context) {
                      cubit.setDesktop(false);
                      return buildArticleList(list: cubit.business);
                    },
                ),
                desktop: Builder(
                  builder: (context) {
                    cubit.setDesktop(true);
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: buildArticleList(list: cubit.business),
                        ),
                        Expanded(
                          child: Container(
                            color: Colors.grey[200],
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                cubit.business[cubit.selectedItem]['description'],
                                style: TextStyle(fontSize: 18.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                breakpoints:
                    ScreenBreakpoints(desktop: 850, tablet: 500, watch: 100),
              );
      },
    );
  }
}
