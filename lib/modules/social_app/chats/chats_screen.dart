import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy/layout/social_app/cubit/cubit.dart';
import 'package:udemy/layout/social_app/cubit/states.dart';
import 'package:udemy/modules/social_app/chats/chat_details_screen.dart';
import 'package:udemy/shared/components/components.dart';

import '../../../shared/styles/icon_broken.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return  SocialCubit.get(context).users.length > 0 ? ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) => InkWell(
            onTap: (){
              navigateTo(context, ChatDetailsScreen(model: SocialCubit.get(context).users[index],));
            },
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 34.0,
                    backgroundImage: NetworkImage(
                        SocialCubit.get(context).users[index].image!),
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  SocialCubit.get(context).users[index].name!,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,fontSize: 18.0),
                ),
              ],
            ),
          ),
          separatorBuilder: (context, index) => buildDivider(),
          itemCount: SocialCubit.get(context).users.length,
        ) : Center(child: CircularProgressIndicator());
      },
    );
  }
}
