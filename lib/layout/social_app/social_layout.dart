import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy/layout/social_app/cubit/cubit.dart';
import 'package:udemy/layout/social_app/cubit/states.dart';
import 'package:udemy/modules/social_app/post/post_screen.dart';
import 'package:udemy/shared/components/components.dart';
import '../../shared/styles/icon_broken.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SocialCubit cubit = SocialCubit.get(context);
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state) {
        // if(state is SocialNewPostState)
        //   navigateTo(context, PostScreen());
      },
      builder: (context, state) {
        return BlocConsumer<SocialCubit,SocialStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: Text("${cubit.titles[cubit.currentIndex]}"),
                actions: [
                  IconButton(onPressed: (){}, icon: Icon(IconBroken.Notification)),
                  IconButton(onPressed: (){}, icon: Icon(IconBroken.Search)),
                ],
              ),
              body: cubit.screens[cubit.currentIndex],
              bottomNavigationBar: BottomNavigationBar(
                items: [
                  BottomNavigationBarItem(icon: Icon(IconBroken.Home),label: "Home"),
                  BottomNavigationBarItem(icon: Icon(IconBroken.Chat),label: "Chats"),
                  BottomNavigationBarItem(icon: Icon(IconBroken.Paper_Upload),label: "Post"),
                  BottomNavigationBarItem(icon: Icon(IconBroken.User),label: "Users"),
                  BottomNavigationBarItem(icon: Icon(IconBroken.Setting),label: "Settings"),
                ],
                currentIndex: cubit.currentIndex,
                onTap: (index){
                  cubit.socialChangeNav(index);
                },

              ),
            );
          },
        );
      },
    );
  }
}
