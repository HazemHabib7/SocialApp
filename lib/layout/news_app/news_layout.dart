import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../modules/news_app/search/search_screen.dart';
import '../../shared/components/components.dart';
import 'cubit/cubit.dart';
import 'cubit/dark_mode_cubit.dart';
import 'cubit/states.dart';


class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsCubit()..getBusiness(),
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          NewsCubit cubit = NewsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text('News App',),
              actions: [
                IconButton(onPressed: () {
                  navigateTo(context, SearchScreen());
                }, icon: Icon(Icons.search)),
                IconButton(onPressed: () {
                  DarkModeCubit.get(context).changeAppMode();
                }, icon: Icon(Icons.brightness_4_outlined)),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              // type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.business),
                  label: 'Business',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.sports),
                  label: 'Sport',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.science),
                  label: 'Science',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Settings',
                ),
              ],
              onTap: (index) {
                cubit.changeBottomNavBar(index);
                print(cubit.currentIndex);
              },
              currentIndex: cubit.currentIndex,
            ),
            body: cubit.screens[cubit.currentIndex],
          );
        },
      ),
    );
  }
}
